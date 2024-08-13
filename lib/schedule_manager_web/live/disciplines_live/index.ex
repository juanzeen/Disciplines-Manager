defmodule ScheduleManagerWeb.DisciplinesLive.Index do
  use ScheduleManagerWeb, :live_view


  def render(assigns) do
    ~H"""
    <header class="flex flex-col gap-1">
    <h1 class="text-6xl font-medium text-lime-400"> Disciplines Manager</h1>
    <h3 class="text-2xl italic text-lime-200 font-light">The perfect way to organize your period!</h3>
    </header>

    <main>
    <.discipline_card>
      <:name> Estrutura de Dados II</:name>
      <:local_and_hour>105 CCT - Seg, Quar -  10:00</:local_and_hour>
      <:credits>3</:credits>
    </.discipline_card>


    <button type="submit" class="bg-lime-450 rounded-full">
     <!--   <Heroicons.LiveView.icon name="plus" class="text-zinc-100"/> -->

    </button>

    </main>
    """
  end
end
