require_relative '../config'

class CreateParties < ActiveRecord::Migration
  def self.change
    create_table :parties do |col|
      col.string :party
      col.belongs_to :congress_member
      col.timestamps
    end
  end
end
