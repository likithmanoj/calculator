defmodule CalculatorWeb.CalcController do
  use CalculatorWeb, :controller
  def index(conn, _params) do
    render(conn, :index, result: nil, history: "")
  end

  def calculate(conn, %{"calc" => %{"a" => a, "b" => b, "op" => op}}) do
    a = String.to_float(a)
    b = String.to_float(b)

    result = case op do
      "+" -> a + b
      "-" -> a - b
      "*" -> a * b
      "/" -> if b != 0, do: a / b, else: "Cannot Divide by Zero"
    end

    result_string = "#{a} #{op} #{b} = #{result}"

    history_param = get_session(conn, :history) || ""
    new_history = history_param <> result_string <> ";"

    IO.inspect(new_history)
    conn|>put_session(:history,new_history)|>
    render(:index, result: result, history: new_history)
  end

  @spec history(Plug.Conn.t(), any()) :: Plug.Conn.t()
  def history(conn, _params) do
    history_param = get_session(conn, :history)|| ""
    render(conn, :history, result: nil, history: history_param)
  end
end
