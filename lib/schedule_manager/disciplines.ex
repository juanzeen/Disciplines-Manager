defmodule ScheduleManager.Disciplines do
  alias ScheduleManager.Disciplines.Delete
  alias ScheduleManager.Disciplines.GetAll
  alias ScheduleManager.Disciplines.Create
  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get(), to: GetAll, as: :call
end
