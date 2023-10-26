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
	var property bala
	
	method image()="assets/imagenes/tanque" + tanque + "_" + fotoTanque.toString() + ".png"
	
	method position() = position
	
	method desaparecer(){
		game.removeVisual(self)
		vida = 5
		juego.detener()
        
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
	
	method disparar(){
		
		game.addVisual(bala)
		
		if (fotoTanque==1){
			bala.position(position.up(1))
			bala.fotoBala(1)
			game.onTick(20,"disparo", { => bala.subir()})
			//game.schedule(400,{bala.parar()})
		}if (fotoTanque==2){
			bala.position(position.down(1))
			bala.fotoBala(2)
			game.onTick(20,"disparo", { => bala.bajar()})
			//game.schedule(400,{bala.parar()})
		}if (fotoTanque==3){
			bala.position(position.left(1))
			bala.fotoBala(3)
			game.onTick(20,"disparo", { => bala.izquierda()})
			//game.schedule(400,{bala.parar()})
		}if (fotoTanque==4){
			bala.position(position.right(1))
			bala.fotoBala(4)
			game.onTick(20,"disparo", { => bala.derecha()})
			//game.schedule(400,{bala.parar()})
		}
		
		game.onCollideDo(bala,{enemigo => enemigo.pierdeVida()})
        game.whenCollideDo(tanque1,{ cosa => cosa.parar()})
        game.whenCollideDo(tanque2,{ cosa => cosa.parar()})
	}
}

class Bala {
	
	var property tanque
	var property position
	var property fotoBala
	
	method image()= "assets/imagenes/bala" + fotoBala.toString() + ".png"
	
	method subir(){
		position = position.up(1)
	}
	
	method bajar(){
		position = position.down(1)
	}
	
	method derecha(){
		position = position.right(1)
	}
	
	method izquierda(){
		position = position.left(1)
	}
	
	method parar(){
		game.removeTickEvent("disparo")
		game.removeVisual(self)
	}
}

class Pared {
	
	var property position
	
	method image()="assets/imagenes/pared.jpg"	
}

class Vida {
	
	var property tanque
	var property position
	
	method image() = "assets/imagenes/vida" + tanque.vida().toString() + ".png"
}

object tanque1 inherits Tanque(tanque="A",fotoTanque=2,position = game.at(7, 13),vida=5,oponente=tanque2,bala=bala1){}
object tanque2 inherits Tanque(tanque="B",fotoTanque=1,position = game.at(7,1),vida=5,oponente=tanque1,bala=bala2){}

object bala1 inherits Bala(tanque=tanque1,position=tanque1.position(),fotoBala=null){}
object bala2 inherits Bala(tanque=tanque2,position=tanque2.position(),fotoBala=null){}

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
