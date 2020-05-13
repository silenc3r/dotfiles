function tplink_wifi_off
    nmcli connection show --active | grep -q 'enp0s25'
    if test $status -gt 0
        return
    end

    sshpass -p 'zaq12wsx' \
        ssh -o StrictHostKeyChecking=no \
            -o UserKnownHostsFile=/dev/null \
            'root@10.0.0.1' \
            'nvram set ath0_net_mode=disabled; nvram commit; reboot'
end
