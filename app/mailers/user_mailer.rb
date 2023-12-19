class UserMailer < ApplicationMailer

    default from: 'amachermathieu@gmail.com'

    def welcome_email(user)
        @user = user
        
        @url = 'https://the-wedding-project-1b83c5344eda.herokuapp.com/users/sign_in'

        mail(to: @user.email, subject: "Votre inscription sur Ceremonia")
    end
    
end
