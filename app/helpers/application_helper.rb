module ApplicationHelper
  # 页面标题
  def full_title(page_title = '')
    base_title = '审核系统'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
