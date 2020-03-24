defmodule CovidParser.Cron.Fetcher do

  @spec save_value(binary) :: :ok
  def save_value(url) do
    HTTPoison.start
    response = HTTPoison.get! url

    use Timex

    data =
      response.body
      |> Jason.decode!
      |> Map.put("latest_fetch", Timex.format!(Timex.now, "{YYYY}-{0M}-{0D} {h24}:{0m} UTC"))

    ConCache.put(:covid, :data, data)
  end

  @spec get_value :: map()
  def get_value do
    ConCache.get(:covid, :data)
  end
end
