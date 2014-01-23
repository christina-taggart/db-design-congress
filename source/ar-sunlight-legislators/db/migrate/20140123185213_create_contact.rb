require_relative '../config'

class CreateContact < ActiveRecord::Migration
  def change
    create_table :contacts do |col|
      col.string :phone
      col.string :fax
      col.string :website
      col.string :webform
      col.string :twitter_id
      col.integer :congress_member_id
    end
  end
end
