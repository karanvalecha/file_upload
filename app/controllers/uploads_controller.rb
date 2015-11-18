class UploadsController < ApplicationController

  include UtilityFileMethods
  include FileMethods

  before_action :logged_in_users_only, except: :index
  before_action :read_uploaded_file, only: [:show, :destroy, :update]

  def index
    @files = current_user.uploads if current_user
  end

  def create
    content = params[:file].read
    name = params[:file].original_filename
    @upload = current_user.uploads.build(name: name)
    write_file(@upload.file_path, content) if @upload.save
  end

  def show
    @file_contents = read_file(@file.file_path)
  end

  def destroy
    @file.destroy # We need callbacks to run here
  end

  def update
    @file_path = @file.file_path
    cmd = params[:command]
    update_actions(cmd)

    @file_contents = read_file(@file_path)

    render :template => "uploads/show.js.erb", 
           :layout => false  

  end

  private

  def logged_in_users_only
    unless current_user
      flash[:danger] = "Log in to continue"
      redirect_to login_path
    end
  end

  def read_uploaded_file
    @file = current_user.uploads.find(params[:id])
  end

end
