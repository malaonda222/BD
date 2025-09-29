-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi aeroporti?
select a.codice, a.nome, count(distinct(ap.comp)) as num_compagnie
from arrpart ap, aeroporto a
where ap.arrivo = a.codice or ap.partenza = a.codice 
group by a.codice

-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno 100 minuti?
select count(*)
from volo v, arrpart a
where a.codice = v.codice and a.comp = v.comp and v.durataminuti >= 100 and a.partenza = 'HTR'

--3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione nella quale opera?
select distinct(la.nazione), count(distinct(a.codice))
from aeroporto a 
join luogoaeroporto la on a.codice = la.aeroporto 
join arrpart ap on a.codice = ap.arrivo or a.codice = ap.partenza
where ap.comp = 'Apitalia'
group by la.nazione

--4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla compagnia ‘MagicFly’?
select avg(v.durataminuti) as media, min(v.durataminuti) as minimo, max(v.durataminuti) as massimo
from volo v 
where v.comp = 'MagicFly'

--5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli aeroporti?
SELECT a.codice, a.nome, MIN(c.annoFondaz) as anno
FROM aeroporto a
JOIN arrpart ap ON a.codice = ap.arrivo OR a.codice = ap.partenza
JOIN compagnia c ON c.nome = ap.comp
GROUP BY a.codice

--6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più voli?
select la1.nazione, count(distinct(la2.nazione)) as raggiungibili 
from arrpart ap
join luogoaeroporto la1 on la1.nazione = ap.partenza 
join luogoaeroporto la2 on la2.nazione = ap.arrivo 
where la1.nazione <> la2.nazione
group by la1.nazione  

--7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?
select a.codice, a.nome, avg(v.durataminuti) as media_durata
from volo v, arrpart ap, aeroporto a
where ap.partenza = a.codice and ap.codice = v.codice and ap.comp = v.comp
group by a.codice

select a.codice, a.nome, avg(v.durataminuti) as media_durata
from aeroporto a
join arrpart ap on ap.partenza = a.codice 
join volo v on ap.comp = v.comp and ap.codice = v.codice
group by a.codice

--8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate a partire dal 1950?
select c.nome, sum(durataminuti) as durata_tot
from volo v
join compagnia c on v.comp = c.nome
where c.annofondaz >= 1950
group by c.nome

--9. Quali sono gli aeroporti nei quali operano esattamente due compagnie?
select a.codice, a.nome
from aeroporto a
join arrpart ap on ap.arrivo = a.codice or ap.partenza = a.codice
group by a.codice, a.nome
having count(distinct ap.comp) = 2

--10. Quali sono le città con almeno due aeroporti?
select la.citta
from luogoaeroporto la
join aeroporto a on la.aeroporto = a.codice
group by la.citta
having count(distinct la.aeroporto) >= 2

--11. Qual è il nome delle compagnie i cui voli hanno una durata media maggiore di 6 ore?
select c.nome as compagnia
from compagnia c
join volo v on c.nome = v.comp 
group by c.nome 
having avg(v.durataminuti) > 360

--12. Qual è il nome delle compagnie i cui voli hanno tutti una durata maggiore di 100 minuti?
select c.nome as compagnia
from compagnia c
join volo v on c.nome = v.comp
group by c.nome
having min(v.durataminuti) > 100