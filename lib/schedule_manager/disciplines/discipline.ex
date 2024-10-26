defmodule ScheduleManager.Disciplines.Discipline do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:name, :credits]
  @additional_params [:hour, :exams_dates, :exams_results]
  schema "disciplines" do
    field :name, :string, default: ""
    field :hour, :string, default: ""
    field :exams_dates, {:array, :string}
    field :credits, :decimal, default: 0
    field :exams_results, {:array, :decimal}
  end

  def changeset(discipline \\ %__MODULE__{}, params \\ %{}) do
    discipline
    |> cast(params, @required_params)
    |> cast(params, @additional_params)
    |> validate_required(@required_params)
    |> unique_constraint(:name)
  end
end
