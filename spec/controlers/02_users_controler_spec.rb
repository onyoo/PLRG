require 'spec_helper'

describe UsersController do
  it "allows a user-to-be to view the right form" do
    visit 'signup'
    expect(page.body).to include('<form')
    expect(page.body).to include('first_name')
    expect(page.body).to include('last_name')
    expect(page.body).to include('email')
    expect(page.body).to include('username')
    expect(page.body).to include('password')
  end

  it "allows a user-to-be to sign-up" do
    visit 'signup'
    fill_in "first_name", :with => "Darth"
    fill_in "last_name", :with => "Vader"
    fill_in "email", :with => "Vaderloveskittens@gmail.com"
    fill_in "username", :with => "Devader"
    fill_in "password", :with => "password"
    click_button "submit"
    expect(User.all).to include("Vaderloveskittens@gmail.com")
  end


end