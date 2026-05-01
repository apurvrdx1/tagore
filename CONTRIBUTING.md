# Contributing to Tagore

Tagore lives or dies by the catalog and the rubric. The most valuable contributions sharpen those two things. Everything else is welcome but lower priority.

## What helps the most

### 1. New AI tells the catalog misses

If you've seen a slop pattern that the 29-pattern catalog doesn't catch, file it as an issue using the **Missing AI tell** template. The bar is two things:
- The pattern shows up in AI output far more often than in human writing
- There's a clean rewrite rule someone could follow without seeing examples

A good submission has a real before/after, a one-sentence rule, and a note on where you've seen it (which model, which type of writing). Synthetic examples are fine if labeled as such.

If accepted, the pattern lands in `SKILL.md` with attribution to the issue and reporter.

### 2. Cases where the rubric scores wrong

If tagore passed prose you'd reject, or failed prose that's clearly fine, that's a rubric bug. File it as an issue using the **Rubric scored wrong** template. Include the text, the score tagore gave it, the score you think it should have gotten, and one-sentence reasoning per disagreed dimension.

The rubric has subtotal floors specifically to prevent "passing on mechanics alone" — if a substance failure slipped through, that's exactly the kind of bug the project wants to know about.

## Smaller contributions

These are also welcome:

- **Install path fixes** for harnesses where the path is wrong or has changed
- **Voice calibration improvements** — particularly for non-English text, which Tagore has not been tested against in any depth
- **Worked examples** for prose types not currently covered (technical specs, personal essays, etc.)
- **Translations of the skill** into other languages

## How PRs land

1. Open an issue first if the change is non-trivial. A 5-line PR can go straight to PR; a new pattern or rubric tweak should start with an issue so the discussion has a single thread.
2. Match the existing prose style. Tagore is opinionated about its own writing. Run your prose changes through Tagore itself before submitting.
3. Keep PRs focused. One pattern per PR. One rubric tweak per PR. Mixed PRs get split during review.
4. Add yourself to the credits in `SKILL.md` if your contribution is substantial (a new pattern or a rubric change). Typo fixes don't need credit; pattern catalog additions do.

## What won't land

- **Generic "humanize my text" wrappers.** The skill already does this. New entry points or aliases muddy the surface.
- **AI-vocabulary terms reintroduced "for completeness."** If something was deliberately stripped, leave it out.
- **Rubric dimension expansion past 8.** The 8 dimensions were chosen to keep scoring fast. Adding a 9th is a major change requiring a clear case.
- **Marketing copy in the README.** Run README changes through Tagore. If they don't pass the rubric, they don't land.

## Code of Conduct

Be specific, be useful, don't waste people's time. Disagreement is fine; performative outrage is not.

Project maintained by [@apurvrdx1](https://github.com/apurvrdx1).
