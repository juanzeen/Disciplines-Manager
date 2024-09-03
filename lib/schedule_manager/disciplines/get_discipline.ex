defmodule ScheduleManager.Disciplines.GetDiscipline do
  alias ScheduleManager.Disciplines.Discipline
  alias ScheduleManager.Repo

  def call(id) do
    Repo.get(Discipline, id)
  end
end
