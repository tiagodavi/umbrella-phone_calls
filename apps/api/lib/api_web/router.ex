defmodule ApiWeb.Router do
  use ApiWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/api", ApiWeb, as: :api do
    pipe_through(:api)

    scope "/v1", Api.V1, as: :v1 do
      post("/telephone-calls", TelephoneSystemController, :create)
      get("/telephone-bills", TelephoneSystemController, :index)
    end
  end

  scope "/", ApiWeb do
    get("/*path", CatchAllController, :index)
  end
end
