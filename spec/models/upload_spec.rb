require "spec_helper"

describe "Upload" do
  before :all do
    @user = create(:user)
    @upload = create(:upload, user: @user)
  end

  it "must be valid" do
    expect(@upload).to be_valid
  end

  it "must have a name" do
    file = build(:upload, name: nil, user: @user)
    expect(file).not_to be_valid
  end

  it "must be .txt only" do
    file = build(:upload, name: "NoDotTxtFile", user: @user)
    expect(file).not_to be_valid
  end

  it "must belong to a user" do
    file = build(:upload, name: "file.txt", user: nil)
    expect(file).not_to be_valid
  end

  it "must have a directory" do
    expect(File.directory?(@upload.get_path)).to be true
  end
end