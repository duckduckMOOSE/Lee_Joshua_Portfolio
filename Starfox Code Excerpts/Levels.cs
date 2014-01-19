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
    public class Levels : Microsoft.Xna.Framework.DrawableGameComponent
    {
        protected Model ActorModel;
        public Matrix worldMatrix;
        public string sMeshName;
        protected Utils.Timer timer;
        protected Matrix[] actorBones;

        //Transformation properties//
        public float uniformScale;
        public Vector3 Position;
        public Quaternion Rotation;
        public float RotationAngle;
        private Matrix AllTransform;

        //Movement//
        public Vector3 Velocity;
        public Vector3 RotationAxis;

        //Basic Properties//
        public float Mass;
        public float TerminalVelocity;
        public Vector3 Force;
        public Vector3 Acceleration;
        public Vector3 Drag;
        public bool bPhysicsDriven;

        //Collisions//
        public BoundingBox WorldBound;

        
        private Random rand = new Random();
        public Levels(Game game)
            : base(game)
        {
            // TODO: Construct any child components here
            worldMatrix = Matrix.Identity;
            sMeshName = "Levels";
            timer = new Utils.Timer();

            uniformScale = 1.0f;
            Position = Vector3.Zero;
            Rotation = Quaternion.Identity;

            Velocity = Vector3.Zero;
            RotationAxis = Vector3.Zero;

            //Initialize basic Physics Properties//
            Mass = 1.0f;
            TerminalVelocity = 1.0f;
            Force = Vector3.Zero;
            Acceleration = Vector3.Zero;
            Drag = Vector3.One;
            Drag.Z = 0;
            bPhysicsDriven = false;
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
        protected override void LoadContent()
        {
            sMeshName = "Models/" + sMeshName;
            ActorModel = Game.Content.Load<Model>(sMeshName);
            actorBones = new Matrix[ActorModel.Bones.Count];

          

            base.LoadContent();
        }

        protected override void UnloadContent()
        {
            base.UnloadContent();
        }

        public override void Draw(GameTime gameTime)
        {
            GraphicsDevice.DepthStencilState = DepthStencilState.Default;
            ActorModel.CopyAbsoluteBoneTransformsTo(actorBones);
            foreach (ModelMesh mesh in ActorModel.Meshes)
            {
                foreach (BasicEffect effect in mesh.Effects)
                {
                    effect.World = actorBones[mesh.ParentBone.Index] * worldMatrix;
                    effect.View = GameplayScreen.Camera1.LookAtMatrix;
                    effect.Projection = GameplayScreen.ProjectionMatrix;
                    effect.EnableDefaultLighting();
                    effect.PreferPerPixelLighting = true;
                    effect.AmbientLightColor = new Vector3(0.5f, 0.5f, 0.1f);
                    effect.SpecularColor = GameplayScreen.ColorLerp;//new Vector3(0.5f, 0.5f, 0.1f);
                    //effect.SpecularPower = 0.1f;
                    effect.DirectionalLight0.Direction = GameplayScreen.DirectionalLightPos;//new Vector3(0.0f, 0.0f, -0.1f);
                    //effect.DirectionalLight0.DiffuseColor = new Vector3(0.5f, 0.5f, 0.5f);
                }
                mesh.Draw();
            }
            base.Draw(gameTime);
        }

        public Vector3 GetWorldFacing()
        {
            return worldMatrix.Forward;
        }

        public Vector3 GetWorldPosition()
        {
            return worldMatrix.Translation;
        }
        /// </summary>
        /// <param name="gameTime">Provides a snapshot of timing values.</param>
        /// 




        public override void Update(GameTime gameTime)
        {
            // TODO: Add your update code here
            if (GameplayScreen.gameState == GameplayScreen.GameState.Exit)
            {
                UnloadContent();
                Game.Components.Remove(this);
                return;
            }

            base.Update(gameTime);
            timer.Update(gameTime);

            float fDeltaTime = (float)gameTime.ElapsedGameTime.TotalSeconds;

            #region Physics Driven Calculation
            if (bPhysicsDriven)
            {
                Velocity += Acceleration * fDeltaTime / 2.0f;
                Position += Velocity * fDeltaTime * 100;
                Acceleration = Force / Mass;
                Velocity += Acceleration * fDeltaTime / 2.0f;

                //Diminishing Velocity due to "friction"
                //Velocity -= Drag * fDeltaTime;

                //Setting Max Velocity//
                if (Velocity.LengthSquared() > (TerminalVelocity * TerminalVelocity))
                {
                    Velocity.Normalize();
                    Velocity = Vector3.Multiply(Velocity, TerminalVelocity);
                }

                //Setting Min Velocity//
                if (Velocity.LengthSquared() < 0.0f)
                    Velocity = Vector3.Zero;
            }
            #endregion
            #region Non-Physics Speed Calculation
            else
            {
                //Velocity Update:

                Position += Vector3.Multiply(Velocity, (float)gameTime.ElapsedGameTime.TotalSeconds) * 100;
            }
            #endregion
      



            //Rotation//
            Rotation *= Quaternion.CreateFromAxisAngle(RotationAxis, (float)(RotationAngle * gameTime.ElapsedGameTime.TotalSeconds));

            //Final Transformation Matrix//
            AllTransform = Matrix.CreateScale(uniformScale) * Matrix.CreateFromQuaternion(Rotation) * Matrix.CreateTranslation(Position);
            worldMatrix = Matrix.Identity * AllTransform;

            //WrapAround();
        }
        protected virtual void CheckCollision() { ;}
    }
}
