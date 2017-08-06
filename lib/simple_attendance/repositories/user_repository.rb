class UserRepository < Hanami::Repository
  def create_with_password(params)
    return nil if params[:password] != params[:password_confirmation]

    enc_password = BCrypt::Password.create(params[:password])
    debugger
    create(
      username: params[:username],
      email: params[:email],
      encrypted_password: enc_password,
      last_signed_in: Time.now.utc
    )
  end

  def authenticate!(username, password)
    user = users.
      where(username: username).
      first

    return nil if user.nil?
    debugger
    if user.encrypted_password == BCrypt::Password.new(password)
      user
    else
      nil
    end
  end
end
