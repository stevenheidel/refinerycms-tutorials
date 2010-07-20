class CreateTutorials < ActiveRecord::Migration

  def self.up
    create_table :tutorials do |t|
      t.string :title
      t.text :description
      t.string :category
      t.string :author
      t.text :content
      t.integer :position

      t.timestamps
    end

    add_index :tutorials, :id

    load(Rails.root.join('db', 'seeds', 'tutorials.rb'))
  end

  def self.down
    UserPlugin.destroy_all({:name => "Tutorials"})

    Page.find_all_by_link_url("/tutorials").each do |page|
      page.link_url, page.menu_match = nil
      page.deletable = true
      page.destroy
    end
    Page.destroy_all({:link_url => "/tutorials"})

    drop_table :tutorials
  end

end
