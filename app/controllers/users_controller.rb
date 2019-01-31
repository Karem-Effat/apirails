class UsersController < ApplicationController
  skip_before_action :authenticate_request, only: %i[login register]
     # POST /register
      def register
        @user = User.create(user_params)
       if @user.save
        UserMailer.welcome_email(User.first).deliver_now
        response = { message: 'User created successfully'}
        render json: response, status: :created
       else
        render json: @user.errors, status: :bad
       end
      end

      def login

        authenticate params[:email], params[:phone]
      end
      def karem
        render json: {
              message: 'You have passed  '
            }
      end


      def authenticate(email, phone)
          command = AuthenticateUser.call(email, phone)
          UserMailer.welcome_email(User.first).deliver_now
          if command.success?
            render json: {
              access_token: command.result,
              message: 'Successful'
            }
          else
            render json: { error: command.errors }, status: :unauthorized
          end
         end



      private

      def user_params
        params.permit(
          :name,
          :email,
          :phone
        )
      end


    end
