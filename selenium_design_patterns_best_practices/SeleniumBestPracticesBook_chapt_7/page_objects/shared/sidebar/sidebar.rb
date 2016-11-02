# Since the sidebar has an advertisement section, and the cart, we will need
# two getter methods, to return an object for each

class Sidebar

  def initialize(selenium)
    @selenium = selenium
  end

  def cart
    SidebarCart.new(@selenium)
  end

  def advertisement
    # optional
  end

end
