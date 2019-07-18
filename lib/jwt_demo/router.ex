defmodule JwtDemo.Router do
  use Plug.Router

  plug(Plug.Parsers,
    parsers: [:json],
    pass: ["application/json"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  forward("/users", to: JwtDemo.Router.Private)

  post "/login" do
    %{"id" => id} = conn.body_params
    user = JwtDemo.Users.get(id)

    # let's emulate variable signing key id here
    kid = Enum.random(["foo", "bar"])

    conn
    |> put_resp_header("content-type", "application/json")
    |> JwtDemo.Guardian.Plug.sign_in(user, %{}, headers: %{kid: kid})
    |> authorize!()
  end

  match _ do
    send_resp(conn, 404, "Oops!")
  end

  def authorize!(conn) do
    user = JwtDemo.Guardian.Plug.current_resource(conn)
    token = JwtDemo.Guardian.Plug.current_token(conn)

    response =
      Jason.encode!(%{
        user: user,
        token: token
      })

    send_resp(conn, 201, response)
  end
end
