require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  fixtures :users, :books

  describe "GET index" do
    let(:book) { books(:basic) }
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

      it "assigns @books" do
        expect(assigns(:books).to_a).to eq([book])
      end
      it "renders the index template" do
        expect(response).to render_template("index")
      end
    end
  end
end