class CreateArticles < ActiveRecord::Migration
  def self.up
    create_table :articles do |t|
      t.string :title, :limit => 100
      t.string :rubric, :limit => 100
      t.text :content
      t.text :autor, :limit => 100
      t.integer :release, :limit => 5000
      t.date :date

      t.timestamps
    end
  end

  def self.down
    drop_table :articles
  end
end
