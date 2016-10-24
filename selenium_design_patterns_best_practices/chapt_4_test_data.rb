require 'yaml'
require 'net/http'
require 'json' # required for API
require 'faker'

class TestData

  def self.get_full_name
    Faker::Name.name
  end

  def self.get_email
    Faker::Internet.email
  end

  def self.get_website
    Faker::Internet.url
  end

  # #get_buzzword created to use fortune 500 ad catch phrase
  def self.get_buzzword
    Faker::Company.catch_phrase
  end

  # creates a hash  and inserts faker data
  def self.get_comment_form_values(overwrites = {})
    {
      :name    => self.get_full_name,
      :email   => self.get_email,
      :url     => self.get_website,
      :comment => self.get_buzzword
    }.merge(overwrites)
  end

  # self keyword allows us ot directly call get_base_url method without
  # creating a new instance of TestData. This method also allows to change
  # the URL of our env.
  def self.get_base_url # this method also avoids hardcoding URL in code
    {
      "production" => "http://awful-valentine.com/",
      "staging"    => "http://staging.awful-valentine.com/",
      "test"       => "http://test.awful-valentine.com/"
    }[self.get_environment]
  end

  # method below uses ENV['environment'] to check the environment var in current system
  def self.get_environment
    ENV['environment'] || "test"
  end

  def self.get_product_fixtures
    fixture_file = File.join(File.dirname(__FILE__), 'chapt_4_yaml_fixtures.yml')
    YAML.load_file(fixture_file)
  end

  def self.get_product_from_api
    uri = URI.parse("http://api.awful-valentine.com/") # creates a URI obj from a string
    json_string = NET::HTTP.get(uri) # passed to method call to unparse JSON in return
    JSON.parse(json_string) # Parses the atring, returns a hash
  end

end
