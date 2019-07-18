defmodule JwtDemo.Router.Private do
  use Plug.Router

  plug(Guardian.Plug.Pipeline,
    module: JwtDemo.Guardian,
    error_handler: JwtDemo.Guardian.ErrorHandler
  )

  plug(Guardian.Plug.VerifyHeader)
  plug(Guardian.Plug.LoadResource)
  plug(Guardian.Plug.EnsureAuthenticated)

  plug(:match)
  plug(:dispatch)

  get "/profile" do
    user = JwtDemo.Guardian.Plug.current_resource(conn)

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(200, Jason.encode!(user))
  end
end
