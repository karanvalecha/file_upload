require 'rails_helper'

RSpec.feature "Logins", type: :feature do
  before :each do
    @user = create(:user)
  end
  scenario "will log me in" do
    visit '/login'
    within('.well') do
      fill_in 'Email', with: @user.email
      fill_in 'Password', with: @user.password
      click_button 'Login'
    end
    expect(page).to have_content 'Login Success'
  end
  scenario "Unauthorised log me in" do
    visit '/login'
    within('.well') do
      fill_in 'Email', with: 'wrong@email.com'
      fill_in 'Password', with: 'wrong_password'
      click_button 'Login'
    end
    expect(page).to have_content 'Unauthorised Access'
  end
end
