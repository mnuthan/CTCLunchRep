class Userlogindetail < ActiveRecord::Base
  attr_accessible :mobileno, :useremail, :username, :userpassword
  
  validates_presence_of :mobileno,:useremail,:username,:userpassword
  validates_uniqueness_of :username,:useremail,:mobileno
  validates :mobileno,:length=>{:maximum=>10}
  validates_length_of :userpassword,:within =>6..8
end
