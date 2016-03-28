require 'test_helper'

class CheckingProgressTest < ActionDispatch::IntegrationTest
  def log_me_in
    user = create_a_user()
    # ... figure out what it means to fake logging in!
  end

  def test_checking_my_high_level_progress
    greg = log_me_in()
    skip

    # I'm on my homepage
    # I see a list of my challenges
    # I see that I've completed the "Linked list challenges"
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
