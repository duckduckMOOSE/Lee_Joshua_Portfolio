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
    public class Building : Levels
    {
        public static Vector3 ObjectPosition;
        public static Matrix ObjectWorldMatrix;

        public Building(Game game, Vector3 p)
            : base(game)
        {
            sMeshName = "Building";
            uniformScale = 3;
            Position = p; //new Vector3(0,-300,-5000);
            ObjectWorldMatrix = Matrix.Identity;
            WorldBound = new BoundingBox(new Vector3(Position.X - 210, Position.Y - 1000, Position.Z - 210), new Vector3(Position.X + 210, Position.Y + 1000, Position.Z + 210));
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
