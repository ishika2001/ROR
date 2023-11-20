class CrudNotificatonMailer < ApplicationMailer
    def create_notification(object)
        @object = object
        @object_count =object.class.count
        # attachments['code.png'] = File.read('/home/developer/Pictures/code.png')
        mail to: "demo@mailinator.com", 
        bcc: User.all.pluck(:email),
        subject:"New #{object.class} has been created!"
    end
  

    def welcome(object)
      @object = object
      mail to: @object.email, subject: "Welcome to the event management platform!"
    end
end
