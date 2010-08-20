package com.exploid
{
	import com.exploid.events.EnemyEvent;
	import com.exploid.groups.ParticleGroup;
	
	import flash.events.Event;
	
	
	/**
	 * Game state that contains the emitters and special shit for a level 
	 * @author devin
	 * 
	 */	
	
	public class ExLevel
	{
		public var particles:ParticleGroup;
		public var player:ExPlayer;
		
		public function ExLevel()
		{
			particles = new ParticleGroup();
			particles.addEventListener(EnemyEvent.KILLED, onEnemyKilled);
		}
		
		private function onEnemyKilled(event:Event):void {
			ExGlobal.currentMultiplier ++;
		}
		
		public function createPlayer():void {
			player = new ExPlayer(ExGlobal.worldWidth / 2, ExGlobal.worldHeight / 2);
			player.state = ExPlayer.ST_INVINCIBLE;
			this.particles.add(player);
		}
		
		public function update():void {
			particles.update();
			
			// check if respawn is needed / possible
			if(player.state == ExParticle.ST_DEAD && this.player.respawn()) {
				player.x = ExGlobal.worldWidth / 2;
				player.y = ExGlobal.worldHeight / 2;
				this.particles.add(player);
			}
		}
	}
}