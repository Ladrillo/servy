defmodule Servy.Wildthings do
  alias Servy.Bear

  def list_bears do
    [
      %Bear{id: 1, name: "Teddy", type: "Brown", hibernating: false},
      %Bear{id: 1, name: "Ted", type: "Black", hibernating: true},
      %Bear{id: 1, name: "Paddy", type: "Grizzly", hibernating: false},
      %Bear{id: 1, name: "Yogi", type: "Brown", hibernating: true},
      %Bear{id: 1, name: "Winnie-the-Pooh", type: "Brown", hibernating: false},
    ]
  end
end