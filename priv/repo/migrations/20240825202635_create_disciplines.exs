defmodule ScheduleManager.Repo.Migrations.CreateDisciplines do
  use Ecto.Migration

  def change do
    create table(:disciplines) do
      add :name, :string, null: false
      add :hour, :string, null: false
      add :exams_dates, {:array, :string}, null: false
      add :exams_results, {:array, :decimal}, null: false
      add :credits, :decimal, null: false
    end
    create unique_index(:disciplines, :name)
  end

end
