class ApplicationController < ActionController::Base

  # Callbacks
  before_action :authenticate_user!

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

 	# Callbacks
 	layout :layout_by_view

  protected

  # Layout by view
  def layout_by_view
  	if devise_controller?
  		"authentication"
  	else
  		"application"
  	end
  end

  # Devise paths
  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end

end
