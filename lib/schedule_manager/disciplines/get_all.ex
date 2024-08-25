defmodule ScheduleManager.Disciplines.GetAll do
  alias ScheduleManager.Disciplines.Discipline

  def call() do
    ScheduleManager.Repo.all(Discipline)
  end

end
