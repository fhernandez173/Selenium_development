require 'rubygems'
require 'selenium-webdriver'
require 'test/unit'
require 'pry'



class MyOwnSpaghetti < Test::Unit::TestCase

  def test_customer_service_email
    # open browser
    fox_driver = Selenium::WebDriver.for(:firefox)
    fox_driver.get("http://automationpractice.com")

    assert_equal("http://automationpractice.com/index.php", fox_driver.current_url)

    fox_driver.find_element(:id, "contact-link").click
    # assert we are in the rigth contacts page
    assert_equal("http://automationpractice.com/index.php?controller=contact", fox_driver.current_url)
=begin
    down vote
    Here's a better option that I found:

    #Select the dropdown button
    dropdown_list = driver.find_element(:id, 'check_list')

    #Get all the options from the dropdown
    options = dropdown_list.find_elements(tag_name: 'option')

    #Find the dropdown value by text
    options.each { |option| option.click if option.text == 'CHEESE' }
=end

    # click on SubjectHeading
    binding.pry
    # select the top div, and go into the div the select is tigged under
    fox_driver.find_element(:xpath, "//*[@id=\"id_contact\"]/descendant::span[text='-- Choose --']")
    dropdown_div.find_element(tag_name: 'select').click
    # FInd the id below, and click on the option based on nth-child we want
    # this below scrolls the page down
    fox_driver.find_element(:css, 'select#id_contact option:nth-child(1)').click

    # Alternative to the above
    # use xpath and get the id and span tag. Search for click issues.
    fox_driver.find_element(:xpath, 'uniform-id_contact').click

    # click on EmailAddress
    fox_driver.find_element(:id, "email").send_keys("f.hernandez173+1234567@gmail.com")
    # click on Order Reference
    fox_driver.find_element(:id, "id_order").send_keys("shirt order")
    # click on Message
    fox_driver.find_element(:id, "message").send_keys("Testing the contacts page with this message #{ENV['USERNAME'] || ENV['USER']}")
    # Press send
    fox_driver.find_element(:id, "submitMessage").click
    # assertion to confirm message went through
    assert_equal("Your message has been successfully sent to our team.", fox_driver.find_element(:class, "alert alert-success".text))

    fox_driver.quit
  end

  # def test_searching_for_item
  #   fox_driver = Selenium::WebDriver.for(:firefox)
  #   fox_driver.get("http://automationpractice.com")
  #
  #   # Find search bar and use .clear
  #   fox_driver.find_element(:id, "search_query_top").clear
  #   # input something to search
  #   fox_driver.find_element(:id, "search_query_top").send_keys("shirts")
  #   fox_driver.find_element(:name, "submit_search").click
  #   # find a certain item, and click on it, confirm I clicked on something
  #   # issue below selecting what I want
  #   fox_driver.find_element(:css, "a.product-name").click
  #   # assertion to confirm I am in the right page
  #   # add to cart
  #   fox_driver.find_element(:id, "add_to_cart").find_element(:class, "exclusive").click
  #
  #   fox_driver.quit
  #
  # end

end


=begin

Spaghetti pattern, an anti-pattern, involves lack of percieved architecture
and design. There are single tests or multiple tests intertwined so tightly
together it becomes difficult to tell one apart from another. Tests depends
on execution order of all tests, tends to over-share internal private
components.

Selecting dropdown:
https://www.getdrip.com/deliveries/zwsgzvxxeybaxe29bgpe?__s=gpqtcoipuyd7foxcygax

http://stackoverflow.com/questions/5665307/how-to-search-dom-elements-using-xpath-or-css-selectors-in-chrome-developer-tool

Locating element by link
http://www.software-testing-tutorials-automation.com/2014/01/how-to-locate-element-by-link-text-or.html

Automation book
https://www.packtpub.com/mapt/book/Web+Development/9781783982707/2/ch02lvl1sec17/Testing+the+product+review+functionality

Automation practice sites
http://www.seleniumframework.com/demo-sites/
http://automationpractice.com/index.php

Installed SelectorGadget extension to find what selector I want

=end
