class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception

  # layout
  layout :layout_by_resource
  def layout_by_resource
    case request.fullpath
    when root_path
      "index"
    # when sign_in_path
    #   "sign_in"
    # when dashboard_root_path
    #   "dashboard"
    end
  end
end
