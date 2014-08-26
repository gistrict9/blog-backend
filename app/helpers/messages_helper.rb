module MessagesHelper

	# Bootstrap flash messages
  def bootstrap_class_for(flash_type)
    case flash_type
      when "success"
        "alert-success"
      when "error"
        "alert-danger"
      when "alert"
        "alert-danger"
      when "notice"
        "alert-info"
      when "timedout"
      	"hidden"
      else
        flash_type.to_s
    end
  end

end
