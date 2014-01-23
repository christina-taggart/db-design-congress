class AddStartingTables < ActiveRecord::Migration
  def change
   create_table :politicians do |t|
      t.string :office_name, :first_name, :last_name, :gender
      t.integer :party_id, :state_id, :is_active?
      t.date :date_of_birth
      t.datetime :created_at, :updated_at
    end

    create_table :parties do |t|
      t.string :party_name
      t.datetime :created_at, :updated_at
    end

    create_table :contacts do |t|
      t.integer :politician_id
      t.string :phone, :fax, :website, :webform, :twitter_name
      t.datetime :created_at, :updated_at
    end

    create_table :states do |t|
      t.string :state_abbr
      t.datetime :created_at, :updated_at
    end

  end
end
