defmodule ScheduleManagerWeb.DisciplinesLive.Update do
  alias ScheduleManagerWeb.DisciplinesLive.Index
  alias ScheduleManager.Disciplines.Discipline
  alias ScheduleManager.Disciplines
  use ScheduleManagerWeb, :live_view

  def mount(%{"id" => id}, _session, socket) do
    form =
      Discipline.changeset()
      |> to_form()

    socket =
      socket
      |> assign(current_discipline: ScheduleManager.Disciplines.get_discipline(id))
      |> assign(form: form)

    {:ok, socket}
  end

  def handle_event("edit_discipline", %{"discipline" => params}, socket) do
    new_dates = Index.string_to_list(params["exams_dates"])
    new_results = Index.string_to_list(params["exams_results"])

    edited_discipline =
      params
      |> Map.put("exams_dates", new_dates)
      |> Map.put("exams_results", new_results)
      |> Map.put("id", socket.assigns.current_discipline.id)

    Disciplines.update(socket.assigns.current_discipline, edited_discipline)

    put_flash(socket, :info, "Updated with success!")

    {:noreply, push_navigate(socket, to: ~p"/")}
  end

  def render(assigns) do
    ~H"""
    <div class="w-7/12 max-w-[1200px] h-[300px] bg-zinc-800 rounded-lg md:max-lg:w-11/12">
      <.simple_form
        class="flex flex-col gap-4 justify-center items-center py-5 px-2"
        phx-submit="edit_discipline"
        for={@form}
      >
        <h2 class="text-lime-300 text-xl">
          Edit the <strong class="text-lime-400"><%= @current_discipline.name %></strong> discipline!
        </h2>

        <div class="flex justify-around items-around w-full">
          <div class="flex flex-col items-around justify-center gap-2">
            <.input
              type="text"
              placeholder="Discipline name"
              class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              field={@form[:name]}
              value={@current_discipline.name}
            />
            <.input
              type="text"
              placeholder="Discipline hour and day"
              class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              field={@form[:hour]}
              value={@current_discipline.hour}
            />
            <.input
              type="text"
              placeholder="Discipline credits"
              class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              field={@form[:credits]}
              value={@current_discipline.credits}
            />
          </div>

          <div class="h-[100] w-px bg-zinc-100"></div>

          <div class="flex flex-col items-around justify-center gap-4">
            <.input
              type="text"
              placeholder="Discipline exams dates"
              class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              field={@form[:exams_dates]}
              value={Index.get_texts_from_list(@current_discipline.exams_dates)}
            />
            <.input
              type="text"
              placeholder="Discipline exams results"
              class="bg-transparent text-lime-200 rounded-md placeholder-green-100 border-lime-400"
              field={@form[:exams_results]}
              value={Index.get_texts_from_list(@current_discipline.exams_results)}
            />
          </div>
        </div>

        <.button
          class="bg-lime-400/60 text-lime-200 hover:bg-lime-400/80 transition-opacity py-1 px-4"
        >
          Edit!
        </.button>
      </.simple_form>
    </div>

    <.back navigate={~p"/"}>
      Go back to the list of disciplines
    </.back>
    """
  end
end
