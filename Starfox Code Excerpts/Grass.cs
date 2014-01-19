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
    public class Grass : Levels
    {
        public static Vector3 ObjectPosition;
        public static Matrix ObjectWorldMatrix;

        public Grass(Game game, Vector3 p)
            : base(game)
        {
            sMeshName = "Grass";
            Position = p;
            ObjectWorldMatrix = Matrix.Identity;
            uniformScale = 24f;
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
