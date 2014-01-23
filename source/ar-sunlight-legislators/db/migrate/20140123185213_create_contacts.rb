require_relative '../config'

class CreateContacts < ActiveRecord::Migration
  def self.change
    create_table :contacts do |col|
      col.string :phone
      col.string :fax
      col.string :website
      col.string :webform
      col.string :twitter_id
      col.index :congress_member_id
    end
  end
end
