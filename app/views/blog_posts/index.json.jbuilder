json.array!(@blog_posts) do |blog_post|
  json.extract! blog_post, :id, :title, :draft_body, :published_body, :published_at
  json.url blog_post_url(blog_post, format: :json)
end
