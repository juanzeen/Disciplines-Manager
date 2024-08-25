defmodule ScheduleManager.Disciplines.Delete do
  alias ScheduleManager.Repo
  alias ScheduleManager.Disciplines.Discipline

  def call(id) do
   case discipline = Repo.get(Discipline, id) do
    %Discipline{} -> Repo.delete(discipline)
    nil -> IO.inspect("This discipline dont exist")
   end
  end
end
