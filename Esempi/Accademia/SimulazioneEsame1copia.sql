--1. Elencare tutti i progetti la cui fine è successiva al 2023-12-31
select id, nome
from progetto 
where fine > '2023-12-31'


--2. Contare il numero totale di persone per ciascuna posizione (Ricercatore, Professore Associato, Professore Ordinario).
select posizione, count(*) 
from persona 
group by posizione 


--3. Restituire gli id e i nomi delle persone che hanno almeno un giorno di assenza per "Malattia".
select distinct p.id, p.nome, p.cognome 
from assenza a  
join persona p on a.persona = p.id
where a.tipo = 'Malattia'


--4. Per ogni tipo di assenza, restituire il numero complessivo di occorrenze
select tipo, count(*)
from assenza 
group by tipo 


--5. Calcolare lo stipendio massimo tra tutti i "Professori Ordinari"
select max(stipendio) 
from persona 
where posizione = 'Professore Ordinario'


--6. Quali sono le attività e le ore spese dalla persona con id 1 nelle attività del progetto con id 4, ordinate in ordine decrescente. Per ogni attività, restituire l’id, il tipo e il numero di ore.
select id, tipo, oreDurata  
from attivitaprogetto
where persona = '1'
    and progetto = '4'  
order by oreDurata desc  


--7. Quanti sono i giorni di assenza per tipo e per persona. Per ogni persona e tipo di assenza, restituire nome, cognome, tipo assenza e giorni totali.
select p.id, p.nome, p.cognome, a.tipo, count(a.giorno) as giorni_totali 
from assenza a 
join persona p on p.id = a.persona 
group by p.id, p.nome, p.cognome, a.tipo 


--8. Restituire tutti i “Professori Ordinari” che hanno lo stipendio massimo. Per ognuno, restituire id, nome e cognome. 
select id, nome, cognome 
from persona 
where posizione = 'Professore Ordinario' 
    and stipendio = (
            select max(stipendio) 
            from persona 
    )


--9. Restituire la somma totale delle ore relative alle attività progettuali svolte dalla persona con id = 3 e con durata minore o uguale a 3 ore
select persona, sum(oreDurata) as totale_ore 
from attivitaprogetto
where persona = '3' and oreDurata <= 3 
group by persona 


--10.Restituire gli id e i nomi delle persone che non hanno mai avuto assenze di tipo "Chiusura Universitaria"
select p.id, p.nome, p.cognome 
from persona p
where not EXISTS (
    select * 
    from assenza a, persona p
    where a.tipo = 'Chiusura Universitaria'
        and p.id = a.persona 
)   
