defmodule BuDuoTravelWeb.Router do
  use BuDuoTravelWeb, :router
  import BuDuoTravelWeb.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_user
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug :fetch_user
  end

  scope "/", BuDuoTravelWeb do
    pipe_through :browser # Use the default browser stack

    post "/sessions", SessionController, :login
    delete "/sessions", SessionController, :logout   
    resources "/users", UserController 
    resources "/flights", FlightController
    resources "/hotels", HotelController
    resources "/chatrooms", ChatroomController
    get "/", PageController, :index
    post "/searchFlights", FlightController, :search
    post "/searchHotels", HotelController, :search
  end

  # Other scopes may use custom stacks.
   scope "/api", BuDuoTravelWeb do
   pipe_through :api
   end
end
