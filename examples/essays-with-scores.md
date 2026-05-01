# Tagore: Worked Examples

Three before/after rewrites covering the prose types most people actually use a humanizer on: a product blog post, an internal status email, and a README intro. Each example shows the original AI-flavored draft, the final rewrite, the 8-dimension score that justifies it, and a short list of what changed.

For the canonical worked example (a 5-paragraph essay run through every pipeline stage), see the `Full Worked Example` section in [`SKILL.md`](../SKILL.md).

---

## Example 1: Product launch blog post

A common case: marketing or DevRel asks Claude to draft a launch post and gets back a wall of puffery.

### Before

> We're thrilled to announce the launch of Quill, our groundbreaking new note-taking platform that's revolutionizing the way teams capture and share knowledge. In today's fast-paced digital landscape, capturing fleeting ideas has never been more critical, and Quill stands as a testament to what's possible when thoughtful design meets cutting-edge technology.
>
> Quill seamlessly integrates with your existing workflow, empowering individuals and teams to unlock their full creative potential. Whether you're a solo creator, a growing startup, or an enterprise organization, Quill scales with you — providing intuitive tools that adapt to your unique needs.
>
> At its core, Quill is more than just a note app. It's a catalyst for collaboration, a partner in productivity, and a foundation for the future of knowledge work. We can't wait to see what you build with it.

### After

> Quill is a note-taking app. We built it because the notes apps we used were either too rigid (Notion) or too messy (anything plain-text and synced) and we wanted something between the two.
>
> What you get: a markdown editor, fast search across everything you've ever written, and per-note sharing that doesn't require pulling people into a workspace. What you don't get: AI summaries, a calendar, a kanban board, or any of the other things that turn note apps into project-management tools you have to learn.
>
> It's $5 a month. There's a free tier for under 100 notes. If you've tried it and have opinions, the team reads every email at hello@quill.app, including the angry ones.

### Score

*Mechanics:*
- Directness: 9 (states what the product is in the first sentence)
- Rhythm: 8 (sentences vary; one fragment in paragraph 2)
- Trust: 9 (no signposting, no "let me explain why this matters")
- Authenticity: 8 (sounds like a person, not a launch deck)
- Density: 9 (every sentence carries information)

*Substance:*
- Specificity: 9 (names competitors, names price, names email, lists actual features)
- Restraint: 9 (no "groundbreaking," no "transformative," no "stands as")
- Voice: 8 (a point of view appears: too rigid vs too messy; what we deliberately left out)

**Total: 69/80**, passes comfortably. Both subtotals clear their floors (Mechanics 43/50, Substance 26/30).

### Changes

- Removed every word in the first paragraph's vocabulary list ("thrilled," "groundbreaking," "revolutionizing," "fast-paced digital landscape," "stands as a testament," "thoughtful design meets cutting-edge technology")
- Removed three-camp hedging ("solo creator, growing startup, enterprise organization")
- Removed copula avoidance ("stands as," "is more than just," "is a catalyst for"), replacing it with "is"
- Removed rule-of-three closer ("catalyst for collaboration, a partner in productivity, a foundation for the future")
- Added a point of view (which competitors and why), specificity (price, free tier limit, contact email), and restraint (no claim to revolutionize anything)
- Cut total length by roughly 60%. Most launch-post slop is filler

---

## Example 2: Internal status update email

The everyday case. Most people will use a humanizer here more than anywhere else.

### Before

> Subject: Q3 Migration Update — Significant Progress and Path Forward
>
> Hi team,
>
> I wanted to provide a comprehensive update on our ongoing Q3 migration efforts. As you know, this has been a critical initiative, and I'm pleased to share that we've made substantial progress across multiple workstreams.
>
> Our infrastructure team has been working tirelessly to ensure a seamless transition, and their efforts have been instrumental in moving us forward. We've successfully completed the initial phase of database migration, which represents a major milestone in our journey toward modernization.
>
> That said, we have encountered some challenges along the way — particularly around schema compatibility and downstream dependencies. However, our team has demonstrated remarkable resilience in addressing these issues head-on, and I'm confident we'll continue to navigate any obstacles that arise.
>
> Looking ahead, we're targeting full completion by end of Q3, with several key deliverables expected in the coming weeks. I'll continue to provide updates as we progress, and please don't hesitate to reach out if you have any questions.
>
> Best,
> Alex

### After

> Subject: Q3 migration: where we are, what's blocking us
>
> Hi team,
>
> Database migration is done for the user and billing services. Orders and inventory are still on the old schema; the blocker is a foreign-key chain we didn't catch in the audit.
>
> Two things to flag. First, the schema audit was wrong. We thought 6 tables would need rewrites; it's 11. Adds about two weeks. I should have caught this. Sorry.
>
> Second, the cutover window is tight. If we push through both remaining services we hit Q3, but that leaves no buffer for a rollback if anything goes wrong on cutover night. I'd rather slip a week than rush the cutover.
>
> Asks: Maya, can you re-run the dependency check on the orders schema by Friday? Devon, I need a yes/no on whether finance can absorb a one-week slip.
>
> Alex

### Score

*Mechanics:*
- Directness: 9 (states status, blocker, ask in plain language)
- Rhythm: 8 (mix of short flagging sentences and longer explanations)
- Trust: 9 (no "as you know," no "I wanted to provide")
- Authenticity: 9 (admits a mistake, names two specific people, names tradeoffs)
- Density: 8 (one ~five-line block could probably trim further)

*Substance:*
- Specificity: 10 (names services, table counts, deadlines, two named asks)
- Restraint: 9 (no "remarkable resilience," no "instrumental," no "milestone")
- Voice: 9 (visible point of view: "I'd rather slip than rush"; visible accountability: "I should have caught this")

**Total: 71/80**, passes. The substance dimensions are doing the heavy lifting (28/30); this is a piece that says something.

### Changes

- Removed throat-clearing ("I wanted to provide," "As you know," "I'm pleased to share")
- Removed superficial -ing phrases ("ensuring," "moving us forward," "addressing these issues head-on")
- Removed promotional language ("substantial progress," "remarkable resilience," "instrumental," "successfully completed")
- Removed false-balance hedge ("That said... However"), replacing it with the actual problem
- Removed vague closer ("don't hesitate to reach out"), replacing it with two specific named asks
- Added stakes and accountability ("I should have caught this. Sorry."), specificity (table counts, named services, named people), and a real recommendation instead of "navigating obstacles"

---

## Example 3: README intro for an open-source library

Technical writing has its own slop pattern: vague capabilities lists with no shape.

### Before

> ## About
>
> ratelimit is a comprehensive, lightweight, and production-ready rate-limiting library for Node.js applications. Designed with developers in mind, it provides a robust set of features that enable seamless integration into your existing infrastructure while maintaining exceptional performance.
>
> Whether you're building a small API or scaling to handle millions of requests, ratelimit empowers you to take control of your traffic with confidence. Its intuitive API and flexible configuration options make it the ideal choice for modern web applications.
>
> Key features include:
>
> - 🚀 **Blazing fast performance** with minimal overhead
> - 🔒 **Robust security** to protect your endpoints
> - 🎯 **Flexible configuration** to suit any use case
> - ⚡ **Easy integration** with popular frameworks

### After

> ## What it is
>
> A rate limiter for Node.js. Sliding window, fixed window, and token bucket algorithms; backed by Redis or an in-memory map for single-instance use.
>
> Built it because `express-rate-limit` doesn't share state across processes and `rate-limiter-flexible` needs more configuration than I wanted for the common case (one limit per route, per IP, per minute).
>
> If you have one Node process, use the in-memory backend. If you have more than one, use Redis. That's the whole decision tree.
>
> ```js
> import { limit } from 'ratelimit'
>
> app.use(limit({ requests: 100, per: '1m', by: 'ip' }))
> ```

### Score

*Mechanics:*
- Directness: 10 (first sentence states what it is)
- Rhythm: 8 (mix of short declaratives and one explanation paragraph)
- Trust: 9 (gives the user the decision tree and stops)
- Authenticity: 8 (sounds like a developer wrote it, not a marketing intern)
- Density: 9 (no filler; the code block does the work a feature list usually fakes)

*Substance:*
- Specificity: 9 (names the algorithms, names the backends, names the two competing libraries and what's wrong with each)
- Restraint: 10 (no "blazing fast," no "robust," no "production-ready"; just the actual capability)
- Voice: 8 (a point of view appears: why this exists, what the decision tree is)

**Total: 71/80**, passes comfortably. The Restraint score is what most README slop fails on.

### Changes

- Removed the entire vocabulary list ("comprehensive," "lightweight," "production-ready," "robust," "seamless," "exceptional," "blazing fast," "intuitive," "ideal")
- Removed the false-range positioning ("Whether you're building a small API or scaling to handle millions")
- Replaced the emoji bullet list with a single code example showing the common case
- Added the actual capability list (named algorithms, named backends), the actual reason this library exists (vs two named alternatives), and a one-line decision rule the reader can act on

---

## How to use these examples

When invoking Tagore on your own prose, the score breakdown matters more than the rewrite itself. Two diagnostic shortcuts to watch for:

- **Mechanics ≥ 35, Substance < 21**: "clean but soulless." The text is grammatically smooth but there's no point of view, no specificity, no stakes. Push hard on the Personality and Soul section of `SKILL.md`.
- **Mechanics < 35, Substance ≥ 21**: "interesting but slop-shaped." The ideas are real but the prose is still wearing AI-vocabulary clothes. Run another scrub against the 29-pattern catalog.

A piece that fails one subtotal but passes the other gets routed back to the right fix instead of a generic "rewrite this." That's the whole point of splitting the rubric.
