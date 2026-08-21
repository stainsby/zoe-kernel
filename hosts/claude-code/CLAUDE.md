# ZOE enterprise

<!-- The import below resolves relative to this file, which belongs at the enterprise's
     project root with the kernel tree at kernel/. Keeping the kernel somewhere else is
     fine — change this one line to match. Nothing warns you if it resolves to nothing:
     the session just starts without the ZOE instructions. See the adapter's README,
     under "Install", for the check that catches that. -->

@kernel/instructions/zoe.instructions.md

Then follow the cycle the instructions define — it starts with `zoe-orient`. On this
host, redesign and assess dispatch to the `zoe-redesigner` and `zoe-assessor` subagents
(the separation rule they implement is the instructions' `## Conduct`).
