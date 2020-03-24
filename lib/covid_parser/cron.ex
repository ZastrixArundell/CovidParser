defmodule CovidParser.Cron do
  use Quantum, otp_app: :covid_parser

  @doc """
  Call the function which starts the latest update.
  """
  def update_cache do
    url = Application.get_env(:covid_parser, __MODULE__, :covid_data_url)
    CovidParser.Cron.Fetcher.get_value(url[:covid_data_url])
    :ok
  end
end
