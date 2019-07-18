defmodule JwtDemo.Guardian.SecretFetcher do
  @doc """
  It's a good idea to have multiple signing keys for your
  JWT. It's the current standard for IDaaS platforms like
  Auth0 and Cognito
  """
  def fetch_signing_secret(_, opts) do
    %{kid: kid} = Keyword.get(opts, :headers)
    {:ok, fetch(kid)}
  end

  @doc """
  Fetch the public key to verify JWT

  The only requirement here is that the provider MUST include
  its `kid` in the JWT header, so that we can get the correct
  public key stored on our side.

  We're using PEM files in this demo, but for performance
  reasons you might want to convert and combine them into
  JWKS file instead.

  More info on JWKS here: https://auth0.com/docs/jwks
  """
  def fetch_verifying_secret(_mod, %{"kid" => kid}, _opts) do
    {:ok, fetch(kid)}
  end

  def fetch_verifying_secret(_, _, _) do
    {:error, :invalid_token}
  end

  def fetch(kid) do
    :jwt_demo
    |> Application.app_dir("/priv/keys/#{kid}.pem")
    |> JOSE.JWK.from_pem_file()
  end
end
