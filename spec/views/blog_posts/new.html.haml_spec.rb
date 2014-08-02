require 'spec_helper'

describe "blog_posts/new" do
  before(:each) do
    assign(:blog_post, stub_model(BlogPost,
                                  title: "some title 1",
                                  draft_body: "Draft Body 1",
                                  published_body: "Published Body 1").as_new_record)
  end

  it "renders new blog_post form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", blog_posts_path, "post" do
      assert_select "input#blog_post_title[name=?]", "blog_post[title]"
      assert_select "input#blog_post_draft_body,[name=?]", "blog_post[draft_body,]"
    end
  end
end
