# -*- encoding : utf-8 -*-
# OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE
Rails.application.config.middleware.use OmniAuth::Builder do
    provider :facebook, Setting.facebook_app_id, Setting.facebook_secret,
             :scope => 'email,user_mobile_phone'

    # OmniAuth.config.on_failure = UsersController.action(:failure)
end