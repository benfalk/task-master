defmodule TaskMaster.ProjectChannel do
  @moduledoc """
  This module is responsible for the high level on-going with projects.
  It notifies users of when projects are created, deleted, or updated,
  and allows a user to also perform those actions as well.
  """
  use TaskMaster.Web, :channel

  def join("projects", _, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_in("create", project_params, socket) do
    case Project.new(project_params) |> Repo.insert do
      {:ok, project} ->
        broadcast! socket, "created", project
        {:reply, :ok, socket}

      {:error, _} ->
        {:reply, :error, socket}
    end
  end

  def handle_in("delete", %{"id"=>id}, socket) do
    case Repo.get(Project, id) do
      nil ->
        {:reply, :error, socket}

      project ->
        TaskMaster.Repo.delete(project)
        broadcast! socket, "deleted", project
        {:reply, :ok, socket}
    end
  end

  def handle_in("update", %{"id"=>id}=params, socket) do
    case Repo.get(Project, id) do
      nil ->
        {:reply, :error, socket}

      project ->
        case Project.changeset(project, params) |> Repo.update do
          {:error, _} ->
            {:reply, :error, socket}

          {:ok, project} ->
            broadcast! socket, "updated", project
            {:reply, :ok, socket}
        end
    end
  end

  def handle_info(:after_join, socket) do
    projects = Repo.all(Project)
    push(socket, "sync_project_list", %{projects: projects})
    {:noreply, socket}
  end
end
