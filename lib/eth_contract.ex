defmodule EthContract do
  @doc false
  defmacro __using__(_opts) do
    quote do
      import EthContract

      # Initialize @tests to an empty list
      @tests []

      # Invoke TestCase.__before_compile__/1 before the module is compiled
      @before_compile EthContract
    end
  end

  defmacro test(description, do: block) do
    function_name = String.to_atom("test " <> description)
    quote do
      # Prepend the newly defined test to the list of tests
      @tests [unquote(function_name) | @tests]
      def unquote(function_name)(), do: unquote(block)
    end
  end

  @doc false
  defmacro __before_compile__(macros= %Macro.Env{module:  module}) do
    abi = module
      |> Atom.to_string()
      |> String.trim_leading("Elixir.")
      |> abi_file_name()
      |> File.read!()
      |> Jason.decode!()

    functions = Enum.filter(abi, fn item ->
      Map.get(item, "type") == "function"
    end)



    IO.inspect Enum.map(functions, fn function -> function["name"] end)
    result = Enum.map(functions, &quote_function/1)
    IO.inspect Macro.to_string(result)
    # result
    result
  end

  def quote_function(%{"name" => name, "inputs" => inputs}) do
    quote do
      def unquote(:"#{name}")() do
        5
      end
    end
  end

  defp abi_file_name(module_name), do:
    Path.join([File.cwd!, "config", "ethereum_abis", "#{module_name}.abi"])
end
