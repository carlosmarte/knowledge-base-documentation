
# Run in CodeGen Mode
npx playwright codegen <optional‑URL>

## Playwright UI Mode
npx playwright test --ui

Customize playback with flags:
	•	--device="iPhone 13", --viewport-size="800,600", --color-scheme=dark, etc.  ￼
	•	Save browser state for logins: --save-storage=auth.json  ￼

| **Task** | **Command** |
| --- | --- |
| Generate tests via recording | npx playwright codegen <URL> |
| Debug interactively (Inspector) | npx playwright test --debug (PWDEBUG=1) |
| Show full test UI & time travel | npx playwright test --ui |
| Run tests with visible browser | npx playwright test --headed |

•	--debug = runs browser + Inspector, pauses on first test step  ￼ ￼ ￼ ￼
•	--headed = runs tests with visible UI (no Inspector)
•	--ui = launches full test UI with history, snapshots, time travel

npx playwright codegen --device="iPhone 13"

# Example:
npx playwright codegen --device="iPhone 13" https://example.com/login
