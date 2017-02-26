defmodule Team8es.Repo.Migrations.AddUuidToGroups do
  use Ecto.Migration

  def change do
    alter table(:groups) do
      add :uuid, :string
      add :access_token, :binary
    end
  end
end
