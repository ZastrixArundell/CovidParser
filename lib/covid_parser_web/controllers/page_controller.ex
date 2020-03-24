defmodule CovidParserWeb.PageController do
  use CovidParserWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
