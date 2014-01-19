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
    public class Wall : Levels
    {
        public static Vector3 ObjectPosition;
        public static Matrix ObjectWorldMatrix;

        public Wall(Game game, Vector3 p)
            : base(game)
        {
            sMeshName = "Wall";
            Position = p; // new Vector3(0, -300, 0);
            ObjectWorldMatrix = Matrix.Identity;
            uniformScale = 1000;
            WorldBound = new BoundingBox(new Vector3(Position.X - 0, Position.Y - 0, Position.Z - 10500), new Vector3(Position.X + 0, Position.Y + 6300, Position.Z + 10500));
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
