class ApplicationController < ActionController::Base

  #↓controllerにログインしていない場合にログイン画面に推移する記述(:topより、topアクションはアクセス可能)
  before_action :authenticate_user!,except: [:top]

  before_action :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
    user_path(current_user.id)
  end

  private

   def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email,:remember_me])
    end
end
