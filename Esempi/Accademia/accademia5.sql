/*Definire in SQL le seguenti interrogazioni, in cui si chiedono tutti risultati distinti*/

/*1. Quali sono il nome, la data di inizio e la data di fine dei WP del progetto di
nome ‘Pegasus’?*/
select wp.id, wp.nome, wp.inizio, wp.fine
from progetto, wp
where progetto.nome = 'Pegasus'
and wp.progetto = progetto.id

-- oppure 
select wp.nome, wp.inizio, wp.fine 
from wp, progetto 
where wp.progetto = p.id 
and p.nome = 'Pegasus'


/*2. Quali sono il nome, il cognome e la posizione degli strutturati che hanno almeno una 
attività nel progetto ‘Pegasus’, ordinati per cognome decrescente?*/
select distinct p.nome, p.cognome, p.posizione
from persona p
join attivitaprogetto ap on p.id = ap.persona
join progetto pr on ap.progetto = pr.id
where pr.nome = 'Pegasus'
order by p.cognome desc

-- oppure 
select distinct p.id, p.nome, p.cognome, p.posizione
from attivitaprogetto ap, progetto pr, persona p 
where ap.progetto = pr.id 
    and ap.persona = p.id 
    and pr.nome = 'Pegasus'
order by p.cognome desc 


/*3. Quali sono il nome, il cognome e la posizione degli strutturati che hanno più di 
una attività nel progetto ‘Pegasus’?*/
select p.nome, p.cognome, p.posizione
from persona p
join attivitaprogetto ap on p.id = ap.persona
join progetto pr on ap.progetto = pr.id
where pr.nome = 'Pegasus'
group by p.id, p.nome, p.cognome, p.posizione
having count (p.nome) > 1

--oppure 
select distinct p.nome, p.cognome, p.posizione
from persona p, attivitaprogetto ap1, attivitaprogetto ap2, progetto prog 
where prog.nome = 'Pegasus'
	and p.id = ap1.persona
	and p.id = ap2.persona
	and ap1.id <> ap2.id


/*4. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno 
fatto almeno una assenza per malattia?*/
select distinct p.nome, p.cognome, p.posizione
from persona p
join assenza a on p.id = a.persona 
where a.tipo = 'Malattia' and p.posizione = 'Professore Ordinario'
group by p.nome, p.cognome, p.posizione
having count (a.tipo) >= 1

---oppure 
select distinct p.nome, p.cognome, p.posizione
from persona p, assenza a 
where p.id = a.persona 
	and p.posizione = 'Professore Ordinario'
	and a.tipo = 'Malattia'


/*5. Quali sono il nome, il cognome e la posizione dei Professori Ordinari che hanno
fatto più di una assenza per malattia?*/
select distinct p.nome, p.cognome, p.posizione 
from persona p
join assenza a on p.id = a.persona 
where a.tipo = 'Malattia' and p.posizione = 'Professore Ordinario'
group by p.nome, p.cognome, p.posizione
having count (a.tipo) > 1

-- oppure 
select distinct p.nome, p.cognome, p.posizione
from persona p, assenza a1, assenza a2
where p.id = a1.persona
	and p.id = a2.persona
	and p.posizione = 'Professore Ordinario'
	and a1.tipo = 'Malattia'
	and a2.tipo = a1.tipo 


/*6. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno almeno
un impegno per didattica?*/
select distinct p.nome, p.cognome, p.posizione 
from persona p
join attivitanonprogettuale anp on p.id = anp.persona 
where anp.tipo = 'Didattica' and p.posizione = 'Ricercatore'
group by p.nome, p.cognome, p.posizione
having count (anp.tipo) >= 1

--oppure 
select distinct p.nome, p.cognome, p.posizione
from persona p, attivitanonprogettuale anp
where p.posizione = 'Ricercatore'
	and p.id = anp.persona 
	and anp.tipo = 'Didattica'


/*7. Quali sono il nome, il cognome e la posizione dei Ricercatori che hanno più di un
impegno per didattica?*/
select distinct p.nome, p.cognome, p.posizione 
from persona p
join attivitanonprogettuale anp on p.id = anp.persona 
where anp.tipo = 'Didattica' and p.posizione = 'Ricercatore'
group by p.nome, p.cognome, p.posizione
having count (anp.tipo) > 1

-- oppure 
select distinct p.nome, p.cognome, p.posizione
from persona p, attivitanonprogettuale anp1, attivitanonprogettuale anp2
where p.posizione = 'Ricercatore'
	and p.id = anp1.persona 
	and p.id = anp2.persona
	and anp1.tipo = 'Didattica'
	and anp1.tipo = anp2.tipo


/*8. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
attività progettuali che attività non progettuali?*/
select distinct p.nome, p.cognome
from persona p
join attivitanonprogettuale anp on p.id = anp.persona
join attivitaprogetto ap on p.id = ap.persona 
where anp.giorno = ap.giorno

-- oppure 
select distinct p.nome, p.cognome
from persona p, attivitanonprogettuale anp, attivitaprogetto ap
where p.id = anp.persona 
	and p.id = ap.persona
	and anp.giorno = ap.giorno 

/*9. Quali sono il nome e il cognome degli strutturati che nello stesso giorno hanno sia
attività progettuali che attività non progettuali? Si richiede anche di proiettare il
giorno, il nome del progetto, il tipo di attività non progettuali e la durata in ore di
entrambe le attività.*/
select p.nome, p.cognome, anp.giorno, ap.giorno, prog.nome, anp.tipo, anp.oredurata, ap.oredurata
from persona p
join attivitanonprogettuale anp on p.id = anp.persona
join attivitaprogetto ap on p.id = ap.persona 
join progetto prog on ap.progetto = prog.id
where anp.giorno = ap.giorno

-- oppure
select p.nome, p.cognome, anp.giorno, prog.nome, anp.tipo, ap.tipo, anp.oredurata, ap.oredurata
from persona p, attivitanonprogettuale anp, attivitaprogetto ap, progetto prog
where p.id = anp.persona 
	and p.id = ap.persona
	and anp.giorno = ap.giorno 
	and ap.progetto = prog.id


/*10. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
assenti e hanno attività progettuali?*/
select p.nome, p.cognome 
from persona p
join assenza a on p.id = a.persona
join attivitaprogetto ap on p.id = ap.persona 
where a.giorno = ap.giorno

-- oppure 
select p.nome, p.cognome
from persona p, assenza a, attivitaprogetto ap
where p.id = ap.persona 
	and p.id = a.persona
	and ap.giorno = a.giorno


/*11. Quali sono il nome e il cognome degli strutturati che nello stesso giorno sono
assenti e hanno attività progettuali? Si richiede anche di proiettare il giorno, il
nome del progetto, la causa di assenza e la durata in ore della attività progettuale.*/
select p.nome, p.cognome, a.giorno, prog.nome, a.tipo, ap.oredurata
from persona p
join assenza a on p.id = a.persona
join attivitaprogetto ap on p.id = ap.persona 
join progetto prog on ap.progetto = prog.id
where a.giorno = ap.giorno

-- oppure
select p.nome, p.cognome, ap.giorno, prog.nome, a.tipo, ap.oredurata
from persona p, assenza a, attivitaprogetto ap
where p.id = ap.persona 
	and p.id = a.persona
	and ap.giorno = a.giorno
	and ap.progetto = prog.id


/*12. Quali sono i WP che hanno lo stesso nome, ma appartengono a progetti diversi?*/
select distinct wp1.nome 
from wp as wp1, wp as wp2
where wp1.nome = wp2.nome 
    and wp1.progetto <> wp2.progetto