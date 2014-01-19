#region File Description
//-----------------------------------------------------------------------------
// GameplayScreen.cs
//
// Microsoft XNA Community Game Platform
// Copyright (C) Microsoft Corporation. All rights reserved.
//-----------------------------------------------------------------------------
#endregion
using System.Collections.Generic;
#region Using Statements
using System;
using System.Threading;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Media;

#endregion

namespace GameStateManagement
{
    /// <summary>
    /// This screen implements the actual game logic. It is just a
    /// placeholder to get the idea across: you'll probably want to
    /// put some more interesting gameplay in here!
    /// </summary>
    class GameplayScreen : GameScreen
    {
        #region Fields

        ContentManager content;
        SpriteFont gameFont;
        //Song bgm;

        Vector2 playerPosition = new Vector2(100, 100);
        Vector2 enemyPosition = new Vector2(100, 100);

        Random random = new Random();

		Utils.Timer m_kTimer = new Utils.Timer();

		Star m_Star;

        //Level Initialization
        List<Ocean> oceanList = new List<Ocean>();
        List<Cliff> cliffList = new List<Cliff>();
        List<Grass> grassList = new List<Grass>();
        List<Wall> wallList = new List<Wall>();
        List<Building> buildingList = new List<Building>();
        List<Arch_Lintel> archLintelList = new List<Arch_Lintel>();
        List<Arch_Side> archSideList = new List<Arch_Side>();
        Skybox skybox;

        //Origin of Different Areas//
        int Area1 = 0 - 7000;
        int Area2 = -14000 - 4000;
        int Area3 = -28000 - 4000;
        int Area4 = -42000 - 4000;
        int Area5 = -56000 - 4000;



        Reticule m_Reticule;
        public Utils.HUD hud;
        public Utils.Timer timer;
        public static Ship m_Ship;
        public static Boss m_Boss;
        static FollowMe followme;

        //private EnemyShip enemy;

        EnemyManager m_Spawn;

        //Camera and Projection!//
        public static LookAtCamera Camera1;
        public static Matrix ProjectionMatrix;

        //Audio//
        
        #endregion

        //Gameplay states//
        public enum GameState {Normal, FreeRanged, Paused, Victory, VictoryM, Lost, Exit};
        public static GameState gameState;

        //Input Booleans//
        bool Left = false;
        bool Right = false;
        bool Up = false;
        bool Down = false;
        bool Moving = false;
        bool Fire = false;
        bool Charging = false;
		bool Bomb = false;		
        bool barrelRoll = false;
        #region Initialization

        //Dynamic Ambient lighting//
        public float amount;
        public bool colorincrease;
        public bool posincrease;
        public Vector3 StartPos;
        public Vector3 StartColor;
        public Vector3 MaxColor;
        public static Vector3 ColorLerp;
        public static Vector3 DirectionalLightPos;
        public static Cue cue;
        public static Cue alarmcue;
        bool alarmon;
        bool respawned;
        private Matrix DirectionalLightMatrix;

        private Quaternion PosColorRotation;

        /// <summary>
        /// Constructor.
        /// </summary>
        public GameplayScreen()
        {
            TransitionOnTime = TimeSpan.FromSeconds(1.5);
            TransitionOffTime = TimeSpan.FromSeconds(0.5);

            amount = 0.0f;
            colorincrease = true;
            posincrease = true;
            
            StartColor = new Vector3(0.86f, 0.72f, 0.58f);
            MaxColor = new Vector3(0.72f, 0.48f, 0.24f);
            ColorLerp = new Vector3();

            PosColorRotation = Quaternion.Identity;
            StartPos = new Vector3(-1.0f, -1.0f, -1.0f);
            DirectionalLightMatrix = Matrix.Identity;
            DirectionalLightPos = new Vector3();

            timer = new Utils.Timer();
            timer.AddTimer("BossSpawnTimer", 75.0f, AddBoss, false);
            //timer.AddTimer("BossSpawnTimer", 0.0f, AddBoss, false);

            cue = ScreenManager.bgmbank.GetCue("corneria");
            cue.Play();
            alarmon = false;
            respawned = false;
            alarmcue = ScreenManager.soundbank.GetCue("damagealert");
            gameState = GameState.Normal;
        }


        /// <summary>
        /// Load graphics content for the game.
        /// </summary>
        public override void LoadContent()
        {
            //Load all meshhes 1st before anything else//
            ScreenManager.Game.Content.Load<Model>("Models/Asteroid");
            ScreenManager.Game.Content.Load<Model>("Models/Missile");
            ScreenManager.Game.Content.Load<Model>("Models/Starship");


            ScreenManager.Game.Content.Load<Model>("Models/Ocean");
            ScreenManager.Game.Content.Load<Model>("Models/Cliff");
            ScreenManager.Game.Content.Load<Model>("Models/Grass");
            ScreenManager.Game.Content.Load<Model>("Models/Wall");
            ScreenManager.Game.Content.Load<Model>("Models/Building");
            ScreenManager.Game.Content.Load<Model>("Models/Arch_Lintel");
            ScreenManager.Game.Content.Load<Model>("Models/Arch_Side");
            ScreenManager.Game.Content.Load<Model>("Models/cube");
            //bgm = ScreenManager.Game.Content.Load<Song>("Audio/corneria");
            //MediaPlayer.Play(bgm);

            if (content == null)
                content = new ContentManager(ScreenManager.Game.Services, "Content");

            gameFont = content.Load<SpriteFont>("gamefont");

            // A real game would probably have more content than this sample, so
            // it would take longer to load. We simulate that by delaying for a
            // while, giving you a chance to admire the beautiful loading screen.
            //Thread.Sleep(1000);

            // once the load has finished, we use ResetElapsedTime to tell the game's
            // timing mechanism that we have just finished a very long frame, and that
            // it should not try to catch up.
            ScreenManager.Game.ResetElapsedTime();

		    //m_kTimer.AddTimer("Timer 1", 10.0f, new Utils.TimerDelegate(TimerOneShot), false);
			//m_kTimer.AddTimer("Timer 2", 1.0f, new Utils.TimerDelegate(TimerLoop), true);
			//m_kTimer.AddTimer("Timer 3", 10.0f, new Utils.TimerDelegate(TimerLoop), true);
			//m_kTimer.AddTimer("Timer 4", 5.0f, new Utils.TimerDelegate(TimerOneShot), false);
			//m_kTimer.AddTimer("Timer 5", 22.0f, new Utils.TimerDelegate(TimerLoopRemove), true);

            
			//m_Star = new Star(ScreenManager.Game);
			//ScreenManager.Game.Components.Add(m_Star);

            makeLevel();

            //Add Spawn Manager//
            m_Spawn = new EnemyManager(ScreenManager.Game);
            ScreenManager.Game.Components.Add(m_Spawn);


            //Add Ship!!//
            AddShip();
            
            //Add Boss!!//
            //AddBoss();

            //Add Reticule//
            m_Reticule = new Reticule(ScreenManager.Game);
            ScreenManager.Game.Components.Add(m_Reticule);

            //Add HUD//

            hud = new Utils.HUD(ScreenManager.Game, new Vector2(750.0f, 600.0f), m_Ship);
            ScreenManager.Game.Components.Add(hud);

            m_Ship.setEnemyManager(m_Spawn);

            //This is for collisions with terrain
            m_Ship.setTerrainHazards(archLintelList, archSideList, buildingList, wallList);

            //CAMERA STUFF
            //CameraMatrix = Matrix.CreateLookAt(new Vector3(0.0f, -1000.0f, 1000.0f), new Vector3(0.0f, 0.0f, 0.0f), new Vector3(0.0f, 1.0f, 0.0f));
            Camera1 = new LookAtCamera(ScreenManager.Game);
            ScreenManager.Game.Components.Add(Camera1);

            ProjectionMatrix = Matrix.CreatePerspectiveFieldOfView(1.0f, ScreenManager.Game.GraphicsDevice.Viewport.AspectRatio, 0.1f, 150000.0f);

            //FreeRangeModeOn();
        }

        //Add the Ship into the game
        #region AddShip
        private void AddShip()
        {
            m_Ship = new Ship(ScreenManager.Game);
            //enemy = new EnemyShip(ScreenManager.Game);
            ScreenManager.Game.Components.Add(m_Ship);
            //ScreenManager.Game.Components.Add(enemy);
            //enemy.setShip(m_Ship);
            followme = new FollowMe(ScreenManager.Game);
            skybox = new Skybox(ScreenManager.Game);
            ScreenManager.Game.Components.Add(followme);
            ScreenManager.Game.Components.Add(skybox);
            followme.Visible = false;
        }
        #endregion

        #region AddBoss
        private void AddBoss()
        {
            m_Boss = new Boss(ScreenManager.Game);
            hud.addBoss(m_Boss);
            EnemyManager.enemyList.Add(m_Boss);
            m_Ship.setBoss(m_Boss);
            ScreenManager.Game.Components.Add(m_Boss);
            EnemyManager.timer.RemoveTimer("SpawnTimer");
        }
        #endregion

        /// <summary>
        /// Unload graphics content used by the game.
        /// </summary>
        public override void UnloadContent()
        {
            content.Unload();
        }

        #endregion

        #region Update and Draw


        /// <summary>
        /// Updates the state of the game. This method checks the GameScreen.IsActive
        /// property, so the game will stop updating when the pause menu is active,
        /// or if you tab away to a different application.
        /// </summary>
        public override void Update(GameTime gameTime, bool otherScreenHasFocus,
                                                       bool coveredByOtherScreen){


            //Game Progression Logic//
            if(gameState == GameState.Exit)
                 ExitScreen();

            if (Ship.lives <= 0 && gameState != GameState.Lost)
            {
                gameState = GameState.Lost;
                m_kTimer.AddTimer("Exit Timer", 5.0f, Exit, false);
            }

            if (gameState == GameState.Victory)
            {
                gameState = GameState.VictoryM;
                m_Ship.BarrelRoll();
                m_kTimer.AddTimer ("Victory Pose Timer", 1.0f, VictoryPose, false);
                m_kTimer.AddTimer("Exit Timer", 5.0f, Exit, false);
            }
            if (Ship.health <= 30 && !alarmcue.IsPlaying && !alarmon)
            {
                alarmon = true;
                alarmcue.Play();
            }
            if (Ship.health <= 0 && alarmcue.IsPlaying)
            {
                alarmcue.Pause();
                respawned = false;
            }
            if (Ship.health <= 30 && !alarmcue.IsPlaying && alarmon && respawned)
            {
                alarmcue.Resume();
            }

            timer.Update(gameTime);
            ScreenManager.audio.Update();

            float fDeltaTime = (float)gameTime.ElapsedGameTime.TotalSeconds;

            #region Lighting
            //Lerp increase//
            if (colorincrease)
            {
                amount += 1.0f * fDeltaTime;
            }
            else
            {
                amount -= 1.0f * fDeltaTime;
            }

            if (amount >= 1.0f)
                colorincrease = false;
            else if (amount <= 0.0f)
                colorincrease = true;

            Vector3.Lerp(ref StartColor, ref MaxColor, amount, out ColorLerp);

            //Color Position//
            //PosColorRotation *= Quaternion.CreateFromAxisAngle(Vector3.UnitZ, (float)((MathHelper.PiOver2) * fDeltaTime));

            DirectionalLightMatrix = Matrix.CreateTranslation(StartPos) * Matrix.CreateFromQuaternion(PosColorRotation);
            DirectionalLightPos = DirectionalLightMatrix.Translation;
            //Directional Light position complete//

            #endregion Lighting

            if (IsActive)
            {
                // Apply some random jitter to make the enemy move around.
                const float randomization = 10;

                enemyPosition.X += (float)(random.NextDouble() - 0.5) * randomization;
                enemyPosition.Y += (float)(random.NextDouble() - 0.5) * randomization;

                // Apply a stabilizing force to stop the enemy moving off the screen.
                Vector2 targetPosition = new Vector2(200, 200);

                enemyPosition = Vector2.Lerp(enemyPosition, targetPosition, 0.05f);

                // TODO: this game isn't very fun! You could probably improve
                // it by inserting something more interesting in this space :-)
				m_kTimer.Update(gameTime);
            }

            #region Player's Destroyed and Blink


            double nextBlinkTime = 10;
            if (gameTime.TotalGameTime.TotalMilliseconds >= nextBlinkTime && ((Ship.state == Ship.State.Invincible1) || (Ship.state == Ship.State.Invincible2)) )
            {
                m_Ship.Visible = !m_Ship.Visible;
                //modelVisibility = !modelVisibility;

                nextBlinkTime = gameTime.TotalGameTime.TotalMilliseconds + 1000;
            }
            else if (!m_Ship.destroyed)
            {
                m_Ship.Visible = true;
            }

            #endregion
        }


        /// <summary>
        /// Lets the game respond to player input. Unlike the Update method,
        /// this will only be called when the gameplay screen is active.
        /// </summary>
        /// 

        public void respawnShip()
        {
            m_Ship.Position.X = 0;
            m_Ship.Position.Y = 0;
            m_Ship.Visible = true;
            Ship.lives--;
            m_Ship.setInvincible();
            Ship.health = 100;
            alarmcue.Resume();
            respawned = true;
        }

        public void FreeRangeModeOn()
        {
            gameState = GameState.FreeRanged;
            m_Ship.Velocity = Vector3.Zero;
            followme.Velocity = Vector3.Zero;
        }

		public override void HandleInput(InputState input, GameTime gameTime)
        {
            if (input == null)
                throw new ArgumentNullException("input");

            if (input.PauseGame)
            {
                // If they pressed pause, bring up the pause menu screen.
                ScreenManager.AddScreen(new PauseMenuScreen());
                //skybox.Visible = false;
            }
            else
            {
                #region PlayerInput

                if (input.ResetCamera)
                {
                    Camera1.cameraPosition = Vector3.Zero;
                    Camera1.cameraVelocity = Vector3.Zero;
                }

                // Otherwise move the player position--- Code here:
                if (Ship.state != Ship.State.Destroyed)
                {
                    if (input.ShipLeft)
                        Left = true;
                    else
                        Left = false;

                    if (input.ShipRight)
                        Right = true;
                    else
                        Right = false;

                    if (input.ShipUp)
                        Up = true;
                    else
                        Up = false;

                    if (input.ShipDown)
                        Down = true;
                    else
                        Down = false;

                    if (input.ShipFire)
                        Fire = true;
                    else
                        Fire = false;
                    if (input.ShipBomb)
                        Bomb = true;
                    else
                        Bomb = false; if (input.ShipBarrelRoll)
                        barrelRoll = true;
                    else
                        barrelRoll = false;

                    if (Up || Down || Left || Right)
                        Moving = true;
                    else
                        Moving = false;
                }
                else
                {
                    Left = false;
                    Right = false;
                    Up = false;
                    Down = false;
                    Moving = false;
                    Fire = false;
                    Bomb = false;
                    barrelRoll = false;
                    Moving = false;
                }

                //Process bool values//

                if (input.ShipCharging)
                    Charging = true;
                else
                    Charging = false;
                if (input.ShipBomb)
                    Bomb = true;
                else
                    Bomb = false;                if (input.ShipBarrelRoll)
                    barrelRoll = true;
                else
                    barrelRoll = false;                //Process bool values//
                //shifting x-y

                if (gameState == GameState.Normal)       //Controls for normal operation
                {
                    //Set the Camera lockonTarget to the ship if the ship is moved//
                    if (Moving)
                        Camera1.target = LookAtCamera.lockOnTarget.ChangeA;
                    else
                        Camera1.target = LookAtCamera.lockOnTarget.FollowMe;

                    if (Left && m_Ship.Position.X >= -250)
                    {
                        //int x = (int)Math.Floor(3 * -(m_Ship.Position.Y) / 10 + 45);
                        //if (m_Ship.Position.X > -(160 + x))
                        int x = (int)Math.Floor((-m_Ship.Position.Y + 150) / 3);
                        if (m_Ship.Position.X > -(150 + x))
                            m_Ship.Position.X -= 3 * (float)gameTime.ElapsedGameTime.TotalSeconds * 150;
                    }
                    else if (Right && m_Ship.Position.X <= 250)
                    {
                        //int x = (int)Math.Floor(3 * -(m_Ship.Position.Y) / 10 + 45);
                        //if (m_Ship.Position.X < (160 + x))
                        int x = (int)Math.Floor((-m_Ship.Position.Y + 150) / 3);
                        if (m_Ship.Position.X < (150 + x))
                            m_Ship.Position.X += 3 * (float)gameTime.ElapsedGameTime.TotalSeconds * 150;
                    }
                    else if (Up && m_Ship.Position.Y < 150)
                    {
                        m_Ship.Position.Y += 3 * (float)gameTime.ElapsedGameTime.TotalSeconds * 150;
                        int x = (int)Math.Floor((-m_Ship.Position.Y + 150) / 3);
                        if (m_Ship.Position.X > (150 + x))
                            m_Ship.Position.X -= 2 * (float)gameTime.ElapsedGameTime.TotalSeconds * 150;
                        else if (m_Ship.Position.X < -(150 + x))
                            m_Ship.Position.X += 2 * (float)gameTime.ElapsedGameTime.TotalSeconds * 150;
                    }
                    else if (Down && m_Ship.Position.Y > -150)
                    {
                        m_Ship.Position.Y -= 3 * (float)gameTime.ElapsedGameTime.TotalSeconds * 150;
                        int x = (int)Math.Floor((-m_Ship.Position.Y + 150) / 3);
                        if (m_Ship.Position.X < (150 + x) && m_Ship.Position.X >= 150)
                            m_Ship.Position.X += 2 * (float)gameTime.ElapsedGameTime.TotalSeconds * 150;
                        else if (m_Ship.Position.X > -(150 + x) && m_Ship.Position.X <= -150)
                            m_Ship.Position.X -= 2 * (float)gameTime.ElapsedGameTime.TotalSeconds * 150;
                    } 
                }

                if (gameState == GameState.FreeRanged)   //For Freerange gameplay portion of the game
                {
                    //Movements//
                    if (Up)
                    {
                        //m_Ship.Velocity += Vector3.Multiply(m_Ship.worldMatrix.Forward, 2.0f) * (float)gameTime.ElapsedGameTime.TotalSeconds * 5;
                        followme.Velocity += Vector3.Multiply(followme.worldMatrix.Forward, 2.0f) * (float)gameTime.ElapsedGameTime.TotalSeconds * 2;
                    }
                    else if (Down)
                    {
                        //m_Ship.Velocity += Vector3.Multiply(m_Ship.worldMatrix.Backward, 2.0f) * (float)gameTime.ElapsedGameTime.TotalSeconds * 5;
                        followme.Velocity -= Vector3.Multiply(followme.worldMatrix.Forward, 2.0f) * (float)gameTime.ElapsedGameTime.TotalSeconds * 2;
                    }
                    else
                    {
                        //m_Ship.Force = Vector3.Zero;
                        followme.Force = Vector3.Zero;
                        //m_Ship.Velocity -= m_Ship.Velocity / 1500 * (float)gameTime.ElapsedGameTime.TotalSeconds;
                        followme.Velocity -= followme.Velocity / 1500 * (float)gameTime.ElapsedGameTime.TotalSeconds;
                    }
                    //Rotation//
                    if (Left)
                        followme.RotationAngle = MathHelper.PiOver2 * (float)gameTime.ElapsedGameTime.TotalSeconds * 400;
                    else if (Right)
                        followme.RotationAngle = -MathHelper.PiOver2 * (float)gameTime.ElapsedGameTime.TotalSeconds * 400;
                    else
                        followme.RotationAngle = 0.0f;

                }

                    //Firing//
                if (Fire && !m_Ship.destroyed)
                {
                    m_Ship.ShipFire();
                }
                if (Charging && !m_Ship.destroyed)
                {
                    m_Ship.ChargeLazor();
                }
                else if (!Charging)
                    m_Ship.UnchargeLazor();

                if (Bomb && !m_Ship.destroyed)
                {
                    m_Ship.ShootBomb();
                }
                if (barrelRoll && !m_Ship.destroyed)
                        m_Ship.BarrelRoll();
                #endregion PlayerInput
            }
        }


        /// <summary>
        /// Draws the gameplay screen.
        /// </summary>
        public override void Draw(GameTime gameTime)
        {


            // This game has a blue background. Why? Because!
            ScreenManager.GraphicsDevice.Clear(ClearOptions.Target,
                                               Color.Black, 0, 0);

            // Our player and enemy are both actually just text strings.
            SpriteBatch spriteBatch = ScreenManager.SpriteBatch;

            spriteBatch.Begin();

            //Draw the gameOver message//
            //spriteBatch.DrawString(gameFont, "// TODO", playerPosition, Color.Green);

            //spriteBatch.DrawString(gameFont, "Insert Gameplay Here",
            //                       enemyPosition, Color.DarkRed);

			//spriteBatch.DrawString(gameFont, MakeTimerDebugString("Timer 1"), new Vector2(20.0f, 500.0f), Color.Blue);
			//spriteBatch.DrawString(gameFont, MakeTimerDebugString("Timer 2"), new Vector2(20.0f, 550.0f), Color.White);
			//spriteBatch.DrawString(gameFont, MakeTimerDebugString("Timer 3"), new Vector2(20.0f, 600.0f), Color.White);
			//spriteBatch.DrawString(gameFont, MakeTimerDebugString("Timer 4"), new Vector2(20.0f, 650.0f), Color.Blue);
			//spriteBatch.DrawString(gameFont, MakeTimerDebugString("Timer 5"), new Vector2(20.0f, 700.0f), Color.White);

            spriteBatch.End();

            // If the game is transitioning on or off, fade it out to black.
            if (TransitionPosition > 0)
                ScreenManager.FadeBackBufferToBlack(255 - TransitionAlpha);
        }

        #endregion

		#region Timer Test Functions
		void TimerOneShot()
		{
			Console.WriteLine("TimerOneShot fired!");
		}

		void TimerLoop()
		{
			Console.WriteLine("TimerLoop fired!");
		}

		void TimerLoopRemove()
		{
			Console.WriteLine("TimerLoopRemove fired!");
			m_kTimer.RemoveTimer("Timer 3");
		}

		string MakeTimerDebugString(string sTimerName)
		{
			if (m_kTimer.GetTriggerCount(sTimerName) != -1)
				return sTimerName + " - Time: " + m_kTimer.GetRemainingTime(sTimerName).ToString("f3")
					+ " Count: " + m_kTimer.GetTriggerCount(sTimerName);
			else
				return sTimerName + " not found! ";
		}
		#endregion

        void makeArch(Arch_Side left, Arch_Side right, Arch_Lintel top) {

            archSideList.Add(left);
            archSideList.Add(right);
            archLintelList.Add(top);

            ScreenManager.Game.Components.Add(left);
            ScreenManager.Game.Components.Add(right);
            ScreenManager.Game.Components.Add(top);

        }

        void makeLevel(){
            //AREA1//////////////////////////////////////////////////////////////////////////////////
            //Add Ocean!!
            for (int i = 0; i < 1; i++)
            {
                oceanList.Add(new Ocean(ScreenManager.Game, new Vector3(0, -400, Area1)));
                ScreenManager.Game.Components.Add(oceanList[i]);
            }



            //AREA2//////////////////////////////////////////////////////////////////////////////////
            //Add Grass!!//
            ScreenManager.Game.Components.Add(new Grass(ScreenManager.Game, new Vector3(0, -390, Area2)));

            //Add Cliffs!!//
            int cliffZ = Area2 + 4000;
            for (int i = 0; i < 12; i += 2)
            {
                cliffList.Add(new Cliff(ScreenManager.Game, new Vector3(500, -400, cliffZ), true));
                ScreenManager.Game.Components.Add(cliffList[i]);
                cliffList.Add(new Cliff(ScreenManager.Game, new Vector3(-500, -400, cliffZ), false));
                ScreenManager.Game.Components.Add(cliffList[i + 1]);

                cliffZ -= 1850;
            }


            //AREA3///////////////////////////////////////////////////////////////////////////////////////////////////
            //Add Grass
            ScreenManager.Game.Components.Add(new Grass(ScreenManager.Game, new Vector3(0, -390, Area3)));

            //Add Buildings!!//
            buildingList.Add(new Building(ScreenManager.Game, new Vector3(200, -390, Area3 + 7000)));
            buildingList.Add(new Building(ScreenManager.Game, new Vector3(-300, -390, Area3 + 3500)));           
            buildingList.Add(new Building(ScreenManager.Game, new Vector3(-700, -390, Area3)));
            buildingList.Add(new Building(ScreenManager.Game, new Vector3(500, -390, Area3 - 3500)));
            buildingList.Add(new Building(ScreenManager.Game, new Vector3(-200, -390, Area3 - 7000)));



            //Add obstacles inside the tunnel in Area5 or so...
            buildingList.Add(new Building(ScreenManager.Game, new Vector3(200, -390, Area4 - 2000)));
            buildingList.Add(new Building(ScreenManager.Game, new Vector3(-300, -390, Area4 - 10000)));

            Arch_Lintel first = new Arch_Lintel(ScreenManager.Game, new Vector3(0, 0, Area4 - 6000));
            archLintelList.Add(first);
            ScreenManager.Game.Components.Add(first);

            Arch_Lintel second = new Arch_Lintel(ScreenManager.Game, new Vector3(0, -200, Area4 - 6000));
            archLintelList.Add(second);
            ScreenManager.Game.Components.Add(second);

            buildingList.Add(new Building(ScreenManager.Game, new Vector3(200, -390, Area4 - 12000)));

            Arch_Lintel third = new Arch_Lintel(ScreenManager.Game, new Vector3(0, -350, Area4 - 12000));
            archLintelList.Add(third);
            ScreenManager.Game.Components.Add(third);

            Arch_Lintel fourth = new Arch_Lintel(ScreenManager.Game, new Vector3(0, -550, Area4 - 12000));
            archLintelList.Add(fourth);
            ScreenManager.Game.Components.Add(fourth);



            Arch_Lintel fifth = new Arch_Lintel(ScreenManager.Game, new Vector3(0, -500, Area4 - 16000));
            archLintelList.Add(fifth);
            ScreenManager.Game.Components.Add(fifth);

            Arch_Lintel sixth = new Arch_Lintel(ScreenManager.Game, new Vector3(0, -700, Area4 - 16000));
            archLintelList.Add(sixth);
            ScreenManager.Game.Components.Add(sixth);

            Arch_Lintel seventh = new Arch_Lintel(ScreenManager.Game, new Vector3(0, 50, Area4 - 16000));
            archLintelList.Add(seventh);
            ScreenManager.Game.Components.Add(seventh);

            Arch_Lintel eighth = new Arch_Lintel(ScreenManager.Game, new Vector3(0, -150, Area4 - 16000));
            archLintelList.Add(eighth);
            ScreenManager.Game.Components.Add(eighth);

            buildingList.Add(new Building(ScreenManager.Game, new Vector3(375, -390, Area4 + 200 - 16000)));
            buildingList.Add(new Building(ScreenManager.Game, new Vector3(-375, -390, Area4 + 200 - 16000)));




            


            for (int i = 0; i < buildingList.Count; i++)
            {
                ScreenManager.Game.Components.Add(buildingList[i]);
            }

            //Add Arches!!//
            int ArchCenter = 0;
            int ArchZDisplacement = 5500;
            Arch_Side left = new Arch_Side(ScreenManager.Game, new Vector3(ArchCenter + 400, -590, Area3));
            Arch_Side right = new Arch_Side(ScreenManager.Game, new Vector3(ArchCenter - 400, -590, Area3));
            Arch_Lintel top = new Arch_Lintel(ScreenManager.Game, new Vector3(ArchCenter, -200, Area3));
            makeArch(left, right, top);

            ArchCenter = 500;
            ArchZDisplacement = 3500;
            left = new Arch_Side(ScreenManager.Game, new Vector3(ArchCenter + 400, -890, Area3 + ArchZDisplacement));
            right = new Arch_Side(ScreenManager.Game, new Vector3(ArchCenter - 400, -890, Area3 + ArchZDisplacement));
            top = new Arch_Lintel(ScreenManager.Game, new Vector3(ArchCenter, -500, Area3 + ArchZDisplacement));
            makeArch(left, right, top);

            ArchCenter = -500;
            ArchZDisplacement = -3500;
            left = new Arch_Side(ScreenManager.Game, new Vector3(ArchCenter + 400, -890, Area3 + ArchZDisplacement));
            right = new Arch_Side(ScreenManager.Game, new Vector3(ArchCenter - 400, -890, Area3 + ArchZDisplacement));
            top = new Arch_Lintel(ScreenManager.Game, new Vector3(ArchCenter, -500, Area3 + ArchZDisplacement));
            makeArch(left, right, top);


            //AREA4///////////////////////////////////////////////////////////////////////////////////////////////////
            //Add Grass
            ScreenManager.Game.Components.Add(new Grass(ScreenManager.Game, new Vector3(0, -390, Area4)));


            //AREA5///////////////////////////////////////////////////////////////////////////////////////////////////
            //Add ominous wall...
            Wall temp;

            temp = new Wall(ScreenManager.Game, new Vector3(3500, -4000, Area4 - 9500));
            ScreenManager.Game.Components.Add(temp);
            wallList.Add(temp);

            temp = new Wall(ScreenManager.Game, new Vector3(-3500, -4000, Area4 - 9500));
            ScreenManager.Game.Components.Add(temp);
            wallList.Add(temp);

            temp = new Wall (ScreenManager.Game, new Vector3(0, 700, Area4 - 10000));
            ScreenManager.Game.Components.Add(temp);
            wallList.Add(temp);

            temp = new Wall(ScreenManager.Game, new Vector3(0, -6500, Area4 - 10000));
            ScreenManager.Game.Components.Add(temp);
            wallList.Add(temp);

            Wall aestheticWall = new Wall(ScreenManager.Game, new Vector3(0, 7800, Area4 - 10000));
            aestheticWall.uniformScale = 500;
            ScreenManager.Game.Components.Add(aestheticWall);




            //Add Skybox!!//
            ScreenManager.Game.Components.Add(new Skybox(ScreenManager.Game));

        }

        private void VictoryPose()
        {
            m_Ship.Velocity *= 2;
        }

        private void Exit()
        {
            cue.Stop(AudioStopOptions.AsAuthored);
            GameplayScreen.gameState = GameplayScreen.GameState.Exit;
            ScreenManager.AddScreen(new BackgroundScreen());
            ScreenManager.AddScreen(new MainMenuScreen());
        } 
	}
}
