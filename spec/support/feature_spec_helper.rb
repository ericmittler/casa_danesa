include BestInPlace::TestHelpers
include Warden::Test::Helpers
Warden.test_mode!

module FeatureMacros

end

Capybara.ignore_hidden_elements = true
module Capybara
  class Session
    def has_image?(src)
      has_xpath?("//img[contains(@src,\"/images/#{src}\")]")
    end
  end
end