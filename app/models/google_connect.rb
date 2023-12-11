class GoogleConnect < ApplicationRecord
  belongs_to :user

  after_create do
    user.google_connects.update_all(active: false)

    credentials = response["credentials"]

    update_columns(
     access_token: credentials["token"],
     token_expire_at: Time.at(credentials["expires_at"]),
     refresh_token: credentials["refresh_token"],
     active: true
     )
  end

  def self.process_response(response, user_id)
    return { success: false } if response.blank?

    self.create(
      uid: response.uid,
      response: {
        info: response.info,
        credentials: response.credentials
      },
      user_id: user_id,
     )
     { success: true }
  end
end
