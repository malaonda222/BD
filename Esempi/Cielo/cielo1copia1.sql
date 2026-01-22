-- 1. Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?
select codice, comp 
from volo 
where durataMinuti > 180

select codice, comp
from volo 
where durataMinuti > 180 

-- 2. Quali sono le compagnie che hanno voli che superano le 3 ore?
select distinct comp 
from volo 
where durataMinuti > 180

-- 3. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto con codice ‘CIA’ ?
select codice, comp 
from arrpart 
where partenza = 'CIA'

-- 4. Quali sono le compagnie che hanno voli che arrivano all’aeroporto con codice ‘FCO’ ?
select distinct comp 
from arrpart 
where arrivo = 'FCO'

-- 5. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto ‘FCO’ e arrivano all’aeroporto ‘JFK’ ?
select codice, comp 
from arrpart 
where partenza = 'FCO'
    and arrivo = 'JFK'

-- 6. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ e atterrano all’aeroporto ‘JFK’ ?
select distinct comp 
from arrpart 
where partenza = 'FCO'
    and arrivo = 'JFK'

-- 7. Quali sono i nomi delle compagnie che hanno voli diretti dalla città di ‘Roma’ alla città di ‘New York’ ?
select distinct ap.comp 
from arrpart ap, luogoaeroporto l1, luogoaeroporto l2  
where ap.partenza = l1.aeroporto 
    and ap.arrivo = l2.aeroporto 
    and l1.citta = 'Roma'
    and l2.citta = 'New York'


select distinct ap.comp 
from arrpart ap
join luogoaeroporto l1 on ap.partenza = l1.aeroporto 
join luogoaeroporto l2 on ap.arrivo = l2.aeroporto 
where l1.citta = 'Roma'
    and l2.citta = 'New York'

-- 8. Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali partono voli della compagnia di nome ‘MagicFly’ ?
select distinct a.codice, a.nome, la.nazione 
from arrpart ap
join aeroporto a on a.codice = ap.partenza 
join luogoaeroporto la on la.aeroporto = a.codice 
where ap.comp = 'MagicFly'

-- 9. Quali sono i voli che partono da un qualunque aeroporto della città di ‘Roma’ e atterrano ad un qualunque aeroporto della città di ‘New York’ ? Restituire: codice del volo, nome della compagnia, e aeroporti di partenza e arrivo.
select ap1.codice, ap1.comp, l1.aeroporto as partenza, l2.aeroporto as arrivo 
from arrpart ap1 
join luogoaeroporto l1 on ap1.partenza = l1.aeroporto 
join luogoaeroporto l2 on ap1.arrivo = l2.aeroporto  
where l1.citta = 'Roma' 
    and l2.citta = 'New York'

-- 10. Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo voli della stessa compagnia) da un qualunque aeroporto della città di ‘Roma’ ad un qualunque aeroporto della città di ‘New York’ ? Restituire: nome della compagnia, codici dei voli, e aeroporti di partenza, scalo e arrivo.
select ap1.comp, ap1.codice as codice_primo_volo, ap2.codice as codice_secondo_volo, l1.aeroporto as aeroporto_partenza, l2.aeroporto as aeroporto_scalo, l3.aeroporto as aeroporto_arrivo 
from arrpart ap1 
join luogoaeroporto l1 on l1.aeroporto = ap1.partenza 
join luogoaeroporto l2 on l2.aeroporto = ap1.arrivo 
join arrpart ap2 on ap1.arrivo = ap2.partenza 
join luogoaeroporto l3 on l3.aeroporto = ap2.arrivo 
where ap1.comp = ap2.comp 
    and l1.citta = 'Roma'
    and l3.citta = 'New York'
    and l2.citta <> l1.citta 
    and l2.citta <> l3.citta 

-- 11. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’, atterrano all’aeroporto ‘JFK’, e di cui si conosce l’anno di fondazione?
select distinct ap.comp
from arrpart ap, compagnia c  
where ap.comp = c.nome 
    and ap.partenza = 'FCO'
    and ap.arrivo = 'JFK'
    and c.annoFondaz is not null


-- 1. Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?
select codice, comp
from volo 
where durataMinuti > 180 

-- 2. Quali sono le compagnie che hanno voli che superano le 3 ore?
select distinct comp 
from volo 
where durataMinuti > 180 

-- 3. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto con codice ‘CIA’ ?
select codice, comp 
from arrpart 
where partenza = 'CIA'

-- 4. Quali sono le compagnie che hanno voli che arrivano all’aeroporto con codice ‘FCO’ ?
select distinct comp 
from arrpart 
where arrivo = 'FCO'

-- 5. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto ‘FCO’ e arrivano all’aeroporto ‘JFK’ ?
select codice, comp 
from arrpart 
where partenza = 'FCO'
    and arrivo = 'JFK'

-- 6. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ e atterrano all’aeroporto ‘JFK’ ?
select distinct comp  
from arrpart 
where partenza = 'FCO'
    and arrivo = 'JFK'

-- 7. Quali sono i nomi delle compagnie che hanno voli diretti dalla città di ‘Roma’ alla città di ‘New York’ ?
select distinct ap.comp 
from arrpart a1 
join luogoaeroporto la1 on la1.aeroporto = a1.partenza 
join luogoaeroporto la2 on la2.aeroporto = a1.arrivo 
where la1.citta = 'Roma'
    and l2.citta = 'New York'

-- 8. Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali partono voli della compagnia di nome ‘MagicFly’ ?
select distinct a.codice, a.nome, la.nazione 
from arrpart ap 
join aeroporto a on ap.partenza = a.codice 
join luogoaeroporto la on la.aeroporto = a.codice  
where ap.comp = 'MagicFly'

-- 9. Quali sono i voli che partono da un qualunque aeroporto della città di ‘Roma’ e atterrano ad un qualunque aeroporto della città di ‘New York’ ? Restituire: codice del volo, nome della compagnia, e aeroporti di partenza e arrivo.
select ap.codice, ap.comp, ap1.partenza, ap1.arrivo
from arrpart ap1 
join luogoaeroporto la1 on la1.aeroporto = ap1.partenza 
join luogoaeroporto la2 on la2.aeroporto = ap1.arrivo 
where la1.citta = 'Roma'
    and la2.citta = 'New York'

-- 10. Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo voli della stessa compagnia) da un qualunque aeroporto della città di ‘Roma’ ad un qualunque aeroporto della città di ‘New York’ ? Restituire: nome della compagnia, codici dei voli, e aeroporti di partenza, scalo e arrivo.
select ap1.comp, ap1.codice, ap2.codice, ap1.partenza, ap1.arrivo, ap2.arrivo 
from arrpart ap1 
join luogoaeroporto la1 on ap1.partenza = la1.aeroporto 
join luogoaeroporto la2 on ap1.arrivo = la2.aeroporto 
join arrpart ap2 on ap1.arrivo = ap2.partenza 
join luogoaeroporto la3 on ap2.arrivo = la3.aeroporto 
where ap1.comp = ap2.comp 
    and la1.citta = 'Roma'
    and la2.citta = 'New York'
    and la2.citta <> la1.citta 
    and la2.citta <> la3.citta 

-- 11. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’, atterrano all’aeroporto ‘JFK’, e di cui si conosce l’anno di fondazione?
select distinct c.nome 
from arrpart ap 
join compagnia c on ap.comp = c.nome and ap.codice = c.codice 
where ap.partenza = 'FCO'
    and ap.arrivo = 'JFK'
    and c.annoFondaz is not null 