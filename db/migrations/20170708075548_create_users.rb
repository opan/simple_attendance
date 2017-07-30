Hanami::Model.migration do
  change do
    create_table :users do
      primary_key :id

      column :username, String, null: false, unique: true
      column :email, String, null: false
      column :encrypted_password, String, null: false
      column :last_signed_in, DateTime

      column :created_at, DateTime, null: false
      column :updated_at, DateTime, null: false

      constraint(:username_constraint) { char_length(username) <= 100 }
    end
  end
end
