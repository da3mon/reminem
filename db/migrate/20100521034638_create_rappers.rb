class CreateRappers < ActiveRecord::Migration
  def self.up
    create_table :rappers do |t|
      t.string :name
      t.text :album_count
      t.timestamps
    end
  end

  def self.down
    drop_table :rappers
  end
end
