class CreateGoogleConnects < ActiveRecord::Migration[7.0]
  def change
    create_table :google_connects do |t|
      t.json :response, null: false
      t.string :access_token
      t.string :refresh_token
      t.boolean :active, default: false
      t.string :uid, unique: true
      t.datetime :token_expire_at
      t.belongs_to :user

      t.timestamps
    end
  end
end
