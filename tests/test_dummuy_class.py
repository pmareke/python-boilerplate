from expects import equal, expect
from src.dummy_class import Dummy


class TestDummy:
    def test_dummy(self) -> None:
        dummy = Dummy()

        result = dummy.add(1, 2)

        expect(result).to(equal(3))
