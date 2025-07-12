from typing import Any 
from random import *
from datetime import *

def progetto_random(N: int) -> set[int]:
    res = "INSERT INTO public.Progetto(id, nome, inziio, fine, budget) VALUES \n"

    id_progetti = sample(range(10000000), k=N)
    nomi_progetti = sample(range(10000000), k=N)

    progetti: dict[int, dict[str, Any]] = {}
    for i in range(N):
        id_progetto = id_progetti[i]
        nome = nomi_progetti[i]
        inizio_weeks_ago: int = random.randint(51+1, 52*10)
        inizio = date.today() - timedelta(weeks=inizio_weeks_ago)

        fine_weeks_ago: int = random.randint(52, inizio_weeks_ago-1)
        fine = date.today() - timedelta(weeks=fine_weeks_ago)

        budget = random.randint(10, 5000) * 1000

        res += f"({id_progetto}, \'{nome}\',\'{inizio.isoformat()}\',\'{fine.isoformat()}\n,{budget}),\n"
        progetti[id_progetto] = {'id': id_progetto,
                                 'nome': nome, 
                                 'inizio': inizio,
                                 'fine': fine 
                                 }
    print(res[:-2]+";")
    return progetti 
