#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

expected=(
  protocolo-conversa-turbo
  funil-8-turbo
  criador-paginas-low-ticket-turbo
  criador-vsl-turbo
  criador-criativos-turbo
  criativos-lpsg-turbo
  meta-ads-cli-setup-turbo
  meta-ads-cli-turbo
  designer-senior-turbo
  design-tokens-turbo
  lovable-style-turbo
  page-optimizer-turbo
)

fail() { printf 'ERRO: %s\n' "$*" >&2; exit 1; }

mapfile -t discovered < <(find .agents/skills -mindepth 1 -maxdepth 1 -type l -printf '%f\n' | sort)
mapfile -t expected_sorted < <(printf '%s\n' "${expected[@]}" | sort)
[[ "${#discovered[@]}" -eq 12 ]] || fail "esperadas 12 skills Codex; encontradas ${#discovered[@]}"
[[ "$(printf '%s\n' "${discovered[@]}")" == "$(printf '%s\n' "${expected_sorted[@]}")" ]] || fail "inventario de skills Codex diverge"

for skill in "${expected[@]}"; do
  link=".agents/skills/$skill"
  [[ -L "$link" ]] || fail "$link nao e um link simbolico"
  [[ "$(readlink "$link")" == "../../skills/$skill" ]] || fail "$link aponta para destino inesperado"
  [[ -f "$link/SKILL.md" ]] || fail "$link/SKILL.md nao pode ser descoberto"
  grep -q "^name: $skill$" "$link/SKILL.md" || fail "frontmatter invalido em $link/SKILL.md"
done

mapfile -t orchestrated < <(sed -n '/^skills:/,/^---$/s/^  - \([^ #][^ ]*\)$/\1/p' agents/funil8-turbo.md | head -n 12)
[[ "$(printf '%s\n' "${orchestrated[@]}")" == "$(printf '%s\n' "${expected[@]}")" ]] || fail "ordem das 12 skills diverge do agente principal"

sha256sum --check --quiet codex/original-files.sha256 || fail "um ou mais arquivos originais foram alterados"

printf 'OK: 12/12 skills descobertas em .agents/skills.\n'
printf 'OK: ordem de orquestracao coincide com agents/funil8-turbo.md.\n'
printf 'OK: todos os arquivos originais conferem com o manifesto SHA-256.\n'
