defmodule ScheduleManagerWeb.DisciplinesLive.Index do
  require Decimal
  alias ScheduleManager.Disciplines.Discipline
  alias ScheduleManager.Disciplines
  use ScheduleManagerWeb, :live_view

  def mount(_params, _session, socket) do
    form =
      Discipline.changeset()
      |> to_form()

      to_delete_confirm =  %{discipline_name: nil} |> to_form()

    socket =
      socket
      |> assign(disciplines: Disciplines.get_all())
      |> assign(form: form)
      |> assign(to_delete_discipline: %Discipline{})
      |> assign(to_delete_confirm: to_delete_confirm)

    {:ok, socket}
  end

  def string_to_list(""), do: []

  def string_to_list(string) do
    String.split(string)
  end

  def get_average([]), do: 0

  def get_average(results) do
    Enum.reduce(results, 0, fn x, acc -> Decimal.to_float(x) / length(results) + acc end)
    |> Float.round(1)
  end

  def get_texts_from_list(list, acc \\ "")
  def get_texts_from_list([], acc), do: acc
  def get_texts_from_list(nil, acc), do: acc

  def get_texts_from_list([h | t], acc) do
    cond do
      is_binary(h) -> get_texts_from_list(t, acc <> h <> " ")
      Decimal.is_decimal(h) -> get_texts_from_list(t, acc <> Decimal.to_string(h) <> " ")
      true -> nil
    end
  end

  def handle_event("create_discipline", %{"discipline" => discipline_params}, socket) do
    dates = string_to_list(discipline_params["exams_dates"])
    results = string_to_list(discipline_params["exams_results"])

    discipline =
      discipline_params
      |> Map.put("exams_dates", dates)
      |> Map.put("exams_results", results)

    Disciplines.create(discipline)

    socket = assign(socket, disciplines: Disciplines.get_all())

    {:noreply, socket}
  end

  def handle_event("get_discipline_to_delete", %{"discipline_name" => name}, socket) do
    socket = assign(socket, to_delete_discipline: Disciplines.get_discipline_by_name(name))
    {:noreply, socket}
  end

  def handle_event("delete_discipline", %{"delete-discipline-name-input" => delete_input}, socket) do
    if(delete_input === socket.assigns.to_delete_discipline.name) do
      Disciplines.delete(socket.assigns.to_delete_discipline.id)
    end

    socket = socket
    |> assign(disciplines: Disciplines.get_all())

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

    <main class="flex flex-col w-9/10 gap-3 items-center justify-around relative">
      <div class="flex w-full flex-wrap justify-around items-center gap-6">
        <%= for discipline <- @disciplines do %>
          <.discipline_card dates={discipline.exams_dates} results={discipline.exams_results}>
            <:name><%= discipline.name %></:name>
            <:local_and_hour><%= discipline.hour %></:local_and_hour>
            <:credits><%= discipline.credits %></:credits>
            <:final_average><%= get_average(discipline.exams_results) %></:final_average>
            <div class="flex justify-around items-center w-[150px] mx-auto">
              <button type="submit">
                <a href={"/update/#{discipline.id}"}>
                  <.icon
                    name="hero-pencil"
                    class="w-[22px] h-[22px] bg-zinc-700/50 hover:bg-lime-600 cursor-pointer transition-all"
                  />
                </a>
              </button>

              <button class="open-delete-modal">
                <.icon
                  phx-click={
                    JS.push("get_discipline_to_delete",
                      value: %{"discipline_name" => discipline.name}
                    )
                  }
                  name="hero-x-mark-solid"
                  class="w-[22px] h-[22px] bg-zinc-700/50 hover:bg-red-700 cursor-pointer transition-all"
                />
              </button>
            </div>
          </.discipline_card>
        <% end %>
      </div>

      <button
        class="bg-lime-400 rounded-full w-[50px] h-[50px] hover:bg-lime-500"
        phx-click={show_modal("create-discipline-modal")}
      >
        <.icon name="hero-plus" class="h-6 w-6 text-lime-100" />
      </button>

      <.modal id="create-discipline-modal">
        <.form
          class="flex flex-col gap-4 justif
          y-center items-center"
          phx-submit="create_discipline"
          for={@form}
        >
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

            <div class="h-[100] w-px bg-zinc-100"></div>

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

          <.button
            class="bg-lime-400/60 text-lime-200 hover:bg-lime-400/80 transition-opacity"
            type="submit"
            phx-click={hide_modal("create-discipline-modal")}
          >
            Create!
          </.button>
        </.form>
      </.modal>

      <div
        id="delete-modal"
        class="w-[360px] h-[220px] bg-zinc-800 rounded-lg md:max-lg:w-11/12 flex flex-col items-center justify-evenly absolute transition-opacity bottom-50 left-50 z-10 bg-color-700/50 hidden"
      >
      <div class="w-3/4 flex justify-between">
        <h2 class="text-zinc-200 text-md">
          Remove <strong class="text-red-500"><%= @to_delete_discipline.name %></strong> ?
        </h2>
        <.icon
          id="hide-delete-modal"
          name="hero-x-mark-solid"
          class="w-[22px] h-[22px] bg-zinc-700/50 hover:bg-red-700 cursor-pointer transition-all"
        />
      </div>
        <.form
        class="flex flex-col items-center justify-around h-1/2"
        for={@to_delete_confirm}
        phx-submit="delete_discipline"
        >
          <div class="flex justify-around items-around w-full">
            <div class="flex flex-col items-around justify-center gap-2">
              <.input
                name="delete-discipline-name-input"
                placeholder={@to_delete_discipline.name}
                class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400 placeholder:text-zinc-100/50"
                field={@to_delete_confirm[:discipline_name]}
              />
            </div>
          </div>

          <.button
            class="bg-transparent text-red-400 hover:text-red-500 transition-opacity py-1 px-4"

            phx-submit={hide_modal("delete-modal")}
          >
            REMOVE
          </.button>
        </.form>
      </div>
    </main>
    """
  end
end
