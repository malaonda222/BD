-- 1. Trovare le compagnie che non volano mai verso l’aeroporto 'JFK'.
select c.nome 
from compagnia c
where not exists (
    select *
    from arrpart ap 
    where ap.comp = c.nome 
        and ap.arrivo = 'JFK'
)

--2. Trovare gli aeroporti che non hanno mai visto voli partire negli ultimi 3 anni.
select a.codice, a.nome 
from aeroporto a 
where not exists (
    select *
    from arrpart ap 
    where a.codice = ap.partenza 
)

--3. Individuare le compagnie che hanno almeno un volo verso tutti gli aeroporti in Italia.
select distinct ap.comp 
from arrpart ap 
join luogoaeroporto la on la.aeroporto = ap.arrivo 
where la.nazione = 'Italia'
group by ap.comp 
having count(distinct ap.arrivo) = (
    select (*)
    from luogoaeroporto 
    where nazione = 'Italia'
)

--4. Per ogni compagnia, contare il numero totale di voli che opera.
select comp, count(*) as numero_voli
from arrpart 
group by comp 

--5. Trovare le compagnie che hanno più di 2 voli.
select comp 
from arrpart 
group by comp 
having count(*) > 2 

--6. Per ogni aeroporto di arrivo, contare quanti voli arrivano lì.
select arrivo, count(*) as numero_voli 
from arrpart 
group by arrivo 

--7. Trovare gli aeroporti dai quali partono almeno 3 voli.
select partenza 
from arrpart 
group by partenza 
having count(*) >= 3 

--8. Trovare le compagnie che non volano verso l’aeroporto “JFK”.
select c.nome 
from compagnia c
where not exists (
    select *
    from arrpart ap 
    where ap.comp = c.nome 
        and ap.arrivo = 'JFK' 
)

--9. Per ogni compagnia, contare il numero di aeroporti di arrivo distinti verso cui vola.
select comp, count(distinct arrivo) as numero_aeroporti_arrivo 
from arrpart 
group by comp 

--10. Trovare le compagnie che hanno almeno un volo di durata maggiore o uguale a 120 minuti.
select comp 
from volo 
group by comp   
having max(durataMinuti) >= 120   