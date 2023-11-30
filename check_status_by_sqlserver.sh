#!/bin/bash
servico='ARQUIVOS_GRAVACAO'

while test -n "$1"; do
        case "$1" in
        -s)
                servico='ARQUIVOS_GRAVACAO'
                shift
                ;;
        *)
                echo "PARAMETROS INVALIDOS"
                exit $STATE_UNKNOWN
                ;;
        esac
        shift
done

if [ ! "$servico" ]; then
        echo "Favor definir o servico"
        exit $STATE_UNKNOWN
fi

STATUS=$(echo "exec ss_sp_PBX_nagios '$servico'"|isql -b -dx MSSQL-discador dss dss88340566 2>/dev/null)
STATE_NAGIOS=$(echo $STATUS| cut -d'_' -f 1)
STATE_MSG=$(echo $STATUS| cut -d'_' -f 2)

if [ "$STATE_MSG" != "WARNING - Checagem de gravacoes foi finalizada apos o comando de arquivos de gravacao. Tente novamente mais tarde." ]; then
    echo "0"
else
    echo "1"
fi

exit $STATE_NAGIOS
