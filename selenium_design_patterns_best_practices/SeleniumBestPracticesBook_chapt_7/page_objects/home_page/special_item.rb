# In SpecialItem class, each object initializes with element that WebDriver found on home page.

class SpecialItem

  def initialize(element, selenium)
    @selenium = selenium
    @element = element
  end

  def add_to_cart
    @element.find_element(:class, "add-to-cart").click
    @selenium.find_element(:id, "fancybox-outer").find_element(:class, "purAddToCart").click
  end

end
