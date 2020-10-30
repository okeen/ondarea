require 'rails_helper'

RSpec.describe BooksCsvImportCreationService, type: :model do
  fixtures :users

  let(:user)     { users('basic') }
  let(:csv_file) {
    Rack::Test::UploadedFile.new(
      File.open(File.join(Rails.root, '/test/fixtures/books/example_books.csv'))
    )
  }

  subject { BooksCsvImportCreationService.new(user: user, uploaded_file: csv_file) }

  describe "save" do
    let(:import) { subject.instance }
    after do
      subject.save
    end

    context "with a valid BulkBooksImport instance" do
      it "calls the BulkBooksImport to import the uploaded items" do
        expect(import).to receive(:add_import_item).with(
          {
            title: "Don Quijote",
            author: "Miguel de Cervantes",
            isbn: "9783161484100",
            publisher: "Freelance",
            publication_date: "1605/01/01"
          }
        )
        expect(import).to receive(:add_import_item).with(
          {
            title: "Don palotes",
            author: "Anonymous",
            isbn: "9783161484101",
            publisher: "Freelance",
            publication_date: "1805/01/01"
          }
        )
      end
    end

    context "with an invalid BulkBooksImport instance" do
      before do
        import.uploaded_file = nil
      end

      it "doesn't do anything" do
        expect(import).not_to receive(:add_import_item)
      end
    end
  end

  describe "imported_items" do
    pending("I normally don't test simple gem integrations, that should already be well tested by the gem test suite")
  end
end