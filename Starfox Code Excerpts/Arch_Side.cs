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
    public class Arch_Side : Levels
    {
        public static Vector3 ObjectPosition;
        public static Matrix ObjectWorldMatrix;

        public Arch_Side(Game game, Vector3 p)
            : base(game)
        {
            sMeshName = "Arch_Side";
            uniformScale = 3;
            Position = p; //new Vector3(0,-300,-5000);
            ObjectWorldMatrix = Matrix.Identity;
            WorldBound = new BoundingBox(new Vector3(Position.X -100, Position.Y - 810, Position.Z - 100), new Vector3(Position.X + 100, Position.Y + 810, Position.Z + 100));
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
