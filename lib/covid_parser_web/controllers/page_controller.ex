defmodule CovidParserWeb.PageController do
  use CovidParserWeb, :controller

  @spec show(Plug.Conn.t(), any) :: Plug.Conn.t()
  def show(conn, params) do
    country = params["country"] || ""
    date = params["date"] || ""

    full =
      CovidParser.Cron.Fetcher.get_value()
      |> filter!(country, date)

    json(conn, full)
  end

  @doc """
  Filters the data map through data and country.
  """
  def filter!(full, country, date) do
    if country == nil && date == nil do
      full
    else
      latest_fetch = full["latest_fetch"]
      timestamped_data =
        full["timestamped_data"]
        |> filter_per_date!(date)
        |> filter_per_country!(country)

      %{"latest_fetch" => latest_fetch, "timestamped_data" => timestamped_data}
    end
  end

  @doc """
  Filter the data per date. It checks if the date starts
  with a custom string.
  """
  def filter_per_date!(timestamped_data, date) do
    Enum.filter timestamped_data, fn per_date ->
      String.starts_with?(per_date["date"], date)
    end
  end

  @doc """
  Filters the data per country. It checks if there are
  any countries which start with the given string. This is
  case agnostic.
  """
  def filter_per_country!(timestamped_data, country) do
    country = String.upcase(country)

    return =
      Enum.map timestamped_data, fn per_date ->
        areas =
          Enum.filter per_date["areas"], fn area ->
            name = String.upcase(area["name"])
            real_name = String.upcase(area["real_name"])

            name == country || real_name == country
          end

        %{per_date | "areas" => areas}
      end

    Enum.filter return, fn value -> !Enum.empty?(value["areas"]) end
  end
end
