defmodule ScheduleManager.Disciplines.Create do
  alias ScheduleManager.Repo
  alias ScheduleManager.Disciplines.Discipline

  def call(discipline_map) do
    %Discipline{}
    |> Discipline.changeset(discipline_map)
    |> Repo.insert()
  end
end
