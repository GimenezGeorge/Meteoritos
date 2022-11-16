#EnemigoInterceptor.gd
class_name EnemigoInterceptor
extends EnemigoBase

## Enums
enum ESTADO_IA {IDLE, ATACANDOQ, ATACANDOP, PERSECUCION}

## Atributos
var estado_ia_actual:int = ESTADO_IA.IDLE

...

