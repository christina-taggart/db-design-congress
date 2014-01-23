require_relative '../config'

class CreateStates < ActiveRecord::Migration
  def self.change
    create_table :states do |col|
      col.string :state
      col.belongs_to :congress_member
      col.timestamps
    end
  end
end
