defmodule Team8es.User do
  use Team8es.Web, :model

  @required_fields ~w(email password password_confirmation)
  @optional_fields ~w()

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true

    # Relationships
    has_one :group, Team8es.Group

    timestamps()
  end

  defp hash_password(%{valid?: false} = changeset), do: changeset
  defp hash_password(%{valid?: true} = changeset) do
      hashedpw = Comeonin.Bcrypt.hashpwsalt(Ecto.Changeset.get_field(changeset, :password))
      Ecto.Changeset.put_change(changeset, :password_hash, hashedpw)
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(model, params \\ %{}) do
      model
      |> cast(params, @required_fields)
      |> validate_format(:email, ~r/@/)
      |> validate_length(:password, min: 6)
      |> validate_confirmation(:password)
      |> validate_required([:email, :password])
      |> hash_password
      |> unique_constraint(:email)
    end
end
