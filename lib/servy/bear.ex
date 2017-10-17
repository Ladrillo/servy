defmodule Servy.Bear do
  defstruct id: nil, type: "", name: "", hibernating: false

  def is_brown(bear) do
    bear.type == "Brown"
  end

  def make_bear_item(bear) do
    "<li>#{bear.name} #{bear.type}</li>"
  end

  def sort_bear_by_name(a, b) do
    a.name >= b.name
  end
end