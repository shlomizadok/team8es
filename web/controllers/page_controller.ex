defmodule Team8es.PageController do
  use Team8es.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
