module ApplicationHelper
  def body_class
    "#{controller.controller_path} #{controller.action_name}"
  end
end
