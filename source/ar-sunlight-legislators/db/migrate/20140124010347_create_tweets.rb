class CreateTweets < ActiveRecord::Migration
  def change
     create_table :tweets do |t|
      t.string :legislator_id
      t.string :text
      t.timestamps
    end
  end
end