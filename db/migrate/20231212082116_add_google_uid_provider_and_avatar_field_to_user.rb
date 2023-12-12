class AddGoogleUidProviderAndAvatarFieldToUser < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :google_uid, :string
    add_column :users, :google_provider, :string
  end
end
