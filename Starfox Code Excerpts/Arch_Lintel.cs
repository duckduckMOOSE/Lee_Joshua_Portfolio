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
    public class Arch_Lintel : Levels
    {
        public static Vector3 ObjectPosition;
        public static Matrix ObjectWorldMatrix;

        public Arch_Lintel(Game game, Vector3 p)
            : base(game)
        {
            sMeshName = "Arch_Lintel";
            uniformScale = 3;
            Position = p;
            ObjectWorldMatrix = Matrix.Identity;
            Rotation = Quaternion.CreateFromAxisAngle(Vector3.UnitY, MathHelper.PiOver2);
            WorldBound = new BoundingBox(new Vector3(Position.X - 730, Position.Y + 320, Position.Z - 100), new Vector3(Position.X + 730, Position.Y + 420, Position.Z + 100));
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
