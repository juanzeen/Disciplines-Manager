defmodule ScheduleManagerWeb.DisciplinesLive.Index do
  use ScheduleManagerWeb, :live_view

  def mount(params, session, socket) do
    {:ok, socket}
  end

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
        <:final_average>10</:final_average>
      </.discipline_card>

      <button
        type="submit"
        class="bg-lime-400 rounded-full w-[50px] h-[50px] hover:bg-lime-500"
        phx-click={show_modal("create-discipline-modal")}
      >
        <.icon name="hero-plus" class="h-6 w-6 text-lime-100" />
      </button>

      <.modal id="create-discipline-modal" class="bg-zinc-100">
        <form class="flex flex-col gap-4 justify-center items-center">
          <h2 class="text-lime-400 text-xl">Create a discipline!</h2>

          <div class="flex justify-around items-around w-full">
            <div class="flex flex-col items-around justify-center gap-2">
              <input
                type="text"
                placeholder="Discipline name"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              />
              <input
                type="text"
                placeholder="Discipline hour and day"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              />
              <input
                type="text"
                placeholder="Discipline credits"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              />
            </div>

            <div class="h-[100] w-px text-lime-400 bg-lime-400">.</div>

            <div class="flex flex-col items-around justify-center gap-4">
              <input
                type="text"
                placeholder="Discipline exams dates"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              />
              <input
                type="text"
                placeholder="Discipline exams results"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              />
            </div>
          </div>

          <.button class="bg-lime-400/60 text-lime-200 hover:bg-lime-400/80 transition-opacity">
            Create!
          </.button>
        </form>
      </.modal>
    </main>
    """
  end
end
