defmodule ScheduleManager.Disciplines do
  alias ScheduleManager.Disciplines.Delete
  alias ScheduleManager.Disciplines.GetAll
  alias ScheduleManager.Disciplines.GetDiscipline
  alias ScheduleManager.Disciplines.Create

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get_all(), to: GetAll, as: :call
  defdelegate get_discipline(id), to: GetDiscipline, as: :call
end
