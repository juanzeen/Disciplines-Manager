defmodule ScheduleManager.Repo.Migrations.CreateDisciplines do
  use Ecto.Migration

  def change do
    create table(:disciplines) do
      add :name, :string, null: false
      add :hour, :string, null: false
      add :exams_date, {:array, :string}, null: false
      add :exams_note, {:array, :decimal}, null: false
      add :credits, :decimal, null: false
    end
  end
end
