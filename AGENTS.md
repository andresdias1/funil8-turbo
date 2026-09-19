# Funil 8 Turbo no OpenAI Codex

## Ativacao e fonte de verdade

Este repositorio e a distribuicao standalone do Funil 8 Turbo. Quando o usuario
pedir para usar, iniciar, construir, operar, diagnosticar ou otimizar o Funil 8:

1. Leia integralmente `agents/funil8-turbo.md`. Esse arquivo continua sendo a
   fonte de verdade da persona, comandos, gates, criterios e workflows.
2. Trate a invocacao como a ativacao do agente principal descrito naquele
   arquivo. Se a solicitacao ja contiver uma tarefa, pule o greeting, conforme a
   propria regra do agente.
3. Carregue as skills necessarias na ordem definida abaixo. Nunca troque a ordem
   metodologica por conveniencia de implementacao.
4. Siga todos os gates de seguranca do agente, em especial: campanhas nascem
   `PAUSED`, ativacao requer decisao humana separada e segredos nunca entram no
   repositorio.

As copias originais em `CLAUDE.md`, `agents/`, `skills/`, scripts, referencias e
templates sao imutaveis durante a adaptacao Codex. A camada nativa vive em
`.agents/skills/` e aponta para as 12 skills originais, sem duplica-las.

## Ordem de orquestracao

O agente principal deve coordenar as skills, e nao substituir seus workflows.
Use esta ordem operacional (carregando apenas as etapas pertinentes a tarefa):

1. `protocolo-conversa-turbo` — sempre primeiro; protocolo transversal.
2. `funil-8-turbo` — nucleo e regras completas do metodo.
3. `criador-paginas-low-ticket-turbo` — copy de pagina, quando aplicavel.
4. `criador-vsl-turbo` — VSL, quando aplicavel.
5. `criador-criativos-turbo` — copy e estrutura dos anuncios.
6. `criativos-lpsg-turbo` — formatos e producao da batelada.
7. `meta-ads-cli-setup-turbo` — setup seguro antes da operacao de Meta Ads.
8. `meta-ads-cli-turbo` — operacao avancada somente depois do setup/gates.
9. `designer-senior-turbo` — implementacao da pagina.
10. `design-tokens-turbo` — sistema visual.
11. `lovable-style-turbo` — build React, se esse for o stack escolhido.
12. `page-optimizer-turbo` — performance e validacao ao final do build.

Para um comando pontual (`*produto`, `*escadinha`, `*pagina`, `*vsl`,
`*criativos`, `*subir-campanha`, `*otimizar` ou `*diagnostico`), consulte o
roteamento e o workflow correspondentes em `agents/funil8-turbo.md`; nao execute
automaticamente as doze etapas quando elas nao forem necessarias.

## Adaptacao de caminhos e ferramentas

- Resolva `references/`, `scripts/`, `template/`, `recipes/` e demais caminhos
  relativos a partir do diretorio real da skill em `skills/<nome>/`.
- Uma mencao a `~/.claude/skills/<nome>` significa, no Codex deste repositorio,
  `skills/<nome>` (ou o link equivalente `.agents/skills/<nome>`).
- Uma mencao a um agente Claude (`@agente` ou subagente) significa que o agente
  principal deve executar o mesmo papel/workflow com as skills disponiveis. Nao
  finja que houve delegacao nem que uma ferramenta inexistente foi chamada.
- Use ferramentas nativas disponiveis no Codex para shell, edicao, browser e
  imagens, mantendo os gates e a sequencia do metodo.
- Nao instale nem invente `deploy-to-vercel`, `webapp-testing`, Meta Ads CLI,
  credenciais, plugins ou qualquer dependencia ausente. Quando uma etapa
  depender delas, informe a limitacao e ofereca apenas o fallback manual seguro
  descrito pelas skills.
- Antes de comandos externos ou operacoes de anuncios, confirme pre-requisitos e
  autenticacao. Nunca grave tokens, IDs privados ou `.env` no repositorio.

## Validacao da camada Codex

Depois de alterar esta camada, execute:

```bash
bash codex/validate-codex-layer.sh
```

O comando valida as 12 entradas descobertas, a ordem declarada pelo agente, os
alvos da camada nativa e os hashes dos arquivos que existiam antes da migracao.
