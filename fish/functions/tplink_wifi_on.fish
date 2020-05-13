# Defined in - @ line 1
function tplink_wifi_on
	nmcli connection show --active | grep -q 'enp0s25'
    if test $status -gt 0
        return
    end

    sshpass -p 'zaq12wsx' \
        ssh -o StrictHostKeyChecking=no \
            -o UserKnownHostsFile=/dev/null \
            'root@10.0.0.1' \
            'nvram set ath0_net_mode=mixed; nvram commit; reboot'
end
