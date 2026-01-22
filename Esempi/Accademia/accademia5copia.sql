-- 1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome‘Pegasus’ ?
select wp.nome, wp.inizio, wp.fine 
from wp
join progetto p on wp.progetto = p.id 
where p.nome = 'Pegasus'


-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?
select distinct p.nome, p.cognome, p.posizione 
from persona p
join attivitaprogetto ap on ap.persona = p.id 
join progetto pr on pr.id = ap.progetto 
where pr.nome = 'Pegasus'
order by p.cognome desc 


-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di una attività nel progetto ‘Pegasus’ ?
select p.nome, p.cognome, p.posizione 
from persona p 
join attivitaprogetto ap on p.id = ap.persona 
join progetto pr on pr.id = ap.progetto 
where pr.nome = 'Pegasus'
group by p.nome, p.cognome, p.posizione 
having count (p.nome) > 1


select p.nome, p.cognome, p.posizione 
from persona p, attivitaprogetto ap1, attivitaprogetto ap2, progetto pr 
where p.id = ap1.persona
    and p.id = ap2.persona 
    and pr.nome = 'Pegasus'
    and ap1.id <> ap2.id


-- 4. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto almeno una assenza per malattia?
select distinct p.nome, p.cognome, p.posizione
from persona p, assenza a 
where a.persona = p.id
    and a.tipo = 'Malattia' 
    and p.posizione = 'Professore Ordinario'


select p.id, p.nome, p.cognome, p.posizione
from persona p  
join assenza a on a.persona = p.id 
where a.tipo = 'Malattia'
    and a.posizione = 'Professore Ordinario'
group by (p.id)
having count (a.tipo) >= 1

-- 5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto più di una assenza per malattia?
select p.nome, p.cognome, p.posizione 
from persona p, assenza a1, assenza a2  
where a1.persona = p.id 
    and a2.persona = p.id 
    and p.posizione = 'Professore Ordinario'
    and a1.tipo = 'Malattia'
    and a2.tipo = a1.tipo 


select p.id, p.nome, p.cognome, p.posizione 
from persona p 
join assenza a on a.persona = p.id 
where p.posizione = 'Professore Ordinario'
    and a.tipo = 'Malattia'
group by p.id, p.nome, p.cognome, p.posizione 
having count (a.tipo) >= 2


-- 6. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno un impegno per didattica?
select distinct p.nome, p.cognome, p.posizione
from persona p 
join attivitanonprogettuale anp on anp.persona = p.id 
where p.posizione = 'Ricercatore'
    and anp.tipo = 'Didattica'


select distinct p.id, p.nome, p.cognome, p.posizione
from persona p, attivitanonprogettuale anp 
where p.id = anp.persona 
    and p.posizione = 'Ricercatore'
    and anp.tipo = 'Didattica'
group by p.id, p.nome, p.cognome, p.posizione
having count (anp.tipo) >= 1


-- 7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un impegno per didattica?
select p.id, p.nome, p.cognome, p.posizione 
from persona p 
join attivitanonprogettuale anp on anp.persona = p.id
where p.posizione = 'Ricercatore'
    and anp.tipo = 'Didattica'
group by p.id, p.nome, p.cognome, p.posizione
having count (anp.tipo) > 1


select 
from persona p, attivitanonprogettuale anp1, attivitanonprogettuale anp2 
where anp1.persona = p.id 
    and anp1.persona = p.id 
    and anp1.tipo = 'Didattica'
    and anp2.tipo = anp2.tipo 
    and p.posizione = 'Ricercatore'


-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali?
select distinct p.nome, p.cognome
from persona p
join attivitanonprogettuale anp on anp.persona = p.id 
join attivitaprogetto on ap.persona = p.id 
where anp.giorno = ap.giorno 


-- 9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di entrambe le attività.
select p.nome, p.cognome, ap.giorno as giorno_attivita_progettuale, anp.giorno as giorno_attivita_non_progettuale, pr.nome as nome_progetto, anp.tipo as attivita_non_progettuali, ap.oreDurata as durata_attivita_progettuali, anp.oreDurata as durata_attivita_non_progettuali
from persona p 
join attivitanonprogettuale anp on anp.persona = p.id 
join attivitaprogetto ap on ap.persona = p.id 
join progetto pr on ap.progetto = pr.id 
where anp.giorno = ap.giorno 


-- 10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali?
select distinct p.nome, p.cognome 
from persona p 
join assenza a on a.persona = p.id 
join attivitaprogetto ap on ap.persona = p.id 
where a.giorno = ap.giorno 


-- 11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, la causa di assenza e la durata in ore della attività progettuale.
select p.nome, p.cognome, ap.giorno, pr.nome as nome_progetto, a.tipo as causa_assenza, ap.oreDurata as durata_in_ore_attivita_progettuale 
from persona p
join assenza a on a.persona = p.id 
join attivitaprogetto ap on ap.persona = p.id 
join progetto pr on pr.id = ap.progetto
where ap.giorno = a.giorno 


-- 12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi
select distinct wp1.nome 
from wp wp1, wp wp2 
where wp1.nome = wp2.nome 
    and wp1.progetto <> wp2.progetto 