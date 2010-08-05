class AddDraftToTutorials < ActiveRecord::Migration
  def self.up
    add_column :tutorials, :draft, :boolean, :default => false
  end

  def self.down
    remove_column :tutorials, :draft
  end
end
