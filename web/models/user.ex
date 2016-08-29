# web/models/user.ex
defmodule AuthApi.User do
  use AuthApi.Web, :model

  @primary_key {:user_id, Ecto.UUID, [autogenerate: true]}
  @derive {Phoenix.Param, key: :user_id}
  
  schema "users" do
    field :email, :string
    field :username, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :first, :string
    field :middle, :string
    field :last, :string
    field :address_type, :string
    field :street, :string
    field :street2, :string
    field :city, :string
    field :state, :string
    field :province, :string
    field :country, :string
    field :postalcode, :string
    field :zipcode, :string
    field :access_level, :string
    field :last_login, Ecto.DateTime
    field :archived, :integer

    timestamps
  end
  
  @required_fields ~w(email username password)
  @optional_fields ~w(password_hash middle first last address_type street street2 city state province country postalcode zipcode access_level last_login archived)

  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:email, min: 1, max: 255)
    |> validate_format(:email, ~r/@/)
    |> unique_constraint(:email)
    |> unique_constraint(:username)
  end
  
  def registration_changeset(model, params \\ :empty) do
    model
    |> changeset(params)
    |> cast(params, @required_fields, @optional_fields)
    |> validate_length(:password, min: 6)
    |> put_password_hash
  end

  defp put_password_hash(changeset) do
    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: pass}} ->
        put_change(changeset, :password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
      _ ->
        changeset
    end
  end
  
  defimpl Poison.Encoder, for: AuthApi.User do
    def encode(user, _options) do
      IO.puts "Encoding"
      user
      |> Map.from_struct
      |> Map.drop([:__meta__, :__struct__])
      |> Poison.encode!
    end
  end
end
