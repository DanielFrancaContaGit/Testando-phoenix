defmodule HelloWeb.Router do
  use HelloWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {HelloWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", HelloWeb do
    pipe_through :browser

    get "/", PageController, :home
    get "/coxinha", PageController, :coxinha
  end

  scope "/users", HelloWeb do
    pipe_through :browser

    get "/", UserController, :index
    get "/new", UserController, :new
    post "/", UserController, :create
    get "/:id", UserController, :show
    get "/:id/edit", UserController, :edit
    put "/:id", UserController, :update
    delete "/:id", UserController, :delete
  end

  scope "/todo", HelloWeb do
    pipe_through :browser

    get "/", TodoController, :index
    get "/new", TodoController, :new
    post "/", TodoController, :create
    get "/:id", TodoController, :show
    get "/:id/edit", TodoController, :edit
    put "/:id", TodoController, :update
    delete "/:id", TodoController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", HelloWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:hello, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: HelloWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
