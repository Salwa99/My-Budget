require 'rails_helper'

RSpec.feature 'Categories Index', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Salwa', email: 'salwa@gmail.com', password: 'password') }
  let!(:category1) { Category.create!(user:, name: 'Food', icon: '🍔') }
  let!(:category2) { Category.create!(user:, name: 'Health', icon: '💊') }

  before do
    sign_in user
    visit categories_path
  end

  scenario 'displays the categories with their details' do
    expect(page).to have_content('Categories')

    within('.categories') do
      expect(page).to have_content(category1.name)
      expect(page).to have_content(category1.expenses.collect(&:amount).sum)
      expect(page).to have_content(category2.name)
      expect(page).to have_content(category2.expenses.collect(&:amount).sum)
    end
  end

  scenario 'displays buttons to view expenses and add a new expense for each category' do
    within('.categories') do
      expect(page).to have_link('View Expenses', href: category_expenses_path(category1))
      expect(page).to have_link('View Expenses', href: category_expenses_path(category2))
      expect(page).to have_link('Add a New Expense', href: new_category_expense_path(category1))
      expect(page).to have_link('Add a New Expense', href: new_category_expense_path(category2))
    end
  end

  scenario 'displays a button to add a new category' do
    expect(page).to have_link('Scan', href: new_category_path)
  end

  scenario 'displays a message and a button to add a new category when no categories exist' do
    Category.destroy_all
    visit categories_path

    expect(page).to have_content('No categories found. Click the button below to add a new category.')
    expect(page).to have_link('Scan', href: new_category_path)
  end
end
