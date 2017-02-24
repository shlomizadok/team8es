defmodule Team8es.Group do
  use Team8es.Web, :model

  schema "groups" do
    field :name, :string
    field :description, :string
    field :mailing_list_email, :string
    belongs_to :user, Team8es.User

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description, :mailing_list_email])
    |> validate_required([:name, :description])
    |> validate_format(:mailing_list_email, ~r/@/)
  end
end
