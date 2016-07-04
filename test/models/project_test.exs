defmodule TaskMaster.ProjectTest do
  use TaskMaster.ModelCase

  alias TaskMaster.Project

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Project.changeset(%Project{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Project.changeset(%Project{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "new generates a valid changeset" do
    changeset = Project.new(@valid_attrs)
    assert changeset.valid?
  end

  test "new generates an invalid changeset" do
    changeset = Project.new(@invalid_attrs)
    refute changeset.valid?
  end
end
