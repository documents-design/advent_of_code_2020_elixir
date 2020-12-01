defmodule Day1 do
    def input() do
        with {:ok, data} <- File.read("input"),
            lines <- String.split(data, "\n"),
            as_nums <- lines |> Enum.filter(&(&1 != "")) |> Enum.map(&(String.to_integer(&1))) do
            as_nums
        else
            []
        end
    end
end

defmodule Day1Part1 do
    def run() do
        input = Day1.input()
        not_found = {0, 0}
        {a, b} = Enum.reduce(input, not_found, fn (num, {z, _} = output) ->
            case z do
                0 ->  case Enum.find(input, fn n -> n == (2020 - num) end) do
                        nil -> not_found
                        found -> {num, found}
                    end
                _ -> output
            end
        end)
        IO.inspect("#{a}, #{b}, #{a * b}")
    end
end

defmodule Day1Part2 do
    def run() do
        input = Day1.input()
        not_found = {0, 0, 0}
        {a, b, c} = Enum.reduce(input, not_found, fn num, {z, _, _} = global_output ->
            case z do
                0 -> case Enum.filter(input, fn n -> n < (2020 - num) end) do
                    [] -> not_found
                    rest -> Enum.reduce(rest, not_found, fn num2, {y, _, _} = partial_output ->
                        case y do
                            0 -> case Enum.find(rest, fn num3 -> num + num2 + num3 == 2020 end) do
                                nil -> not_found
                                match -> {num, num2, match}
                            end
                            _ -> partial_output
                        end
                    end)
                end
                _ -> global_output
            end
        end)
        IO.inspect("#{a}, #{b}, #{c}, #{a * b * c}")
    end
end

Day1Part1.run()
Day1Part2.run()