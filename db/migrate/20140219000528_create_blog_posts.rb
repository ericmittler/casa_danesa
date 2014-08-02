class CreateBlogPosts < ActiveRecord::Migration
  def change
    create_table :blog_posts do |t|
      t.string :title
      t.text :draft_body
      t.text :published_body
      t.datetime :published_at

      t.timestamps
    end
  end
end
