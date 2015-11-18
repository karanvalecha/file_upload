require 'rails_helper'

RSpec.feature "File", type: :feature do
  before :each do
    @user = create(:user)
    @upload = create(:upload, user: @user)
    visit '/login'
    within('.well') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Login'
    end
  end
  scenario 'should have files when logged in' do
    visit '/'
    within('#fileItems') do
      expect(page).to have_content @upload.name
    end
  end


  scenario 'should display file contents', js: true do
    within('#fileItems') do
      click_link @upload.name
    end
    expect(page).to have_content("Hello, this is sample file")
  end
  # This scenario will require js
  scenario 'should delete the file', js: true do
    visit '/'
    within('#fileItems') do
      find(".delete").click
      expect(page).not_to have_content(@upload.name)
    end
  end
end

class ActionDispatch::IntegrationTest
  self.use_transactional_fixtures = false
end
