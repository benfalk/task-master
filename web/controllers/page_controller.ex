defmodule TaskMaster.PageController do
  use TaskMaster.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
