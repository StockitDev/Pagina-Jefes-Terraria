require("dotenv").config();

const cors = require("cors");
const express = require("express");
const mysql = require("mysql2/promise");

const requiredVariables = ["DB_HOST", "DB_USER", "DB_NAME"];
const missingVariables = requiredVariables.filter((name) => !process.env[name]);

if (missingVariables.length) {
  console.error(`Faltan datos de conexión en backend/.env: ${missingVariables.join(", ")}`);
  process.exit(1);
}

const app = express();
const port = Number(process.env.PORT || 3000);
const allowedOrigins = (process.env.FRONTEND_ORIGINS || "")
  .split(",")
  .map((origin) => origin.trim())
  .filter(Boolean);

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  port: Number(process.env.DB_PORT || 3306),
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD || "",
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 5
});

app.use(cors({ origin: allowedOrigins }));

app.get("/api/data", async (request, response, next) => {
  try {
    const [bosses, attacks, minions, bags, items, segments] = await Promise.all([
      pool.query("SELECT ID_BOSS, Boss_Name, Life_Amount, Defense, ID_MINION, ID_ATTACK, Image_URL FROM Boss ORDER BY ID_BOSS"),
      pool.query("SELECT ID_ATTACK, Attack_Name, Type, Damage FROM Attack ORDER BY ID_ATTACK"),
      pool.query("SELECT ID_MINION, Minion_Name, Life_Amount, Defense, ID_ATTACK FROM Minion ORDER BY ID_MINION"),
      pool.query("SELECT ID_TREASUREBAG, Treasure_Bag_Name, ID_BOSS FROM Treasure_Bag ORDER BY ID_TREASUREBAG"),
      pool.query("SELECT ID_ITEM, Item_Name, Type, Amount, ID_TREASUREBAG FROM Item ORDER BY ID_ITEM"),
      pool.query("SELECT ID_SEGMENT, Segment_Name, Life_Amount, Defense, ID_BOSS FROM Segment ORDER BY ID_SEGMENT")
    ]);

    response.json({
      bosses: bosses[0],
      attacks: attacks[0],
      minions: minions[0],
      bags: bags[0],
      items: items[0],
      segments: segments[0]
    });
  } catch (error) {
    next(error);
  }
});

app.use((error, request, response, next) => {
  console.error("Error consultando MySQL:", error);
  response.status(500).json({ error: "No se pudieron leer los datos de MySQL." });
});

async function startServer() {
  try {
    await pool.query("SELECT 1");
    app.listen(port, "127.0.0.1", () => {
      console.log(`Servidor listo: http://localhost:${port}`);
      console.log("API del bestiario: http://localhost:3000/api/data");
    });
  } catch (error) {
    console.error("No se pudo conectar a MySQL. Revisa el servicio y backend/.env.", error);
    process.exitCode = 1;
    await pool.end();
  }
}

startServer();
