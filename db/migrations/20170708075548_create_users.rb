Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :username, String, size: 255, null: false, index: true, unique: true
      column :email, String, size: 255, null: false, index: true, unique: true
      column :encrypted_password, String, size: 255, null: false, index: true
      column :last_signed_in, DateTime

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      constraint(:username_constraint) { char_length(username) <= 100 }
    end
  end
end
