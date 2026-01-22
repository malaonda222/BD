--1. Per ogni compagnia, calcolare il numero totale di voli che opera.
select comp, count(*) 
from arrpart 
group by comp 

--2. Trovare le compagnie che operano più di 5 voli.
select comp
from arrpart 
group by comp 
having count(*) > 5

--3. Per ogni compagnia, calcolare il numero di aeroporti di arrivo distinti verso cui vola.
select comp, count(distinct arrivo) as num_aeroporti
from arrpart 
group by comp 

--4. Trovare le compagnie che volano verso almeno 3 aeroporti diversi.
select comp 
from arrpart 
group by comp 
having count (distinct arrivo) >= 3

--5. Individuare gli aeroporti dai quali partono più di 10 voli.
select a.codice, a.nome 
from arrpart ap 
join aeroporto a on ap.partenza = a.codice  
group by a.codice, a.nome  
having count(*) > 10  

--oppure 
select partenza 
from arrpart 
group by partenza 
having count(*) > 10

--6. Trovare le compagnie che non hanno alcun volo.
select nome 
from compagnia 
where nome not in (
    select comp
    from arrpart 
)

--oppure 
select c.nome 
from compagnia
where not exists (
    select *
    from arrpart 
    where ap.comp = c.nome 
)

--7. Individuare gli aeroporti che non sono mai stati utilizzati come aeroporto di arrivo.
select distinct a.codice, a.nome 
from aeroporto a 
where not exists (
    select * 
    from arrpart ap
    where a.codice = ap.arrivo
)

--oppure 
select codice
from aeroporto 
where codice not in (
    select arrivo 
    from arrpart 
)

--8. Trovare le compagnie che operano solo voli con durata maggiore o uguale a 60 minuti.
select c.nome  
from compagnia c 
where not exists (
    select *
    from volo v 
    where v.durataMinuti < 60
        and v.comp = c.nome 
)

--oppure 
select comp 
from volo 
group by comp 
having min(durataMinuti) >= 60

--9. Individuare gli aeroporti che sono stati utilizzati sia come aeroporto di partenza sia come aeroporto di arrivo.
select a.codice, a.nome 
from aeroporto a 
where a.codice in (
    select distinct partenza from arrpart
)
and a.codice in (
    select distinct arrivo from arrpart 
);

--10. Trovare le compagnie che volano verso un solo aeroporto di arrivo.
select comp 
from arrpart
group by comp 
having count(distinct arrivo) = 1 