
class Disfraz{
    var property caracteristicas = []
    var property fechaDeConfeccion 
    const property nivelDeGracia
    const fiesta
    var persona
    const property nombre

    method puntaje(){
        return caracteristicas.sum{unaCaracteristica => unaCaracteristica.puntaje(self)}
    }

    method esAntiguo(){
        return fiesta.fecha().year() - fechaDeConfeccion.year() >= 50
    }

    method diasDesdeQueLoCompraron(){
        return fiesta.fecha().day() - fechaDeConfeccion.day()
    }

    method nombrePar() = return nombre.size().even()


}

//---------------------------------------------------------------------------------------
//---------------------------CARACTERISTICAS---------------------------------------------
//---------------------------------------------------------------------------------------

object gracioso{

    method puntaje(unDisfraz){
        return unDisfraz.nivelDeGracia() * unDisfraz.esAntiguo()
    }

    method multiplicarSiEsAntiguo(unDisfraz){
        if(unDisfraz.esAntiguo()){
            return 3
        }
        else return 1
    }
}

object tobaras{

    method puntaje(unDisfraz){
        if(unDisfraz.diasDesdeQueLoCompraron() > 2){
            return 5
        }
        else{
            return 3 
        }
    }
}

class caretas{
    const property valorDelPersonaje 

    method puntaje(unDisfraz) = return valorDelPersonaje
}

object sexi{

    method puntaje(unDisfraz){
        if(unDisfraz.esSexyQuienMeUsa()){
            return 15
        }
        else{
            return 2
        }
    }
}

//---------------------------------------------------------------------------------------
//---------------------------FIESTA------------------------------------------------------
//---------------------------------------------------------------------------------------

class Fiesta{
    const property fecha 
    var property invitados  = []
    var property asistentes = []

    method esUnBodrio(){
        return asistentes.all{unAsistente => !unAsistente.satisfechoConDisfraz()}
    }

    method mejorDisfraz(){
     return invitados.max{unInvitado => unInvitado.puntajeDeMiDisfraz()}   
    }

    method intercambiarDisfraz(unAsistente, otroAsistente){
        if(self.puedenIntercambiar(unAsistente, otroAsistente)){
            unAsistente.intercambiarDisfraz(otroAsistente.disfraz())
            otroAsistente.intercambiarDisfraz(unAsistente.disfraz())
            //ya no estan disconformes hacer
        }
    }

    method puedenIntercambiar(unAsistente, otroAsistente){
        return self.ambosPertenecen(unAsistente, otroAsistente) && self.algunoEstaDisconforme(unAsistente,otroAsistente)
    }

    method algunoEstaDisconforme(unAsistente, otroAsistente){
        unosAsistentes = [[unAsistente], [otroAsistente]].concat()
        return unosAsistentes.any{unAsistente => !unAsistente.satisfechoConDisfraz()}
    }
    
    method ambosPertenecen(unAsistente, otroAsistente){
        return self.perteneceAlaFiesta(unAsistente) && self.perteneceAlaFiesta(otroAsistente)
    }

    method perteneceAlaFiesta(unAsistente){
        return asistentes.contains(unAsistente)
    }

    method agregarAsistente(nuevoAsistente){
        if(self.puedoSumarAsistente(nuevoAsistente)){
            asistentes.add(nuevoAsistente)
        }
    }

    method puedoSumarAsistente(nuevoAsistente){
        return !self.perteneceAlaFiesta(nuevoAsistente) && nuevoAsistente.tengoDisfraz()
    }
}

object fiestaInolvidable inherits Fiesta{

    method esUnBodrio(){
        return self.todosConformes() && self.todosAsistentesSexies() 
    }

    method todosConformes(){
        return asistentes.all{unAsistente => unAsistente.satisfechoConDisfraz()}
    }

    method todosAsistentesSexies(){
        return asistentes.all{unAsistente => unAsistente.sexy()}
    }
}

//---------------------------------------------------------------------------------------
//---------------------------PERSONAS----------------------------------------------------
//---------------------------------------------------------------------------------------

 class Persona{
    var property disfraz 
    var property personalidad
    var property edad
    

    method satisfechoConDisfraz() = return unDisfraz.puntaje() > 10

    method puntajeDeMiDisfraz() = return disfraz.puntaje()

    method tengoDisfraz() {
        return disfraz.persona() == self
    }

    method sexy() = personalidad.soySexy(self)

 }

//---------------------------------------------------------------------------------------
//---------------------------PERSONALIDADES----------------------------------------------
//---------------------------------------------------------------------------------------

object alegre{

    method soySexy(unaPersona) = false
}

object taciturnas{

    method soySexy(unaPersona) = unaPersona.edad() < 30
}


//---------------------------------------------------------------------------------------
//---------------------------SATISFECHO--------------------------------------------------
//---------------------------------------------------------------------------------------


class Caprichoso inherits Persona{

    override method satisfechoConDisfraz() = super() && unDisfraz.nombrePar()
}

class Pretencioso inherits Persona{

    override method satisfechoConDisfraz() =  unDisfraz.diasDesdeQueLoCompraron() < 30
}

class Numerologo inherits Persona{
    const cifraDelPuntaje
    
    override method satisfechoConDisfraz() = super() && unDisfraz.puntaje() == cifraDelPuntaje
}