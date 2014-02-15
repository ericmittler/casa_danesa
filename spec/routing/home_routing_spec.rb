require 'spec_helper'

describe HomeController do

  describe 'routing to home' do
    it 'routes to #index' do
      {:get => "/"}.should route_to("home#index")
      {:get => "/home"}.should route_to("home#index")
    end
  end

end