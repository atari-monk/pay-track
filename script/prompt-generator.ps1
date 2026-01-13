$prompt = 
"""
1. Project Structure
    - based on story and architecture propose monorepo structure with services and package.json
    - use latest typescript and pnpm
    - in this step do only must have config files for monorepo and service user-service so we can start implementing it next
"""

snippet clear

snippet -f "/home/atari-monk/atari-monk/project/pay-track/docs/story-architecture.md" -t context

Set-Location /home/atari-monk/atari-monk/project/pay-track
fstree . -c
snippet -d "Project Structure" -t context

snippet pop $prompt
Set-Location /home/atari-monk/atari-monk/project/pay-track/script
