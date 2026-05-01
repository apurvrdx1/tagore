# Tagore

![Tagore](assets/social-preview.png)

> *"The butterfly counts not months but moments, and has time enough."*
> — Rabindranath Tagore

A skill for Claude Code, OpenCode, GitHub Copilot CLI, OpenAI Codex CLI, Gemini CLI, and Goose. Run `/tagore` on the AI-drafted prose you just generated; it rewrites the text to sound human and scores how close it got. Named in homage to Rabindranath Tagore, whose prose carried what frontier models reach for and miss: a point of view, specificity over abstraction, and restraint over puffery.

[![Buy Me A Coffee](https://img.buymeacoffee.com/button-api/?text=Buy+me+a+coffee&emoji=&slug=apurvrdx&button_colour=FFDD00&font_colour=000000&font_family=Lato&outline_colour=000000&coffee_colour=ffffff)](https://www.buymeacoffee.com/apurvrdx)

## What it does

Tagore attacks slop in two directions at once:

- **Removes the tells.** 29 cataloged AI patterns get scrubbed: significance inflation, em dash overuse, vague attributions, AI vocabulary, rule of three, copula avoidance, and more.
- **Adds what's missing.** Point of view, stakes, specificity, restraint, varied rhythm, and trust in the reader.

The skill runs every rewrite through a six-stage pipeline ending in an 8-dimension scoring rubric (5 mechanics + 3 substance) with a 56/80 pass threshold and subtotal floors so a piece can't pass on mechanics alone.

## Why merge two skills

Tagore is a synthesis of two complementary skills:

| Source | Contribution |
|--------|--------------|
| [humanizer](https://github.com/blader/humanizer) by [blader](https://github.com/blader) (based on Wikipedia "Signs of AI writing") | 29-pattern catalog, voice calibration, personality/soul section, self-audit loop, full worked example |
| [stop-slop](https://github.com/hardikpandya/stop-slop) by [Hardik Pandya](https://hvpandya.com) | 8 core principles, 12-item pre-delivery checklist, scoring rubric |

humanizer is a deep catalog with a pipeline. stop-slop is a tight rulebook with a scoring gate. Tagore fuses them into a single workflow and adds three substance dimensions (Specificity, Restraint, Voice) that neither skill scored on its own.

## Install

### One-liner (auto-detect)

```bash
curl -fsSL https://raw.githubusercontent.com/apurvrdx1/tagore/main/install.sh | bash
```

The installer detects every supported harness on your system and installs Tagore into each. It also drops a universal symlink at `~/.agents/skills/tagore/` so any agent honoring the cross-tool convention can find it.

### Install for one harness only

```bash
curl -fsSL https://raw.githubusercontent.com/apurvrdx1/tagore/main/install.sh | bash -s -- --platform claude
```

Supported `--platform` values: `claude`, `opencode`, `copilot`, `codex`, `gemini`, `goose`, `agents` (universal).

### Install for every detected harness

```bash
git clone https://github.com/apurvrdx1/tagore.git && cd tagore && ./install.sh --all
```

### Manual install

Pick your harness and copy the `tagore/` directory (with `SKILL.md` inside) into the matching location:

| Harness | Global install path | Per-project alternative |
|---------|---------------------|-------------------------|
| Claude Code | `~/.claude/skills/tagore/` | `.claude/skills/tagore/` |
| OpenCode | `~/.config/opencode/skills/tagore/` | `.opencode/skills/tagore/` |
| GitHub Copilot CLI | `~/.copilot/skills/tagore/` | `.github/skills/tagore/` |
| OpenAI Codex CLI | `~/.codex/skills/tagore/` | `.agents/skills/tagore/` |
| Gemini CLI | `~/.gemini/skills/tagore/` | — |
| Goose | `~/.config/goose/skills/tagore/` | — |
| Cursor | — | `.cursor/rules/tagore/` |
| Windsurf | — | `.windsurf/rules/tagore/` |
| Universal (cross-tool) | `~/.agents/skills/tagore/` | `.agents/skills/tagore/` |

The universal `~/.agents/skills/` path is recognized by OpenCode, Copilot CLI, and Codex, so installing there once covers three harnesses.

## Usage

### Claude Code

```
/tagore Humanize this draft: [paste text]
```

Or invoke the skill explicitly via the Skill tool. Provide a writing sample inline for voice calibration:

```
/tagore Humanize this. Use my style from this sample: [sample]. Now rewrite: [draft]
```

### OpenCode

```
@tagore Humanize this draft: [paste text]
```

Voice calibration works the same way: paste a sample with your prose alongside the draft.

### GitHub Copilot CLI

```
/tagore [paste text]
```

After copying the skill into the directory, run `/skills reload` (or restart the CLI) so Copilot picks it up. Verify with `/skills info tagore`.

### OpenAI Codex CLI

```
codex
> /tagore Humanize this draft: [paste text]
```

Codex auto-loads everything under `~/.codex/skills/`; no reload step required.

### Gemini CLI / Goose

Invoke by name and paste the text. Same six-stage pipeline runs regardless of the harness.

## The pipeline

```
0. (Optional) Voice calibration from sample
1. Draft rewrite — apply the 8 core principles, scrub the 29 patterns
2. Pre-delivery checklist — 12 mechanical yes/no checks
3. Score 1–10 on eight dimensions (5 mechanics + 3 substance, revise if < 56/80)
4. Self-audit — "What makes this still obviously AI generated?"
5. Final rewrite incorporating the audit
6. (Optional) Brief change summary
```

## The scoring rubric

### Mechanics (carried from stop-slop)

| Dimension | Question |
|-----------|----------|
| Directness | Statements or announcements? |
| Rhythm | Varied or metronomic? |
| Trust | Respects reader intelligence? |
| Authenticity | Sounds human? |
| Density | Anything cuttable? |

### Substance (extracted from humanizer)

| Dimension | Question | Catches |
|-----------|----------|---------|
| Specificity | Names the actual thing, or gestures at categories? | Vague attributions, knowledge-cutoff hedging, generic positive conclusions |
| Restraint | States things at their actual size, or puffs them up? | Significance inflation, notability puffery, promotional language |
| Voice | Has a point of view, or neutral wire-copy? | Failure of personality: opinions, stakes, mixed feelings, first-person where appropriate |

**Pass threshold:** 56/80 (70%), with no subtotal failing on its own (Mechanics ≥ 35/50, Substance ≥ 21/30).

A piece can pass mechanics and fail substance. That's the "clean but soulless" failure mode the substance dimensions specifically catch.

## What sets Tagore apart

Plenty of "anti-slop" prompts exist. Tagore's distinguishing features:

1. **Quantitative gate.** 8 dimensions, 80 points, 56 to pass. Forces a numerical decision instead of vibes.
2. **Two failure modes named explicitly.** Inflated slop (puffery) vs. flattened slop (passive narrator-from-a-distance). The rubric tests both.
3. **Self-audit loop built into the process.** "What makes this still obviously AI generated?" → revise. Catches what the catalog scrub missed.
4. **Voice calibration from a sample.** Match the user's actual writing instead of producing generic "human" output.
5. **Adds, not just removes.** The Personality and Soul section prescribes what to put in (opinions, stakes, mixed feelings), not just what to take out.

## Examples

See [examples/essays-with-scores.md](examples/essays-with-scores.md) for full before/after rewrites with scoring breakdowns.

## License

MIT. See [LICENSE](LICENSE).

## Credits

Built from two excellent prior works:
- **[humanizer](https://github.com/blader/humanizer)** by [blader](https://github.com/blader), based on [Wikipedia:Signs of AI writing](https://en.wikipedia.org/wiki/Wikipedia:Signs_of_AI_writing) (WikiProject AI Cleanup).
- **[stop-slop](https://github.com/hardikpandya/stop-slop)** by [Hardik Pandya](https://hvpandya.com).

Both are MIT-licensed; this merge is too.

## Contributing

Issues and PRs welcome. The most valuable contributions:
- New AI tells the catalog misses (with before/after examples)
- Edge cases where the rubric scores wrong
- Voice calibration improvements for non-English text
- Translations of the skill into other languages

## Support

If tagore saved you from sounding like a chatbot in a doc that mattered, drop a coffee. The catalog grows from real submissions, and your support buys time to read them, score them, and ship them in the next release.

[![Buy Me A Coffee](https://img.buymeacoffee.com/button-api/?text=Buy+me+a+coffee&emoji=&slug=apurvrdx&button_colour=FFDD00&font_colour=000000&font_family=Lato&outline_colour=000000&coffee_colour=ffffff)](https://www.buymeacoffee.com/apurvrdx)

## Reference

> "LLMs use statistical algorithms to guess what should come next. The result tends toward the most statistically likely result that applies to the widest variety of cases."
> — WikiProject AI Cleanup

Good writing is rarely the most statistically likely thing. That gap is what Tagore tries to close.
