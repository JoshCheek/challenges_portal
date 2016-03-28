require 'test_helper'

class CheckingProgressTest < ActionDispatch::IntegrationTest
  def teardown
    $test_user = nil
  end

  def log_me_in
    user = create_a_user()
    $test_user = user
    user
  end

  def test_checking_my_high_level_progress
    greg = log_me_in()

    # I'm on my homepage
    page.visit home_path

    # I see a list of my challenges
    challenge_names = page.all('.challenge .name').map(&:text)
    assert_includes challenge_names, 'linked list functions'
    assert_includes challenge_names, 'list recursion'

    # I see that I've completed the "Linked list functions"
    challenge = challenges.css('.challenge').to_a
                          .find { |challenge| challenge.text == 'linked list functions' }

    progress = challenge.find('.progress')
    assert_equal '2', progress.find('.correct').text
    assert_equal '65', progress.find('.possible').text

    # I see that I've completed 2 of the 65 "Module Challenges"
    # I see that I've not started "ActiveRecord challenges"
  end

  def test_checking_my_low_level_progress
    skip
    # I click on "Module Challenges"
    #   I see the toplevel groups of namespaces and include challenges
    #   Within namespace challenges, I have 2 of 17 completed:
    #     define a module MahMod
    #     define a module MahMod::A
    #   Within the include challenges, I have 0 of 48 completed
  end
end
