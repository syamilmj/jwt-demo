use Mix.Config

config :jwt_demo, JwtDemo.Guardian,
  issuer: "jwt_demo",
  allowed_algos: ["RS512"],
  secret_fetcher: JwtDemo.Guardian.SecretFetcher,
  ttl: {1, :hour}
