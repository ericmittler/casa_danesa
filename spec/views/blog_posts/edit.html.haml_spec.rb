require 'spec_helper'

describe "blog_posts/edit" do
  before(:each) do
    @blog_post = assign(:blog_post, stub_model(BlogPost,
                                               title: "",
                                               draft_body: "Draft Body",
                                               published_body: "Published Body"))
  end

  it "renders the edit blog_post form" do
    render
    assert_select "form[action=?][method=?]", blog_post_path(@blog_post), "post" do
      assert_select "input#blog_post_title[name=?]", "blog_post[title]"
      assert_select "input#blog_post_draft_body,[name=?]", "blog_post[draft_body,]"
    end
  end
end
