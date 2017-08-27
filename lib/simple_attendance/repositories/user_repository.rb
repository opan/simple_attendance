# frozen_string_literal: true

class UserRepository < Hanami::Repository
  def create_with_password(params)
    enc_password = BCrypt::Password.create(params[:password])
    create(
      username: params[:username],
      email: params[:email],
      encrypted_password: enc_password,
      last_signed_in: Time.now.utc
    )
  end

  def authenticate!(username, password)
    user = users.where(username: username).first
    return nil if user.nil?
    return user if BCrypt::Password.new(user.encrypted_password) == password
    nil
  end

  def query(*conditions)
    users.where(*conditions)
  end
end
