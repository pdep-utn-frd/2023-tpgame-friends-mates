import wollok.game.*

object pantalla {
	method iniciar() {
		self.configurarInicio()
		self.agregarVisuales()
		self.programarTeclas()
//		self.definirColisiones()
	}
	method configurarInicio() {
		game.clear()
		game.height(12)
		game.width(20)
		game.title("Guerra de tanques")
	}
	method agregarVisuales() {
//		game.addVisual(fondo)
		game.addVisual(tanque1)
		game.addVisual(tanque2)
		
//		game.addVisual(vida1)
//		game.addVisual(vida2)
	}
	method programarTeclas() {
		keyboard.d().onPressDo{tanque1.derecha()}
		keyboard.a().onPressDo{tanque1.izquierda()}
		keyboard.w().onPressDo{tanque1.arriba()}
		keyboard.s().onPressDo{tanque1.bajar()}
		keyboard.f().onPressDo{tanque1.disparar()}
		
		
		keyboard.left().onPressDo{tanque2.izquierda()}
		keyboard.right().onPressDo{tanque2.derecha()}
		keyboard.up().onPressDo{tanque2.arriba()}
		keyboard.down().onPressDo{tanque2.bajar()}
		keyboard.enter().onPressDo{tanque2.disparar()}
	}
//	method definirColisiones() {
//		game.onCollideDo(tanque,{algo => algo.desaparecer() }) 
//	}
}


class Tanque {
	var property position
	var property vida
	var property oponente
	var property image
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
	method arriba(){position = position.up(1)}
	method bajar(){position = position.down(1)}
	method derecha(){position = position.right(1)}
	method izquierda(){position = position.left(1)}
	method disparar(){game.say(self, "disparé")}
}
//falta ver imagenes de movimiento de cada objeto (tanques), solo use una para la prueba
//el metodo vidas es solo una prueba para el juego
//falta metodo disparar, agregar las balas y su colision
//agregar paredes y su colision
object tanque1 inherits Tanque(position = game.at(13, 0),vida=100,oponente=tanque2,image="2arriba.jpg"){}
object tanque2 inherits Tanque(position = game.origin(),vida=100,oponente=tanque1,image="2arriba.jpg"){}
