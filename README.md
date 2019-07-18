# JwtDemo

## Setup

### 1. Generate private/public key pair

We don't include the keys in this demo, so you'll have to generate your own. Here's how to do that:

```
cd priv/keys

# Generate private key
openssl genrsa -out foo.pem 2048

# Generate public key
openssl rsa -in foo.pem -outform PEM -pubout -out foo.pub

# Repeat for bar.pem, etc.
```

### 2. Running the app

```
mix deps.get
iex -S mix
```

Now you can do some simple requests to the server at [localhost:8080](http://localhost:8080)

- POST `/login` - https://paw.pt/ekHmx2DQ
- GET `/users/profile` - https://paw.pt/ekHoCBWr
