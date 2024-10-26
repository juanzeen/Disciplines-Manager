defmodule ScheduleManager.Disciplines.Update do
  alias ScheduleManager.Repo
  alias ScheduleManager.Disciplines.Discipline

  def call(old_disc, new_disc) do
    Discipline.changeset(old_disc, new_disc)
    |> Repo.update()
  end
end
