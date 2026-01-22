--1. Trova tutte le compagnie che hanno più di 7 voli operativi. Mostra il nome della compagnia e il numero di voli.
select comp, count(*) 
from volo 
group by comp 
having count (*) > 7 

--2. Elenca gli aeroporti sui quali operano almeno 4 compagnie diverse. Mostra codice e nome dell’aeroporto.
select a.codice, a.nome
from arrpart ap 
join aeroporto a on ap.arrivo = a.codice or ap.partenza = a.codice 
group by a.codice, a.nome 
having count (distinct ap.comp) > 4

--3. Trova le compagnie fondate dopo il 2010 che hanno almeno un volo con durata superiore a 300 minuti. Mostra solo il nome della compagnia.
select c.nome 
from volo v 
join compagnia c on v.comp = c.nome and ap.codice = v.codice 
where c.annoFondaz > 2010
group by c.nome
having max(v.durataMinuti) > 300

--4. Per ogni aeroporto di partenza, calcola quanti voli hanno durata maggiore di 5 ore. Mostra solo gli aeroporti con almeno 3 voli così lunghi.
select a.codice, a.nome 
from arrpart ap 
join aeroporto a on ap.partenza = a.codice 
join volo v on ap.codice = v.codice and ap.comp = v.comp
where v.durataMinuti > 300 
group by a.codice, a.nome 
having count (*) > 3 

--5. Trova le compagnie che hanno almeno un volo in tutti gli aeroporti della Francia. Mostra solo il nome della compagnia.
select ap.comp 
from luogoaeroporto la 
join arrpart ap on la.aeroporto = ap.partenza or la.aeroporto = ap.arrivo 
where la.nazione = 'Francia'
group by ap.comp 
having count (distinct la.aeroporto) = (
    select count(*)
    from luogoaeroporto
    where nazione = 'Francia'
)
