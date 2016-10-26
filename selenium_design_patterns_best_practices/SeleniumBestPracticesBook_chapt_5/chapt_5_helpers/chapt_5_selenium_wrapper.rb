# SeleniumWrapper class will be a single pont of contact between tests and web page being tested.

require 'selenium-webdriver'

class SeleniumWrapper

  def initialize(browser = :firefox) # creates a new instance of WebDriver
    # below we tak advantage of the browser's HTTP proxy settings. Our tests will
    # send all HTTP traffic without test env, to a fake proxy.
    profile = Selenium::WebDriver::Firefox::Profile.new # creates an instance of Firefox::Profile class
    profile["network.proxy.type"] = 1
    profile["network.proxy.http"] = "127.0.0.1" # proxy that does not exixts
    profile["network.proxy.http_port"] = 9999
    # Below tells profile to not use the proxy for any connectios going to localhost
    profile["network.proxy.no_proxies_on"] "localhost, 127.0.0.1, *awful-valentine.com"
    @fox_driver = Selenium::WebDriver.for(browser, :profile => profile)
  end

  def quit
    @fox_driver.quit
  end

  # method below allows time for animation to finish.
  def wait_for_animation
    Selenium::WebDriver::Wait.new(:timeout => 60).until do
      sleep 1
      # jQuery(':animated').length is used to knwo how many animations are in the page
      @fox_driver.execute_script("return jQuery(':animated').length") == 0
    end
  end

  # method below is used to handle AJAX requests.
  def wait_for_ajax
    # create inatnce of Wait provided by Selenium, time set to 60 secs or until AJAX requests == 0.
    Selenium::WebDriver::Wait.new(:timeout => 60).until do
      sleep 1
      @fox_driver.execute_script("return jQuery.active") == 0
    end
  end

  def wait_for_ajax_and_animation
    if jQuery_defined?
      wait_for_ajax
      wait_for_animation
    end
  end

  def type_text(text, element, strategy=:css)
    # wrapping methods with begin-rescue will help catch errors and screenshots of errors
    begin
      bring_current_window_to_front # locate the browser window and put it in view
      clear(element, strategy) # deletes any present text, avoids appending existing text with new text
      find_element(element, strategy).send_keys(text)
      wait_for_ajax_and_animation
    rescue Exception => e
      puts "Attempt to type #{text} into #{element} with strategy '#{strategy}' has failed"
      screenshot
      raise e
    end
  end

  def click(element, strategy=:css)
    begin
      bring_current_window_to_front
      find_element(element, strategy).click
      wait_for_ajax_and_animation
    rescue Exception => e
      puts "Attempt to click the #{element} with strategy '#{strategy}' has failed"
      screenshot
      raise e
    end
  end

  def get_inner_text(element, strategy=:css)
    find_element(element, strategy).text
  end

  def clear(element, strategy=:css)
    begin
      find_element(element, strategy).clear
    rescue Exception => e
      puts "Attempt to clear the #{element} has failed"
      screenshot
      raise e
    end
  end

  def find_element(element, strategy=:css)
    @fox_driver.find_element(strategy, element)
  end

  def screenshot
    screenshot_location = "images/#{Time.now.to_i}.png" # saves screenshot in images
    puts "Screenshot of the WebPage can be found here #{screenshot_location}"
    @fox_driver.save_screenshot(screenshot_location)
  end

  # locates browser window and puts it in display view, due to JS sometimes not triggered
  # when tests are running not in focus. Can cause test flakiness., ex. AJAX requests
  # are not trigered. http://elementalselenium.com/tips/4-work-with-multiple-windows
  def bring_current_window_to_front
    @fox_driver.switch_to.window(@fox_driver.window_handles.first)
  end

  def current_url
    @fox_driver.current_url
  end

  def get(url)
    @fox_driver.get(url)
  end

  def jQuery_defined?
    @fox_driver.execute_script("return typeof jQuery == 'function'")
  end

end
