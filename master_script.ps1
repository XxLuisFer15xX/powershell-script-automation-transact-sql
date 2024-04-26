# ===========================
# Section to save script path
# ===========================
$PATH_CREATE_DDL = "scripts/ddl/!RUN_CREATE_DDL.sql"
$PATH_DROP_DDL = "scripts/ddl/!RUN_DROP_DDL.sql"
$PATH_CREATE_DML = "scripts/dml/!RUN_CREATE_DML.sql"
$PATH_DELETE_DML = "scripts/dml/!RUN_DELETE_DML.sql"
$PATH_CREATE_UPDATE_FUNCTIONS = "scripts/functions/!RUN_CREATE_UPDATE_FUNCTIONS.sql"
$PATH_DROP_FUNCTIONS = "scripts/functions/!RUN_DROP_FUNCTIONS.sql"
$PATH_CREATE_UPDATE_SP = "scripts/sp/!RUN_CREATE_UPDATE_SP.sql"
$PATH_DROP_SP = "scripts/sp/!RUN_DROP_SP.sql"

# ===========================
# Section to choose an option
# ===========================
# Loading options.
Clear-Host
$menuTitle = "Select the option:"
$menuOptions = @{
    0 = "LOCAL"
    1 = "DEV"
    2 = "QA"
    3 = "PROD"
}
$maxValue = $menuOptions.count - 1
$selection = 0
$enterPressed = $False
while($enterPressed -eq $False){
    Write-Host "$menuTitle"
    for ($i=0; $i -le $maxValue; $i++){
        if ($i -eq $selection){
            Write-Host -BackgroundColor Cyan -ForegroundColor Black "[ $($menuOptions[$i]) ]"
        } else {
            Write-Host "  $($menuOptions[$i])  "
        }
    }
    $keyInput = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown").virtualkeycode
    switch($keyInput){
        13{
            $enterPressed = $True
            break
        }
        38{
            if ($selection -eq 0){
                $selection = $maxValue
            } else {
                $selection -= 1
            }
            Clear-Host
            break
        }
        40{
            if ($selection -eq $maxValue){
                $selection = 0
            } else {
                $selection +=1
            }
            Clear-Host
            break
        }
        default{
            Clear-Host
        }
    }
}
# Confirming the selected option.
Write-Host
Write-Host "Your selected answer was:"
Write-Host ">" $menuOptions.get_Item($selection)
pause

# =======================================
# Section to obtain environment variables
# =======================================
# Getting environment variables from the .env file.
$DB_ENVIRONMENT =
$DB_SERVER_NAME =
$DB_DATABASE_NAME =
$DB_USERNAME =
$DB_PASSWORD =
Write-Host

if ($selection -eq 0){
    Write-Host "Getting environment variables from the .env file."
    switch -File .env {
        default {
            $name, $value = $_.Trim() -split '=', 2
            if ($name -and $name[0] -ne '#') { # ignore blank and comment lines.
                if ($value) {
                    Set-Variable -Name $name -Value $value -Scope Script
                }
            }
        }
    }
}
if ($selection -eq 1){
    Write-Host "Getting environment variables from the .env.dev file."
    switch -File .env.dev {
        default {
            $name, $value = $_.Trim() -split '=', 2
            if ($name -and $name[0] -ne '#') { # ignore blank and comment lines.
                if ($value) {
                    Set-Variable -Name $name -Value $value -Scope Script
                }
            }
        }
    }
}
if ($selection -eq 2){
    Write-Host "Getting environment variables from the .env.qa file."
    switch -File .env.qa {
        default {
            $name, $value = $_.Trim() -split '=', 2
            if ($name -and $name[0] -ne '#') { # ignore blank and comment lines.
                if ($value) {
                    Set-Variable -Name $name -Value $value -Scope Script
                }
            }
        }
    }
}
if ($selection -eq 3){
    Write-Host "Getting environment variables from the .env.prod file."
    switch -File .env.prod {
        default {
            $name, $value = $_.Trim() -split '=', 2
            if ($name -and $name[0] -ne '#') { # ignore blank and comment lines.
                if ($value) {
                    Set-Variable -Name $name -Value $value -Scope Script
                }
            }
        }
    }
}

# Verify the database connection data in the environment variables of the ".env" file.
$count = 0
if (-not $DB_ENVIRONMENT) {
    $count = $count + 1
}
if (-not $DB_SERVER_NAME) {
    $count = $count + 1
}
if (-not $DB_DATABASE_NAME) {
    $count = $count + 1
}
if (-not $DB_USERNAME) {
    $count = $count + 1
}
if (-not $DB_PASSWORD) {
    $count = $count + 1
}
if ($count -gt 0) {
    Write-Host
    Write-Host "ERROR: Some environment variables were not found in the .env file."
    Write-Host
    break
}

# ===========================
# Section to choose an option
# ===========================
# Loading options.
Clear-Host
$menuTitle = "Select the option:"
$menuOptions = @{
    0 = "Create the entire database from 0."
    1 = "Update FUNCTIONS and STORED PROCEDURES."
    2 = "Delete the entire database."
}
$maxValue = $menuOptions.count - 1
$selection = 0
$enterPressed = $False
while($enterPressed -eq $False){
    Write-Host "$menuTitle"
    for ($i=0; $i -le $maxValue; $i++){
        if ($i -eq $selection){
            Write-Host -BackgroundColor Cyan -ForegroundColor Black "[ $($menuOptions[$i]) ]"
        } else {
            Write-Host "  $($menuOptions[$i])  "
        }
    }
    $keyInput = $host.ui.rawui.readkey("NoEcho,IncludeKeyDown").virtualkeycode
    switch($keyInput){
        13{
            $enterPressed = $True
            break
        }
        38{
            if ($selection -eq 0){
                $selection = $maxValue
            } else {
                $selection -= 1
            }
            Clear-Host
            break
        }
        40{
            if ($selection -eq $maxValue){
                $selection = 0
            } else {
                $selection +=1
            }
            Clear-Host
            break
        }
        default{
            Clear-Host
        }
    }
}

# Confirming the selected option.
Write-Host
Write-Host "Your selected answer was:"
Write-Host ">" $menuOptions.get_Item($selection)

# Verifying the environment in which the operation is being executed.
if (($DB_ENVIRONMENT -eq "PROD") -and -not (
    $selection -eq 1
)) {
    Write-Host
    Write-Host "You cannot run this action in production environment."
    Write-Host "The operation was aborted."
    Write-Host
    break
}

$confirm = Read-Host "Are you sure you want to execute this operation? (YES/NO)"
if ($confirm -ne "YES") {
    Write-Host
    Write-Host "Your response was:" $confirm
    Write-Host "The operation was aborted."
    Write-Host
    break
}
Clear-Host
Write-Host
Write-Host "Starting the action."
Write-Host "Type Ctrl + C to abort the action."
Write-Host
pause

# ==========================
# Section to run the scripts
# ==========================
# Preparing the scripts
Clear-Host
if ($selection -eq 0){
    Write-Host "Create the entire database from 0."
    Write-Host
    sqlcmd -S $DB_SERVER_NAME -U $DB_USERNAME -P $DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DB_DATABASE_NAME -i $PATH_CREATE_DDL -b -f 65001
    Write-Host
    sqlcmd -S $DB_SERVER_NAME -U $DB_USERNAME -P $DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DB_DATABASE_NAME -i $PATH_CREATE_DML -b -f 65001
    Write-Host
    sqlcmd -S $DB_SERVER_NAME -U $DB_USERNAME -P $DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DB_DATABASE_NAME -i $PATH_CREATE_UPDATE_FUNCTIONS -b -f 65001
    Write-Host
    sqlcmd -S $DB_SERVER_NAME -U $DB_USERNAME -P $DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DB_DATABASE_NAME -i $PATH_CREATE_UPDATE_SP -b -f 65001
    Write-Host
}
if ($selection -eq 1){
    Write-Host "Update FUNCTIONS and STORED PROCEDURES."
    Write-Host
    sqlcmd -S $DB_SERVER_NAME -U $DB_USERNAME -P $DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DB_DATABASE_NAME -i $PATH_CREATE_UPDATE_FUNCTIONS -b -f 65001
    Write-Host
    sqlcmd -S $DB_SERVER_NAME -U $DB_USERNAME -P $DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DB_DATABASE_NAME -i $PATH_CREATE_UPDATE_SP -b -f 65001
}
if ($selection -eq 2){
    Write-Host "Delete the entire database."
    Write-Host
    sqlcmd -S $DB_SERVER_NAME -U $DB_USERNAME -P $DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DB_DATABASE_NAME -i $PATH_DROP_SP -f 65001
    Write-Host
    sqlcmd -S $DB_SERVER_NAME -U $DB_USERNAME -P $DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DB_DATABASE_NAME -i $PATH_DROP_FUNCTIONS -f 65001
    Write-Host
    sqlcmd -S $DB_SERVER_NAME -U $DB_USERNAME -P $DB_PASSWORD -v FullScriptDir=`"$pwd`" DataBaseName=$DB_DATABASE_NAME -i $PATH_DROP_DDL -f 65001
    Write-Host
    Write-Host "Database deleted successfully."
}
Write-Host
