defmodule TaskMaster.Project do
  use TaskMaster.Web, :model

  schema "projects" do
    field :name, :string
    field :description, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :description])
    |> validate_required([:name])
  end

  @doc """
  Constructs a changeset based on a new empty Project
  """
  def new(params \\ %{}) do
    changeset(%__MODULE__{}, params)
  end
end
