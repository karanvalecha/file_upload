class UploadsController < ApplicationController
  include SessionsHelper

  def index
    @files ||= Dir.entries("public/uploads").select {|f| !File.directory? f}
    # debugger
  end

  def create
    content = params[:content].read
    name = params[:content].original_filename

    # uploaded_file = Upload.create!(content: content) 

    # # Open a new stream and write to the file.
    # File.open("#{Rails.root}/public/uploads/#{name}", "w") do |file| 
    #   begin
    #     file.write(content)
    #   ensure
    #     file.close
    #   end
    # end
    # flash[:success] = "The file was uploaded succesfully."
    redirect_to root_url
  end

  def file
    respond_to { |format| format.js {} }
    @file_name = params[:choose]
    File.open("#{Rails.root}/public/uploads/#{@file_name}", "r") do |file| 
      begin
        @file_contents = file.read
      ensure
        file.close
      end
    end
  end

  def command
    @file_name = params[:choose]
    cmd = params[:command] # Split space seperated into new array

    words = cmd.scan(/['|"][\w?\s*]+['|"]/) # grab the words for swapping
    @word1 = words[0][/(\w\s*)+/] if words[0]
    @word2 = words[1][/(\w\s*)+/] if words[1]
    cmd.gsub!(/['|"][\w?\s*]+['|"]/,"")

    @at_line = cmd.scan(/\d{1,}/)[0].to_i || 0 # grab the line number
    cmd.gsub!(/\d{1,}/, "")
    cmd.gsub!(/_/, "")

    cmd = cmd.split(/\s+/)

    cmd.each do |method|
      self.send("#{method}",
      {at_line: @at_line, word1: @word1, word2: @word2})
    end

    File.open("#{Rails.root}/public/uploads/#{@file_name}", "r") do |file| 
      begin
        @file_contents = file.read
      ensure
        file.close
      end
    end

  end

private

  # def i(word, at_line=0)
  def i(args = {})
    puts "i called"
    word = args[:word1] + "\n"
    at_line = args[:at_line]
    
    tempfile=File.open("file.tmp", 'w')
    f=File.new("#{Rails.root}/public/uploads/#{@file_name}")

    f.each_with_index do |line, index|

      if (index+1 == at_line)
        tempfile << word
        tempfile<<line
      else
        tempfile<<line
      end
    end
    tempfile << word if at_line == nil

    f.close
    tempfile.close

    FileUtils.mv("file.tmp", "#{Rails.root}/public/uploads/#{@file_name}")
  end

  # def r(word1, word2, at_line=0)
  def r(args = {})
    puts "r called"
    word1 = args[:word1]
    word2 = args[:word2]
    at_line = args[:at_line]

    tempfile=File.open("file.tmp", 'w')
    f=File.new("#{Rails.root}/public/uploads/#{@file_name}")

    if at_line == 0
      f.each { |line| tempfile << line.gsub(/#{word1}/i, word2) }
    else
      at_line = at_line
      f.each.with_index do |line, index|
        index+1 == at_line ? tempfile << line.gsub(/#{word1}/i, word2) : tempfile << line
      end
    end

    f.close
    tempfile.close

    FileUtils.mv("file.tmp", "#{Rails.root}/public/uploads/#{@file_name}")
  end

  # def rev(at_line=0)
  def rev(args = {})
    puts "rev called"
    at_line = args[:at_line]

    tempfile=File.open("file.tmp", 'w')
    f=File.new("#{Rails.root}/public/uploads/#{@file_name}")

    f.each_with_index do |line, index|
      if (index+1 == at_line)
        tempfile << line.reverse.gsub(/\n/,"") + "\n" # Remove the new line and and it to the end
      else
        tempfile << line
      end
    end

    f.close
    tempfile.close

    FileUtils.mv("file.tmp", "#{Rails.root}/public/uploads/#{@file_name}")
  end

  def s(args)
    puts "Inside S"
  end

  def d(args)
    at_line = args[:at_line]

    tempfile=File.open("file.tmp", 'w')
    f=File.new("#{Rails.root}/public/uploads/#{@file_name}")

    f.each_with_index do |line, index|
      unless (index+1 == at_line)
        tempfile << line
      end
    end

    f.close
    tempfile.close

    FileUtils.mv("file.tmp", "#{Rails.root}/public/uploads/#{@file_name}")
  end

end