require 'rails_helper'

RSpec.describe BulkBooksImportsController, type: :controller do
  fixtures :users
  let(:user)   { users('basic') }
  let(:import) { BulkBooksImport.create(
      user: user,
      uploaded_file: Rack::Test::UploadedFile.new(
          File.open(File.join(Rails.root, '/test/fixtures/books/example_books.csv'))
      )
    )
  }

  describe "GET index" do
    before do
      get :index
    end

    context "with no logged user" do
      it "redirects to the log in screen" do
        expect(response).to redirect_to new_user_session_path
      end
    end
  end

  describe "PATCH complete" do

  end
end