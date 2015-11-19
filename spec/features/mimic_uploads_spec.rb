require 'rails_helper'

RSpec.feature "MimicUploads", type: :feature do
  background do
    @user = create(:user)
    @upload = create(:upload, user: @user)

    visit '/login'

    within('.well') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Login'
    end
  end

  scenario 'this will upload my file', js: true do

    within("ul#fileItems") do
      expect(page).to have_text(@upload.name, count: 1)
    end

    attach_file 'file', File.absolute_path("#{Rails.root.join}/spec/fixtures/sample.txt")

    within "#fileItems" do
      expect(page).to have_text(@upload.name, count: 2)
    end
  end
end
