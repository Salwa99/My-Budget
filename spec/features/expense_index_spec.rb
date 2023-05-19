require 'rails_helper'

RSpec.feature 'Expense Index', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Salwa', email: 'salwa@gmail.com', password: 'password') }
  let!(:category) { Category.create!(user:, name: 'Gym', icon: '🏋️‍♂️') }

  before do
    sign_in user
    visit category_expenses_path(category)
  end

  scenario 'displays the category name and expenses' do
    expect(page).to have_content("Expenses for #{category.name}")
  end
  
  scenario 'displays a message when no expenses exist' do
    category.expenses.destroy_all
    visit category_expenses_path(category)

    expect(page).to have_content('No expenses found.')
    expect(page).not_to have_selector('.expenses-card')
  end
end
