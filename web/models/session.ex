defmodule AuthApi.Session do
  use AuthApi.Web, :model

  schema "sessions" do
    field :token, :string
    field :user_id, Ecto.UUID

    timestamps
  end

  @required_fields ~w(user_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def registration_changeset(model, params \\ :empty) do
    rand = SecureRandom.urlsafe_base64()
    model
    |> changeset(params)
    |> put_change(:token, rand)
  end
end