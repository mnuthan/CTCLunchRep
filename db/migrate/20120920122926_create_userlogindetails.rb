class CreateUserlogindetails < ActiveRecord::Migration
  def change
    create_table :userlogindetails do |t|
      t.string :username
      t.string :useremail
      t.string :userpassword
      t.integer :mobileno

      t.timestamps
    end
  end
end
