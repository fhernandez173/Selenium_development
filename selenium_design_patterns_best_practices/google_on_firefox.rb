require 'selenium-webdriver'
require 'rubygems'

driver = Selenium::WebDriver.for(:firefox)
driver.get("http://awful-valentine.com/")
driver.find_element(:id, "searchinput").clear
driver.find_element(:id, "searchinput").send_keys("cheese")
driver.find_element(:id, "searchsubmit").click

driver.quit
