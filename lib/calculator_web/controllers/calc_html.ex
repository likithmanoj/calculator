defmodule CalculatorWeb.CalcHTML do
  use CalculatorWeb, :html
  import Phoenix.Component
  embed_templates "calc_html/*"
end
