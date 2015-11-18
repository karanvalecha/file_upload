require 'rails_helper'

RSpec.describe UploadsController, type: :controller do

  context "unlogged User" do

    describe 'GET #index' do
      subject { get :index }

      it "renders the index template" do
        expect(subject).to render_template(:index)
        expect(assigns(:files)).to be_nil
      end
    end

    describe 'POST #create' do
      subject { post :create }

      it "Must be redirected to login page" do
        expect(subject).to redirect_to("/login")
      end
    end

    describe 'DELETE #destroy' do
      subject { delete :destroy, id: rand(1..5) }

      it "Must be redirected to login page" do
        expect(subject).to redirect_to("/login")
      end
    end

    describe 'PUT #update' do
      subject { put :update, id: rand(1..5) }

      it "Must be redirected to login page" do
        expect(subject).to redirect_to("/login")
      end

    end
  end

# -----------------------------------------------------------------------------

  context "logged-in User" do

    include ActionDispatch::TestProcess

    before :each do
      @user = create(:user)
      session[:current_user_id] = @user.id
      @upload = create(:upload, user: @user)
      @uploads = @user.uploads
      # create files in particular directories accordingly
      file = File.new(@upload.file_path, "w")
      file.puts("Hello, this is sample file"); file.close
    end

    after :each do
      session[:current_user_id] = nil
    end

    describe 'GET #index' do
      subject { get :index }

      it "must have array of files" do
        get :index
        expect(assigns(:files)).to exist
      end

      it "renders the index template" do
        expect(subject).to render_template(:index)
      end
    end

    describe 'POST #create' do
      subject { xhr :post, :create, file: fixture_file_upload("sample.txt") }

      it "render the create template" do
        expect(subject).to render_template(:create)
      end

      it "must add a new upload" do
        expect{ xhr :post, :create,
          file: fixture_file_upload("sample.txt")
          }.to change(Upload, :count).by(1)
      end
    end

    describe 'DELETE #destroy' do
      subject { xhr :delete, :destroy, id: @upload.id }

      it "renders destroy template" do
        expect(subject).to render_template(:destroy)
      end

      it "removes the upload" do
        expect{ xhr :delete, :destroy,
          id: @upload.id }.to change(Upload, :count).by(-1)
      end
    end

    describe 'PUT #update' do
      subject { xhr :put, :update, id: @upload.id,
                command: %w(rev r i del).sample  }

      it "renders show template" do
        expect(subject).to render_template("uploads/show.js.erb")
      end

      it "doesn't change the upload count" do
        expect{ xhr :put, :update, id: @upload.id,
              command: %w(rev r i del).sample
              }.to change(Upload, :count).by(0)
      end      
    end

  end
end
