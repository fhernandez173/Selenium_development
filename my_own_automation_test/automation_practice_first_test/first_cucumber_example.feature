Feature: Checking out and buying tea flow
  Users will be able to oder their own tea and pay for it.

  Scenario: Adding items to cart
  Given I am in page http://www.practiceselenium.com/menu.html
  When I click on Check Out
  Then Users will be taken to checkout page http://www.practiceselenium.com/check-out.html

  Scenario: Adding customer and payment information
  Given I am in check-out page http://www.practiceselenium.com/check-out.html
  When I add information in the fields
  Then It should take me back to the menu page

 # New features for automationpractice website for contacts page
@contact_page # Look this up
 Feature: Sending contact message should users have questions ....
  Takes into account errors/ misisng fields...

  Scenario: If information is correct ...
  Given
  When
  Then

  Scenario: If missing fields ....
  Given
  When
  Then
