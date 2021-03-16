Integrants del grup
=========================
Aniol Barnada Tintó
Marc Vicente Cazallas

Instruccions per a jugar
=========================
* Moviment:
   * Tecles de direcció (tank controls) 
   * Mouse dragged (s’ha moure's i mantenir clicat a la vegada, és dpi sensitive)
* Borrar l’input del número de NPCs: 
   * Backspace
* Aceptar l’input del número de NPCs:
   *  Intro

Decisions que heu pres
=========================
* Vam decidir posar els tres possibles portals de sortida als eixos laterals i superior, mentre que el d'entrada es troba a l'eix inferior.
* Vam decidir que la millor funció per moure el PC era mouseDragged() ja que les altres no encaixaven amb el que esperàvem.
* També vam implementar que els NPC que fugen comencessin a moure's a partir d'un radi d'acció invisible present al PC, a manera de trigger.
* El PC no pot passar dels marges de la pantalla, mentre que els NPCs sí que poden: això ha sigut decisió degut a que els que fugen poden perdre’s i així fent que el jugador no pugui aconseguir sempre la màxima puntuació possible.
* Voliem fer que els NPCs perseguidors desapareguessin quan et tocaven i et treien vida, però degut a que ens va donar problemes vam fer que apareguessin a dalt de la pantalla i que et poguessin tornar a tocar i fer-te mal.
* Finalment, vam inclinar-nos perquè el boss tingués diverses fases les quals s'aniran activant segons el progrés del jugador; el qual ha de prémer quatre botons, i faran que les característiques variïn. A cada fase el boss es fa més gran i més ràpid, fins que a l'última fa spawnear els NPCs que perseguien al jugador.

Post Mortem
=========================
La pràctica ha sigut realitzada en equip utilitzant l’eina de control de versions GitHub Desktop per poder treballar de forma segura en diferents ordinadors.
Els dos integrants ja hem fet diversos treballs en grup junts i ja sabem com treballar entre nosaltres, coneixent els aspectes positius i les mancances de cadascú i on ens complementem més. Tot i que ens sentim orgullosos de que la gran part dels punts proposats siguin funcionals i el cicle del joc està complert, ens hauria agradat que tot funcionés de la forma més correcte i óptima possible.
En definitiva, no hi ha hagut cap problema a l’hora de treballar entre nosaltres i ens hem complementat bastant bé.

El que SÍ ha funcionat:
* El jugador defineix correctament el nombre de NPCs abans de jugar i aquest és repartit entre els tres grups
* Apareixen tots els NPCs, obstacles i portals al inicialitzar la partida
* Cada NPC té una velocitat aleatoria dintre uns rangs
* Els quatre portals funcionen correctament i el de sortida és aleatori a cada partida
* El PC es pot controlar tant amb el teclat com amb el ratolí
* El PC té tres vides, una barra de vida i una puntuació que varien
* Hi ha un temporitzador, el qual si arriba a zero resta una vida al jugador i es reinicia fins que el jugador no té vides
* Al acabar-se les vides s’acaba la partida
* La condició de victoria et porta a una pantalla que especifica que has guanyat i la teva puntuació. 
* Al inicializar la partida apareixen vuit obstacles de diferenta geometria i tamany amb els quals el jugador pot colisionar
* El comptadors de vides, punts, temps i vida son visibles en pantalla
* El boss funciona correctament amb les fases, elements i mecàniques que li vam voler introduir
* El moviment dels NPC que fugen i et persegueixen funciona correctament.

El que NO ha funcionat:
* Vam intentar fer els power ups però no anavem sobrats de temps per fer-los i, com donaven problemes vam decidir centrar-nos en altres punts de la pràctica.
* Les col·lisions entre els objectes rectangulars i el PC no funcionen del tot bé: desde abaix i els costats fa bé la col·lisió però desde dalt no.
* No hem aconseguit fer el moviment diagonal pressionant dues tecles alhora.
* Si el jugador inserta un nombre més petit a 3 NPCs a l’inici de la partida, no apareixerà cap. Això és degut a que el nombre de NPCs que apareixen sempre és múltiple de 3, i si no ho és, agafa el nombre anterior múltiple. Per exemple: 10 NPC / 3 = 9 NPC spawnejats +1. El restant s’elimina.