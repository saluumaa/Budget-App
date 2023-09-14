require 'rails_helper'

RSpec.feature "Expenses", type: :feature do
  let(:user) { User.create(name: 'salma', email: 'salma@example.com', password: 'password') }

  before do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: 'password'
    click_button 'Log in'
  end

    scenario 'User navigates to the expenses index page' do
     
        visit category_expenses_path
        expect(page).to have_content('Transactions')
        expect(page).to have_link('Add a New Expense')
    end
end
