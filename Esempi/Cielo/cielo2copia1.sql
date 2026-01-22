-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi aeroporti?
select a.codice, a.nome, count(distinct(ap.comp)) as num_compagnie
from arrpart ap
join aeroporto a on ap.arrivo = a.codice or ap.partenza = a.codice
group by a.codice, a.nome   

-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno 100 minuti?
select count(*) as num_voli
from arrpart ap 
join volo v on ap.codice = v.codice and ap.comp = v.comp
where ap.partenza = 'HTR'
    and v.durataMinuti >= 100 

--3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione nella quale opera?
select la.nazione, count(distinct(a.codice)) as num_aerop
from arrpart ap 
join aeroporto a on ap.arrivo = a.codice or ap.partenza = a.codice 
join luogoaeroporto la on la.aeroporto = a.codice
where ap.comp = 'Apitalia'
group by la.nazione

--4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla compagnia ‘MagicFly’?
select round(avg(durataMinuti)::numeric, 2) as media, min(durataMinuti) as minimo, max(durataMinuti) as massimo 
from volo 
where comp = 'MagicFly'

--5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli aeroporti?
select a.codice, a.nome, min(c.annoFondaz) as anno  
from arrpart ap 
join aeroporto a on ap.arrivo = a.codice or ap.partenza = a.codice 
join compagnia c on ap.comp = c.nome  
group by a.codice, a.nome 

--6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più voli?
select l1.nazione, count(distinct la2.nazione) as raggiungibili 
from arrpart ap 
join luogoaeroporto l1 on l1.aeroporto = ap.arrivo 
join luogoaeroporto l2 on l2.aeroporto = ap.partenza 
where l1.nazione <> l2.nazione   
group by l1.nazione 

--7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?
select a.codice, a.nome, round(avg(v.durataMinuti)::numeric, 2) as media_durata
from arrpart ap 
join aeroporto a on ap.partenza = a.codice 
join volo v on ap.codice = v.codice and ap.comp = v.comp  
group by a.codice, a.nome

--8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate a partire dal 1950?
select c.nome, sum(v.durataMinuti) as durata_tot 
from volo v 
join compagnia c on v.comp = c.nome  
where c.annoFondaz >= 1950 
group by c.nome 

--9. Quali sono gli aeroporti nei quali operano esattamente due compagnie?
select a.codice, a.nome 
from aeroporto a 
join arrpart ap on ap.arrivo = a.codice or ap.partenza = a.codice 
group by a.codice, a.nome 
having count (distinct ap.comp) = 2

--10. Quali sono le città con almeno due aeroporti?
select la.citta 
from luogoaeroporto la 
join aeroporto a on a.codice = la.aeroporto 
group by la.citta 
having count (a.codice) >= 2

--o ancora meglio!!!
select citta 
from luogoaeroporto 
group by citta 
having count (aeroporto) >= 2

--11. Qual è il nome delle compagnie i cui voli hanno una durata media maggiore di 6 ore?
select comp 
from volo 
group by comp 
having avg(durataMinuti) > 360 

--12. Qual è il nome delle compagnie i cui voli hanno tutti una durata maggiore di 100 minuti?
select comp 
from volo 
group by comp 
having min(durataMinuti) > 100 