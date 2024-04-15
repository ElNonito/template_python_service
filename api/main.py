import fastapi
import os
import sys
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '..')))

from core import core


app = fastapi.FastAPI()


@app.get("/")
def read_root():
   return core.some_dummy_function()

