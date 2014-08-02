require 'spec_helper'

describe "blog_posts/show" do
  before(:each) do
    @blog_post = assign(:blog_post, stub_model(BlogPost,
                                               title: "some title 1",
                                               draft_body: "Draft Body 1",
                                               published_body: "Published Body 1" ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/some title 1/)
    rendered.should match(/Draft Body 1/)
    rendered.should match(/Published Body 1/)
  end
end
