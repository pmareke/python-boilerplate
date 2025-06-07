class DayOne:
    _POINTS = {"A": 0, "B": 1, "C": 3}

    def __init__(self, filename: str) -> None:
        self.filename = filename

    def solve(self) -> int:
        with open(self.filename) as file:
            lines = file.readlines()
            lines = list(map(lambda x: x.strip(), lines))

        return sum([self._POINTS[item] for item in lines[0]])
