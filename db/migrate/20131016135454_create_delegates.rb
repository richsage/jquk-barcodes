class CreateDelegates < ActiveRecord::Migration
  def change
    create_table :delegates do |t|
      t.integer :delegate_id
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :company

      t.timestamps
    end
  end
end
