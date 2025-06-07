import pytest
from expects import equal, expect

from src.twenty_four.day_one import DayOne


class TestDay01:
    @pytest.mark.parametrize(
        "filename, expected",
        [
            ("inputs/2024/01.example", 5),
            ("inputs/2024/01.in", 1289),
        ],
    )
    def test_solve_problem(self, filename: str, expected: int) -> None:
        day_one = DayOne(filename)

        result = day_one.solve()

        expect(result).to(equal(expected))
