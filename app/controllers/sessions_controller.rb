class SessionsController < ApplicationController
  allow_unauthenticated_access only: %i[ new create signup newuser]
  rate_limit to: 10, within: 3.minutes, only: :create, with: -> { redirect_to new_session_url, alert: "Try again later." }

  def new
  end

  def show
    redirect_to new_session_path
  end

  def signup
    @user = User.new
  end

 def newuser
    @user = User.new(email_address: params[:email_address], password: params[:password])

    if @user.save
      redirect_to new_session_path, notice: "Signup successful!"
    else
      flash.now[:alert] = @user.errors.full_messages.to_sentence
      render :signup, status: :unprocessable_entity
    end
 rescue => e
    Rails.logger.error("Signup error: #{e.message}")
    flash.now[:alert] = "An error occurred during signup"
    render :signup, status: :unprocessable_entity
 end

  def create
    if user = User.authenticate_by(params.permit(:email_address, :password))
      start_new_session_for user
      redirect_to after_authentication_url
    else
      redirect_to new_session_path, alert: "Try another email address or password."
    end
  end

  def destroy
    terminate_session
    redirect_to new_session_path
  end
end
