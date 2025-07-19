-- Definire in SQL le seguenti interrogazioni, in cui si chiedono tutti risultati distinti:

-- 1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome ‘Pegasus’ ?
select wp.nome, wp.inizio, wp.fine
from progetto, wp
where progetto.nome = 'Pegasus'


-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?
select distinct p.nome, p.cognome, p.posizione
from persona p
join attivitaprogetto ap on p.id = ap.persona
join progetto pr on ap.progetto = pr.id
where pr.nome = 'Pegasus'
order by p.cognome desc


-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di
-- una attività nel progetto ‘Pegasus’ ?
select p.nome, p.cognome, p.posizione
from persona p
join attivitaprogetto ap on p.id = ap.persona
join progetto pr on ap.progetto = pr.id
where pr.nome = 'Pegasus'
group by p.id, p.nome, p.cognome, p.posizione
having count (p.nome) > 1


-- 4. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto almeno una assenza per malattia?
select p.nome, p.cognome, p.posizione 
from persona p
join assenza a on p.id = a.persona 
where a.tipo = 'Malattia' and p.posizione = 'Professore Ordinario'


-- 5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
-- fatto più di una assenza per malattia?
select p.nome, p.cognome, p.posizione 
from persona p
join assenza a on p.id = a.persona 
where a.tipo = 'Malattia' and p.posizione = 'Professore Ordinario'
group by p.id, p.nome, p.cognome
having count (a.tipo) > 1

-- 6. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno
un impegno per didattica?


-- 7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un
impegno per didattica?


-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
attività progettuali che attività non progettuali?


-- 9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
attività progettuali che attività non progettuali? Si richiede anche di proiettare il
giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di
entrambe le attività.


-- 10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
assenti e hanno attività progettuali?


-- 11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il
nome del progetto, la causa di assenza e la durata in ore della attività progettuale.


-- 12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?