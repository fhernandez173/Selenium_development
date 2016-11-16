# Thsi class hides dta from Tests

require 'faker' # for later cart tests

class TestingData

  def self.site_url
    "http://automationpractice.com/index.php"
  end

 # URL extensions
 def self.url_extensions(key_searched)
   url_extension_hash = {
     "contact_page"       => "?controller=contact",
     "cart_summary_page"  => "?controller=order",
     "account_page"       => "?controller=authentication&back=my-account"
   }
   url_extension_hash.each do |key, value|
     if key_searched = key
       return value
     end
   end
 end

 def self.user_email
   Faker::Internet.email
 end

 def self.user_name
   Faker::Internet.user_name
 end

 def self.user_first_name
   Faker::Name.first_name
 end

 def self.user_last_name
   Faker::Name.last_name
 end

 def self.user_password
   Faker::Internet.password
 end

 def self.order_reference
   Faker::Number.number(8)
 end

 def self.message_box_input
   "I have an issue with #{self.order_reference}."
 end

 def self.search_term(search = true)
   if search == true
     return search_term = "dress"
   elsif search == false
     return search_term = "dbhwrthwthn"
   end
   # is false, give garbled non-sense
   # If true, give actual findable product
 end

end
