defmodule Teiserver.Battle.BalanceLibInternalTest do
  use ExUnit.Case
  @moduletag :balance_test
  alias Teiserver.Battle.BalanceLib

  test "does team have parties" do
    team = [
      %{count: 2, group_rating: 13, members: [1, 4], ratings: [8, 5]}
    ]

    assert BalanceLib.team_has_parties?(team)

    team = [
      %{count: 1, group_rating: 8, members: [2], ratings: [8]}
    ]

    refute BalanceLib.team_has_parties?(team)
  end

  test "does team_groups in balance result have parties" do
    team_groups = %{
      1 => [
        %{count: 2, group_rating: 13, members: [1, 4], ratings: [8, 5]}
      ],
      2 => [
        %{count: 1, group_rating: 6, members: [2], ratings: [6]}
      ]
    }

    assert BalanceLib.balanced_teams_have_parties?(team_groups)

    team_groups = %{
      1 => [
        %{count: 1, group_rating: 8, members: [1], ratings: [8]},
        %{count: 1, group_rating: 8, members: [2], ratings: [8]}
      ],
      2 => [
        %{count: 1, group_rating: 6, members: [3], ratings: [6]},
        %{count: 1, group_rating: 8, members: [4], ratings: [8]}
      ]
    }

    refute BalanceLib.balanced_teams_have_parties?(team_groups)

    team_groups = %{
      1 => [
        %{count: 1, group_rating: 8, members: [1], ratings: [8]},
        %{count: 1, group_rating: 8, members: [2], ratings: [8]}
      ],
      2 => [
        %{count: 1, group_rating: 13, members: [3], ratings: [6]},
        %{count: 2, group_rating: 8, members: [4, 5], ratings: [8, 0]}
      ]
    }

    assert BalanceLib.balanced_teams_have_parties?(team_groups)
  end
end
