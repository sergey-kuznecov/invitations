class Users::RegistrationsController < Devise::RegistrationsController
  before_filter :set_invitation_token, only: :new

  def new
    if get_current_invitation
      super
    else
      flash[:danger] = 'In order to register, you should get an invitation!'
      redirect_to root_path
    end
  end

  def create
    build_resource(sign_up_params)
    if resource.save
      get_current_invitation.destroy
      yield resource if block_given?
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      respond_with resource
    end
  end

  private

  def set_invitation_token
    session[:token] = params[:token]
  end

  def get_current_invitation
    Invitation.where(token: session[:token]).first
  end
end