require 'spec_helper'

describe ApplicationHelper do
  describe 'body_class' do
    it 'returns the name of the controller and action' do
      controller.stub(:controller_path).and_return 'happy_cats'
      controller.stub(:action_name).and_return 'index'
      expect(helper.body_class).to eq 'happy_cats index'
    end
  end
end