require 'rails_helper'

RSpec.feature "Categories", type: :feature do
  let(:user) { User.create(name: 'salma', email: 'salma@example.com', password: 'password') }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

  scenario 'User navigates to the categories index page' do
    visit categories_path

    expect(page).to have_content('Categories')
    expect(page).to have_link('Add New Category')
  end
end
