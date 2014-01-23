require_relative '../config'

class CreateSenators < ActiveRecord::Migration
  def change
    create_table :senators do |t|
      t.string :name
      t.string :phone
      t.string :fax
      t.string :website
      t.string :webform
      t.string :gender
      t.date   :birthday
      t.string :twitter_id
      t.integer :active
      t.integer :party_id
      t.integer :state_id

      t.timestamps
    end
  end
end
