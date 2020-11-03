require 'rails_helper'

RSpec.describe BulkBooksImport, type: :model do
  fixtures :users
  let(:user) { users('basic') }
  subject {
    BulkBooksImport.new user: user,
                        uploaded_file: Rack::Test::UploadedFile.new(
                            File.open(File.join(Rails.root, '/test/fixtures/books/example_books.csv'))
                        )
  }
  it "sets an uuid" do
    expect(subject.uuid).to be_present
  end

  describe "valid?" do
    context "with no uploaded file" do
      before do
        subject.uploaded_file = nil
      end

      it "should not be valid" do
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:uploaded_file]).to include "can't be blank"
      end
    end

    context "with no user" do
      before do
        subject.user = nil
      end

      it "should not be valid" do
        expect(subject.valid?).to be_falsey
        expect(subject.errors[:user_id]).to include "can't be blank"
      end
    end
  end

  describe "save" do
    after do
      subject.save
    end

    it "calls to clone the uploaded file fields" do
      expect(subject).to receive(:clone_uploaded_file_fields)
    end
  end

  describe "set_uuid" do
    # very simple test coming here
  end

  describe "clone_uploaded_file_fields" do
    it "calls ot update uploaded_file_name and uploaded_file_url" do
      expect(subject).to receive(:update).with(
          uploaded_file_name: subject.uploaded_file.filename,
          uploaded_file_url: subject.uploaded_file.url
      )
      subject.send(:clone_uploaded_file_fields)
    end
  end
end
