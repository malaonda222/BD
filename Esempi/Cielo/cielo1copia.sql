/*Definire in SQL le seguenti interrogazioni, in cui si chiedono tutti risultati distinti:*/

/*1. Quali sono i voli (codice e nome della compagnia) la cui durata supera le 3 ore?*/
select codice, comp 
from volo 
where durataMinuti > 180 


/*2. Quali sono le compagnie che hanno voli che superano le 3 ore?*/
select distinct comp 
from volo 
where durataMinuti > 180


/*3. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto con codice ‘CIA’?*/
select codice, comp 
from arrpart 
where partenza = 'CIA'


/*4. Quali sono le compagnie che hanno voli che arrivano all’aeroporto con codice ‘FCO’?*/
select distinct comp  
from arrpart 
where arrivo = 'FCO'


/*5. Quali sono i voli (codice e nome della compagnia) che partono dall’aeroporto ‘FCO’ e  arrivano all’aeroporto ‘JFK’?*/
select codice, comp 
from arrpart 
where partenza = 'FCO' and arrivo = 'JFK'


/*6. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’ e atterrano all’aeroporto ‘JFK’?*/
select distinct comp 
from arrpart 
where partenza = 'FCO' and arrivo = 'JFK'


/*7. Quali sono i nomi delle compagnie che hanno voli diretti dalla città di ‘Roma’ alla città di ‘New York’?*/
select distinct ap.comp 
from arrpart ap
join luogoaeroporto l1 on l1.aeroporto = ap.partenza 
join luogoaeroporto l2 on l2.aeroporto = ap.arrivo 
where l1.citta = 'Roma' and l2.citta = 'New York'


/*8. Quali sono gli aeroporti (con codice IATA, nome e luogo) nei quali partono voli della compagnia di nome ‘MagicFly’?*/
select distinct a.codice, a.nome, la.citta 
from aeroporto a 
join arrpart ap on ap.partenza = a.codice 
join luogoaeroporto la on la.aeroporto = ap.partenza   
where ap.comp = 'MagicFly'


/*9. Quali sono i voli che partono da un qualunque aeroporto della città di ‘Roma’ e atterrano ad un qualunque aeroporto della città di ‘New York’? Restituire: codice del volo, nome della compagnia, e aeroporti di partenza e arrivo.*/
select ap.codice, ap.comp, ap.partenza, ap.arrivo 
from arrpart ap 
join luogoaeroporto l1 on l1.aeroporto = ap.partenza 
join luogoaeroporto l2 on l2.aeroporto = ap.arrivo  
where l1.citta = 'Roma' and l2.citta = 'New York'


/*10. Quali sono i possibili piani di volo con esattamente un cambio (utilizzando solo voli della stessa compagnia da un qualunque aeroporto della città di ‘Roma’ ad un qualunque aeroporto della città di ‘New York’? Restituire: nome della compagnia, codici dei voli e aeroporti di partenza, scalo e arrivo.*/
select ap1.comp, ap1.codice as codice_volo_1, ap1.partenza as partenza, l2.aeroporto as scalo, ap2.codice as codice_volo_2, l3.aeroporto as arrivo 
from arrpart ap1
join luogoaeroporto l1 on l1.aeroporto = ap1.partenza
join luogoaeroporto l2 on l2.aeroporto = ap1.arrivo
join arrpart ap2 on ap1.arrivo = ap2.partenza 
join luogoaeroporto l3 on l3.aeroporto = ap2.arrivo 
where l1.citta = 'Roma' 
    and l3.citta = 'New York' 
    and ap1.comp = ap2.comp 
    and l2.citta <> l1.citta
    and l2.citta <> l3.citta 


/*11. Quali sono le compagnie che hanno voli che partono dall’aeroporto ‘FCO’, atterrano all’aeroporto ‘JFK' e di cui si conosce l’anno di fondazione?*/
select distinct c.nome 
from arrpart ap
join compagnia c on ap.comp = c.nome 
where ap.partenza = 'FCO' and ap.arrivo = 'JFK' and c.annoFondaz is not null 