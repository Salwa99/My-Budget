require 'rails_helper'

RSpec.describe 'Categories New Page', type: :feature do
  include Devise::Test::IntegrationHelpers

  let!(:user) { User.create!(name: 'Salwa', email: 'salwa@gmail.com', password: 'password') }

  before do
    sign_in user
    visit new_category_path
  end

  it 'displays the header and form' do
    expect(page).to have_selector('.header')
    expect(page).to have_selector('.cat-form')
  end

  it 'displays the back button' do
    expect(page).to have_link('', href: categories_path, class: 'btn btn-primary')
    expect(page).to have_selector('i.fas.fa-arrow-left')
  end

  it 'displays the page title' do
    expect(page).to have_selector('h1', text: 'New Category')
  end

  it 'displays the logout button' do
    expect(page).to have_selector('button[type="submit"].btn-logout')
    expect(page).to have_selector('i.fa-solid.fa-right-from-bracket')
  end

  it 'displays the category form' do
    expect(page).to have_selector('div.field label', text: 'Name')
    expect(page).to have_selector('div.field input[type="text"][name="category[name]"][required="required"]')
    expect(page).to have_selector('div.field label', text: 'Icon')
    expect(page).to have_selector('div.field select[name="category[icon]"]')
    expect(page).to have_selector('div.actions input[type="submit"][value="Create Category"]')
  end
end
