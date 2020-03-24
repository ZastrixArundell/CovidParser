defmodule CovidParser.Cron.Fetcher do

  def get_value(url) do
    HTTPoison.start
    response = HTTPoison.get! url
    ConCache.put(:covid, :data, Jason.decode! response.body)
  end
end
