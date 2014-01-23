require_relative '../config'

class CreateCongressMembers < ActiveRecord::Migration
  def self.change
    create_table :congress_members do |col|
      col.string :title
      col.string :firstname
      col.string :lastname
      col.string :phone
      col.string :fax
      col.string :website
      col.string :webform
      col.string :gender
      col.string :twitter_id
      col.integer :in_office
      col.timestamps
    end
  end
end
