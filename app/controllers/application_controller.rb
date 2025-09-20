class ApplicationController < ActionController::API
  class << self
    def skip_auth_for(*actions)
      skip_before_action :authenticate_user!,   { only: actions, raise: false }
      skip_before_action :authenticate_request!, { only: actions, raise: false }
    end
  end
end
