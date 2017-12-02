class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  skip_before_action :refresh_notifications
  before_action :message_if_account_not_found, only: :new

  # GET /resource/sign_in
  def new
    super
  end

  # POST /resource/sign_in
  def create
    super
  end

  # DELETE /resource/sign_out
  def destroy
    super
  end

  private

  def message_if_account_not_found
    if !user_signed_in? && params[:user]
      flash[:alert] = "The email or phone number you’ve entered doesn’t match any account. 
                      #{view_context.link_to('Sign up for an account', new_user_session_path)}.".html_safe
    end
  end
end
