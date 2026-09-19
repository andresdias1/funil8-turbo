# Executando o Funil 8 Turbo no Codex Web

## Inicio rapido

Abra uma **nova tarefa do Codex Web** apontando para este repositorio e use
exatamente este prompt:

```text
Use o Funil 8 Turbo deste repositorio para estruturar meu funil de entrada. Leia o AGENTS.md e ative o agente principal descrito em agents/funil8-turbo.md. Minha tarefa e: <descreva aqui produto, publico, oferta e fase atual>.
```

Se quiser apenas abrir o agente e receber o menu, use:

```text
Ative o agente Funil 8 Turbo deste repositorio seguindo o AGENTS.md, sem executar uma etapa ainda.
```

O `AGENTS.md` e carregado como instrucao persistente do repositorio. As 12 skills
nativas sao expostas em `.agents/skills/`; cada entrada aponta para a skill
original em `skills/`, portanto metodologia, referencias, scripts e templates
continuam tendo uma unica fonte de verdade.

## Comandos diretos

Depois da ativacao, use `*produto`, `*escadinha`, `*pagina`, `*vsl`,
`*criativos`, `*subir-campanha`, `*otimizar` ou `*diagnostico`. O agente principal
faz o roteamento e carrega primeiro o protocolo transversal, preservando a ordem
documentada em `AGENTS.md`.

## Limites conhecidos

- `deploy-to-vercel` e `webapp-testing` sao skills externas opcionais e nao fazem
  parte deste repositorio. O Codex deve usar somente o fallback manual seguro e
  explicitar a ausencia, sem simular deploy ou teste.
- A Meta Ads CLI, suas credenciais e os acessos da conta nao sao fornecidos pelo
  repositorio. A operacao so pode ocorrer se o ambiente ja os disponibilizar e
  os gates da metodologia forem satisfeitos.
- Nomes de agentes ou mecanismos de delegacao especificos do Claude sao
  interpretados como papeis/workflows executados pelo agente principal do Codex;
  eles nao garantem a existencia de um subagente separado.
- Referencias a `~/.claude/...` nos originais permanecem intactas por requisito de
  preservacao. No Codex, elas sao resolvidas conforme o mapeamento em `AGENTS.md`.

## Verificacao local

```bash
bash codex/validate-codex-layer.sh
```

O validador falha se alguma das 12 skills deixar de estar exposta, se a ordem do
agente divergir, se um link apontar para fora da fonte original ou se qualquer
arquivo original mudar em relacao ao manifesto da migracao.
