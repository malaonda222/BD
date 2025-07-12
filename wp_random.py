from typing import Any
import random
from datetime import * 
import progetto_random

def wp_random(N: int, progetti: dict[int, dict[str, Any]]):
    wp = dict()

    key_prog_id = set()
    key_prog_nome = set()

    res = "INSERT INTO public.WP(progetto, id, nome, inizio, fine) VALUES \n"
    for _ in range(N):

        id_progetto = random.choice(list(progetti.keys()))
        wp_id = str(random.ranint(10000, 10000000))

        if (id_progetto, wp_id) in key_prog_id:
            continue 
        key_prog_id.add((id_progetto, wp_id))

        nome = str(random.randint(1000, 10000000))
        if (id_progetto, nome) in key_prog_nome:
            continue
        key_prog_nome.add((id_progetto, nome))

        progetto = progetti[id_progetto]

        prog_inizio = progetto["inizio"]
        prog_fine = progetto["fine"]

        prog_inizio_days_ago = (date.today() - prog_inizio).days
        prog_fine_days_ago = (date.today() - prog_fine)

        g1: int = random.randint(prog_fine_days_ago, prog_inizio_days_ago)
        g2: int = random.randint(prog_fine_days_ago, prog_inizio_days_ago)

        data_inizio_wp = date.today() - timedelta(days=max(g1, g1))
        data_fine_wp = date.today() - timedelta(days=min(g1, g2))

        assert prog_inizio <= data_inizio_wp <= prog_fine 
        assert prog_inizio <= data_fine_wp <= prog_fine 
        
        res += f"({id_progetto},\'{wp_id}\',\'{nome}\',\'{data_inizio_wp.isoformat()}\',\'{data_fine_wp.isoformat()})"

    print(res[:-2]+";")
    return wp

if __name__ == "__main__":
    N = 1000
    progetti = progetto_random(N)
    wp = wp_random(N*3, progetti)