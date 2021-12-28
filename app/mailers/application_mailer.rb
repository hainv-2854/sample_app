class ApplicationMailer < ActionMailer::Base
  default from: Settings.email.mail_personal
  layout "mailer"
end
