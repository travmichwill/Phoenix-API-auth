ExUnit.start

Mix.Task.run "ecto.create", ~w(-r AuthApi.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r AuthApi.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(AuthApi.Repo)

