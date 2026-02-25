# paste2item / paste2text

## Prereqs
- `jq`
- `curl`
- `OPENAI_API_KEY` exported in your shell

## Usage
- Most common (uses pbpaste if no stdin):
  - `paste2item`
  - `pbpaste | paste2item`

- Print raw ICS/VCF:
  - `pbpaste | paste2text > out.ics` (or `.vcf`)
