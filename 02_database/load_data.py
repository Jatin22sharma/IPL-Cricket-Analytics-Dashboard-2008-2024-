import pandas as pd
from sqlalchemy import create_engine, text
import os
from dotenv import load_dotenv

load_dotenv()

# --- Connection details ---
MYSQL_USER     = "root"
MYSQL_PASSWORD = os.getenv("MYSQL_PASSWORD")
MYSQL_HOST     = "localhost"
MYSQL_DB       = "ipl_db"

# --- Create connection ---
from sqlalchemy import create_engine
from sqlalchemy.engine import URL

connection_url = URL.create(
    drivername="mysql+pymysql",
    username=MYSQL_USER,
    password=MYSQL_PASSWORD,
    host="127.0.0.1",
    port=3306,
    database=MYSQL_DB
)

engine = create_engine(connection_url)

# --- Load matches CSV ---
print("Loading matches.csv...")
matches = pd.read_csv("01_data/matches.csv")
print(f"Matches shape: {matches.shape}")
print(matches.columns.tolist())

# --- Clean column names (remove spaces) ---
matches.columns = matches.columns.str.strip().str.lower().str.replace(" ", "_")

# --- Load to MySQL ---
matches.to_sql(
    name="matches",
    con=engine,
    if_exists="replace",
    index=False,
    chunksize=500
)
print(f"✓ Loaded {len(matches)} matches into MySQL")

# --- Load deliveries CSV ---
print("\nLoading deliveries.csv... (this takes 1-2 minutes)")
deliveries = pd.read_csv("01_data/deliveries.csv")
print(f"Deliveries shape: {deliveries.shape}")

# --- Clean column names ---
deliveries.columns = deliveries.columns.str.strip().str.lower().str.replace(" ", "_")

# --- Load to MySQL ---
deliveries.to_sql(
    name="deliveries",
    con=engine,
    if_exists="replace",
    index=False,
    chunksize=1000
)
print(f"✓ Loaded {len(deliveries)} deliveries into MySQL")

# --- Verify both tables ---
with engine.connect() as conn:
    m = conn.execute(text("SELECT COUNT(*) FROM matches")).fetchone()[0]
    d = conn.execute(text("SELECT COUNT(*) FROM deliveries")).fetchone()[0]
    print(f"\n✓ Verification:")
    print(f"  matches table   : {m} rows")
    print(f"  deliveries table: {d} rows")
    print("\nDatabase ready!")