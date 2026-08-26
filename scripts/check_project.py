#!/usr/bin/env python3
"""Fast, cloud-free checks for the Scholar Track repository."""

from __future__ import annotations

import csv
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "data/raw/StudentPerformanceFactors.csv"
FLOW = ROOT / "flows/kestra/08_student_performance_etl.yaml"

EXPECTED_COLUMNS = [
    "Hours_Studied",
    "Attendance",
    "Parental_Involvement",
    "Access_to_Resources",
    "Extracurricular_Activities",
    "Sleep_Hours",
    "Previous_Scores",
    "Motivation_Level",
    "Internet_Access",
    "Tutoring_Sessions",
    "Family_Income",
    "Teacher_Quality",
    "School_Type",
    "Peer_Influence",
    "Physical_Activity",
    "Learning_Disabilities",
    "Parental_Education_Level",
    "Distance_from_Home",
    "Gender",
    "Exam_Score",
]


def require(condition: bool, message: str) -> None:
    if not condition:
        raise SystemExit(f"FAIL: {message}")


def main() -> None:
    required_files = [
        ROOT / ".env.example",
        ROOT / "docker-compose.yml",
        ROOT / "infrastructure/terraform/main.tf",
        ROOT / "infrastructure/terraform/variables.tf",
        ROOT / "infrastructure/terraform/outputs.tf",
        ROOT / "infrastructure/terraform/terraform.tfvars.example",
        FLOW,
        SOURCE,
    ]
    for path in required_files:
        require(path.is_file(), f"missing required file: {path.relative_to(ROOT)}")

    with SOURCE.open(newline="", encoding="utf-8-sig") as source_file:
        reader = csv.reader(source_file)
        header = next(reader)
        row_count = sum(1 for _ in reader)

    require(header == EXPECTED_COLUMNS, "source CSV schema has changed")
    require(row_count == 6607, f"expected 6607 source rows, found {row_count}")

    flow_text = FLOW.read_text(encoding="utf-8")
    require(
        "data/raw/StudentPerformanceFactors.csv" in flow_text,
        "Kestra flow does not reference the committed source CSV path",
    )
    require("LoadFromGcs" in flow_text, "Kestra flow is missing the BigQuery load")
    require("verify_output" in flow_text, "Kestra flow is missing output checks")

    compose_text = (ROOT / "docker-compose.yml").read_text(encoding="utf-8")
    require(":latest" not in compose_text, "Docker Compose contains an unpinned latest tag")

    left_marker = "<" * 7
    middle_marker = "=" * 7
    right_marker = ">" * 7
    text_suffixes = {".md", ".py", ".sql", ".tf", ".yaml", ".yml"}
    for path in ROOT.rglob("*"):
        if ".git" in path.parts or not path.is_file() or path.suffix not in text_suffixes:
            continue
        text = path.read_text(encoding="utf-8", errors="replace")
        has_conflict = any(
            line.startswith(left_marker)
            or line == middle_marker
            or line.startswith(right_marker)
            for line in text.splitlines()
        )
        require(not has_conflict, f"unresolved merge conflict in {path.relative_to(ROOT)}")

    print(f"PASS: source schema and {row_count} rows")
    print("PASS: reproducibility files are present")
    print("PASS: Kestra flow includes GCS, BigQuery, and output checks")
    print("PASS: no unresolved merge markers or latest Docker tags")


if __name__ == "__main__":
    main()
