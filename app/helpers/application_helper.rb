module ApplicationHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes['style'] = 'display: none'
    end
    content_tag('div', attributes, &block)
  end

  def current_time
    Time.now.strftime('%H:%M:%S')
  end
end
