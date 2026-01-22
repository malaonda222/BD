-- 1.​Elencare tutti i progetti la cui fine è successiva al 2023-12-31. 
select id, nome 
from progetto 
where fine > '2023-12-31'

-- 2.​Contare il numero totale di persone per ciascuna posizione (Ricercatore, Professore Associato, Professore Ordinario).
select posizione, count(*) as numero 
from persona 
group by posizione 

-- 3.​Restituire gli id e i nomi delle persone che hanno almeno un giorno di assenza per "Malattia".
select distinct p.id, p.nome, p.cognome 
from persona p 
join assenza a on a.persona = p.id 
where a.tipo = 'Malattia'

-- 4.​Per ogni tipo di assenza, restituire il numero complessivo di occorrenze.
select tipo, count(*) as numero 
from assenza 
group by tipo 

-- 5.​Calcolare lo stipendio massimo tra tutti i "Professori Ordinari".
select max(stipendio) as massimo 
from persona 
where posizione = 'Professore Ordinario'

-- 6.​Quali sono le attività e le ore spese dalla persona con id 1 nelle attività del progetto con id 4, ordinate in ordine decrescente. Per ogni attività, restituire l’id, il tipo e il numero di ore. 
select progetto, tipo, sum(oreDurata) as numero_ore 
from attivitaprogetto ap
where persona = '1'
    and progetto = '4' 
group by progetto, tipo 
order by numero_ore desc 

-- 7.​Quanti sono i giorni di assenza per tipo e per persona. Per ogni persona e tipo di assenza, restituire nome, cognome, tipo assenza e giorni totali.
select p.id, a.tipo, p.nome, p.cognome, count(a.giorno) as giorni_totali 
from assenza a 
join persona p on p.persona = p.id 
group by p.id, a.tipo, p.nome, p.cognome  

-- 8.​Restituire tutti i “Professori Ordinari” che hanno lo stipendio massimo. Per ognuno, restituire id, nome e cognome 
select id, nome, cognome 
from persona 
where posizione = 'Professore Ordinario'
    and stipendio = (select max(stipendio) from persona)

-- 9.​Restituire la somma totale delle ore relative alle attività progettuali svolte dalla persona con id = 3 e con durata minore o uguale a 3 ore.
select persona, sum(oreDurata) as totale_ore 
from attivitaprogetto 
where persona = '3'
    and oreDurata <= 3 
group by persona 

-- 10.​ Restituire gli id e i nomi delle persone che non hanno mai avuto assenze di tipo "Chiusura Universitaria"
select p.id, p.nome, p.cognome 
from persona p 
where p.id not in (
    select a.persona 
    from assenza a
    where a.tipo = 'Chiusura Universitaria'
)
