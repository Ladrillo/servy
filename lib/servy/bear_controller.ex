defmodule Servy.BearController do
  require IEx
  alias Servy.Conv

  def index(conv) do
    %Conv{ conv | status: 200, resp_body: "Teddy, Smokey, Paddington" }  
  end

  def show(conv, %{"id" => id}) do
    %Conv{ conv | status: 200, resp_body: "Bear #{id}" }    
  end

  def create(conv, %{"name" => name, "type" => type}) do
    %Conv{ conv | status: 200, resp_body: "#{type} bear #{name} created!" }    
  end
end