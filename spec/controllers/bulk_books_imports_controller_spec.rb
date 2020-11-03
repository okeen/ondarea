require 'rails_helper'

RSpec.describe BulkBooksImportsController, type: :controller do
  fixtures :users
  let(:user)   { users('basic') }
  let(:csv_file) {
    Rack::Test::UploadedFile.new(
      File.open(File.join(Rails.root, '/test/fixtures/books/example_books.csv'))
    )
  }
  let(:import) { BulkBooksImport.create(
      user: user,
      uploaded_file: csv_file
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

    context "with a logged in user" do
      before do
        sign_in(users(:basic))
        get :index
      end

      it "assigns @bulk_books_imports" do
        expect(assigns(:bulk_books_imports).to_a).to eq([])
      end
      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end
  end

  describe "GET new" do
    before do
      get :new
    end

    context "with no logged user" do
      it "redirects to the log in screen" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "with a logged in user" do
      before do
        sign_in(users(:basic))
        get :new
      end

      it "assigns a new @bulk_books_import" do
        expect(assigns(:bulk_books_import)).to be_present
        expect(assigns(:bulk_books_import)).not_to be_persisted
      end
      it "renders the index template" do
        expect(response).to render_template("new")
      end
    end
  end

  describe "POST /" do
    context "with no logged user" do
      before do
        post :create
      end

      it "redirects to the log in screen" do
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "with a logged in user" do
      before do
        sign_in(users(:basic))
      end

      it "creates and saves a BooksCsvImportCreationService" do
        mock_instance = BooksCsvImportCreationService.new()
        expect(BooksCsvImportCreationService).to receive(:new).and_return(mock_instance)
        expect(mock_instance).to receive(:save).and_return true
        expect(mock_instance).to receive(:instance).and_return BulkBooksImport.new(id: 1)
        post :create, params: {
            bulk_books_import: {
                uploaded_file: Rack::Test::UploadedFile.new(
                    File.open(File.join(Rails.root, '/test/fixtures/books/example_books.csv'))
                )
            }
        }
        expect(response).to redirect_to edit_bulk_books_import_path(1)
      end
    end
  end

  describe "PATCH /{id}" do
    context "with a logged in user" do
      let(:instance) {
        BulkBooksImport.create(
            user: users(:basic),
            uploaded_file: csv_file
        )
      }
      before do
        sign_in(users(:basic))
        controller.stub(:load_instance)

      end

      it "creates and saves a BooksCsvImportCreationService" do
        controller.instance_variable_set(:@bulk_books_import, instance)
        expect(instance).to receive(:complete!)
        patch :update, params: {
            id: instance.id
        }
      end
    end
  end
end