defmodule JwtDemo.Guardian do
  use Guardian, otp_app: :jwt_demo

  def subject_for_token(%{id: id}, _claims) do
    {:ok, id}
  end

  def subject_for_token(_, _) do
    {:error, :reason_for_error}
  end

  def resource_from_claims(claims) do
    id = claims["sub"]
    user = JwtDemo.Users.get(id)
    {:ok, user}
  end
end

defmodule JwtDemo.Guardian.ErrorHandler do
  import Plug.Conn

  def auth_error(conn, {_type, _reason}, _opts) do
    send_resp(conn, 403, "Unauthenticated")
  end
end
