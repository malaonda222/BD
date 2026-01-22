-- 1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di nome ‘Pegasus’?
select wp.id, wp.nome, wp.inizio, wp.fine 
from wp 
join progetto p on wp.progetto = p.id 
where p.nome = 'Pegasus'

-- 2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?
select distinct p.id, p.nome, p.cognome, p.posizione 
from attivitaprogetto ap 
join progetto pr on ap.progetto = pr.id 
join persona p on ap.persona = p.id 
where pr.nome = 'Pegasus'
order by p.cognome desc 

-- 3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di una attività nel progetto ‘Pegasus’ ?
select p.id, p.nome, p.cognome, p.posizione 
from attivitaprogetto ap 
join progetto pr on ap.progetto = pr.id 
join persona p on ap.persona = p.id 
where pr.nome = 'Pegasus'
group by p.id, p.nome, p.cognome, p.posizione 
having count (p.id) > 1 


select p.id, p.nome, p.cognome, p.posizione 
from attivitaprogetto ap1, attivitaprogetto ap2, progetto pr, persona p 
where ap1.persona = p.id 
    and ap2.persona = p.id 
    and ap1.progetto = pr.id 
    and ap2.progetto = pr.id 
    and pr.nome = 'Pegasus'
    and ap1.id <> ap2.id 

-- 4. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto almeno una assenza per malattia?
select distinct p.id, p.nome, p.cognome, p.posizione 
from assenza a 
join persona p on a.persona = p.id 
where p.posizione = 'Professore Ordinario'
    and a.tipo = 'Malattia'


select p.id, p.nome, p.cognome, p.posizione
from assenza a, persona p 
where p.posizione = 'Professore Ordinario'
    and a.tipo = 'Malattia'
    and a.persona = p.id 

-- 5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno fatto più di una assenza per malattia?
select p.id, p.nome, p.cognome
from assenza a 
join persona p on a.persona = p.id 
where p.posizione = 'Professori Ordinario'
    and a.tipo = 'Malattia'
group by p.id, p.nome, p.cognome 
having count (a.tipo) >= 2


select distinct p.id, p.nome, p.cognome
from persona p, assenza a1, assenza a2 
where a1.persona = p.id 
    and a2.persona = p.id 
    and p.posizione = 'Professore Ordinario'
    and a1.tipo = 'Malattia'
    and a2.tipo = a1.tipo 

-- 6. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno un impegno per didattica?
select p.id, p.nome, p.cognome 
from attivitanonprogettuale anp 
join persona p on anp.persona = p.id 
where p.posizione = 'Ricercatore'
    and anp.tipo = 'Didattica'
group by p.id, p.nome, p.cognome
having count (anp.tipo) >= 1


select distinct p.id, p.nome, p.cognome 
from attivitanonprogettuale anp, persona p 
where anp.persona = p.id 
    and p.posizione = 'Ricercatore'
    and anp.tipo = 'Didattica'

-- 7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un impegno per didattica?
select p.id, p.nome, p.cognome 
from attivitanonprogettuale anp 
join persona p on anp.persona = p.id 
where p.posizione = 'Ricercatore'
    and anp.tipo = 'Didattica'
group by p.id, p.nome, p.cognome 
having count (anp.tipo) > 1 

-- 8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali?
select distinct p.id, p.nome, p.cognome 
from persona p 
join attivitaprogetto ap on ap.persona = p.id 
join attivitanonprogettuale anp on anp.persona = p.id 
where ap.giorno = anp.giorno 

-- 9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia attività progettuali che attività non progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di entrambe le attività.
select p.id, p.nome, p.cognome, ap.giorno, pr.nome as prj, ap.oreDurata as h_prj, anp.tipo as att_noprj, anp.oreDurata as h_noprj 
from persona p 
join attivitaprogetto ap on ap.persona = p.id 
join attivitanonprogettuale anp on anp.persona = p.id
join progetto pr on ap.progetto = pr.id  
where ap.giorno = anp.giorno 

-- 10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali?
select distinct p.id, p.nome, p.cognome 
from persona p 
join assenza a on a.persona = p.id 
join attivitaprogetto ap on ap.persona = p.id 
where a.giorno = ap.giorno 

-- 11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il nome del progetto, la causa di assenza e la durata in ore della attività progettuale.
select p.id, p.nome, p.cognome, ap.giorno, a.tipo as causa_ass, pr.nome as progetto, ap.oreDurata as ore_att_prj
from persona p 
join assenza a on a.persona = p.id 
join attivitaprogetto ap on ap.persona = p.id 
join progetto pr on ap.progetto = pr.id  
where a.giorno = ap.giorno 

-- 12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?
select distinct wp1.nome
from wp wp1, wp wp2 
where wp1.nome = wp2.nome 
    and wp1.progetto <> wp2.progetto 