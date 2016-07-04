defmodule TaskMaster.ProjectChannelTest do
  use TaskMaster.ChannelCase
  alias TaskMaster.ProjectChannel
  alias TaskMaster.Project

  setup do
    {:ok, _, socket} =
        socket("", %{})
        |> subscribe_and_join(ProjectChannel, "projects", %{})

    {:ok, socket: socket}
  end

  test "it can be joined", %{socket: socket} do
    assert socket.joined
  end

  test "after joining, all projects are pushed" do
    assert_push "sync_project_list", %{projects: []}
  end

  test "successful project creation", %{socket: socket} do
    ref = push(socket, "create", %{"name"=>"testy"})
    assert_reply ref, :ok
    assert_broadcast "created", %Project{name: "testy"}
  end

  test "failed project creation", %{socket: socket} do
    ref = push(socket, "create", %{})
    assert_reply ref, :error
  end

  test "deleting successfully", %{socket: socket} do
    project = Project.new(%{name: "testy"}) |> Repo.insert!
    ref = push(socket, "delete", %{"id"=>project.id})
    assert_reply ref, :ok
    assert_broadcast "deleted", %Project{name: "testy"}
    refute Repo.get(Project, project.id)
  end

  test "deleting un-successfully", %{socket: socket} do
    ref = push(socket, "delete", %{"id"=>999_999})
    assert_reply ref, :error
  end

  test "update project successfully", %{socket: socket} do
    project = Project.new(%{name: "testy"}) |> Repo.insert!
    ref = push(socket, "update", %{"id"=>project.id, "name"=>"tested"})
    assert_reply ref, :ok
    assert_broadcast "updated", %Project{name: "tested"}
  end

  test "update project un-successfully", %{socket: socket} do
    ref = push(socket, "update", %{"id"=>90_210, "name"=>"nope"})
    assert_reply ref, :error
  end
end
