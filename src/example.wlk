import wollok.game.*


object menuPrincipal{
	
	method position() = game.at(0,0)
	method image() = "assets/imagenes/menuJuego.jpg"
	
	method iniciar() {
	
		game.width(15)
		game.height(15)
		game.title("Battle City")
		game.addVisual(self)
		game.schedule(1, {audio.reproducir("gameStart")})
		
		
		keyboard.e().onPressDo{
			juego.configurarInicio()
			juego.iniciar()
		
		}
		
		keyboard.q().onPressDo{
			game.stop()
		}
	}	
}


object juego {
	
	
	method iniciar() {
		
		self.configurarInicio()
		self.agregarVisuales()
		self.programarTeclas()
//		self.definirColisiones()
	}
	
	method configurarInicio() {
		
		game.clear()
	    audio.parar()
	    
	    pared1.aparece() pared2.aparece() pared3.aparece() pared4.aparece() pared5.aparece()
	    pared6.aparece() pared7.aparece() pared8.aparece() pared9.aparece() pared10.aparece()
	    pared11.aparece() pared12.aparece() pared13.aparece() pared14.aparece() pared15.aparece()
	    pared16.aparece() pared17.aparece() pared18.aparece() pared19.aparece() pared20.aparece()
	    
		
	}
	
	method agregarVisuales() {
		
		game.addVisual(fondojuego)		
		game.addVisual(jugador1)
		//game.addVisual(tanque2)
		
		game.addVisual(vida1)
		game.addVisual(vida2)
		
		game.addVisual(pared1)
		game.addVisual(pared2)
		game.addVisual(pared3)
		game.addVisual(pared4)
		game.addVisual(pared5)
		
		game.addVisual(pared6)
		game.addVisual(pared7)
		game.addVisual(pared8)
		game.addVisual(pared9)
		game.addVisual(pared10)
		
		game.addVisual(pared11)
		game.addVisual(pared12)
		game.addVisual(pared13)
		game.addVisual(pared14)
		game.addVisual(pared15)
		
		game.addVisual(pared16)
		game.addVisual(pared17)
		game.addVisual(pared18)
		game.addVisual(pared19)
		game.addVisual(pared20)
	}
	
	
	method programarTeclas() {
		
		keyboard.up().onPressDo{ jugador1.mover(jugador1.position().up(1),arriba)}
		keyboard.down().onPressDo{ jugador1.mover(jugador1.position().down(1),abajo)}
		keyboard.left().onPressDo{ jugador1.mover(jugador1.position().left(1),izquierda)}
		keyboard.right().onPressDo{ jugador1.mover(jugador1.position().right(1),derecha)}
		
		
	/* keyboard.left().onPressDo{tanque2.izquierda()}
		keyboard.right().onPressDo{tanque2.derecha()}
		keyboard.up().onPressDo{tanque2.subir()}
		keyboard.down().onPressDo{tanque2.bajar()}
		keyboard.enter().onPressDo{tanque2.disparar()} */
	}
	
	method estaEnElTablero(ubicacion) = ubicacion.x().between( 0 , game.width()) && ubicacion.y().between( 0 , game.height())

/*
    method definirColisiones() {
		game.onCollideDo(tanque,{algo => algo.desaparecer() }) 
	}

    method detener() {
    	
    	audio.parar()
    	game.schedule(---,{game.addVisual(gameOver)})
    	game.schedule(---,{audio.reproducir("gameOver")})
    	
    	keyboard.space().onPressDo {
    		self.configurarInicio()
    		self.iniciar()
    	}
    	
    	keyboard.b().onPressDo {
    		self.volverAlMenu()
    	}
    }
    
    method volverAlMenuPrincipal(){

		game.clear()
		audio.parar()
		menuPrincipal.iniciar()
		
	}
 */
	
}

object fondojuego{
	method position() = game.at(0,0)
	method image() = "assets/imagenes/fondojuego.jpg"
}


object gameOver {
	method position() = game.origin()
	method image() = "assets/imagenes/gameOver.png"
	
	}	

	

object audio {
	
	var property cancionSonando = null
	
	method cancion(nombreCancion) = game.sound( "assets/sonidos/" + nombreCancion + ".mp3")
	
	method reproducir(nombreCancion) {
		cancionSonando = self.cancion(nombreCancion)
		cancionSonando.play()
		cancionSonando.volume(0.4)
		
		
		}
	
	method parar(){
		
		  cancionSonando.stop()
	}

}

class ElementosDelJuego {
	
	method image() = null
	
	method desaparece() {
		game.removeVisual(self)
	}
}

class Tanque inherits ElementosDelJuego{
	
	var orientacion = arriba
	var property position = null
	var imagen
	
	override method image() = orientacion.imagenDelJugador()
	
	method mover ( posicion, unaOrientacion){
		
		orientacion = unaOrientacion
		self.actualizarImagen()
		
		if( self.puedeMoverAl( unaOrientacion )){
			return orientacion.posicionEnEsaDireccion()
		}else{
			return self.position()
		}
	}
	
	method actualizarImagen(){
		imagen = orientacion.imagenDelJugador()
		game.addVisual(self)
	}
	
	method puedeMoverAl( unaOrientacion ) {
	     return
	         game.getObjectsIn( unaOrientacion.posicionEnEsaDireccion()).all {unObj => unObj.esAtravesable()}
}
}

const jugador1 = new Tanque (position = game.at(7, 13),imagen = "assets/imagenes/tanqueA_2.png")


object arriba {
	method imagenDelJugador() = "assets/imagenes/tanqueA_1.png"
	method posicionEnEsaDireccion() = jugador1.position().up(1)
}

object abajo {
	method imagenDelJugador() = "assets/imagenes/tanqueA_2.png"
	method posicionEnEsaDireccion() = jugador1.position().down(1)
}

object izquierda {
	method imagenDelJugador() = "assets/imagenes/tanqueA_3.png"
	method posicionEnEsaDireccion() = jugador1.position().left(1)
}

object derecha {
	method imagenDelJugador() = "assets/imagenes/tanqueA_4.png"
	method posicionEnEsaDireccion() = jugador1.position().right(1)
}

/* 
 * class TanqueB inherits Tanque {
	
	override method image() = "assets/imagenes/tanqueB_" + fotoTanqueB.toString() + ".png"
}
*/

class Bala inherits ElementosDelJuego{
	
	var property position
	var orientacion 
	
	override method image() = ""
	
	method avanza(hacia) {
		if(juego.estaEnElTablero(hacia)) {
			position = hacia
		} else {
			self.desaparece()
		}
	}
	
	method impactoBala(param1) {
		
	}
	
	method danio() = 25
	
	method disparar(){
		position = orientacion.posicionEnEsaDireccion()
		game.addVisual(self)
		game.onCollideDo( self , { elem => elem.impactoBala()})
		game.onTick( 20 , "disparo tanque" , { self.avanza(orientacion.posicionEnEsaDireccion()) } )
	}
	
}

class Vida {
	
	var property fotoVida = 5
	var property position
	
	method image() = "assets/vida5.png"
	
	
}
/* object tanque1 inherits Tanque(position = game.at(7, 13),vida=5,oponente=tanque2){}
	
object tanque2 inherits TanqueB(position = game.at(7,1),vida=5,oponente=tanque1){}
*/


object vida1 inherits Vida(position =game.at(2,14)){}
object vida2 inherits Vida(position =game.at(10,14)){}

class Muro {
	
	var property position = null
	var  x
	var  y 
	
	method aparece() {
			
		   position = game.at(x,y)
		   
	}
	method image()="assets/imagenes/pared.png"
	method esAtravesable()=false
}

const pared1 = new Muro ( x=5 , y=3)
const pared2 = new Muro ( x=5 , y=4)
const pared3 = new Muro ( x=5 , y=5)
const pared4 = new Muro ( x=4 , y=5)
const pared5 = new Muro ( x=3 , y=5)

const pared6 = new Muro ( x=9 , y=3)
const pared7 = new Muro ( x=9 , y=4)
const pared8 = new Muro ( x=9 , y=5)
const pared9 = new Muro ( x=10 , y=5)
const pared10 = new Muro ( x=11 , y=5)

const pared11 = new Muro ( x=3 , y=9)
const pared12 = new Muro ( x=4 , y=9)
const pared13 = new Muro ( x=5 , y=9)
const pared14 = new Muro ( x=5 , y=10)
const pared15 = new Muro ( x=5 , y=11)

const pared16 = new Muro ( x=9 , y=9)
const pared17 = new Muro ( x=9 , y=10)
const pared18 = new Muro ( x=9 , y=11)
const pared19 = new Muro ( x=10 , y=9)
const pared20 = new Muro ( x=11 , y=9)

