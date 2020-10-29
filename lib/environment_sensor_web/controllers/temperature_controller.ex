defmodule EnvironmentSensorWeb.TemperatureController do
  use EnvironmentSensorWeb, :controller

  def receive(conn, %{"temperature" => temperature}) do
    case Phoenix.PubSub.broadcast(EnvironmentSensor.PubSub, "new_temperature_reading", %{
           temperature: temperature
         }) do
      :ok ->
        conn
        |> send_resp(200, "")

      {:error, _term} ->
        conn
        |> send_resp(500, "")
    end
  end
end
