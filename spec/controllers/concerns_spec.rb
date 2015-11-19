require 'rails_helper'

RSpec.describe UploadsController, type: :controller do
  include UtilityFileMethods
  include FileMethods

  before :all do
    @user = create(:user)
    @upload = create(:upload, user: @user)
    @file_path = @upload.file_path
    @content = File.read("#{Rails.root.join}/spec/fixtures/sample.txt")
    FileUtils.cp("#{Rails.root.join}/spec/fixtures/sample.txt", @file_path)
  end

  describe "File Utility Method" do

    context 'Insert "Hii" at line 1' do
      it "should work" do
        cmd = "i 1 'Hii'"
        update_actions cmd
        expect(File.read(@file_path)).to eq "Hii\n#{@content}"
      end
    end

    context 'reverse "Hii" to make "iiH"' do
      it "should work" do
        cmd = "rev 1"
        update_actions cmd
        expect(File.read(@file_path)).to eq "iiH\n#{@content}"
      end
    end

    context 'Search and replace "iiH" to "Hii"' do
      it "should work" do
        cmd = "r 'iiH' 'Hii'"
        update_actions cmd
        expect(File.read(@file_path)).to eq "Hii\n#{@content}"
      end
    end

    context 'delete line 1' do
      it "should work" do
        cmd = "del 1"
        update_actions cmd
        expect(File.read(@file_path)).to eq @content
      end
    end

  end
end