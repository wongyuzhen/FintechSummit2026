from fastapi import APIRouter, Request
from database.database import find_one_collection, add_to_collection, update_to_collection, delete_from_collection
from misc.misc import read_json, format_error_msg, format_success_msg
import hashlib
import random
import string
import asyncio

router = APIRouter()

@router.post("/createDate")
async def createDateRequest(request: Request):
    dummy, error = await read_json(request, ["dummy"])
    if error:
        return format_error_msg(error)
    return createDate(dummy)

def createDate(dummy):
    date_jsn =  {
                "dummy": dummy,
                }
    date = add_to_collection(date_jsn, "dates")
    return format_success_msg({"access": True})

print(createDate("test"))