class HomePage < Page

  def page_path # class starts with declaring the path of the existing path
    "/"
  end

  def body # homepage technically does not have a body
    nil
  end

  # Methods below access unique page sections in home page
  def special_items
    @selenium.find_elements(:class, "special-item").collect do |element|
      SpecialItem.new(element, @selenium)
    end
  end

  def featured_item_carousel
    # implement me
  end

  def recent_products
    # implement me
  end

end
