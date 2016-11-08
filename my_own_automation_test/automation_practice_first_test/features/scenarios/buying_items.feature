Feature: Users are able to purchase items I selected in my cart

  Scenario: User adds items to cart
  Given User is on item page
  And User add it to my cart
  Then User expects that item to be on the cart

  Scenario: User checks their cart
  Given User is in any page
  And THey click Check out on cart
  Then User expects to be in shopping cart summary

  Scenario: Users buy an item
  Given User proceeds to checkout
  And User is logged in

  # Needs to be finished #
