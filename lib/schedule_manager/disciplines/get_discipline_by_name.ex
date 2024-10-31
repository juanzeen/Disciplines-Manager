defmodule ScheduleManager.Disciplines.GetDisciplineByName do
  alias ScheduleManager.Disciplines.Discipline
  alias ScheduleManager.Repo

  def call(discipline_name) do
    Repo.get_by(Discipline, %{name: discipline_name})
  end
end
