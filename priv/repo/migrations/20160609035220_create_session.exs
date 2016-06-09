defmodule AuthApi.Repo.Migrations.CreateSession do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :token, :string
      add :user_id, references(:users, [on_delete: :nothing, column: :user_id, type: :uuid])

      timestamps
    end

    create index(:sessions, [:user_id])
    create index(:sessions, [:token])

  end
end