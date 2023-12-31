module ApplicationHelper
  include Pagy::Frontend

  def desktop_device?
    client = request.user_agent
    device = DeviceDetector.new(client).device_type

    device == 'desktop'
  end

  def format_due_date(due_date)
    return unless due_date.present?

    formatted_date = if due_date.is_a?(String)
                      Date.parse(due_date).strftime("%m-%d")
                    else
                      due_date.strftime("%b %d")
                    end

    formatted_date
  end

  def format_start_time(start_time)
    return unless start_time.present?

    time = if start_time.is_a?(String)
             Time.parse(start_time)
           else
             start_time
           end

    formatted_time = time.strftime("%I:%M %p")

    formatted_time
  end

  def remove_whitespace(text)
    text.gsub(/\s+/, '')
  end

  def profile_picture
    if current_user.avatar.presence
      current_user.avatar
    else
      current_user.gender_male? ? image_path("default_male") : image_path("default_female")
    end
  end

  def user_profile_picture(user)
    if user.avatar.presence
      user.avatar
    else
      user.gender_male? ? image_path("default_male") : image_path("default_female")
    end
  end
  def username
    current_user.username? ? current_user.username : current_user.email.split('@')[0]
  end

  def user_username(user)
    user.username? ? user.username : user.email.split('@')[0]
  end

  def truncate_text(text, length = 20, truncate_string = "...")
    if text.length > length
      text.truncate(length, omission: truncate_string)
    else
      text
    end
  end
end
