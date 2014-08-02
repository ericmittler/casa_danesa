require 'spec_helper'

describe 'Blogs' do

  it 'does CRUD' do
    #@request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials('eric', 'github readers only')
    page.driver.browser.basic_authorize('eric', 'github readers only')
    visit 'blog_posts/new'
    fill_in 'Title', with: 'some clever title'
    fill_in 'Draft body', with: 'some body text'
    expect {
      click_button 'Save'
    }.to change(BlogPost, :count).by(1)
    last_blog_post = BlogPost.last
    expect(last_blog_post.title).to eq 'some clever title'
    expect(last_blog_post.draft_body).to eq 'some body text'
    expect(page).to have_selector '#notice', text: 'Blog post was successfully created.'
  end
end