-- 1. Quante sono le compagnie che operano (sia in arrivo che in partenza) nei diversi aeroporti?
select a.codice, a.nome, count(distinct(ap.comp)) as compagnia 
from arrpart ap
join aeroporto a on ap.arrivo = a.codice or ap.partenza = a.codice
group by a.codice


-- 2. Quanti sono i voli che partono dall’aeroporto ‘HTR’ e hanno una durata di almeno 100 minuti?
select count(*) as numero_voli
from arrpart ap
join volo v on v.codice = ap.codice and ap.comp = v.comp
where ap.partenza = 'HTR' and v.durataMinuti >= 100  


--3. Quanti sono gli aeroporti sui quali opera la compagnia ‘Apitalia’, per ogni nazione nella quale opera?
select distinct la.nazione, count(distinct(a.codice)) 
from aeroporto a
join luogoaeroporto la on la.aeroporto = a.codice 
join arrpart ap on ap.arrivo = a.codice or ap.partenza = a.codice 
where ap.com = 'Apitalia'
group by la.nazione 


--4. Qual è la media, il massimo e il minimo della durata dei voli effettuati dalla compagnia ‘MagicFly’?
select round(avg(durataMinuti)::numeric, 2) as media, max(durataMinuti) as massimo, min(durataMinuti)
from volo 
where comp = 'MagicFly'


--5. Qual è l’anno di fondazione della compagnia più vecchia che opera in ognuno degli aeroporti?
select a.codice, a.nome,, min(c.annofondaz) 
from aeroporto a 
join arrpart ap on a.codice = ap.arrivo or a.codice = ap.partenza   
join compagnia c on c.nome = ap.comp 
group by a.codice, a.nome


--6. Quante sono le nazioni (diverse) raggiungibili da ogni nazione tramite uno o più voli?
select distinct l1.nazione, count(distinct la2.nazione) as raggiungibili 
from arrpart ap 
join luogoaeroporto l1 on ap.arrivo = l1.aeroporto
join luogoaeroporto l2 on ap.partenza = l2.aeroporto 
where l1.nazione <> l2.nazione 
group by l1.nazione 


--7. Qual è la durata media dei voli che partono da ognuno degli aeroporti?
select a.codice, avg(v.durataMinuti) as media 
from arrpart ap 
join aeroporto a on ap.partenza = a.codice 
join volo v on ap.codice = v.codice and ap.comp = v.comp 
group by a.codice 


--8. Qual è la durata complessiva dei voli operati da ognuna delle compagnie fondate a partire dal 1950?
select c.nome, sum(durataMinuti) 
from compagnia c
join volo v on c.nome = v.comp 
where c.annoFondaz >= 1950 
group by c.nome 


--9. Quali sono gli aeroporti nei quali operano esattamente due compagnie?
select a.codice, a.nome 
from arrpart ap
join aeroporto on a.codice = ap.arrivo and a.codice = ap.partenza 
group by a.codice, a.nome 
having count (distinct ap.comp) = 2


--10. Quali sono le città con almeno due aeroporti?
select citta 
from luogoaeroporto
group by citta 
having count(aeroporto) >= 2 


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


-- TROVARE GLI AEROPORTI DAI QUALI NON PARTE NESSUN VOLO
select a.codice, a.nome 
from aeroporto a 
where a.codice not in (select distinct partenza 
                        from arrpart)


select a.codice, a.nome 
from aeroporto 
where a.codice not in (select arrivo 
                        from arrpart )