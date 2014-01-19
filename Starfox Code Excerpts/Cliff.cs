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
    public class Cliff : Levels
    {
        public static Vector3 ObjectPosition;
        public static Matrix ObjectWorldMatrix;

        public Cliff(Game game, Vector3 p, Boolean isRightSide)
            : base(game)
        {
            sMeshName = "Cliff";
            if (isRightSide) {
                Rotation = Quaternion.CreateFromAxisAngle(Vector3.UnitY, MathHelper.Pi);
            }

            Position = p; //new Vector3(0,-300,-5000);
            ObjectWorldMatrix = Matrix.Identity;
        }

        public override void Initialize()
        {
            base.Initialize();
        }

        public override void Update(GameTime gameTime)
        {
            // TODO: Add your update code here
            CheckCollision();
            base.Update(gameTime);
        }

        protected override void CheckCollision()
        {
        }
    }
}
