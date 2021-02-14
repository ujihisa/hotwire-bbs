class ApplicationController < ActionController::Base
  def root
    render plain: 'ok'
  end
end
