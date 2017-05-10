class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  protect_from_forgery with: :null_session, if: -> { request.format.json? }
  attr_reader :current_user

  before_action :authenticate!

  # 不显示侧边栏、顶栏
  # 参数与 before_action 相同
  def self.without_sidebar(*args)
    before_action(*args) do
      @without_sidebar = true
    end
  end

  protected

  def authenticate!
    @current_user = session[:user_id] && User.find_by(id: session[:user_id])
    # 如已登录，或正在登录，就不跳转到登录页面
    return if @current_user || controller_name == 'sessions'
    redirect_to login_path(redirect_url: request.original_fullpath)
  end
end
