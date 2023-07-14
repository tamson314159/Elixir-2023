alias ApiToEcto.Repo

Enum.map(ApiToEcto.get_access_point(), &Repo.insert(&1))

Enum.map(ApiToEcto.get_place("./lat-lon.csv"), &Repo.insert(&1))
