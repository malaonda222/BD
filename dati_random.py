import random 

def persone_random(N: int):
    res = "INSERT INTO PERSONA(ID, NOME, COGNOME, POSIZIONE, STIPENDIO) VALUES \n"
    
    ids = set()
    for _ in range(N):
        id_persona = random.randint(0, 1000000)
        if id_persona in ids:
            continue 
        nome = str(random.randint(10000, 100000))
        cognome = str(random.randint(10000, 100000))
        posizione = random.choice(['Ricercatore', 'Professore Associato', 'Professore Ordinario'])
        match posizione:
            case 'Ricercatore':
                min_stipendio, max_stipendio = 19000, 28000
            case 'Professore Associato':
                min_stipendio, max_stipendio = 25000, 40000
            case 'Professore Ordinario':
                min_stipendio, max_stipendio = 30000, 100000
    
        stipendio = random.randint(min_stipendio, max_stipendio)

        res += f"({id_persona},\'{nome}\', \'{cognome}\', \'{posizione}\', {stipendio}),\n"
    print(res[:-2]+";")
    return res 

persone_random(20)