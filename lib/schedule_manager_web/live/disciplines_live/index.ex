defmodule ScheduleManagerWeb.DisciplinesLive.Index do
  alias ScheduleManager.Disciplines.Discipline
  alias ScheduleManager.Disciplines
  use ScheduleManagerWeb, :live_view

  def mount(_params, _session, socket) do
    form =
      Discipline.changeset()
      |> to_form()

    socket = socket
    |> assign(disciplines: Disciplines.get)
    |> assign(form: form)

    {:ok, socket}
  end

  def string_to_list(""), do: []
  def string_to_list(string) do
  String.split(string)
  end

  def get_average([]), do: 0
  def get_average(results) do
    Enum.reduce(results, 0, fn x, acc ->  (Decimal.to_float(x) / length(results)) + acc end )
    |> Float.round(1)
  end

  def handle_event("create_discipline", %{"discipline" => discipline_params}, socket) do
      dates = string_to_list(discipline_params["exams_dates"])
      results = string_to_list(discipline_params["exams_results"])

      discipline =
        discipline_params
        |> Map.put("exams_dates", dates)
        |> Map.put("exams_results", results)

      Disciplines.create(discipline)

      socket = assign(socket, disciplines: Disciplines.get())

      {:noreply, socket}
  end

  def render(assigns) do
    ~H"""
    <header class="flex flex-col gap-1 mb-10 mx-auto text-center">
      <h1 class="text-6xl font-medium text-lime-400">Disciplines Manager</h1>
      <h3 class="text-2xl italic text-lime-200 font-light">
        The perfect way to organize your period!
      </h3>
    </header>

    <main class="flex flex-col w-9/10 gap-3 items-center justify-around">
    <div class="flex w-full flex-wrap justify-around items-center gap-6">
    <%= for discipline <- @disciplines do %>
      <.discipline_card dates={discipline.exams_dates} results={discipline.exams_results}>
        <:name> <%= discipline.name %></:name>Z
        <:local_and_hour> <%= discipline.hour %> </:local_and_hour>
        <:credits> <%= discipline.credits %> </:credits>
        <:final_average> <%= get_average(discipline.exams_results) %> </:final_average>
      </.discipline_card>
    <% end %>
    </div>

      <button
        type="submit"
        class="bg-lime-400 rounded-full w-[50px] h-[50px] hover:bg-lime-500"
        phx-click={show_modal("create-discipline-modal")}
      >
        <.icon name="hero-plus" class="h-6 w-6 text-lime-100" />
      </button>

      <.modal id="create-discipline-modal">
        <.form
        class="flex flex-col gap-4 justify-center items-center"
        phx-submit="create_discipline"
        for={@form}>
          <h2 class="text-lime-400 text-xl">Create a discipline!</h2>

          <div class="flex justify-around items-around w-full">
            <div class="flex flex-col items-around justify-center gap-2">
              <.input
                type="text"
                placeholder="Discipline name"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
                field={@form[:name]}
              />
              <.input
                type="text"
                placeholder="Discipline hour and day"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
                field={@form[:hour]}
              />
              <.input
                type="text"
                placeholder="Discipline credits"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
                field={@form[:credits]}
              />
            </div>

            <div class="h-[100] w-px text-lime-400 bg-lime-400">.</div>

            <div class="flex flex-col items-around justify-center gap-4">
              <.input
                type="text"
                placeholder="Discipline exams dates"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
                field={@form[:exams_dates]}
              />
              <.input
                type="text"
                placeholder="Discipline exams results"
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
                field={@form[:exams_results]}
              />
            </div>
          </div>

          <.button class="bg-lime-400/60 text-lime-200 hover:bg-lime-400/80 transition-opacity"
          type="submit"
          phx-click={hide_modal("create-discipline-modal")}>
            Create!
          </.button>
        </.form>
      </.modal>
    </main>
    """
  end
end
