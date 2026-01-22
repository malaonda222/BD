--1. Quali sono le persone con stipendio di al massimo 40000 euro?
select id, nome, cognome 
from persona 
where stipendio <= 40000 


--2. Quali sono i ricercatori che lavorano ad almeno un progetto e hanno uno stipendio di al massimo 40000
select distinct p.id, p.nome, p.cognome 
from persona p 
join attivitaprogetto ap on ap.persona = p.id 
where p.stipendio <= 40000 
    and p.posizione = 'Ricercatore'


--3. Qual è il budget totale dei progetti nel db 
select sum(budget) as budget_totale 
from progetto 


--4. Qual è il budget totale dei progetti a cui lavora ogni persona. Per ogni persona restituire nome, cognome e budget totale dei progetti nei quali è coinvolto. 
select p.id, p.nome, p.cognome, sum(distinct(pr.budget)) as budget_totale
from attivitaprogetto ap 
join progetto pr on ap.progetto = pr.id 
join persona p on ap.persona = p.id 
group by p.id, p.nome, p.cognome


--5. Qual è il numero di progetti a cui partecipa ogni professore ordinario. Per ogni professore ordinario, restituire nome, cognome, numero di progetti nei quali è coinvolto ogni professore associato. 
select p.id, p.nome, p.cognome, count(distinct(ap.progetto)) as numero_progetti
from attivitaprogetto ap
join persona p on p.id = ap.persona 
where p.posizione = 'Professore Ordinario'
group by p.id, p.nome, p.cognome 


--6. Per ogni professore associato, restituire nome, cognome e numero di assenze per malattia
select p.id, p.nome, p.cognome, count(a.tipo) as assenze_malattia 
from assenza a 
join persona p on a.persona = p.id 
where p.posizione = 'Professore Associato' and a.tipo = 'Malattia'
group by p.id, p.nome, p.cognome 


--7. Qual è il numero totale di ore, per ogni persona, dedicate al progetto con id ‘5’. Per ogni persona che lavora al progetto, restituire nome, cognome e numero di ore totali dedicate ad attività progettuali relative al progetto
select p.id, p.nome, p.cognome, sum(ap.oreDurata) as totale_ore 
from attivitaprogetto ap 
join persona p on p.id = ap.persona
where ap.progetto = '5' 
group by p.id, p.nome, p.cognome 


--8. Qual è il numero medio di ore delle attività progettuali svolte da ogni persona. Per ogni persona, restituire nome, cognome e numero medio di ore delle sue attività progettuali (in qualsivoglia progetto)
select p.id, p.nome, p.cognome, round(avg(oreDurata)::numeric, 2) as numero_medio_ore 
from attivitaprogetto ap 
join persona p on p.id = ap.persona  
group by p.id, p.nome, p.cognome 


--9. Qual è il numero totale di ore, per ogni persona, dedicate alla didattica. Per ogni persona che ha svolto attività didattica, restituire nome, cognome e numero di ore totali dedicate alla didattica.
select p.id, p.nome, p.cognome, sum(anp.oreDurata) as ore_totali_didattica 
from attivitanonprogettuale anp 
join persona p on p.id = anp.persona 
where anp.tipo = 'Didattica'
group by p.id, p.nome, p.cognome


--10. Quali sono le persone che hanno svolto attività nel WP di id ‘5’ del progetto con id ‘3’. Per ogni persona, restituire il numero totale di ore svolte in attività progettuali per il WP in questione
select persona, sum(oreDurata) as totale_ore 
from attivitaprogetto
where wp = '5' 
    and progetto = '3'
group by persona

-- se vogliamo pure id, nome, cognome della persona allora:
select p.id, p.nome, p.cognome, sum(ap.oreDurata) as totale_ore 
from attivitaprogetto ap 
join persona p on p.id = ap.persona 
where ap.wp = '5'
    and ap.progetto = '3'
group by p.id, p.nome, p.cognome 