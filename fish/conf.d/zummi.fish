set -q ZUMMI_HEIGHT; or set -U ZUMMI_HEIGHT "40%"
set -g _ZUMMI_SESSION_ID (env LC_ALL=C tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 24)

function __zummi_on_variable_pwd --on-variable PWD
    zummi dir add $PWD
end

function __zummi_save_time --on-event fish_preexec
    set -g __ZUMMI_START_TIME (date +%s)
end

function __zummi_on_command --on-event fish_postexec
    set -l exit_status $status
    # TODO: do we want to expand variables here?
    zummi history add $argv --session-id $_ZUMMI_SESSION_ID --start-time $__ZUMMI_START_TIME --exit-status $exit_status
end
