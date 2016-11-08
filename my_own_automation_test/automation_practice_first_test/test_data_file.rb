# Thsi class hides dta from Tests

require 'faker'

class TestingData

  def self.site_url
    "http://automationpractice.com/index.php"
  end

 # URL extensions
 def self.url_extensions(key_searched)
   url_extension_hash = {
     "contact_page" => "controller=contact",
     "cart_summary_page" => "?controller=order"
   }
   url_extension_hash.each do |key, value|
     if key_searched = key
       return value
     end
 end

end
