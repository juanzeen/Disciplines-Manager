defmodule ScheduleManagerWeb.DisciplinesLive.Index do
  use ScheduleManagerWeb, :live_view

  def render(assigns) do
    ~H"""
    <header class="flex flex-col gap-1 mb-10 mx-auto text-center">
      <h1 class="text-6xl font-medium text-lime-400">Disciplines Manager</h1>
      <h3 class="text-2xl italic text-lime-200 font-light">
        The perfect way to organize your period!
      </h3>
    </header>

    <main class="flex flex-col w-full gap-3 items-center">
      <.discipline_card dates={["01/01", "13/10", "09/08"]} results={["10.0", "9.2", "6.4"]}>
        <:name>Estrutura de Dados II</:name>
        <:local_and_hour>105 CCT - Seg, Quar -  10:00</:local_and_hour>
        <:credits>3</:credits>
        <:final_average>9.0</:final_average>
      </.discipline_card>

      <button type="submit" class="bg-lime-400 rounded-full w-[50px] h-[50px] hover:bg-lime-500">
        <h2 class="text-2xl text-zinc-100">+</h2>
      </button>
    </main>
    """
  end
end
