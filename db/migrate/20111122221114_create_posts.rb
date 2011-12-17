class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :posting_id
      t.string :status
      t.string :url
      t.string :title
      t.text :body
      t.string :loc
      t.string :comp
      t.date :posted

      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
