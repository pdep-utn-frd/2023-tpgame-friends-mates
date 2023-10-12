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
		
	}
	
	method agregarVisuales() {
		game.addVisual(fondojuego)		
		game.addVisual(tanque1)
		game.addVisual(tanque2)
		
//		game.addVisual(vida1)
//		game.addVisual(vida2)
	}
	
	
	method programarTeclas() {
		
		keyboard.d().onPressDo{tanque1.derecha()}
		keyboard.a().onPressDo{tanque1.izquierda()}
		keyboard.w().onPressDo{tanque1.subir()}
		keyboard.s().onPressDo{tanque1.bajar()}
		keyboard.f().onPressDo{tanque1.disparar()}
		
		
		keyboard.left().onPressDo{tanque2.izquierda()}
		keyboard.right().onPressDo{tanque2.derecha()}
		keyboard.up().onPressDo{tanque2.subir()}
		keyboard.down().onPressDo{tanque2.bajar()}
		keyboard.enter().onPressDo{tanque2.disparar()}
	}

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

class Tanque {
	
	var property fotoTanqueA = 2
	var property fotoTanqueB = 1
	var property position
	var property vida
	var property oponente
	
	method image() = "assets/imagenes/tanqueA_" + fotoTanqueA.toString() + ".png"
	
	method position() = position
	
	method desaparecer(){
		game.removeVisual(self)
		oponente.ganar()
	}
	
	method pierdeVida(){
		vida = vida - 20
		game.say(self, "tengo " + vida)
		if (self.vida() == 0){
			self.desaparecer()
		}
	}
	
	method ganar(){
		game.say(self, "Gané")
	}
	
	method subir(){
	  if(position.y()>=0 and position.y()<14){
		position = position.up(1)
		fotoTanqueA=1
		fotoTanqueB=1
		}
	}
		
	method bajar(){
		if (position.y()<=15 and position.y()>0){
		  position = position.down(1)
		  fotoTanqueA=2
		  fotoTanqueB=2
		}
	}
	
	method izquierda(){
		if (position.x()<=15 and position.x()>0){
		  position = position.left(1)
		  fotoTanqueA=3
		  fotoTanqueB=3
		}
	}
	
	method derecha(){
		if (position.x()>=0 and position.x()<14){
		  position = position.right(1)
		  fotoTanqueA=4
		  fotoTanqueB=4
		}
	}
	

	method disparar(){game.say(self, "disparé")}
}

class TanqueB inherits Tanque {
	
	override method image() = "assets/imagenes/tanqueB_" + fotoTanqueB.toString() + ".png"
}


object tanque1 inherits Tanque(position = game.at(7, 13),vida=100,oponente=tanque2){}
	
object tanque2 inherits TanqueB(position = game.at(7,1),vida=100,oponente=tanque1){}


