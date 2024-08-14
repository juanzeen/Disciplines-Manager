defmodule ScheduleManager.Disciplines.Discipline do
  use Ecto.Schema
  import Ecto.Changeset

  @required_params [:name, :hour, :exams_dates, :credits, :exams_results]
  schema "disciplines" do
    field :name, :string
    field :hour, :string
    field :exams_dates, {:array, :string}
    field :credits, :decimal
    field :exams_reults, {:array, :decimal}
  end

  def changeset(discipline \\ %__MODULE__{}, params) do
    discipline
    |> cast(params, @required_params)
    |> validate_required(@required_params)
  end
end
