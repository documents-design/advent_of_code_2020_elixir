defmodule Day4 do
  def input() do
    {cur, out} = File.read("input_4")
    |> elem(1)
    |> String.split("\n")
    |> Enum.reduce({%{}, []}, fn (line, {tmp, out}) ->
      case line do
        "" -> {%{}, [tmp | out]}
        l ->
          tmp = String.split(l, " ") |> Enum.reduce(tmp, fn (pair, t) ->
            [key, val] = String.split(pair, ":")
            Map.put(t, String.to_atom(key), val)
          end)
          {tmp, out}
      end
    end)
    case cur do
      %{} -> out
      a -> [a | out]
    end
  end
end

defmodule Day4Part1 do

  def validate(%{
    byr: _,
    iyr: _,
    eyr: _,
    hgt: _,
    hcl: _,
    ecl: _,
    pid: _,
    }), do: true
  def validate(_), do: false

  def run() do
    Day4.input() |> Enum.filter(&(validate(&1)))
  end
end

defmodule Day4Part2 do
  def input() do
    Day4Part1.run()
  end

  def year_between(str, min, max) do
    if Regex.match?(~r/^\d{4}$/, str) do
      a = String.to_integer(str)
      a >= min and a <= max
    else
      false
    end
  end

  def num_between(str, min, max) do
    a = String.to_integer(str)
    a >= min and a <= max
  end

  def valid_byr(%{byr: b}), do: year_between(b, 1920, 2002)
  def valid_iyr(%{iyr: i}), do: year_between(i, 2010, 2020)
  def valid_eyr(%{eyr: e}), do: year_between(e, 2020, 2030)
  def valid_hgt(%{hgt: h}) do
    re = ~r/(\d+)(cm|in)/
    if Regex.match?(re, h) do
      [_str, num, unit] = Regex.run(re, h)
      case unit do
        "cm" -> num_between(num, 150, 193)
        "in" -> num_between(num, 59, 76)
        _ -> false
      end
    else
      false
    end
  end
  def valid_hcl(%{hcl: h}),do: Regex.match?(~r/^#[0-9a-f]{6}$/, h)
  def valid_ecl(%{ecl: e}), do: !is_nil(Enum.find(~w(amb blu brn gry grn hzl oth), &(e == &1)))
  def valid_pid(%{pid: p}),do: Regex.match?(~r/^\d{9}$/, p)

  def pipe({false, s}, _), do: {false, s}
  def pipe({true, s}, f), do: {f.(s), s}

  def validate(s) do
    {result, _} = {true, s}
    |> pipe(&valid_byr/1)
    |> pipe(&valid_iyr/1)
    |> pipe(&valid_eyr/1)
    |> pipe(&valid_hgt/1)
    |> pipe(&valid_hcl/1)
    |> pipe(&valid_ecl/1)
    |> pipe(&valid_pid/1)

    result
  end

  def run() do
    input() |> Enum.filter(&(validate(&1)))
  end
end

Day4Part1.run() |> length |> IO.inspect

Day4Part2.run() |> length |> IO.inspect
