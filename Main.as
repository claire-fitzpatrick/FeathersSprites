package {
	import starling.events.Event;
	import starling.display.Sprite;

	import feathers.controls.Button;
	import feathers.controls.Screen;
	import feathers.controls.Panel;
	import feathers.controls.ImageLoader;
	import feathers.controls.TabBar;
	import feathers.layout.VerticalLayout;
	import feathers.layout.VerticalLayoutData;
	import feathers.layout.HorizontalLayout;
	import feathers.layout.AnchorLayout;
	import feathers.layout.AnchorLayoutData;
	import feathers.themes.MetalWorksMobileTheme;
	import feathers.events.FeathersEventType;

	import starling.textures.Texture;
	import starling.textures.TextureAtlas;
	import starling.display.Image;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import starling.display.Button;
	import feathers.motion.transitions.ScreenFadeTransitionManager;
	import feathers.data.ListCollection;
	import starling.utils.AssetManager;
	import flash.events.Event;

	public class Main extends Screen {
		//Sprites
		[Embed(source = "SpriteSheet.xml", mimeType = "application/octet-stream")]
		public static const ATLAS_XML: Class;

		[Embed(source = "SpriteSheetTextures.png")]
		public static const ATLAS_TEXTURE: Class;

		private var atlas: TextureAtlas;
		private var atlasTexture: Texture;
		private var bgTexture: Texture;
		private var bgImgLoader: ImageLoader;

		protected var button: Button;
		private var contentPanel: Panel;
		private var buttonPanel: Panel;

		private var tabBar: TabBar;
		private var contentPanelLayoutData: AnchorLayoutData;
		private var tabsLayoutData: AnchorLayoutData;
		private var assetMgr: AssetManager;

		public function Main() {
			// constructor code
			super();
			this.addEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.addEventListener(FeathersEventType.INITIALIZE, startApp);

		}

		private function initializeHandler(e: Event): void {
			// constructor code
			assetMgr = new AssetManager();
			assetMgr.verbose = true;
			assetMgr.enqueue(EmbeddedAssets);

			assetMgr.loadQueue(handleAssetsLoading);
		}

		private function handleAssetsLoading(ratioLoaded: Number): void {
			trace("handleAssetsLoading: " + ratioLoaded);

			//if the ratio is 1 assets are loaded
			if (ratioLoaded == 1) {
				//And start
				startApp()
			}
		}

		private function startApp(e: Event): void {
			this.removeEventListener(FeathersEventType.INITIALIZE, initializeHandler);
			this.stage.addEventListener(Event.RESIZE, stageResized);

			new MetalWorksMobileTheme();

			var screenLayout: AnchorLayout = new AnchorLayout();
			this.layout = screenLayout;

			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;

			tabBar = new TabBar();
			tabBar.dataProvider = new ListCollection(
				[{
					label: "one"
				}, {
					label: "two"
				}, {
					label: "three"
				}, ]
			);
				tabBar.selectedIndex = 1;
				tabBar.addEventListener(Event.CHANGE, tabsChange_Handler);
				
				tabsLayoutData = new AnchorLayoutData();
				tabsLayoutData.bottom = 5;
				tabsLayoutData.left = 5;
				tabsLayoutData.right = 5;
				
				tabBar.layoutData = tabsLayoutData;
				this.addChild(tabBar);
				


			atlasTexture = Texture.fromBitmap(new ATLAS_TEXTURE());

			var xml: XML = XML(new ATLAS_XML());
			atlas = new TextureAtlas(atlasTexture, xml);

			this.buttonPanel = new Panel();

			var buttonPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			buttonPanelLayoutData.left = 10;
			buttonPanelLayoutData.right = 10;
			buttonPanelLayoutData.bottom = 10;

			this.buttonPanel.layoutData = buttonPanelLayoutData;

			var buttonPanelLayout: HorizontalLayout = new HorizontalLayout();
			buttonPanelLayout.horizontalAlign = HorizontalLayout.HORIZONTAL_ALIGN_CENTER;
			this.buttonPanel.layout = buttonPanelLayout;
			this.addChild(this.buttonPanel);

			this.contentPanel = new Panel();

			var contentPanelLayoutData: AnchorLayoutData = new AnchorLayoutData();
			contentPanelLayoutData.top = 10;
			contentPanelLayoutData.bottom = 10;
			contentPanelLayoutData.left = 10;
			contentPanelLayoutData.right = 10;

			contentPanelLayoutData.bottomAnchorDisplayObject = this.buttonPanel;
			contentPanel.layoutData = contentPanelLayoutData;
			this.addChild(contentPanel);

			//Getting sprite
			bgTexture = atlas.getTexture("spriteimg_10000");

			//ImageLoader created
			bgImgLoader = new ImageLoader();
			//Texture goes into ImageLoader
			bgImgLoader.source = bgTexture;
			bgImgLoader.width = this.stage.stageWidth;
			bgImgLoader.maintainAspectRatio = true;
			//bgImgLoader loaded into the contentPanel
			contentPanel.addChild(bgImgLoader);

			this.button = new Button();
			this.button.label = "Click Me!";
			this.button.addEventListener(Event.TRIGGERED, button_TriggerHandle);

			this.buttonPanel.addChild(this.button);
		}
		protected function button_TriggerHandle(event: Event): void {
			//sources changed
			bgImgLoader.source = atlas.getTexture("spriteimg_20000");
		}
		protected function stageResized(e: Event): void {
			this.height = this.stage.stageHeight;
			this.width = this.stage.stageWidth;
			bgImgLoader.width = this.width;
		}
	}

}