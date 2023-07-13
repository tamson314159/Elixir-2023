alias ApiToEcto.Repo

Enum.map(ApiToEcto.get_access_point(), &Repo.insert(&1))
