# require_relative '../config'

class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :title, :party, :state, :name, :phone, :fax, :website, :email,
               :gender, :twitter_id
      t.date :birthday
      t.boolean :in_office

      t.timestamps
    end
  end
end
