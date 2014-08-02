require 'spec_helper'

describe "blog_posts/index" do
  before(:each) do
    assign(:blog_posts, [
      stub_model(BlogPost,
        title: "some title 1",
        draft_body: "Draft Body 1",
        published_body: "Published Body 1"
      ),
      stub_model(BlogPost,
        title: "some title 2",
        draft_body: "Draft Body 2",
        published_body: "Published Body 2"
      )
    ])
  end

  it "renders a list of blog_posts" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "some title 1".to_s, :count => 1
    assert_select "tr>td", :text => "Draft Body 1".to_s, :count => 1
    assert_select "tr>td", :text => "Published Body 1".to_s, :count => 1
    assert_select "tr>td", :text => "some title 2".to_s, :count => 1
    assert_select "tr>td", :text => "Draft Body 2".to_s, :count => 1
    assert_select "tr>td", :text => "Published Body 2".to_s, :count => 1
  end
end
