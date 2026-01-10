# --- Import utility functions
$utilsPath = "/home/atari-monk/atari-monk/project/pay-track/script/utils.ps1"
if (Test-Path $utilsPath) {
    . $utilsPath  # dot-source the script to load functions
} else {
    Write-Error "Utils script not found at $utilsPath"
}

# --- Paths
$proj = "/home/atari-monk/atari-monk/project/dev-blog/post/pay-track"

snippet clear

# --- Blog files
snippet -c 'Dev Blog:' -t context
$files = Get-BlogFiles $proj
foreach ($file in $files) {
    snippet -f $file -t context
}

snippet -f "/home/atari-monk/atari-monk/project/pay-track/create-user-service.sh" -t context

# --- Prompt
$prompt = """
Biorąc pod uwagę specyfikację z bloga, buduj usługę użytkownika przyrostowo.
Aktualizuj plik create-user-service.sh, który wygeneruje całą usługę.
Dostosuj się do jego istniejących założeń.
Za każdym razem będę wykonywać, budować, testować i przekazywać informacje zwrotne.
1. początkowy bootstrap z dokeryzowanym Postgresem i sequelize
2. Express + /health
3. Migracje Sequelize (users table)
4. POST /users + GET /users/:id, DTO + walidacja, zapis do bazy
"""
snippet -c $prompt -t prompt

snippet pop
