require 'rails_helper'

RSpec.feature "MimicUploads", type: :feature do
  before :each do
    @user = create(:user)
    @upload = create(:upload, user: @user)
  end

  scenario 'this will upload my file', js: true do
    visit '/login'
    within('.well') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Login'
    end
    attach_file 'file', File.absolute_path("#{Rails.root.join}/spec/fixtures/sample.txt")
    within "#fileItems"
  end
end
