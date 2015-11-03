class UploadController < ApplicationController
  def index
  end

  def create
    content = params[:content].read
    name = params[:content].original_filename

    uploaded_file = Upload.create!(content: content) 

    # Open a new stream and write to the file.
    File.open("#{Rails.root}/public/uploads/#{uploaded_file.id}#{name}", "w") do |file| 
      begin
        file.write(content)
      ensure
        file.close
      end
    end
    flash[:success] = "The file was uploaded succesfully."
    redirect_to root_url
  end
end
