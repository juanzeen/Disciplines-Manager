defmodule ScheduleManager.Disciplines.Discipline do
  use Ecto.Schema
  import Ecto.Changeset

  schema "disciplines" do
    field :name, :string
    field :hour, :string
    field :exams_date, {:array, :string}
    field :credits, :decimal
    field :exams_note, {:array, :decimal}
  end
end
