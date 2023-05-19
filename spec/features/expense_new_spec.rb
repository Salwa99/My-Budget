require 'rails_helper'

RSpec.feature 'Expenses New Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Salwa', email: 'salwa@gmail.com', password: 'password') }
  let!(:category) { Category.create!(name: 'Gym', icon: '🏋️‍♂️', user:) }

  before do
    sign_in user
    visit new_category_expense_path(category)
  end

  scenario 'displays the header' do
    expect(page).to have_selector('.header')
    expect(page).to have_link(nil, href: categories_path, class: 'btn btn-primary')
    expect(page).to have_selector('h1', text: 'Add Expense')
  end

  scenario 'displays the new expense form' do
    expect(page).to have_selector('h2', text: "New Expense for #{category.name}")
    expect(page).to have_selector('div.field label', text: 'Name')
    expect(page).to have_selector('div.field input[type="text"][name="expense[name]"][required]')
    expect(page).to have_selector('div.field label', text: 'Amount')
    expect(page).to have_selector('div.field input[type="text"][name="expense[amount]"][required]')
    expect(page).to have_selector('div.field label', text: 'Category')
    expect(page).to have_selector('div.field select[name="expense[category_id]"][required]')
    expect(page).to have_selector('div.actions input[type="submit"][value="Create Expense"]')
  end
end
