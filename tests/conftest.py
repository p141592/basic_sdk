import os
from pathlib import Path

import pytest

BASEPATH = Path(os.path.dirname(os.path.realpath(__file__)))


@pytest.fixture
def first():
    return 1
