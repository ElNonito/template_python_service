import unittest

from .context import core

class TestCore(unittest.TestCase):
    def test_core(self):
        self.assertEqual(core.some_dummy_function(), 42)
