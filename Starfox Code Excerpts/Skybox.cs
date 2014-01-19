using System;
using System.Collections.Generic;
using System.Linq;
using Microsoft.Xna.Framework;
using Microsoft.Xna.Framework.Audio;
using Microsoft.Xna.Framework.Content;
using Microsoft.Xna.Framework.GamerServices;
using Microsoft.Xna.Framework.Graphics;
using Microsoft.Xna.Framework.Input;
using Microsoft.Xna.Framework.Media;


namespace GameStateManagement
{
    /// <summary>
    /// This is a game component that implements IUpdateable.
    /// </summary>
    public class Skybox : Actor
    {
        public static Vector3 FollowMePosition;
        public static Matrix FollowMeWorldMatrix;
        private EnemyManager enemyManager;
        const float forwardVelocity = -10.1f;

        public Skybox(Game game)
            : base(game)
        {
            sMeshName = "cube";
            RotationAxis = Vector3.UnitX;
            RotationAngle = 0.0f;
            //RotationAngle = 0.0f;
            TerminalVelocity = 5.0f;
            bPhysicsDriven = false;
            timer = new Utils.Timer();

            FollowMePosition = new Vector3(0, 0, 200);
            //vShipVelocity = Vector3.Zero;
            Velocity = new Vector3(0, 0, forwardVelocity);
            //Velocity = Vector3.Zero;
            FollowMeWorldMatrix = Matrix.Identity;

            uniformScale = 1000.0f;

            // TODO: Construct any child components here
        }

        /// <summary>
        /// Allows the game component to perform any initialization it needs to before starting
        /// to run.  This is where it can query for any required services and load content.
        /// </summary>
        public override void Initialize()
        {
            // TODO: Add your initialization code here
            base.Initialize();
        }

        /// <summary>
        /// Allows the game component to update itself.
        /// </summary>
        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        public override void Update(GameTime gameTime)
        {
            int flyAwayPosition = -66000;

            FollowMePosition = Position;
            FollowMeWorldMatrix = worldMatrix;
            if (Position.Z < flyAwayPosition && Position.Z > flyAwayPosition - 4500)
            {
                RotationAngle = -.5f;
            }
            else {
                RotationAngle = 0f;
            }
            
            base.Update(gameTime);
        }

        //Firing a missile//

        public void setEnemyManager(EnemyManager s)
        {
            enemyManager = s;
            enemyManager.setSkybox(this);
        }
    }
}
