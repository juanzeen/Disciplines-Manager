defmodule ScheduleManager.Disciplines do
  alias ScheduleManager.Disciplines.Delete
  alias ScheduleManager.Disciplines.GetAll
  alias ScheduleManager.Disciplines.GetDiscipline
  alias ScheduleManager.Disciplines.GetDisciplineByName
  alias ScheduleManager.Disciplines.Create
  alias ScheduleManager.Disciplines.Update

  defdelegate create(params), to: Create, as: :call
  defdelegate delete(id), to: Delete, as: :call
  defdelegate get_all(), to: GetAll, as: :call
  defdelegate get_discipline(id), to: GetDiscipline, as: :call

  defdelegate get_discipline_by_name(name), to: GetDisciplineByName, as: :call
  defdelegate update(old_disc, new_disc), to: Update, as: :call
end
