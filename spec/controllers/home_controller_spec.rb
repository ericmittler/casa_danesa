require 'spec_helper'

describe HomeController do

  describe '#index' do
    before :each do
      get :index
    end

    it 'displays the home page' do
      expect(response.status).to eq 200
      expect(response).to render_template 'index'
    end

    describe 'variable assignment' do
      it { expect(assigns :title).to eq 'The Casa Danesa Project' }
    end
  end

end