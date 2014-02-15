require 'spec_helper'

describe 'Home' do
  describe 'GET /home' do
    before :each do
      visit '/'
    end

    it 'renders successfully' do
      expect(page.status_code).to be(200)
    end

    it 'displays the welcome page' do
      expect(page).to have_xpath '//body/img[@src="/assets/Casa-Danesa-Logo.png"]'
    end

    it 'displays the title' do
      expect(page).to have_title 'The Casa Danesa Project'
    end
  end
end