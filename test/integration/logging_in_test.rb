require 'test_helper'

class LoggingInTest < ActionDispatch::IntegrationTest
  def test_i_can_login
    greg = User.create! email:    "101glover@gmail.com",
                        password: "lolhimom"

    # I'll go to the root of the site
    page.visit root_path

    # I see some welcome page
    assert_matches /welcome/i, page.body

    # I click the "login" link
    page.click 'login'

    # I fill "email" in with "101glover@gmail.com"
    page.fill_in 'email', with: "101glover@gmail.com"

    # I fill "password" in with "lolhimom"
    page.fill_in 'password', with: "lolhimom"

    # I click "Login"
    page.click_button 'Login'

    # Am on my home page
    assert_equal '/home', page.current_path

    # I can log out, but not in
    assert page.has_link?('logout')
    refute page.has_link?('login')
  end
end
