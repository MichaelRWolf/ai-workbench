# paste2item tests (bats)
# Run: bats tests/bin/paste2item.bats
# Requires: bats, jq. helper/curl and helper/open override PATH so no network or GUI.

SCRIPT_DIR="$(cd "$(dirname "${BATS_TEST_FILENAME}")/../.." && pwd)"
BIN="$(dirname "${BATS_TEST_FILENAME}")/../../bin"
HELPER="$(dirname "${BATS_TEST_FILENAME}")/helper"
PATH="${HELPER}:${PATH}"

setup() {
  export OPENAI_API_KEY="${OPENAI_API_KEY:-test-key}"
}

# --- Empty / whitespace input (exit 2) ---

@test "empty stdin exits 2 and prints empty input message" {
  run sh -c "printf '' | \"${BIN}/paste2item\""
  [ "$status" -eq 2 ]
  [[ "$output" == *"paste2item: empty input"* ]]
}

@test "whitespace-only stdin exits 2" {
  run sh -c "printf '   \n\t  ' | \"${BIN}/paste2item\""
  [ "$status" -eq 2 ]
  [[ "$output" == *"paste2item: empty input"* ]]
}

# --- API response handling (mocked curl) ---

@test "ICS response produces .ics file path" {
  export MOCK_CURL_RESPONSE=ics
  run sh -c "printf 'Meeting tomorrow 2pm' | \"${BIN}/paste2item\""
  [ "$status" -eq 0 ]
  [[ "$output" == *.ics ]]
  [ -f "$output" ]
  grep -q 'BEGIN:VCALENDAR' "$output"
  grep -q 'END:VCALENDAR' "$output"
}

@test "VCF response produces .vcf file path" {
  export MOCK_CURL_RESPONSE=vcf
  run sh -c "printf 'John Doe, john@example.com' | \"${BIN}/paste2item\""
  [ "$status" -eq 0 ]
  [[ "$output" == *.vcf ]]
  [ -f "$output" ]
  grep -q 'BEGIN:VCARD' "$output"
  grep -q 'END:VCARD' "$output"
}

@test "invalid model output exits 1 and prints diagnostic" {
  export MOCK_CURL_RESPONSE=invalid
  run sh -c "printf 'some input' | \"${BIN}/paste2item\""
  [ "$status" -eq 1 ]
  [[ "$output" == *"paste2item: model output did not look like ICS/VCF"* ]]
}
