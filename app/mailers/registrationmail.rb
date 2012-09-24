class Registrationmail < ActionMailer::Base
  
  def registrationmailconfirm(user)
    default from: "from@example.com"
    recipients user.email
    subject "Thank you for registering"
    body :user=>user
  end
end
