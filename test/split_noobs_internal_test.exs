defmodule Teiserver.Battle.SplitNoobsInternalTest do
  @moduledoc """
  Can run all balance tests via
  mix test --only balance_test
  """
  use ExUnit.Case
  @moduletag :balance_test
  alias Teiserver.Battle.Balance.SplitNoobs

  test "sort noobs" do
    noobs = [
      %{
        id: "kyutoryu",
        name: "kyutoryu",
        rating: 12.25,
        uncertainty: 7.1,
        rank: 0
      },
      %{
        id: "fbots1998",
        name: "fbots1998",
        rating: 13.98,
        uncertainty: 7,
        rank: 1
      },
      %{
        id: "Dixinormus",
        name: "Dixinormus",
        rating: 18.28,
        uncertainty: 8,
        rank: 1
      }
    ]

    result = SplitNoobs.sort_noobs(noobs)

    assert result == [
             %{id: "fbots1998", name: "fbots1998", rank: 1, uncertainty: 7, rating: 13.98},
             %{id: "Dixinormus", name: "Dixinormus", rank: 1, uncertainty: 8, rating: 18.28},
             %{id: "kyutoryu", name: "kyutoryu", rank: 0, uncertainty: 7.1, rating: 12.25}
           ]
  end

  test "split noobs internal functions" do
    expanded_group = [
      %{
        count: 2,
        members: ["kyutoryu", "fbots1998"],
        ratings: [12.25, 13.98],
        names: ["kyutoryu", "fbots1998"],
        uncertainties: [7.1, 8],
        ranks: [1, 1]
      },
      %{
        count: 1,
        members: ["Dixinormus"],
        ratings: [18.28],
        names: ["Dixinormus"],
        uncertainties: [8],
        ranks: [2]
      },
      %{
        count: 1,
        members: ["HungDaddy"],
        ratings: [2.8],
        names: ["HungDaddy"],
        uncertainties: [8],
        ranks: [2]
      },
      %{
        count: 1,
        members: ["SLOPPYGAGGER"],
        ratings: [8.89],
        names: ["SLOPPYGAGGER"],
        uncertainties: [3],
        ranks: [2]
      },
      %{
        count: 1,
        members: ["jauggy"],
        ratings: [20.49],
        names: ["jauggy"],
        uncertainties: [3],
        ranks: [2]
      },
      %{
        count: 1,
        members: ["reddragon2010"],
        ratings: [18.4],
        names: ["reddragon2010"],
        uncertainties: [3],
        ranks: [2]
      },
      %{
        count: 1,
        members: ["Aposis"],
        ratings: [20.42],
        names: ["Aposis"],
        uncertainties: [3],
        ranks: [2]
      },
      %{
        count: 1,
        members: ["MaTThiuS_82"],
        ratings: [8.26],
        names: ["MaTThiuS_82"],
        uncertainties: [3],
        ranks: [2]
      },
      %{
        count: 1,
        members: ["Noody"],
        ratings: [17.64],
        names: ["Noody"],
        uncertainties: [3],
        ranks: [2]
      },
      %{
        count: 1,
        members: ["[DTG]BamBin0"],
        ratings: [20.06],
        names: ["[DTG]BamBin0"],
        uncertainties: [3],
        ranks: [2]
      },
      %{
        count: 1,
        members: ["barmalev"],
        ratings: [3.58],
        names: ["barmalev"],
        uncertainties: [3],
        ranks: [2]
      }
    ]

    players = SplitNoobs.flatten_members(expanded_group)

    assert players == [
             %{
               id: "kyutoryu",
               name: "kyutoryu",
               rating: 12.25,
               uncertainty: 7.1
             },
             %{
               id: "fbots1998",
               name: "fbots1998",
               rating: 13.98,
               uncertainty: 8
             },
             %{
               id: "Dixinormus",
               name: "Dixinormus",
               rating: 18.28,
               uncertainty: 8
             },
             %{
               id: "HungDaddy",
               name: "HungDaddy",
               rating: 2.8,
               uncertainty: 8
             },
             %{
               id: "SLOPPYGAGGER",
               name: "SLOPPYGAGGER",
               rating: 8.89,
               uncertainty: 3
             },
             %{
               id: "jauggy",
               name: "jauggy",
               rating: 20.49,
               uncertainty: 3
             },
             %{
               id: "reddragon2010",
               name: "reddragon2010",
               rating: 18.4,
               uncertainty: 3
             },
             %{
               id: "Aposis",
               name: "Aposis",
               rating: 20.42,
               uncertainty: 3
             },
             %{
               id: "MaTThiuS_82",
               name: "MaTThiuS_82",
               rating: 8.26,
               uncertainty: 3
             },
             %{
               id: "Noody",
               name: "Noody",
               rating: 17.64,
               uncertainty: 3
             },
             %{
               id: "[DTG]BamBin0",
               name: "[DTG]BamBin0",
               rating: 20.06,
               uncertainty: 3
             },
             %{
               id: "barmalev",
               name: "barmalev",
               rating: 3.58,
               uncertainty: 3
             }
           ]

    parties = SplitNoobs.get_parties(expanded_group)
    noobs = SplitNoobs.get_noobs(players, parties)

    assert parties == [["kyutoryu", "fbots1998"]]

    assert noobs == [
             %{id: "Dixinormus", name: "Dixinormus", rating: 18.28, uncertainty: 8},
             %{id: "HungDaddy", name: "HungDaddy", rating: 2.8, uncertainty: 8}
           ]

    experienced_players = SplitNoobs.get_experienced_players(players, noobs)

    assert experienced_players == [
             %{id: "kyutoryu", name: "kyutoryu", rating: 12.25, uncertainty: 7.1},
             %{id: "fbots1998", name: "fbots1998", rating: 13.98, uncertainty: 8},
             %{id: "SLOPPYGAGGER", name: "SLOPPYGAGGER", rating: 8.89, uncertainty: 3},
             %{id: "jauggy", name: "jauggy", rating: 20.49, uncertainty: 3},
             %{id: "reddragon2010", name: "reddragon2010", rating: 18.4, uncertainty: 3},
             %{id: "Aposis", name: "Aposis", rating: 20.42, uncertainty: 3},
             %{id: "MaTThiuS_82", name: "MaTThiuS_82", rating: 8.26, uncertainty: 3},
             %{id: "Noody", name: "Noody", rating: 17.64, uncertainty: 3},
             %{id: "[DTG]BamBin0", name: "[DTG]BamBin0", rating: 20.06, uncertainty: 3},
             %{id: "barmalev", name: "barmalev", rating: 3.58, uncertainty: 3}
           ]

    initial_state = SplitNoobs.get_initial_state(expanded_group)

    assert SplitNoobs.get_result(initial_state) == %{
             first_team: [
               %{id: "HungDaddy", name: "HungDaddy", rating: 2.8, uncertainty: 8},
               %{
                 id: "kyutoryu",
                 name: "kyutoryu",
                 rating: 12.25,
                 uncertainty: 7.1
               },
               %{
                 id: "fbots1998",
                 name: "fbots1998",
                 rating: 13.98,
                 uncertainty: 8
               },
               %{
                 id: "MaTThiuS_82",
                 name: "MaTThiuS_82",
                 rating: 8.26,
                 uncertainty: 3
               },
               %{
                 id: "Noody",
                 name: "Noody",
                 rating: 17.64,
                 uncertainty: 3
               },
               %{
                 id: "[DTG]BamBin0",
                 name: "[DTG]BamBin0",
                 rating: 20.06,
                 uncertainty: 3
               }
             ],
             second_team: [
               %{id: "Dixinormus", name: "Dixinormus", rating: 18.28, uncertainty: 8},
               %{
                 id: "SLOPPYGAGGER",
                 name: "SLOPPYGAGGER",
                 rating: 8.89,
                 uncertainty: 3
               },
               %{
                 id: "jauggy",
                 name: "jauggy",
                 rating: 20.49,
                 uncertainty: 3
               },
               %{
                 id: "reddragon2010",
                 name: "reddragon2010",
                 rating: 18.4,
                 uncertainty: 3
               },
               %{
                 id: "Aposis",
                 name: "Aposis",
                 rating: 20.42,
                 uncertainty: 3
               },
               %{
                 id: "barmalev",
                 name: "barmalev",
                 rating: 3.58,
                 uncertainty: 3
               }
             ]
           }
  end
end
