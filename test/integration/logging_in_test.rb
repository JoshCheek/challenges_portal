require 'test_helper'

class LoggingInTest < ActionDispatch::IntegrationTest
  def test_i_can_login_and_out
    greg = User.create! email:    "101glover@gmail.com",
                        password: "lolhimom"

    # I'll go to the root of the site
    page.visit root_path

    # I see some welcome page
    assert_match /welcome/i, page.body

    # I click the "login" link
    page.click_link 'login'

    # I fill "email" in with "101glover@gmail.com"
    page.fill_in 'Email', with: "101glover@gmail.com"

    # I fill "password" in with "lolhimom"
    page.fill_in 'Password', with: "lolhimom"

    # I click "Login"
    page.click_button 'Log in'

    # Am on my home page
    assert_equal '/home', page.current_path

    # I can log out, but not in
    assert page.has_link?('logout')
    refute page.has_link?('login')

    # Now I log out
    page.click_link 'logout'
    assert page.has_link?('login')
    refute page.has_link?('logout')
  end

  # Other thoughts:
  #  def test_i_dont_get_logged_in_if_i_fuck_up_my_email_or_password
  #  the flash messages show up in the view
end
