defmodule Servy.Wildthings do
  alias Servy.Bear

  def list_bears do
    [
      %Bear{id: 1, name: "Teddy", type: "Brown", hibernating: false},
      %Bear{id: 2, name: "Ted", type: "Black", hibernating: true},
      %Bear{id: 3, name: "Paddy", type: "Grizzly", hibernating: false},
      %Bear{id: 4, name: "Yogi", type: "Brown", hibernating: true},
      %Bear{id: 5, name: "Winnie-the-Pooh", type: "Brown", hibernating: false},
    ]
  end

  def get_bear(id) when is_integer(id) do
    list_bears()
    |> Enum.find(&(&1.id == id))
  end

  def get_bear(id) when is_binary(id) do
    id |> String.to_integer |> get_bear
  end
end

