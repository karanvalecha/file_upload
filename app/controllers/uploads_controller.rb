class UploadsController < ApplicationController
  
  require "#{Rails.root}/lib/utility_file_methods"
  require "#{Rails.root}/lib/file_methods"

  include UtilityFileMethods
  include FileMethods

  before_action :logged_in_users_only, except: :index

  def index
    @files = current_user().uploads if current_user()
    # debugger
  end

  def create
    content = params[:file].read
    name = params[:file].original_filename
    @upload = current_user().uploads.build(name: name)
    write_file(@upload.file_path, content) if @upload.save
  end

  def show
    @file = current_user().uploads.find(params[:id])
    @file_contents = read_file(@file.file_path)
  end

  def destroy
    @file = current_user().uploads.find(params[:id])
    @file.destroy # We need callbacks to run here
  end

  def update
    @file = current_user().uploads.find(params[:id])
    @file_path = @file.file_path
    cmd = params[:command]
    update_actions(cmd)

    @file_contents = read_file(@file_path)

    respond_to do |format|
       format.js do
          render :template => "uploads/show.js.erb", 
                 :layout => false  
       end
    end

  end

  private

  def logged_in_users_only
    unless current_user()
      flash[:danger] = "Log in to continue"
      redirect_to login_path
    end
  end

end
