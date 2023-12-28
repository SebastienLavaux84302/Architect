function endscript() {
    local -r end_time="$(date +%s)"
    local -r duration="$((${end_time} - ${1}))"

    eval_gettext "Done in \${GREEN}\${duration}\${RESET} seconds."; echo
    echo -e "Done in ${duration} seconds." >>"${LOG_FILE}"

    read -rp "$(eval_gettext "Do you want to upload the log file to a pastebin? (y/N) ")" response
    response=${response,,}

    if [[ "$response" =~ ^(yes|y)$ ]]; then
        eval_gettext "Uploading log file to pastebin..."; echo
        local -r url="$(curl -s -F 'file=@'"${LOG_FILE}" https://0x0.st)"
        eval_gettext "Log file uploaded to \${url}"; echo
    fi

    read -rp "$(eval_gettext "\${GREEN}Script completed successfully, the system must restart\${RESET}: Press \${GREEN}Enter\${RESET} to restart or \${RED}Ctrl+C\${RESET} to cancel.")"
    for i in {5..1}; do
        eval_gettext "\${GREEN}Restarting in \${i} seconds...\${RESET}"; echo -ne "\r"
        sleep 1
    done
    reboot
}
