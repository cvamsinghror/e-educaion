class EnrollmentMailer < ApplicationMailer
    default from: 'no-reply@yourapp.com'

    def welcome_email(user)
      @user = user
      mail(
        to: @user.email,
        subject: 'Welcome to Our course!',
        body: "Hello, #{@user.email}! \n\nThank you for successfully enroll  at our course. You can log in at http://yourapp.com/login. \n\nBest regards,\nThe Team",
        content_type: 'text/plain'
      )
    end
  end

