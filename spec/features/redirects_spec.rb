require 'rails_helper'

RSpec.feature "Redirects", type: :feature do

  background do
    @user = create(:user); visit '/login'
    
    within('.well') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Login'
    end
  end

  scenario 'visits login page when already logged in' do
    visit '/login'
    expect(page).to have_content 'You were already Logged In!'
  end

  scenario 'visits signup page when already logged in' do
    visit '/signup'
    expect(page).to have_content 'You were already Logged In!'
  end
end
