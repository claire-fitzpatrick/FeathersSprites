package
{

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.geom.Rectangle;

	import starling.core.Starling;

	import feathers.system.DeviceCapabilities;


	public class FeathersSprites extends Sprite
	{
		private var starling: Starling;

		public function FeathersSprites()
		{
			// constructor code
			this.stage.align = stageAlign.TOP_LEFT;
			this.stage.scaleMode = StageScaleMode.NO_SCALE;

			this.stage.addEventListener(Event.RESIZE, stageResized);
			Starling.handleLostContext = true;

			starling = new Starling(Main, this.stage);
			starling.start();
		}
	private function stageResized(e:Event):void
		{
			starling.stage.stageWidth = this.stage.stageWidth;
			starling.stage.stageHeight = this.stageHeight;
			const viewPort:Rectangle = starling.viewPort;
			viewPort.width = this.stage.stageWidth;
			viewPort.height = this.stage.stageHeight;
			starling.viewPort = viewPort;
		}
	}

}