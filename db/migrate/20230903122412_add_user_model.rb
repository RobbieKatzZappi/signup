class AddUserModel < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
     t.string :first_name, null: false
     t.string :last_name, null: false
     t.string :email, null: false
     t.datetime :date_of_birth
     t.string :gender
     t.string :university
     t.string :password_digest, null: false
     t.string :current_session_id

     t.timestamps
   end
  end
end
