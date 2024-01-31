class Api::V1::AuthenticationController < ApplicationController
  skip_before_action :authenticate

  def login
    user = User.find_by(username: params[:username])
    authenticated_user = user&.authenticate(params[:password])

    if authenticated_user
      token = JsonWebToken.encode(user_id: user.id)
      expires_at = JsonWebToken.decode(token)[:exp]

      render json: { token:, expires_at: }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  def register
    user = User.new(user_params)

    if user.save
      render json: {status: "SUCCESS", message: "User was created successfully!", data: user}, status: :created
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private 

  def user_params
    params.permit(:username, :password_digest)
  end  
end
