class UsersController < ApplicationController
	def sign_in
  end

  def auth_fb
    auth_hash = request.env['omniauth.auth']
    if auth_hash
      authUser = User.where(:fb_id=> auth_hash['uid']).first
      if authUser
        authUser.update_attributes(:token => auth_hash['credentials']['token'])
      else
        authUser = User.new({ fb_id: auth_hash['uid'],
                              token: auth_hash['credentials']['token'],
                               name: auth_hash['info']['name'],
                              email: auth_hash['info']['email']})
        authUser.save
      end
      session[:UserInfo] = { id: authUser.id, fb_id: authUser.fb_id, name: authUser.name}
      redirect_to dashboard_path
    else
      redirect_to sign_failure_path
    end
  end

  def account
    @user = User.find(session[:UserInfo][:id])
  end

  def sign_upping
    @user = User.find(params[:user][:id]).update_attributes(user_params)
    authUser = User.find(params[:user][:id])
    session[:UserInfo] = { :id => authUser.id, :fb_id => authUser.fb_id, :name => authUser.name}
    redirect_to root_path
  end

  def sign_out
    session.delete(:UserInfo)
    reset_session
    redirect_to root_path
  end

  def failure
    # flash[:notice] = 'failure'
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:name, :email)
  end
end
