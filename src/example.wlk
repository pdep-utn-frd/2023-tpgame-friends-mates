import wollok.game.*


object menuPrincipal {
	
	method position() = game.at(0,0)
	method image() = "assets/imagenes/menuJuego.jpg"
	
	method iniciar() {
	
		game.width(15)
		game.height(15)
		game.title("Battle City")
		game.addVisual(self)
		game.schedule(1, {audio.reproducir("gameStart")})
		
		
		keyboard.e().onPressDo{
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
	}
	method configurarInicio() {
		
		game.clear()
	    audio.parar()
	    tanque1.resetear()
    	tanque2.resetear()
		
	}
	method agregarVisuales() {
		
		game.addVisual(fondojuego)		
		game.addVisual(tanque1)
		game.addVisual(tanque2)

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
		
		powerUpVida.aparece()
		powerUpMuerte.aparece()
	
		game.whenCollideDo(pared1,{algo => algo.chocar()})
		game.whenCollideDo(pared2,{algo => algo.chocar()})
		game.whenCollideDo(pared3,{algo => algo.chocar()})
		game.whenCollideDo(pared4,{algo => algo.chocar()})
		game.whenCollideDo(pared5,{algo => algo.chocar()})
		game.whenCollideDo(pared6,{algo => algo.chocar()})
		game.whenCollideDo(pared7,{algo => algo.chocar()})
		game.whenCollideDo(pared8,{algo => algo.chocar()})
		game.whenCollideDo(pared9,{algo => algo.chocar()})
		game.whenCollideDo(pared10,{algo => algo.chocar()})
		game.whenCollideDo(pared11,{algo => algo.chocar()})
		game.whenCollideDo(pared12,{algo => algo.chocar()})
		game.whenCollideDo(pared13,{algo => algo.chocar()})
		game.whenCollideDo(pared14,{algo => algo.chocar()})
		game.whenCollideDo(pared15,{algo => algo.chocar()})
		game.whenCollideDo(pared16,{algo => algo.chocar()})
		game.whenCollideDo(pared17,{algo => algo.chocar()})
		game.whenCollideDo(pared18,{algo => algo.chocar()})
		game.whenCollideDo(pared19,{algo => algo.chocar()})
		game.whenCollideDo(pared20,{algo => algo.chocar()})
		
		game.whenCollideDo(tanque2,{algo => algo.chocar()})
		game.whenCollideDo(tanque1,{algo => algo.chocar()})
		
		game.whenCollideDo(powerUpVida,  { tanque1 => tanque1.colisionarConPowerUp(powerUpVida) })
        game.whenCollideDo(powerUpMuerte,  { tanque1 => tanque1.colisionarConPowerUp(powerUpMuerte) })

        game.whenCollideDo(powerUpVida,  { tanque2 => tanque2.colisionarConPowerUp(powerUpVida) })
        game.whenCollideDo(powerUpMuerte,  { tanque2 => tanque2.colisionarConPowerUp(powerUpMuerte) })
		
		
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
	
	method detener() {
    	
    	audio.parar()
    	game.schedule(1,{game.addVisual(gameOver)})
    	game.schedule(1,{audio.reproducir("gameOver")})
    	
    	keyboard.space().onPressDo {
    		tanque1.resetear()
    		tanque2.resetear()
    		self.iniciar()
    	}
    	
    	keyboard.b().onPressDo {
    		game.clear()
		    audio.parar()
		    menuPrincipal.iniciar()
    	}
    }
}

object fondojuego {
	
	method position() = game.at(0,0)
	
	method image() = "assets/imagenes/fondojuego.jpeg"
	
	method chocar() {}
}

object gameOver {
	
	method position() = game.origin()
	
	method image() = "assets/imagenes/gameOver.jpg"
	
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
	
	var property tanque
	var property fotoTanque=1
	var property position
	var property vida = 5
	var property oponente


	method image()="assets/imagenes/tanque" + tanque + "_" + fotoTanque.toString() + ".png"
	
	method position() = position
	
	method desaparecer(){
		if (game.hasVisual(self)) {
		game.removeVisual(tanque1)
		game.removeVisual(tanque2)
		juego.detener()
       }
	}
	
	method vidaMaxima(){
		vida = 5
	}
	
	method explotarGranada() {
		oponente.pierdeVida()
		oponente.pierdeVida()
	}
	
	
	method pierdeVida(){
		vida = vida - 1
		if (self.vida() == 0){
			self.desaparecer()
		}
	}
	
	method subir(){
		fotoTanque=1
		if(position.y()>=0 and position.y()<13){
		position = position.up(1)
		}
	}
		
	method bajar(){
		fotoTanque=2
		if (position.y()<=15 and position.y()>0){
		  position = position.down(1)
		}
	}
	
	method izquierda(){
		fotoTanque=3
		if (position.x()<=15 and position.x()>0){
		  position = position.left(1)
		}
	}
	
	method derecha(){
		fotoTanque=4
		if (position.x()>=0 and position.x()<14){
		  position = position.right(1)
		}
	}
	
	method chocar(){
		
		if(fotoTanque==1){position = position.down(1)
		}if(fotoTanque==2){position = position.up(1)
		}if(fotoTanque==3){position = position.right(1)
		}if(fotoTanque==4){position = position.left(1)}
	}
	
	method choqueBala(bala) {
		bala.choque()
		self.pierdeVida()
	}
	
	method disparar(){
		
		const bala = new Bala( position = self.position())
		game.addVisual(bala)
		bala.mover(fotoTanque)
		game.whenCollideDo(bala,{ cosa => cosa.choqueBala(bala)})
        
	}
	
	  method colisionarConPowerUp(powerUp) {
        powerUp.efecto(self)
    }
	
    }

class Bala {
	
	var property position
	
	method image()= "assets/imagenes/bala.png"
	
	method mover(direccion) {
		if (direccion == 1){
			position = position.up(1)
			game.onTick(20,"disparo", { => self.subir()})
		}
		else if (direccion == 2){
			position = position.down(1)
			game.onTick(20,"disparo", { => self.bajar()})
		}
		else if (direccion == 3){
			position = position.left(1)
			game.onTick(20,"disparo", { => self.izquierda()})
		}
		else if (direccion == 4){
			position = position.right(1)
			game.onTick(20,"disparo", { => self.derecha()})
	    }	
	}
	
	method subir(){
		position = position.up(1)
		if(position.y() > game.height()){
			self.borrar()
		}
	}
	
	method bajar(){
		position = position.down(1)
		if(position.y() > game.height()){
			self.borrar()
		}
	}
	
	method derecha(){
		position = position.right(1)
		if(position.x() > game.width()){
			self.borrar()
		}
	}
	
	method izquierda(){
		position = position.left(1)
		if(position.x() > game.width()){
			self.borrar()
		}
	}
	
	method borrar(){
		game.removeTickEvent("disparo")
		game.removeVisual(self)
	}
	
	method choque(){
		if(game.hasVisual(self)) {
		    self.borrar()
		}
	}
	
	method choqueBala(bala){
		bala.choque()
		if(game.hasVisual(self)){
			bala.borrar()
		}
	}
}

class Pared {
	
	var property position
	
	method image()="assets/imagenes/pared.jpg"	
	
	method choqueBala(bala) {
		bala.choque()
	}
}

class Vida {
	
	var property tanque
	var property position
	
	method image() = "assets/imagenes/vida" + tanque.vida().toString() + ".png"
}

object tanque1 inherits Tanque(tanque="A",fotoTanque=2,position = game.at(7, 13),vida=5,oponente=tanque2){
	
	method resetear() {
		vida = 5
		tanque="A"
		fotoTanque=2
		position = game.at(7, 13)
	}
}

object tanque2 inherits Tanque(tanque="B",fotoTanque=1,position = game.at(7,1),vida=5,oponente=tanque1){
	
	method resetear() {
		vida = 5
		tanque="B"
		fotoTanque=1
		position = game.at(7, 1)
	}
}

object bala1 inherits Bala(position=tanque1.position()){}
object bala2 inherits Bala(position=tanque2.position()){}

object vida1 inherits Vida(tanque=tanque1,position =game.at(1,14)){}
object vida2 inherits Vida(tanque=tanque2,position =game.at(11,14)){}

object pared1 inherits Pared(position=game.at(3,9)){}
object pared2 inherits Pared(position=game.at(4,9)){}
object pared3 inherits Pared(position=game.at(5,9)){}
object pared4 inherits Pared(position=game.at(5,10)){}
object pared5 inherits Pared(position=game.at(5,11)){}

object pared6 inherits Pared(position=game.at(9,11)){}
object pared7 inherits Pared(position=game.at(9,10)){}
object pared8 inherits Pared(position=game.at(9,9)){}
object pared9 inherits Pared(position=game.at(10,9)){}
object pared10 inherits Pared(position=game.at(11,9)){}

object pared11 inherits Pared(position=game.at(3,5)){}
object pared12 inherits Pared(position=game.at(4,5)){}
object pared13 inherits Pared(position=game.at(5,5)){}
object pared14 inherits Pared(position=game.at(5,4)){}
object pared15 inherits Pared(position=game.at(5,3)){}

object pared16 inherits Pared(position=game.at(9,5)){}
object pared17 inherits Pared(position=game.at(9,4)){}
object pared18 inherits Pared(position=game.at(9,3)){}
object pared19 inherits Pared(position=game.at(10,5)){}
object pared20 inherits Pared(position=game.at(11,5)){}

const paredes = [pared1,pared2, pared3, pared4, pared5, pared6, pared7, pared8, pared9, pared10, pared11, pared12, pared13, pared14, pared15, pared16, pared17, pared18, pared19, pared20]
// POWER UPS

class PowerUps {
	
	var property position = null
	var property x = null
	var property y = null

	
  	method aparece() {
        x = (1..14).anyOne()
		y = (1..13).anyOne()
		if(!paredes.any({par=>par.position()==game.at(x,y)})){
			position = game.at(x,y)
		}else{
			self.aparece()
		}
		
		game.addVisual(self)
		game.schedule(10000,{self.aparece()})
		game.schedule(5000,{self.desaparece()})
	}
	
	method desaparece() {
		if (game.hasVisual(self)) {
			game.removeVisual(self)
		}
	}
	
	method chocar(){}
}


class PowerUpVida inherits PowerUps {
	
	method image()="assets/imagenes/estrella.png"
	
	method efecto(tanque) {
        tanque.vidaMaxima()
        self.desaparece()
    }
}


class PowerUpMuerte inherits PowerUps {
	
	method image()="assets/imagenes/granada.png"
	
    method efecto(tanque) {
        tanque.explotarGranada()
        self.desaparece()
    }
}


const powerUpVida = new PowerUpVida ()
const powerUpMuerte = new PowerUpMuerte ()





