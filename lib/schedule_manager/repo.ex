defmodule ScheduleManager.Repo do
  use Ecto.Repo,
    otp_app: :schedule_manager,
    adapter: Ecto.Adapters.Postgres
end
