import unittest
import requests
import sys
import os
from .context import main
import uvicorn

class TestIntegrationAPI(unittest.TestCase):
    def setUpClass():
        # exec command
        print("Starting server")
        os.system("uvicorn server.main:app --reload &")
        # wait until stdout contains Uvicorn running on http://127.0.0.1:8000
        print("Waiting for server to start")
        while True:
            if "Uvicorn running on http://


    def test_api_responds(self):
        response = requests.get('http://localhost:8000')
        self.assertEqual(response.status_code, 200)

