class SessionsController < ApplicationController
  skip_before_action :authenticate!
  without_sidebar only: [:new, :create]

  # GET /login
  # 登录页面
  def new
    # 禁止 IE <= 10 登录
    match = /MSIE\s([\d.]+)/.match(request.headers['User-Agent'])
    render 'unsupported_browser' if match && match[1].to_f < 11
  end

  # POST /login
  def create
    reset_session
    user = User.find_by(username: params[:username])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id

      redirect_to sanitized_redirect_url, notice: '登录成功'
    else
      flash.now[:notice] = '账户密码错误'
      render :new
    end
  end

  # DELETE /logout
  # 退出登录
  def destroy
    reset_session
    redirect_to login_url, notice: '退出成功'
  end

  private

  # 防范 Open Redirection Attack
  # http://guides.rubyonrails.org/security.html#redirection
  def sanitized_redirect_url
    return root_path if params[:redirect_url].blank?
    uri = URI.parse params[:redirect_url]
    # 只允许当前使用的 host, port
    if (uri.host && uri.host != request.host) || (uri.port && uri.port != request.port)
      root_path
    else
      params[:redirect_url]
    end
  end
end
