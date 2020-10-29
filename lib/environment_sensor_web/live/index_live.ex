defmodule EnvironmentSensorWeb.IndexLive do
  use EnvironmentSensorWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket),
      do: Phoenix.PubSub.subscribe(EnvironmentSensor.PubSub, "new_temperature_reading")

    {:ok, socket, temporary_assigns: [temperature: 0]}
  end

  def handle_info(%{temperature: temperature}, socket) do
    {:noreply, assign(socket, temperature: temperature)}
  end
end
