require 'rails_helper'

RSpec.describe BulkImportItem, type: :model do
  fixtures :users
  fixtures :books
  let(:user)   { users('basic') }
  let(:import) { BulkBooksImport.create(
      user: user,
      uploaded_file: Rack::Test::UploadedFile.new(
          File.open(File.join(Rails.root, '/test/fixtures/books/example_books.csv'))
      )
    )
  }
  let(:book)   { books('basic') }

  subject {
    import.bulk_import_items.build(
      attrs: {
          title: "Otro quijote",
          author: "Quevedo",
          isbn: "9781400132171",
          publisher: book.publisher,
          publication_date: book.publication_date
      }
    )
  }

  describe "imported_errors" do
    context "with valid book attrs" do
      it "should show no imoprt errors" do
        expect(subject.import_errors).to be_empty
      end
    end

    context "with invalid book attrs" do
      before do
        subject.attrs[:isbn] = nil
      end
      it "should show no imoprt errors" do
        expect(subject.import_errors[:isbn]).to include("can't be blank")
        expect(subject.import_errors[:isbn]).to include("is not a valid ISBN code")
      end
    end
  end
end
