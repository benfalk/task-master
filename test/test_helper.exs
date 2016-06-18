ExUnit.start

Mix.Task.run "ecto.create", ~w(-r TaskMaster.Repo --quiet)
Mix.Task.run "ecto.migrate", ~w(-r TaskMaster.Repo --quiet)
Ecto.Adapters.SQL.begin_test_transaction(TaskMaster.Repo)

