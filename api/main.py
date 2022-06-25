import json
import math

from fastapi import FastAPI

app = FastAPI()

def get_json(path: str):
    with open(path) as data_json:
        data = json.load(data_json)
    return data


@app.get("/")
def read_root():
    return {"status": "working"}


@app.get("/catalog")
async def get_carts(page: int = 1):
    carts = get_json("./catalog.json")
    items = carts[(page - 1) * 20 : page * 20]
    total_pages = math.ceil(len(carts) / 20)
    return {"items": items, "page": page, "total_pages": total_pages}



