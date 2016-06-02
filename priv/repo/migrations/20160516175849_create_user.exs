defmodule AuthApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration
  
  def change do
	execute "CREATE EXTENSION \"uuid-ossp\""
	
    create table(:users, primary_key: false) do
	  add :user_id, :uuid, primary_key: true, default: fragment("uuid_generate_v4()")
      add :email, :string
	  add :username, :string
	  add :password_hash, :string
	  add :password, :string
      add :first, :string
      add :middle, :string
      add :last, :string
      add :address_type, :string
      add :street, :string
      add :street2, :string
      add :city, :string
      add :state, :string
      add :province, :string
      add :country, :string
      add :postalcode, :string
      add :zipcode, :string
      add :access_level, :string
      add :last_login, :datetime
      add :archived, :integer

      timestamps
    end

    create index(:users, [:email], unique: true)
	create index(:users, [:username], unique: true)
  end
end
