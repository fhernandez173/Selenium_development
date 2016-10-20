class TestData

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

end
