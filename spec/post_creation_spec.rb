require 'rails_helper'

RSpec.describe 'Create Post', type: :feature do
  let(:user) { User.create(name: 'Foo', email: 'a@a.com', password: '12345678') }
  scenario 'Create Post with valid inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    visit root_path
    fill_in 'Content', with: 'Anything'
    click_on 'Save'
    expect(page).to have_content('Post was successfully created.')
  end

  scenario 'Create Post with blank inputs' do
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
    sleep(3)
    visit root_path
    fill_in 'Content', with: ''
    click_on 'Save'
    expect(page).to_not have_content('Post was successfully created.')
  end
end
