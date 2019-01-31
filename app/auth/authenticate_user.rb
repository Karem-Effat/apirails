class AuthenticateUser
    prepend SimpleCommand
    attr_accessor :email, :phone

    #this is where parameters are taken when the command is called
    def initialize(email, phone)
      @email = email
      @phone = phone
    end

    #this is where the result gets returned
    def call
      JsonWebToken.encode(user_id: user.id) if user
    end

    private

    def user
      user = User.where(email: email , phone: phone).first
    #  UserMailer.welcome_email(@user).deliver_now
      return  user
      errors.add :user_authentication, 'Invalid credentials'
      nil
    end
  end
