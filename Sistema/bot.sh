#!/bin/bash
#===================================================
#	SCRIPT: BOT SSHPLUS MANAGER
#   DATA ATT:   05 de Set 2020
#	DESENVOLVIDO POR:	CRAZY_VPN
#   API SHELLBOT:   SHAMAN
#	CONTATO TELEGRAM:	http://t.me/crazy_vpn
#	CANAL TELEGRAM:	http://t.me/sshplus
#===================================================
[[ ! -d /etc/SSHPlus ]] && exit 0
[[ ! -d /etc/bot ]] && exit 0
source ShellBot.sh
api_bot=$1
id_admin=$2
[[ -z $api_bot ]] && exit 0
[[ -z $id_admin ]] && exit 0
[[ $(awk -F" " '{print $2}' /usr/lib/licence) != "@crazy_vpn" ]] && exit 0
ativos='/etc/bot/lista_ativos'
suspensos='/etc/bot/lista_suspensos'
ShellBot.init --token "$api_bot" --monitor --return map --flush
ShellBot.username
fun_menu() {
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>SEJA BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>SELECIONE UMA OPCAO ABAIXO !</i>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard1" \
            --parse_mode html
        return 0
    }
    [[ -d /etc/bot/suspensos/${message_from_username} ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "🚫 VC ESTA SUSPENSO 🚫\n\nCONTATE O ADMINISTRADOR")"
        return 0
    }
    if [[ "$(grep -w "${message_from_username}" $ativos | grep -wc 'revenda')" != '0' ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>SEJA BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>SELECIONE UMA OPCAO ABAIXO !</i>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard2" \
            --parse_mode html
        return 0
    elif [[ "$(grep -w "${message_from_username}" $ativos | grep -wc 'subrevenda')" != '0' ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>SEJA BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>SELECIONE UMA OPCAO ABAIXO !</i>\n\n"
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} --text "$env_msg" \
            --reply_markup "$keyboard3" \
            --parse_mode html
        return 0
    else
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

fun_ajuda() {
    [[ ${message_chat_id[$id]} == "" ]] && {
        id_chatuser="${callback_query_message_chat_id[$id]}"
        id_name="${callback_query_from_username}"
    } || {
        id_chatuser="${message_chat_id[$id]}"
        id_name="${message_from_username}"
    }
    if [[ "$id_chatuser" = "$id_admin" ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /menu = Exibe menu\n"
        env_msg+="[<b>02</b>] /info = Exibe informacoes\n"
        env_msg+="[<b>03</b>] /ajuda = Informacoes sobre opcoes\n\n"
        env_msg+="⚠️ <i>Opções Disponiveis</i>\n\n"
        env_msg+="• <u>CRIAR USUARIO</u> = Cria usuario ssh\n\n"
        env_msg+="• <u>CRIAR TESTE</u> = Cria teste ssh\n\n"
        env_msg+="• <u>REMOVER</u> = Remove usuario ssh\n\n"
        env_msg+="• <u>INFO USUARIOS</u> = Informacoes do usuario\n\n"
        env_msg+="• <u>USUARIOS ONLINE</u> = Exibe Usuários onlines\n\n"
        env_msg+="• <u>INFO VPS</u> = Informacoes do servidor\n\n"
        env_msg+="• <u>ALTERAR SENHA</u> = Altera senha ssh\n\n"
        env_msg+="• <u>ALTERAR LIMITE</u> = Altera limite ssh\n\n"
        env_msg+="• <u>ALTERAR DATA</u> = Altera data ssh\n\n"
        env_msg+="• <u>EXPIRADOS</u> = Remove ssh expirados\n\n"
        env_msg+="• <u>BACKUP</u> = Cria Backup ssh e revendas\n\n"
        env_msg+="• <u>OTIMIZAR</u> = Limpa o cache - ram\n\n"
        env_msg+="• <u>SPEEDTESTE</u> = Teste de conexao\n\n"
        env_msg+="• <u>ARQUIVOS</u> = Hospeda Arquivos\n\n"
        env_msg+="• <u>REVENDAS</u> = Gerenciar Revendas\n\n"
        env_msg+="• <u>AUTOBACKUP</u> = lig/Des Backup automatico\n\n"
        env_msg+="• <u>RELATORIO</u> = Informacoes sobre revendas\n\n"
        env_msg+="• <u>AJUDA</u> = Informacoes sobre opcoes\n\n"
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    elif [[ -d /etc/bot/suspensos/$id_name ]]; then
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e "🚫 VC ESTA SUSPENSO 🚫\n\nCONTATE O ADMINISTRADOR")"
        return 0
    elif [[ "$(grep -w "$id_name" $ativos | awk '{print $NF}')" == 'revenda' ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /menu = Exibe menu\n"
        env_msg+="[<b>02</b>] /info = Exibe informacoes\n"
        env_msg+="[<b>03</b>] /ajuda = Informacoes sobre opcoes\n\n"
        env_msg+="⚠️ <i>Opções Disponiveis</i>\n\n"
        env_msg+="• <u>CRIAR USUARIO</u> = Cria usuario ssh\n\n"
        env_msg+="• <u>CRIAR TESTE</u> = Cria teste ssh\n\n"
        env_msg+="• <u>REMOVER</u> = Remove usuario ssh\n\n"
        env_msg+="• <u>INFO USUARIOS</u> = Informacoes do usuario\n\n"
        env_msg+="• <u>USUARIOS ONLINE</u> = Exibe Usuários onlines\n\n"
        env_msg+="• <u>ALTERAR SENHA</u> = Altera senha ssh\n\n"
        env_msg+="• <u>ALTERAR LIMITE</u> = Altera limite ssh\n\n"
        env_msg+="• <u>ALTERAR DATA</u> = Altera data ssh\n\n"
        env_msg+="• <u>EXPIRADOS</u> = Remove ssh expirados\n\n"
        env_msg+="• <u>REVENDAS</u> = Gerenciar Revendas\n\n"
        env_msg+="• <u>RELATORIO</u> = Informacoes sobre revendas\n\n"
        env_msg+="• <u>AJUDA</u> = Informacoes sobre opcoes\n\n"
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    elif [[ "$(grep -w "$id_name" $ativos | awk '{print $NF}')" == 'subrevenda' ]]; then
        local env_msg
        env_msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        env_msg+="<b>BEM VINDO(a) AO BOT SSHPLUS</b>\n"
        env_msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        env_msg+="⚠️ <i>Comandos Disponiveis</i>\n\n"
        env_msg+="[<b>01</b>] /menu = Exibe menu\n"
        env_msg+="[<b>02</b>] /info = Exibe informacoes\n"
        env_msg+="[<b>03</b>] /ajuda = Informacoes sobre opcoes\n\n"
        env_msg+="⚠️ <i>Opções Disponiveis</i>\n\n"
        env_msg+="• <u>CRIAR USUARIO</u> = Cria usuario ssh\n\n"
        env_msg+="• <u>CRIAR TESTE</u> = Cria teste ssh\n\n"
        env_msg+="• <u>REMOVER</u> = Remove usuario ssh\n\n"
        env_msg+="• <u>INFO USUARIOS</u> = Informacoes do usuario\n\n"
        env_msg+="• <u>USUARIOS ONLINE</u> = Exibe Usuários onlines\n\n"
        env_msg+="• <u>ALTERAR SENHA</u> = Altera senha ssh\n\n"
        env_msg+="• <u>ALTERAR LIMITE</u> = Altera limite ssh\n\n"
        env_msg+="• <u>ALTERAR DATA</u> = Altera data ssh\n\n"
        env_msg+="• <u>EXPIRADOS</u> = Remove ssh expirados\n\n"
        env_msg+="• <u>AJUDA</u> = Informacoes sobre opcoes\n\n"
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e $env_msg)" \
            --parse_mode html
        return 0
    else
        ShellBot.sendMessage --chat_id $id_chatuser \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

verifica_acesso() {
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        [[ "$(grep -wc ${message_from_username} $suspensos)" != '0' ]] || [[ "$(grep -wc ${message_from_username} $ativos)" == '0' ]] && {
            _erro="1"
            return 0
        }
    }
}

fun_adduser() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CRIAR USUARIO 👤\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

criar_user() {
    IP=$(cat /etc/IP)
    newclient() {
        cp /etc/openvpn/client-common.txt ~/$1.ovpn
        echo "<ca>" >>~/$1.ovpn
        cat /etc/openvpn/easy-rsa/pki/ca.crt >>~/$1.ovpn
        echo "</ca>" >>~/$1.ovpn
        echo "<cert>" >>~/$1.ovpn
        cat /etc/openvpn/easy-rsa/pki/issued/$1.crt >>~/$1.ovpn
        echo "</cert>" >>~/$1.ovpn
        echo "<key>" >>~/$1.ovpn
        cat /etc/openvpn/easy-rsa/pki/private/$1.key >>~/$1.ovpn
        echo "</key>" >>~/$1.ovpn
        echo "<tls-auth>" >>~/$1.ovpn
        cat /etc/openvpn/ta.key >>~/$1.ovpn
        echo "</tls-auth>" >>~/$1.ovpn
    }
    file_user=$1
    usuario=$(sed -n '1 p' $file_user | cut -d' ' -f2)
    senha=$(sed -n '2 p' $file_user | cut -d' ' -f2)
    limite=$(sed -n '3 p' $file_user | cut -d' ' -f2)
    data=$(sed -n '4 p' $file_user | cut -d' ' -f2)
    validade=$(echo "$data" | awk -F'/' '{print $2FS$1FS$3}' | xargs -i date -d'{}' +%Y/%m/%d)

    useradd -M -N -s /bin/false $usuario -e $validade >/dev/null 2>&1
    (
        echo "${senha}"
        echo "${senha}"
    ) | passwd "${usuario}" >/dev/null 2>&1
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        echo "$usuario:$senha:$info_data:$limite" >/etc/bot/revenda/${message_from_username}/usuarios/$usuario
        echo "$usuario:$senha:$info_data:$limite" >/etc/bot/info-users/$usuario
    }
    echo "$usuario $limite" >>/root/usuarios.db
    echo "$senha" >/etc/SSHPlus/senha/$usuario
    [[ -e "/etc/openvpn/server.conf" ]] && {
        cd /etc/openvpn/easy-rsa/
        ./easyrsa build-client-full $usuario nopass
        newclient "$usuario"
    }
}

fun_deluser() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVER USUARIO 🗑\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

fun_del_user() {
    usuario=$1
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        piduser=$(ps -u "$usuario" | grep sshd | cut -d? -f1)
        kill -9 $piduser >/dev/null 2>&1
        userdel --force "$usuario" 2>/dev/null
        grep -v ^$usuario[[:space:]] /root/usuarios.db >/tmp/ph
        cat /tmp/ph >/root/usuarios.db
        rm /etc/SSHPlus/senha/$usuario >/dev/null 2>&1
    } || {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ O USUARIO NAO EXISTE ❌")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        piduser=$(ps -u "$usuario" | grep sshd | cut -d? -f1)
        kill -9 $piduser >/dev/null 2>&1
        userdel --force "$usuario" 2>/dev/null
        grep -v ^$usuario[[:space:]] /root/usuarios.db >/tmp/ph
        cat /tmp/ph >/root/usuarios.db
        rm /etc/SSHPlus/senha/$usuario >/dev/null 2>&1
        rm /etc/bot/revenda/${message_from_username}/usuarios/$usuario
        rm /etc/bot/info-users/$usuario
    }
    [[ -e /etc/SSHPlus/userteste/$usuario.sh ]] && rm /etc/SSHPlus/userteste/$usuario.sh
    [[ -e "/etc/openvpn/easy-rsa/pki/private/$usuario.key" ]] && {
        [[ -e /etc/debian_version ]] && GROUPNAME=nogroup
        cd /etc/openvpn/easy-rsa/
        ./easyrsa --batch revoke $usuario
        ./easyrsa gen-crl
        rm -rf pki/reqs/$usuario.req
        rm -rf pki/private/$usuario.key
        rm -rf pki/issued/$usuario.crt
        rm -rf /etc/openvpn/crl.pem
        cp /etc/openvpn/easy-rsa/pki/crl.pem /etc/openvpn/crl.pem
        chown nobody:$GROUPNAME /etc/openvpn/crl.pem
        [[ -e $HOME/$usuario.ovpn ]] && rm $HOME/$usuario.ovpn >/dev/null 2>&1
    }
}

alterar_senha() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🔐 Alterar Senha 🔐\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

alterar_senha_user() {
    usuario=$1
    senha=$2
    echo "$usuario:$senha" | chpasswd
    echo "$senha" >/etc/SSHPlus/senha/$usuario
    [[ -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
        senha2=$(cat /etc/bot/revenda/${message_from_username}/usuarios/$usuario | awk -F : {'print $2'})
        sed -i "/$usuario/ s/\b$senha2\b/$senha/g" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
        sed -i "/$usuario/ s/\b$senha2\b/$senha/g" /etc/bot/info-users/$usuario
    }
    [[ $(ps -u $usuario | grep sshd | wc -l) != '0' ]] && pkill -u $usuario >/dev/null 2>&1
}

alterar_limite() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👥 Alterar Limite 👥\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

alterar_limite_user() {
    usuario=$1
    limite=$2
    database="/root/usuarios.db"
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        grep -v ^$usuario[[:space:]] /root/usuarios.db >/tmp/a
        mv /tmp/a /root/usuarios.db
        echo $usuario $limite >>/root/usuarios.db
        return 0
    }
    [[ -d /etc/bot/revenda/${message_from_username} ]] && {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ O USUARIO NAO EXISTE ❌")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        _limTotal=$(grep -w 'LIMITE_REVENDA' /etc/bot/revenda/${message_from_username}/${message_from_username} | awk '{print $NF}')
        [[ "$limite" -gt "$_limTotal" ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ VC NAO TEM LIMITE SUFICIENTE ❌\n\nLimite Atual: $_limTotal ")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
        fun_verif_limite_rev ${message_from_username}
        _limsomarev2=$(echo "$_result + $limite" | bc)
        echo "Total $_limsomarev2"
        [[ "$_limsomarev2" -gt "$_limTotal" ]] && {
            [[ "$_limTotal" == "$(($_limTotal - $_result))" ]] && _restant1='0' || _restant1=$(($_limTotal - $_result))
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite restante: $_restant1 ")" \
                --parse_mode html
            _erro='1'
            return 0
        }
        grep -v ^$usuario[[:space:]] /root/usuarios.db >/tmp/a
        mv /tmp/a /root/usuarios.db
        echo $usuario $limite >>/root/usuarios.db
        limite2=$(cat /etc/bot/revenda/${message_from_username}/usuarios/$usuario | awk -F : {'print $4'})
        sed -i "/\b$usuario\b/ s/\b$limite2\b/$limite/" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
        sed -i "/\b$usuario\b/ s/\b$limite2\b/$limite/" /etc/bot/info-users/$usuario
    }
}

alterar_data() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "⏳ Alterar Data ⏳\n\nNome do usuario:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

alterar_data_user() {
    usuario=$1
    inputdate=$2
    database="/root/usuarios.db"
    [[ "$(echo -e "$inputdate" | sed -e 's/[^/]//ig')" != '//' ]] && {
        udata=$(date "+%d/%m/%Y" -d "+$inputdate days")
        sysdate="$(echo "$udata" | awk -v FS=/ -v OFS=- '{print $3,$2,$1}')"
    } || {
        udata=$(echo -e "$inputdate")
        sysdate="$(echo -e "$inputdate" | awk -v FS=/ -v OFS=- '{print $3,$2,$1}')"
        today="$(date -d today +"%Y%m%d")"
        timemachine="$(date -d "$sysdate" +"%Y%m%d")"
        [ $today -ge $timemachine ] && {
            verify='1'
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "❌ Erro! Data invalida")" \
                --parse_mode html
            _erro='1'
            return 0
        }
    }
    chage -E $sysdate $usuario
    [[ -e /etc/bot/revenda/${message_from_username}/usuarios/$usuario ]] && {
        data2=$(cat /etc/bot/info-users/$usuario | awk -F : {'print $3'})
        sed -i "s;$data2;$udata;" /etc/bot/info-users/$usuario
        echo $usuario $udata ${message_from_username}
        sed -i "s;$data2;$udata;" /etc/bot/revenda/${message_from_username}/usuarios/$usuario
    }
}

ver_users() {
    if [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        arq_info=/tmp/$(echo $RANDOM)
        local info_users
        info_users='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_users+='<b>INFORMACOES DOS USUARIOS</b>\n'
        info_users+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_users+='⚠️ Exibe no formato abaixo:\n\n'
        info_users+='<code>USUÁRIO SENHA LIMITE DATA</code>\n'
        ShellBot.sendMessage --chat_id $id_admin \
            --text "$(echo -e $info_users)" \
            --parse_mode html
        fun_infu() {
            local info
            for user in $(cat /etc/passwd | awk -F : '$3 >= 1000 {print $1}' | grep -v nobody); do
                info='===========================\n'
                [[ -e /etc/SSHPlus/senha/$user ]] && senha=$(cat /etc/SSHPlus/senha/$user) || senha='Null'
                [[ $(grep -wc $user $HOME/usuarios.db) != '0' ]] && limite=$(grep -w $user $HOME/usuarios.db | cut -d' ' -f2) || limite='Null'
                datauser=$(chage -l $user | grep -i co | awk -F : '{print $2}')
                [[ $datauser = ' never' ]] && {
                    data="00/00/00"
                } || {
                    databr="$(date -d "$datauser" +"%Y%m%d")"
                    hoje="$(date -d today +"%Y%m%d")"
                    [[ $hoje -ge $databr ]] && {
                        data="Venceu"
                    } || {
                        dat="$(date -d"$datauser" '+%Y-%m-%d')"
                        data=$(echo -e "$((($(date -ud $dat +%s) - $(date -ud $(date +%Y-%m-%d) +%s)) / 86400)) DIAS")
                    }
                }
                info+="$user • $senha • $limite • $data"
                echo -e "$info"
            done
        }
        fun_infu >$arq_info
        while :; do
            ShellBot.sendMessage --chat_id $id_admin \
                --text "$(while read linha; do echo $linha; done < <(sed '1,30!d' $arq_info))" \
                --parse_mode html
            sed -i 1,30d $arq_info
            [[ $(cat $arq_info | wc -l) = '0' ]] && rm $arq_info && break
        done
    elif [[ "$(grep -wc "${callback_query_from_username}" $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC AINDA NAO CRIOU USUARIO!"
            return 0
        }
        arq_info=/tmp/$(echo $RANDOM)
        local info_users
        info_users='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_users+='<b>INFORMACOES DOS USUARIOS</b>\n'
        info_users+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_users+='⚠️ Exibe no formato abaixo:\n\n'
        info_users+='<code>USUÁRIO SENHA LIMITE DATA</code>\n'
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e $info_users)" \
            --parse_mode html
        fun_infu() {
            local info
            for user in $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios); do
                info='===========================\n'
                [[ -e /etc/SSHPlus/senha/$user ]] && senha=$(cat /etc/SSHPlus/senha/$user) || senha='Null'
                [[ $(grep -wc $user $HOME/usuarios.db) != '0' ]] && limite=$(grep -w $user $HOME/usuarios.db | cut -d' ' -f2) || limite='Null'
                datauser=$(chage -l $user | grep -i co | awk -F : '{print $2}')
                [[ $datauser = ' never' ]] && {
                    data="00/00/00"
                } || {
                    databr="$(date -d "$datauser" +"%Y%m%d")"
                    hoje="$(date -d today +"%Y%m%d")"
                    [[ $hoje -ge $databr ]] && {
                        data="Venceu"
                    } || {
                        dat="$(date -d"$datauser" '+%Y-%m-%d')"
                        data=$(echo -e "$((($(date -ud $dat +%s) - $(date -ud $(date +%Y-%m-%d) +%s)) / 86400)) DIAS")
                    }
                }
                info+="$user • $senha • $limite • $data"
                echo -e "$info"
            done
        }
        fun_infu >$arq_info
        while :; do
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "$(while read linha; do echo $linha; done < <(sed '1,30!d' $arq_info))" \
                --parse_mode html
            sed -i 1,30d $arq_info
            [[ $(cat $arq_info | wc -l) = '0' ]] && rm $arq_info && break
        done
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

fun_drop() {
    port_dropbear=$(ps aux | grep dropbear | awk NR==1 | awk '{print $17;}')
    log=/var/log/auth.log
    loginsukses='Password auth succeeded'
    pids=$(ps ax | grep dropbear | grep " $port_dropbear" | awk -F" " '{print $1}')
    for pid in $pids; do
        pidlogs=$(grep $pid $log | grep "$loginsukses" | awk -F" " '{print $3}')
        i=0
        for pidend in $pidlogs; do
            let i=i+1
        done
        if [ $pidend ]; then
            login=$(grep $pid $log | grep "$pidend" | grep "$loginsukses")
            PID=$pid
            user=$(echo $login | awk -F" " '{print $10}' | sed -r "s/'/ /g")
            waktu=$(echo $login | awk -F" " '{print $2"-"$1,$3}')
            while [ ${#waktu} -lt 13 ]; do
                waktu=$waktu" "
            done
            while [ ${#user} -lt 16 ]; do
                user=$user" "
            done
            while [ ${#PID} -lt 8 ]; do
                PID=$PID" "
            done
            echo "$user $PID $waktu"
        fi
    done
}

monitor_ssh() {
    if [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        database="/root/usuarios.db"
        cad_onli=/tmp/$(echo $RANDOM)
        local info_on
        info_on='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_on+='<b>MONITOR USUARIOS ONLINES</b>\n'
        info_on+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_on+='⚠️ Exibe no formato abaixo:\n\n'
        info_on+='<code>USUÁRIO  ONLINE/LIMITE  TEMPO\n</code>'
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e $info_on)" \
            --parse_mode html
        fun_online() {
            local info2
            for user in $(cat /etc/passwd | awk -F : '$3 >= 1000 {print $1}' | grep -v nobody); do
                [[ "$(grep -w $user $database)" != "0" ]] && lim="$(grep -w $user $database | cut -d' ' -f2)" || lim=0
                [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                sqd="$(ps -u $user | grep sshd | wc -l)"
                _cont=$(($drop + $ovp))
                conex=$(($_cont + $sqd))
                [[ $conex -gt '0' ]] && {
                    timerr="$(ps -o etime $(ps -u $user | grep sshd | awk 'NR==1 {print $1}') | awk 'NR==2 {print $1}')"
                    info2+="===========================\n"
                    info2+="🟢 $user       $conex/$lim       ⏳$timerr\n"
                }
            done
            echo -e "$info2"
        }
        fun_online >$cad_onli
        [[ $(cat $cad_onli | wc -w) != '0' ]] && {
            while :; do
                ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                    --text "$(while read linha; do echo $linha; done < <(sed '1,30!d' $cad_onli))" \
                    --parse_mode html
                sed -i 1,30d $cad_onli
                [[ "$(cat $cad_onli | wc -l)" = '0' ]] && {
                    rm $cad_onli
                    break
                }
            done
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "Nenhum usuario online" \
                --parse_mode html
            return 0
        }
    elif [[ "$(grep -wc "${callback_query_from_username}" $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC AINDA NAO CRIOU USUARIO!"
            return 0
        }
        database="/root/usuarios.db"
        cad_onli=/tmp/$(echo $RANDOM)
        local info_on
        info_on='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n'
        info_on+='<b>MONITOR USUARIOS ONLINES</b>\n'
        info_on+='=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n'
        info_on+='⚠️ Exibe no formato abaixo:\n\n'
        info_on+='<code>USUÁRIO  ONLINE/LIMITE  TEMPO\n</code>'
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e $info_on)" \
            --parse_mode html
        fun_online() {
            local info2
            for user in $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios); do
                [[ "$(grep -w $user $database)" != "0" ]] && lim="$(grep -w $user $database | cut -d' ' -f2)" || lim=0
                [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                sqd="$(ps -u $user | grep sshd | wc -l)"
                conex=$(($sqd + $ovp + $drop))
                [[ $conex -gt '0' ]] && {
                    timerr="$(ps -o etime $(ps -u $user | grep sshd | awk 'NR==1 {print $1}') | awk 'NR==2 {print $1}')"
                    info2+="------------------------------\n"
                    info2+="👤$user       $conex/$lim       ⏳$timerr\n"
                }
            done
            echo -e "$info2"
        }
        fun_online >$cad_onli
        [[ $(cat $cad_onli | wc -w) != '0' ]] && {
            while :; do
                ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                    --text "<code>$(while read linha; do echo $linha; done < <(sed '1,30!d' $cad_onli))</code>" \
                    --parse_mode html
                sed -i 1,30d $cad_onli
                [[ "$(cat $cad_onli | wc -l)" = '0' ]] && {
                    rm $cad_onli
                    break
                }
            done
        } || {
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "Nenhum usuario online" \
                --parse_mode html
            return 0
        }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

fun_verif_user() {
    user=$1
    [[ -z "$user" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")" \
            --parse_mode html
        return 0
    }
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        [[ "$(awk -F : '$3 >= 1000 { print $1 }' /etc/passwd | grep -wc $user)" == '0' ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ❌ Usuario $user não existe !)" \
                --parse_mode html
            _erro='1'
            return 0
        }
    }
    [[ -d /etc/bot/revenda/${message_from_username} ]] && {
        [[ ! -e /etc/bot/revenda/${message_from_username}/usuarios/$user ]] && {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ❌ Usuario $user nao existe !)" \
                --parse_mode html
            _erro='1'
            return 0
        }
    }
}

fun_down() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
    [[ ! -d /tmp/file ]] && mkdir /tmp/file
    ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
        --text "[1] - ADICIONAR ARQUIVO\n[2] - EXCLUIR ARQUIVO\n\nInforme a opcao [1-2]:" \
        --reply_markup "$(ShellBot.ForceReply)"
}

infovps() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    PTs='/tmp/prts'
    _ons=$(ps -x | grep sshd | grep -v root | grep priv | wc -l)
    [[ -e /etc/openvpn/openvpn-status.log ]] && _onop=$(grep -c "10.8.0" /etc/openvpn/openvpn-status.log) || _onop="0"
    [[ -e /etc/default/dropbear ]] && _drp=$(ps aux | grep dropbear | grep -v grep | wc -l) _ondrp=$(($_drp - 1)) || _ondrp="0"
    _on=$(($_ons + $_onop + $_ondrp))
    total=$(awk -F: '$3>=1000 {print $1}' /etc/passwd | grep -v nobody | wc -l)
    system=$(cat /etc/issue.net)
    uso=$(top -bn1 | awk '/Cpu/ { cpu = "" 100 - $8 "%" }; END { print cpu }')
    cpucores=$(grep -c cpu[0-9] /proc/stat)
    ram1=$(free -h | grep -i mem | awk {'print $2'})
    usoram=$(free -m | awk 'NR==2{printf "%.2f%%\t\t", $3*100/$2 }')
    total=$(cat -n /root/usuarios.db | tail -n 1 | awk '{print $1}')
    echo -e "SSH: $(grep 'Port' /etc/ssh/sshd_config | cut -d' ' -f2 | grep -v 'no' | xargs)" >$PTs
    [[ -e "/etc/stunnel/stunnel.conf" ]] && echo -e "SSL Tunel: $(netstat -nplt | grep 'stunnel' | awk {'print $4'} | cut -d: -f2 | xargs)" >>$PTs
    [[ -e "/etc/openvpn/server.conf" ]] && echo -e "Openvpn: $(netstat -nplt | grep 'openvpn' | awk {'print $4'} | cut -d: -f2 | xargs)" >>$PTs
    [[ "$(netstat -nplt | grep 'sslh' | wc -l)" != '0' ]] && echo -e "SSlh: $(netstat -nplt | grep 'sslh' | awk {'print $4'} | cut -d: -f2 | xargs)" >>$PTs
    [[ "$(netstat -nplt | grep 'squid' | wc -l)" != '0' ]] && echo -e "Squid: $(netstat -nplt | grep 'squid' | awk -F ":" {'print $4'} | xargs)" >>$PTs
    [[ "$(netstat -nltp | grep 'dropbear' | wc -l)" != '0' ]] && echo -e "DropBear: $(netstat -nplt | grep 'dropbear' | awk -F ":" {'print $4'} | xargs)" >>$PTs
    [[ "$(netstat -nplt | grep 'python' | wc -l)" != '0' ]] && echo -e "Proxy Socks: $(netstat -nplt | grep 'python' | awk {'print $4'} | cut -d: -f2 | xargs)" >>$PTs
    local info
    info="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
    info+="<b>INFORMACOES DO SERVIDOR</b>\n"
    info+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
    info+="<b>SISTEMA OPERACIONAL</b>\n"
    info+="$system\n\n"
    info+="<b>PROCESSADOR</b>\n"
    info+="<b>Nucleos:</b> $cpucores\n"
    info+="<b>Ultilizacao:</b> $uso\n\n"
    info+="<b>MEMORIA RAM</b>\n"
    info+="<b>Total:</b> $ram1\n"
    info+="<b>Ultilizacao:</b> $usoram\n\n"
    while read linha; do
        info+="<b>$(echo -e "$linha")</b>\n"
    done < <(cat $PTs)
    info+="\n<b>$total</b><i> USUARIOS</i><b> $_on</b> <i>ONLINE</i>"
    ShellBot.sendMessage --chat_id $id_admin \
        --text "$(echo -e $info)" \
        --parse_mode html
    return 0
}

fun_download() {
    Opc=$1
    [[ -z "$Opc" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌Erro tente novamente")"
        _erro='1'
        return 0
    }
    _file2=$2
    [[ -z "$_file2" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌Erro tente novamente")"
        _erro='1'
        return 0
    }
    _DirArq=$(ls /etc/bot/arquivos)
    i=0
    unset _Pass
    while read _Arq; do
        i=$(expr $i + 1)
        _oP=$i
        [[ $i == [1-9] ]] && i=0$i && oP+=" 0$i"
        echo -e "[$i] - $_Arq"
        _Pass+="\n${_oP}:${_Arq}"
    done <<<"${_DirArq}"
    _file=$(echo -e "${_Pass}" | grep -E "\b$Opc\b" | cut -d: -f2)
    echo $_file2
    ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
        --document "@/etc/bot/arquivos/$_file" \
        --caption "$(echo -e "✅ CRIADO COM SUCESSO ✅\n\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $_file2)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $_file2)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $_file2)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $_file2)")" \
        --parse_mode html
    [[ -e "/root/$(awk -F " " '/Nome/ {print $2}' $_file2).ovpn" ]] && {
        ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
            --document "@/root/$(awk -F " " '/Nome/ {print $2}' $_file2).ovpn"
    }
}

otimizer() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    MEM1=$(free | awk '/Mem:/ {print int(100*$3/$2)}')
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "🧹 LIMPANDO CACHE DO SERVIDOR"
    apt-get autoclean -y
    echo 3 >/proc/sys/vm/drop_caches
    sync && sysctl -w vm.drop_caches=3 1>/dev/null 2>/dev/null
    sysctl -w vm.drop_caches=0 1>/dev/null 2>/dev/null
    swapoff -a
    swapon -a
    ram1=$(free -h | grep -i mem | awk {'print $2'})
    ram2=$(free -h | grep -i mem | awk {'print $3'})
    ram3=$(free -h | grep -i mem | awk {'print $4'})
    MEM2=$(free | awk '/Mem:/ {print int(100*$3/$2)}')
    res=$(expr $MEM1 - $MEM2)
    local sucess
    sucess="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
    sucess+="<b>OTIMIZADO COM SUCESSO !</b>\n"
    sucess+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
    sucess+="<i>Ultilizacao anterior</i> $MEM1%\n\n"
    sucess+="<b>Memoria Ram Total</b> $ram1\n"
    sucess+="<b>livre</b> $ram3\n"
    sucess+="<b>Em uso</b> $ram2\n"
    sucess+="<i>Ultilizacao atual</i> $MEM2%\n\n"
    sucess+="<b>Economia de:</b> $res%"
    ShellBot.sendMessage --chat_id $id_admin \
        --text "$(echo -e $sucess)" \
        --parse_mode html
    return 0
}

speed_test() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    rm -rf $HOME/speed >/dev/null 2>&1
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "🚀 TESTANDO VELOCIDADE DO SERVIDOR"
    speedtest --share >speed
    png=$(cat speed | sed -n '5 p' | awk -F : {'print $NF'})
    down=$(cat speed | sed -n '7 p' | awk -F : {'print $NF'})
    upl=$(cat speed | sed -n '9 p' | awk -F : {'print $NF'})
    lnk=$(cat speed | sed -n '10 p' | awk {'print $NF'})
    local msg
    msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
    msg+="<b>🚀 VELOCIDADE DO SERVIDOR 🚀</b>\n"
    msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
    msg+="<b>PING/LATENCIA:</b>$png\n"
    msg+="<b>DOWNLOAD:</b>$down\n"
    msg+="<b>UPLOAD:</b>$upl\n"
    ShellBot.sendMessage --chat_id $id_admin \
        --text "$(echo -e $msg)" \
        --parse_mode html
    ShellBot.sendMessage --chat_id $id_admin \
        --text "$(echo -e $lnk)" \
        --parse_mode html
    rm -rf $HOME/speed >/dev/null 2>&1
    return 0
}

backup_users() {
    [[ "${callback_query_from_id[$id]}" != "$id_admin" ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    }
    rm /root/backup.vps 1>/dev/null 2>/dev/null
    ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
        --text "♻️ CRIANDO BACKUP DE USUARIOS"
    tar cvf /root/backup.vps /root/usuarios.db /etc/shadow /etc/passwd /etc/group /etc/gshadow /etc/bot 1>/dev/null 2>/dev/null
    ShellBot.sendDocument --chat_id ${id_admin} \
        --document "@/root/backup.vps" \
        --caption "$(echo -e "♻️ BACKUP DE USUARIOS ♻️")"
    return 0
}

sobremim() {
    local msg
    msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
    msg+="<b>🤖 BOT SSHPLUS MANAGER 🤖</b>\n"
    msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
    msg+="<b>Desenvolvido por:</b> @crazy_vpn\n"
    msg+="<b>Canal Oficial:</b> @SSHPLUS\n\n"
    msg+="Fui criado com o propósito de fornecer informações e ferramentas para gestão VPN em servidores 🐧 GNU/Linux 🐧.\n\n"
    msg+="<b>Menu:</b> /menu\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --parse_mode html
    return 0
}

fun_add_teste() {
    if [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]]; then
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    elif [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👤 CRIAR TESTE 👤\n\nQuantas horas deve durar EX: 1:" \
            --reply_markup "$(ShellBot.ForceReply)"
    elif [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]]; then
        _limTotal=$(grep -w "${callback_query_from_username}" $ativos | awk '{print $4}')
        fun_verif_limite_rev ${callback_query_from_username}
        _limsomarev2=$(echo "$_result + 1" | bc)
        [[ "$_limsomarev2" -gt "$_limTotal" ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "❌ VC NAO TEM LIMITE DISPONIVEL!"
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "👤 CRIAR TESTE 👤\n\nQuantas horas deve durar EX: 1:" \
                --reply_markup "$(ShellBot.ForceReply)"
        }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    fi
}

fun_teste() {
    usuario=$(echo teste$((RANDOM % +500)))
    senha='1234'
    limite='1'
    t_time=$1
    ex_date=$(date '+%d/%m/%C%y' -d " +2 days")
    tuserdate=$(date '+%C%y/%m/%d' -d " +2 days")
    [[ -z $t_time ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "❌ Erro tente novamente")" \
            --parse_mode html
        return 0
        _erro='1'
    }
    useradd -M -N -s /bin/false $usuario -e $tuserdate >/dev/null 2>&1
    (
        echo "$senha"
        echo "$senha"
    ) | passwd $usuario >/dev/null 2>&1
    echo "$senha" >/etc/SSHPlus/senha/$usuario
    echo "$usuario $limite" >>/root/usuarios.db
    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
        echo "$usuario:$senha:$ex_date:$limite" >/etc/bot/revenda/${message_from_username}/usuarios/$usuario
    }
    dir_teste="/etc/bot/revenda/${message_from_username}/usuarios/$usuario"
    cat <<-EOF >/etc/SSHPlus/userteste/$usuario.sh
	#!/bin/bash
	# USUARIO TESTE
	[[ \$(ps -u "$usuario" | grep -c sshd) != '0' ]] && pkill -u $usuario
	userdel --force $usuario
	grep -v ^$usuario[[:space:]] /root/usuarios.db > /tmp/ph ; cat /tmp/ph > /root/usuarios.db
	[[ -e $dir_teste ]] && rm $dir_teste
	rm /etc/SSHPlus/senha/$usuario > /dev/null 2>&1
	rm /etc/SSHPlus/userteste/$usuario.sh
	EOF
    chmod +x /etc/SSHPlus/userteste/$usuario.sh
    echo "/etc/SSHPlus/userteste/$usuario.sh" | at now + $t_time hour >/dev/null 2>&1
    [[ "$t_time" == '1' ]] && hrs="hora" || hrs="horas"
    [[ "$(ls /etc/bot/arquivos | wc -l)" != '0' ]] && {
        for arqv in $(ls /etc/bot/arquivos); do
            ShellBot.sendDocument --chat_id ${message_from_id[$id]} \
                --document "@/etc/bot/arquivos/$arqv" \
                --caption "$(echo -e "✅ Criado com sucesso ✅\n\nUSUARIO: <code>$usuario</code>\nSENHA: <code>1234</code>\n\n⏳ Expira em: $t_time $hrs")" \
                --parse_mode html
        done
        return 0
    } || {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "✅ <b>Criado com sucesso</b> ✅\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$usuario</code>\nSENHA: <code>1234</code>\n\n⏳ Expira em: $t_time $hrs")" \
            --parse_mode html
        return 0
    }
}

fun_exp_user() {
    if [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        [[ $(cat /root/usuarios.db | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC AINDA NAO CRIOU USUARIO!"
            return 0
        }
        datenow=$(date +%s)
        for user in $(cat /etc/passwd | awk -F : '$3 >= 1000 {print $1}' | grep -v nobody); do
            expdate=$(chage -l $user | awk -F: '/Account expires/{print $2}')
            echo $expdate | grep -q never && continue
            datanormal=$(date -d"$expdate" '+%d/%m/%Y')
            expsec=$(date +%s --date="$expdate")
            diff=$(echo $datenow - $expsec | bc -l)
            echo $diff | grep -q ^\- && continue
            pkill -u $user
            userdel --force $user
            grep -v ^$user[[:space:]] /root/usuarios.db >/tmp/ph
            cat /tmp/ph >/root/usuarios.db
            [[ -e /etc/bot/info-users/$user ]] && rm /etc/bot/info-users/$user
            [[ -e /etc/SSHPlus/userteste/$user.sh ]] && rm /etc/SSHPlus/userteste/$user.sh
            [[ "$(ls /etc/bot/revenda)" != '0' ]] && {
                for ex in $(ls /etc/bot/revenda); do
                    [[ -e /etc/bot/revenda/$exp/usuarios/$user ]] && rm /etc/bot/revenda/$ex/usuarios/$user
                done
            }
        done
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⌛️ USUARIOS SSH EXPIRADOS REMOVIDOS"
        return 0
    elif [[ "$(grep -wc "${callback_query_from_username}" $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(ls /etc/bot/revenda/${callback_query_from_username}/usuarios | wc -l) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC AINDA NAO CRIOU USUARIO!"
            return 0
        }
        datenow=$(date +%s)
        dir_user="/etc/bot/revenda/${callback_query_from_username}/usuarios"
        for user in $(ls $dir_user); do
            expdate=$(chage -l $user | awk -F: '/Account expires/{print $2}')
            echo $expdate | grep -q never && continue
            datanormal=$(date -d"$expdate" '+%d/%m/%Y')
            expsec=$(date +%s --date="$expdate")
            diff=$(echo $datenow - $expsec | bc -l)
            echo $diff | grep -q ^\- && continue
            pkill -f $user
            userdel --force $user
            grep -v ^$user[[:space:]] /root/usuarios.db >/tmp/ph
            cat /tmp/ph >/root/usuarios.db
            [[ -e /etc/SSHPlus/userteste/$user.sh ]] && rm /etc/SSHPlus/userteste/$user.sh
            [[ -e "$dir_user/$user" ]] && rm $dir_user/$user
        done
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⌛️ USUARIOS SSH EXPIRADOS REMOVIDOS"
        return 0
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "$(echo -e 🚫 ACESSO NEGADO 🚫)"
        return 0
    fi
}

relatorio_rev() {
    if [[ "${callback_query_from_id[$id]}" = "$id_admin" ]]; then
        _ons=$(ps -x | grep sshd | grep -v root | grep priv | wc -l)
        _tuser=$(awk -F: '$3>=1000 {print $1}' /etc/passwd | grep -v nobody | wc -l)
        [[ -e /etc/openvpn/openvpn-status.log ]] && _onop=$(grep -c "10.8.0" /etc/openvpn/openvpn-status.log) || _onop="0"
        [[ -e /etc/default/dropbear ]] && _drp=$(ps aux | grep dropbear | grep -v grep | wc -l) _ondrp=$(($_drp - 1)) || _ondrp="0"
        _onli=$(($_ons + $_onop + $_ondrp))
        _cont_rev=$(echo $(grep -wc revenda $ativos) - $(grep -wc revenda $suspensos) | bc)
        _cont_sus=$(grep -wc revenda $suspensos)
        _cont_sub=$(grep -wc subrevenda $ativos)
        _cont_revt=$(grep -wc revenda $ativos)
        local msg
        msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>📊 RELATORIO | INFORMACOES</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        msg+="<b>Usuarios total:</b> $_tuser\n"
        msg+="<b>Usuarios online:</b> $_onli\n"
        msg+="<b>Revendas Ativas:</b> $_cont_rev\n"
        msg+="<b>Revendas Suspensas:</b> $_cont_sus\n"
        msg+="<b>Sub-Revendas:</b> $_cont_sub\n\n"
        msg+="<b>User:</b> @${callback_query_from_username}\n"
        msg+="<b>ID:</b> <code>${callback_query_from_id}</code>\n"
        [[ $_cont_revt != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "📊 CRIANDO RELATORIO !"
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ NENHUM REVENDEDOR ENCONTRADO !"
            return 0
        }
        echo -e "RELATORIO DOS REVENDEDORES\n\nTotal: $_cont_revt  -  $(printf 'Data: %(%d/%m/%Y)T\n')\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" >/tmp/Relatorio.txt
        while read _revlist; do
            _nome_rev="$(echo $_revlist | awk '{print $2}')"
            _limite_rev="$(echo $_revlist | awk '{print $4}')"
            _data_rev="$(echo $_revlist | awk '{print $6}')"
            [[ -e "/etc/bot/revenda/$_nome_rev/$_nome_rev" ]] && {
                _dirsts='revenda'
                _status='Ativo'
            } || {
                _dirsts='suspensos'
                _status='Suspenso'
            }
            _subrev="$(grep -wc SUBREVENDA /etc/bot/$_dirsts/$_nome_rev/$_nome_rev)"
            fun_on() {
                for user in $(ls /etc/bot/$_dirsts/$_nome_rev/usuarios); do
                    [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                    [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                    sqd="$(ps -u $user | grep sshd | wc -l)"
                    conex=$(($sqd + $ovp + $drop))
                    echo -e "$conex"
                done
            }
            [[ "$(ls /etc/bot/$_dirsts/$_nome_rev/usuarios | wc -l)" != '0' ]] && {
                total_on=$(fun_on | paste -s -d + | bc)
                total_users=$(ls /etc/bot/$_dirsts/$_nome_rev/usuarios | wc -l)
            } || {
                total_on='0'
                total_users='0'
            }
            echo -e "\nSTATUS: $_status\nREVENDEDOR: @$_nome_rev\nLIMITE: $_limite_rev\nDIAS RESTANTES: $_data_rev\nSSH CRIADAS: $total_users\nSSH ONLINE: $total_on\nSUB-REVENDAS: $_subrev\n\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" >>/tmp/Relatorio.txt
        done <<<"$(grep -w 'revenda' $ativos)"
        ShellBot.sendDocument --chat_id $id_admin \
            --document "@/tmp/Relatorio.txt" \
            --caption "$(echo -e "$msg")" \
            --parse_mode html
        return 0
    elif [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]]; then
        [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
            return 0
        }
        [[ $(grep -wc 'SUBREVENDA' /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username}) == '0' ]] && {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "⚠️ NENHUM SUB REVENDEDOR ENCONTRADO !"
            _cont_limite=$(grep -w ${callback_query_from_username} $ativos | awk '{print $4}')
            fun_verif_limite_rev ${callback_query_from_username}
            _cont_disp=$(echo $_cont_limite - $_result | bc)
            local msg
            msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
            msg+="<b>📊 RELATORIO | INFORMACOES</b>\n"
            msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
            msg+="<b>Limite de Logins:</b> $_cont_limite\n"
            msg+="<b>Limite Disponivel:</b> $_cont_disp\n"
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "$msg" \
                --parse_mode html
            return 0
        }
        fun_contsub() {
            while read _sublist; do
                _usub="$(echo $_sublist | awk '{print $2}')"
                echo $(grep -wc $_usub $suspensos)
            done <<<"$(grep -w 'SUBREVENDA' /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username})"
        }
        _cont_limite=$(grep -w ${callback_query_from_username} $ativos | awk '{print $4}')
        fun_verif_limite_rev ${callback_query_from_username}
        _cont_disp=$(echo $_cont_limite - $_result | bc)
        _cont_atv=$(grep -wc SUBREVENDA /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username})
        _cont_sup=$(fun_contsub | paste -s -d + | bc)
        local msg
        msg="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        msg+="<b>📊 RELATORIO | INFORMACOES</b>\n"
        msg+="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n\n"
        msg+="<b>Limite de Logins:</b> $_cont_limite\n"
        msg+="<b>Limite Disponivel:</b> $_cont_disp\n"
        msg+="<b>Sub-Revendas Total:</b> $_cont_atv\n"
        msg+="<b>Sub-Revendas Suspensas:</b> $_cont_sup\n"
        msg+="<b>User:</b> @${callback_query_from_username}\n"
        msg+="<b>ID:</b> <code>${callback_query_from_id}</code>\n"
        echo -e "RELATORIO DOS SUB REVENDEDORES\n\nTotal: $_cont_atv  -  $(printf 'Data: %(%d/%m/%Y)T\n')\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" >/tmp/Relatorio-${callback_query_from_username}.txt
        while read _sublist; do
            _usub="$(echo $_sublist | awk '{print $2}')"
            _limit_sub=$(echo $_sublist | awk '{print $4}')
            _data_sub=$(grep -w $_usub $ativos | awk '{print $6}')
            [[ -e "/etc/bot/revenda/$_usub/$_usub" ]] && {
                _dirsts='revenda'
                _status='Ativo'
            } || {
                _dirsts='suspensos'
                _status='Suspenso'
            }
            fun_subon() {
                for user in $(ls /etc/bot/$_dirsts/$_usub/usuarios); do
                    [[ $(netstat -nltp | grep 'dropbear' | wc -l) != '0' ]] && drop="$(fun_drop | grep "$user" | wc -l)" || drop=0
                    [[ -e /etc/openvpn/openvpn-status.log ]] && ovp="$(cat /etc/openvpn/openvpn-status.log | grep -E ,"$user", | wc -l)" || ovp=0
                    sqd="$(ps -u $user | grep sshd | wc -l)"
                    conex=$(($sqd + $ovp + $drop))
                    echo -e "$conex"
                done
            }
            [[ "$(ls /etc/bot/$_dirsts/$_usub/usuarios | wc -l)" != '0' ]] && {
                total_on=$(fun_on | paste -s -d + | bc)
                total_users=$(ls /etc/bot/$_dirsts/$_usub/usuarios | wc -l)
            } || {
                total_on='0'
                total_users='0'
            }
            echo -e "\nSTATUS: $_status\nSUB-REVENDEDOR: @$_usub\nLIMITE: $_limit_sub\nDIAS RESTANTES: $_data_sub\nSSH CRIADAS: $total_users\nSSH ONLINE: $total_on\n\n=×=×=×=×=×=×=×=×=×=×=×=×=×=×=×=" >>/tmp/Relatorio-${callback_query_from_username}.txt
        done <<<"$(grep -w 'SUBREVENDA' /etc/bot/revenda/${callback_query_from_username}/${callback_query_from_username})"
        ShellBot.sendDocument --chat_id ${callback_query_message_chat_id[$id]} \
            --document "@/tmp/Relatorio-${callback_query_from_username}.txt" \
            --caption "$(echo -e "$msg")" \
            --parse_mode html
        return 0
    else

        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    fi
}

fun_backauto() {
    [[ "${callback_query_from_id[$id]}" = "$id_admin" ]] && {
        [[ ! -d /etc/SSHPlus/backups ]] && {
            mkdir /etc/SSHPlus/backups
            [[ $(crontab -l | grep -c "userbackup") = '0' ]] && (
                crontab -l 2>/dev/null
                echo "0 */6 * * * /bin/userbackup 1"
            ) | crontab -
            s
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "♻️ BACKUP AUTOMATICO ATIVADO 🟢"
            return 0
        } || {
            [[ $(crontab -l | grep -c "userbackup") != '0' ]] && crontab -l | grep -v 'userbackup' | crontab -
            [[ -d /etc/SSHPlus/backups ]] && rm -rf /etc/SSHPlus/backups
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "♻️ BACKUP AUTOMATICO DESATIVADO 🔴"
            return 0
        }
    }
}

backup_auto() {
    ShellBot.sendDocument --chat_id $id_admin \
        --document "@/etc/SSHPlus/backups/backup.vps" \
        --caption "$(echo -e "♻️ BACKUP AUTOMATICO ♻️")"
    rm /etc/SSHPlus/backups/backup.vps
    return 0
}

msg_bem_vindo() {
    local msg
    msg="✌️😃 Ola <b>${message_from_first_name[$id]}</b>\n\nSEJA BEM VINDO(a)\n\n"
    msg+="Para acessar o menu\nclick ou execute [ /menu ]\n\n"
    msg+="Para obter informacoes\nclick ou execute [ /ajuda ]\n\n"
    ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
        --text "$(echo -e $msg)" \
        --parse_mode html
    return 0
}

fun_verif_limite_rev() {
    _userrev=$1
    [[ "$(grep -w "$_userrev" $ativos | awk '{print $NF}')" == 'revenda' ]] && {
        echo $_userrev
        [[ $(grep -wc 'SUBREVENDA' /etc/bot/revenda/$_userrev/$_userrev) != '0' ]] && {
            _limsomarev=$(grep -w 'SUBREVENDA' /etc/bot/revenda/$_userrev/$_userrev | awk {'print $4'} | paste -s -d + | bc)
        } || {
            _limsomarev='0'
        }
        [[ $(ls /etc/bot/revenda/$_userrev/usuarios | wc -l) != '0' ]] && {
            _mlim1='0'
            _meus_users="/etc/bot/revenda/$_userrev/usuarios"
            for _user_ in $(ls $_meus_users); do
                _mlim2=$(cat $_meus_users/$_user_ | awk -F : {'print $4'})
                _mlim1=$(echo "${_mlim1} + ${_mlim2}" | bc)
            done
        }
        [[ -z "$_mlim1" ]] && _mlim1='0'
        _result=$(echo "${_limsomarev} + ${_mlim1}" | bc)
    }
    [[ "$(grep -w "$_userrev" $ativos | awk '{print $NF}')" == 'subrevenda' ]] && {
        [[ "$(ls /etc/bot/revenda/$_userrev/usuarios | wc -l)" != '0' ]] && {
            _dir_users="/etc/bot/revenda/$_userrev/usuarios"
            _lim1='0'
            for i in $(ls $_dir_users); do
                _lim2=$(cat $_dir_users/$i | awk -F : {'print $4'})
                _lim1=$(echo "${_lim1} + ${_lim2}" | bc)
            done
        }
        [[ -z "$_lim1" ]] && _lim1='0'
        _result=$(echo "${_lim1}")
    }
}

fun_add_revenda() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "👥 ADICIONAR REVENDEDOR 👥\n\nInforme o nome:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

criar_rev() {
    file_rev=$1
    [[ -z "$file_rev" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e Erro)"
        _erro='1'
        break
    }
    n_rev=$(sed -n '1 p' $file_rev | cut -d' ' -f2)
    u_rev=$(sed -n '2 p' $file_rev | awk -F '@' {'print $2'})
    l_rev=$(sed -n '3 p' $file_rev | cut -d' ' -f2)
    d_rev=$(sed -n '4 p' $file_rev | cut -d' ' -f2)
    [[ "${message_from_id[$id]}" = "$id_admin" ]] && {
        t_rev='revenda'
    } || {
        t_rev='subrevenda'
        echo -e "SUBREVENDA: $u_rev LIMITE_SUBREVENDA: $l_rev" >>/etc/bot/revenda/${message_from_username}/${message_from_username}
    }
    mkdir /etc/bot/revenda/"$u_rev"
    mkdir /etc/bot/revenda/"$u_rev"/usuarios
    touch /etc/bot/revenda/"$u_rev"/$u_rev
    echo -e "USER: $u_rev LIMITE: $l_rev DIAS: $d_rev TIPO: $t_rev" >>$ativos
    echo -e "=========================\nLIMITE_REVENDA: $l_rev\nDIAS_REVENDA: $d_rev\n=========================\n" >/etc/bot/revenda/"$u_rev"/$u_rev
    sed -i '$d' $file_rev
    echo -e "Vencimento: $(date "+%d/%m/%Y" -d "+$d_rev days")" >>$file_rev
}

fun_del_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🗑 REMOVER REVENDEDOR 🗑\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

del_rev() {
    _cli_rev=$1
    [[ -z "$_cli_rev" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")"
        return 0
    }
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        [[ "$(grep -wc "$_cli_rev" $ativos)" != '0' ]] && {
            [[ -e "/etc/bot/revenda/$_cli_rev/$_cli_rev" ]] && _dirsts='revenda' || _dirsts='suspensos'
            [[ "$(grep -wc 'SUBREVENDA' /etc/bot/$_dirsts/$_cli_rev/$_cli_rev)" != '0' ]] && {
                while read _listsub2; do
                    _usub="$(echo $_listsub2 | awk '{print $2}')"
                    [[ -e "/etc/bot/revenda/$_usub/$_usub" ]] && _dirsts2='revenda' || _dirsts2='suspensos'
                    _dir_users="/etc/bot/$_dirsts2/$_usub/usuarios"
                    [[ "$(ls $_dir_users | wc -l)" != '0' ]] && {
                        for _user in $(ls $_dir_users); do
                            piduser=$(ps -u "$_user" | grep sshd | cut -d? -f1)
                            kill -9 $piduser >/dev/null 2>&1
                            userdel --force "$_user" 2>/dev/null
                            grep -v ^$_user[[:space:]] /root/usuarios.db >/tmp/ph
                            cat /tmp/ph >/root/usuarios.db
                            rm /etc/bot/info-users/$_user
                        done
                    }
                    [[ -d /etc/bot/$_dirsts2/$_usub ]] && rm -rf /etc/bot/$_dirsts2/$_usub >/dev/null 2>&1
                    sed -i "/\b$_usub\b/d" $ativos
                    [[ $(grep -wc "$_usub" $suspensos) != '0' ]] && {
                        sed -i "/\b$_usub\b/d" $suspensos
                    }
                done <<<"$(grep -w 'SUBREVENDA' /etc/bot/$_dirsts/$_cli_rev/$_cli_rev)"
            }
            [[ "$(ls /etc/bot/$_dirsts/$_cli_rev/usuarios | wc -l)" != '0' ]] && {
                for _user in $(ls /etc/bot/$_dirsts/$_cli_rev/usuarios); do
                    piduser=$(ps -u "$_user" | grep sshd | cut -d? -f1)
                    kill -9 $piduser >/dev/null 2>&1
                    userdel --force "$_user" 2>/dev/null
                    grep -v ^$_user[[:space:]] /root/usuarios.db >/tmp/ph
                    cat /tmp/ph >/root/usuarios.db
                    rm /etc/bot/info-users/$_user
                done
            }
            [[ -d /etc/bot/$_dirsts/$_cli_rev ]] && rm -rf /etc/bot/$_dirsts/$_cli_rev >/dev/null 2>&1
            sed -i "/\b$_cli_rev\b/d" $ativos
            [[ $(grep -wc "$_cli_rev" $suspensos) != '0' ]] && {
                sed -i "/\b$_cli_rev\b/d" $suspensos
            }
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "REMOVIDO COM SUCESSO")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ❌ REVENDEDEDOR NAO EXISTE ❌)"
            return 0
        }
    } || {
        [[ "$(grep -wc "$_cli_rev" /etc/bot/revenda/${message_from_username}/${message_from_username})" != '0' ]] && {
            [[ -d /etc/bot/revenda/$_cli_rev ]] && {
                [[ "$(ls /etc/bot/revenda/$_cli_rev/usuarios | wc -l)" != '0' ]] && {
                    for _user in $(ls /etc/bot/revenda/$_cli_rev/usuarios); do
                        piduser=$(ps -u "$_user" | grep sshd | cut -d? -f1)
                        kill -9 $piduser >/dev/null 2>&1
                        userdel --force "$_user" 2>/dev/null
                        grep -v ^$_user[[:space:]] /root/usuarios.db >/tmp/ph
                        cat /tmp/ph >/root/usuarios.db
                        rm /etc/bot/info-users/$_user
                    done
                }
                [[ -d /etc/bot/revenda/$_cli_rev ]] && rm -rf /etc/bot/revenda/$_cli_rev >/dev/null 2>&1
                sed -i "/\b$_cli_rev\b/d" $ativos
                sed -i "/\b$_cli_rev\b/d" /etc/bot/revenda/${message_from_username}/${message_from_username}
            }
            [[ -d /etc/bot/suspensos/$_cli_rev ]] && {
                [[ "$(ls /etc/bot/suspensos/$_cli_rev/usuarios | wc -l)" != '0' ]] && {
                    for _user in $(ls /etc/bot/suspensos/$_cli_rev/usuarios); do
                        piduser=$(ps -u "$_user" | grep sshd | cut -d? -f1)
                        kill -9 $piduser >/dev/null 2>&1
                        userdel --force "$_user" 2>/dev/null
                        grep -v ^$_user[[:space:]] /root/usuarios.db >/tmp/ph
                        cat /tmp/ph >/root/usuarios.db
                        rm /etc/bot/info-users/$_user
                    done
                }
                [[ -d /etc/bot/suspensos/$_cli_rev ]] && rm -rf /etc/bot/suspensos/$_cli_rev >/dev/null 2>&1
                sed -i "/\b$_cli_rev\b/d" $ativos
                sed -i "/\b$_cli_rev\b/d" $suspensos
                sed -i "/\b$_cli_rev\b/d" /etc/bot/revenda/${message_from_username}/${message_from_username}
            }
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "REMOVIDO COM SUCESSO")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e ❌ REVENDEDEDOR NAO EXISTE ❌)"
            return 0
        }
    }
}

fun_lim_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "♾ ALTERAR LIMITE REVENDA ♾\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

lim_rev() {
    _file_lim=$1
    [[ -z "$_file_lim" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")"
        return 0
    }
    _rev_usern=$(grep -w 'Revendedor' $_file_lim | awk -F '@' {'print $2'})
    new_l=$(grep -w 'Limite' $_file_lim | awk {'print $2'})
    [[ -d /etc/bot/revenda/$_rev_usern ]] && {
        l_old=$(grep -w 'LIMITE_REVENDA' /etc/bot/revenda/$_rev_usern/$_rev_usern | awk {'print $2'})
        sed -i "/LIMITE_REVENDA/ s/$l_old/$new_l/g" /etc/bot/revenda/$_rev_usern/$_rev_usern
        sed -i "/$_rev_usern/ s/LIMITE: $l_old/LIMITE: $new_l/" $ativos
        [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
            sed -i "/\b$_rev_usern\b/ s/$l_old/$new_l/g" /etc/bot/revenda/${message_from_username}/${message_from_username}
        }
        echo $_rev_usern
    } || {
        l_old=$(grep -w 'LIMITE_REVENDA' /etc/bot/suspensos/$_rev_usern/$_rev_usern | awk {'print $2'})
        sed -i "/LIMITE_REVENDA/ s/$l_old/$new_l/g" /etc/bot/suspensos/$_rev_usern/$_rev_usern
        sed -i "/\b$_rev_usern\b/ s/LIMITE: $l_old/LIMITE: $new_l/" $ativos
        sed -i "/\b$_rev_usern\b/ s/LIMITE: $l_old/LIMITE: $new_l/" $suspensos
        [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
            sed -i "/\b$_rev_usern\b/ s/$l_old/$new_l/" /etc/bot/revenda/${message_from_username}/${message_from_username}
        }
        echo $_rev_usern
    }
}

fun_dat_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "📆 ALTERAR DATA REVENDA 📆\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

dat_rev() {
    _datfile=$1
    [[ -z "$_datfile" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")"
        _erro='1'
        return 0
    }
    _revd=$(grep -w 'Revendedor' $_datfile | cut -d'@' -f2)
    new_d=$(grep -w 'Data' $_datfile | awk '{print $NF}')
    [[ -d "/etc/bot/suspensos/$_revd" ]] && {
        [[ "$(ls /etc/bot/suspensos/$_revd/usuarios | wc -l)" != '0' ]] && {
            for _user in $(ls /etc/bot/suspensos/$_revd/usuarios); do
                usermod -U $_user
            done
        }
        d_old=$(grep -w 'DIAS_REVENDA' /etc/bot/suspensos/$_revd/$_revd | awk {'print $2'})
        sed -i "/\b$_revd\b/ s/DIAS: $d_old/DIAS: $new_d/" $ativos
        sed -i "/DIAS_REVENDA/ s/$d_old/$new_d/" /etc/bot/suspensos/$_revd/$_revd
        [[ "$(grep -wc 'SUBREVENDA' /etc/bot/suspensos/$_revd/$_revd)" != '0' ]] && {
            while read _listsub; do
                _usub="$(echo $_listsub | awk '{print $2}')"
                [[ "$(ls /etc/bot/suspensos/$_usub/usuarios | wc -l)" != '0' ]] && {
                    for _user in $(ls /etc/bot/suspensos/$_usub/usuarios); do
                        usermod -U $_user
                    done
                }
                mv /etc/bot/suspensos/$_usub /etc/bot/revenda/$_usub
                sed -i "/\b$_usub\b/d" $suspensos
            done <<<"$(grep -w 'SUBREVENDA' /etc/bot/suspensos/$_revd/$_revd)"
        }
        mv /etc/bot/suspensos/$_revd /etc/bot/revenda/$_revd
        sed -i "/\b$_revd\b/d" $suspensos
        sed -i "s;$new_d;$(date "+%d/%m/%Y" -d "+$new_d days");" $_datfile
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "⚠️ $_revd ESTAVA SUSPENSO E FOI REATIVADO !")" \
            --parse_mode html
    } || {
        d_old=$(grep -w 'DIAS_REVENDA' /etc/bot/revenda/$_revd/$_revd | awk {'print $2'})
        sed -i "/\b$_revd\b/ s/DIAS: $d_old/DIAS: $new_d/" $ativos
        sed -i "/DIAS_REVENDA/ s/$d_old/$new_d/" /etc/bot/revenda/$_revd/$_revd
        sed -i "s;$new_d;$(date "+%d/%m/%Y" -d "+$new_d days");" $_datfile
    }
}

fun_list_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    if [[ "${callback_query_from_id[$id]}" == "$id_admin" ]]; then
        local msg1
        msg1="=×=×=×=×=×=×=×=×=×=×=×=×=×=\n📃 LISTA DE REVENDEDORES !\n=×=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        [[ "$(grep -wc 'revenda' $ativos)" != '0' ]] && {
            while read _atvs; do
                _uativ="$(echo $_atvs | awk '{print $2}')"
                [[ "$(grep -wc "$_uativ" $suspensos)" == '0' ]] && _stsrev='ATIVO' || _stsrev='SUSPENSO'
                msg1+="• @$_uativ - $_stsrev\n"
            done <<<"$(grep -w 'revenda' /etc/bot/lista_ativos)"
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "$(echo -e "$msg1")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC NAO TEM REVENDEDORES"
            return 0
        }
    elif [[ "$(grep -w ${callback_query_from_username} $ativos | awk '{print $NF}')" == 'revenda' ]]; then
        _patch="/etc/bot/revenda"
        local msg1
        msg1="=×=×=×=×=×=×=×=×=×=×=×=×=\n📃 LISTA DE SUB REVENDEDORES !\n=×=×=×=×=×=×=×=×=×=×=×=×=\n"
        [[ "$(grep -wc "SUBREVENDA" $_patch/${callback_query_from_username}/${callback_query_from_username})" != '0' ]] && {
            while read _listsub; do
                _usub="$(echo $_listsub | awk '{print $2}')"
                [[ "$(grep -wc "$_usub" $suspensos)" == '0' ]] && _usts='ATIVO' || _usts='SUSPENSO'
                msg1+="• @$_usub - $_usts\n"
            done <<<"$(grep -w 'SUBREVENDA' $_patch/${callback_query_from_username}/${callback_query_from_username})"
            ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
                --text "$(echo -e "$msg1")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
                --text "VC NAO TEM SUB REVENDEDORES"
            return 0
        }
    else
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    fi
}

fun_susp_rev() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.sendMessage --chat_id ${callback_query_message_chat_id[$id]} \
            --text "🔒 SUSPENDER REVENDEDOR 🔒\n\nInforme o user dele [Ex: @crazy_vpn]:" \
            --reply_markup "$(ShellBot.ForceReply)"
    } || {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "🚫 ACESSO NEGADO 🚫"
        return 0
    }
}

susp_rev() {
    _revs=$1
    [[ -z "$_revs" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "Erro")"
        return 0
    }
    [[ -d "/etc/bot/suspensos/$_revs" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "O USUARIO JA ESTA SUSPENSO !")" \
            --parse_mode html
        return 0
    }
    [[ ! -d "/etc/bot/revenda/$_revs" ]] && {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "O USUARIO NAO EXISTE !")" \
            --parse_mode html
        return 0
    }
    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
        [[ "$(grep -wc 'SUBREVENDA' /etc/bot/revenda/$_revs/$_revs)" != '0' ]] && {
            while read _listsub3; do
                _usub3="$(echo $_listsub3 | awk '{print $2}')"
                _dir_users="/etc/bot/revenda/$_usub3/usuarios"
                [[ "$(ls $_dir_users | wc -l)" != '0' ]] && {
                    for _user in $(ls $_dir_users); do
                        usermod -L $_user
                        pkill -f $_user
                    done
                }
                mv /etc/bot/revenda/$_usub3 /etc/bot/suspensos/$_usub3
                grep -w "$_usub3" $ativos >>$suspensos
            done <<<"$(grep -w 'SUBREVENDA' /etc/bot/revenda/$_revs/$_revs)"
        }
        [[ "$(ls /etc/bot/revenda/$_revs/usuarios | wc -l)" != '0' ]] && {
            for _user_ in $(ls /etc/bot/revenda/$_revs/usuarios); do
                usermod -L $_user_
                pkill -f $_user_
            done
        }
        mv /etc/bot/revenda/$_revs /etc/bot/suspensos/$_revs
        grep -w "$_revs" $ativos >>$suspensos
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "SUSPENDIDO COM SUCESSO")" \
            --parse_mode html
        return 0
    } || {
        [[ "$(grep -wc "$_revs" /etc/bot/revenda/${message_from_username}/${message_from_username})" != '0' ]] && {
            [[ "$(ls /etc/bot/revenda/$_revs/usuarios | wc -l)" != '0' ]] && {
                for _user_ in $(ls /etc/bot/revenda/$_revs/usuarios); do
                    usermod -L $_user_
                    pkill -f $_user_
                done
            }
            mv /etc/bot/revenda/$_revs /etc/bot/suspensos/$_revs
            grep -w "$_revs" $ativos >>$suspensos
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "SUSPENDIDO COM SUCESSO")" \
                --parse_mode html
            return 0
        } || {
            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                --text "$(echo -e "O SUB REVENDEDOR NAO EXISTE")" \
                --parse_mode html
            return 0
        }
    }
}

infouserbot() {
    [[ $(grep -wc ${message_from_username} $ativos) != '0' ]] && {
        _cont_limite=$(grep -w ${message_from_username} $ativos | awk '{print $4}')
        fun_verif_limite_rev ${message_from_username}
        _cont_disp=$(echo $_cont_limite - $_result | bc)
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "<b>NOME: </> ${message_from_first_name[$(ShellBot.ListUpdates)]}\n<b>USER:</>" "@${message_from_username[$(ShellBot.ListUpdates)]:-null}")\n<b>ID:</> ${message_from_id[$(ShellBot.ListUpdates)]}\nACESSO: REVENDA\n<b>LIMITE TOTAL:</b> $_cont_limite\n<b>LIMITE RESTANTE:</b> $_cont_disp" \
            --parse_mode html
        return 0
    } || {
        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
            --text "$(echo -e "<b>NOME: </> ${message_from_first_name[$(ShellBot.ListUpdates)]}\n<b>USER:</>" "@${message_from_username[$(ShellBot.ListUpdates)]:-null}")\n<b>ID:</> ${message_from_id[$(ShellBot.ListUpdates)]} " \
            --parse_mode html
        return 0
    }
}

fun_menurevenda() {
    [[ "$(grep -wc ${callback_query_from_username} $suspensos)" != '0' ]] && {
        ShellBot.answerCallbackQuery --callback_query_id ${callback_query_id[$id]} \
            --text "⚠️ VC ESTA SUSPENSO! CONTATE O ADMINISTRADOR"
        return 0
    }
    [[ "${callback_query_from_id[$id]}" == "$id_admin" ]] || [[ "$(grep -wc ${callback_query_from_username} $ativos)" != '0' ]] && {
        ShellBot.editMessageText --chat_id ${callback_query_message_chat_id[$id]} \
            --message_id ${callback_query_message_message_id[$id]} \
            --text "SELECIONE UMA OPÇÃO ABAIXO:" \
            --reply_markup "$(ShellBot.InlineKeyboardMarkup --button 'menu4')"
        return 0
    }
}

# LISTA MENU ADMIN
unset menu1
menu1=''
ShellBot.InlineKeyboardButton --button 'menu1' --line 1 --text 'CRIAR USUARIO' --callback_data '_criaruser'
ShellBot.InlineKeyboardButton --button 'menu1' --line 2 --text 'CRIAR TESTE' --callback_data '_criarteste'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text 'REMOVER' --callback_data '_deluser'
ShellBot.InlineKeyboardButton --button 'menu1' --line 4 --text 'ALTERAR SENHA' --callback_data '_altsenha'
ShellBot.InlineKeyboardButton --button 'menu1' --line 5 --text 'ALTERAR LIMITE' --callback_data '_altlimite'
ShellBot.InlineKeyboardButton --button 'menu1' --line 6 --text 'ALTERAR DATA' --callback_data '_altdata'
ShellBot.InlineKeyboardButton --button 'menu1' --line 7 --text 'USUARIOS ONLINE' --callback_data '_monitor'
ShellBot.InlineKeyboardButton --button 'menu1' --line 8 --text 'INFO USUARIOS' --callback_data '_verusers'
ShellBot.InlineKeyboardButton --button 'menu1' --line 9 --text 'EXPIRADOS' --callback_data '_expirados'
ShellBot.InlineKeyboardButton --button 'menu1' --line 1 --text 'INFO VPS' --callback_data '_infovps'
ShellBot.InlineKeyboardButton --button 'menu1' --line 2 --text 'OTIMIZAR' --callback_data '_otimizar'
ShellBot.InlineKeyboardButton --button 'menu1' --line 3 --text 'ARQUIVOS' --callback_data '_arqdown'
ShellBot.InlineKeyboardButton --button 'menu1' --line 4 --text 'REVENDA' --callback_data '_opcoesrev'
ShellBot.InlineKeyboardButton --button 'menu1' --line 5 --text 'SPEEDTESTE' --callback_data '_speedteste'
ShellBot.InlineKeyboardButton --button 'menu1' --line 6 --text 'BACKUP USUARIOS' --callback_data '_backupusers'
ShellBot.InlineKeyboardButton --button 'menu1' --line 7 --text "ALTO BACKUP" --callback_data '_autobkp'
ShellBot.InlineKeyboardButton --button 'menu1' --line 8 --text 'RELATORIO' --callback_data '_relatorio'
ShellBot.InlineKeyboardButton --button 'menu1' --line 9 --text 'AJUDA' --callback_data '_ajuda'
ShellBot.regHandleFunction --function fun_adduser --callback_data _criaruser
ShellBot.regHandleFunction --function fun_add_teste --callback_data _criarteste
ShellBot.regHandleFunction --function fun_deluser --callback_data _deluser
ShellBot.regHandleFunction --function alterar_senha --callback_data _altsenha
ShellBot.regHandleFunction --function alterar_limite --callback_data _altlimite
ShellBot.regHandleFunction --function alterar_data --callback_data _altdata
ShellBot.regHandleFunction --function fun_down --callback_data _arqdown
ShellBot.regHandleFunction --function monitor_ssh --callback_data _monitor
ShellBot.regHandleFunction --function ver_users --callback_data _verusers
ShellBot.regHandleFunction --function fun_exp_user --callback_data _expirados
ShellBot.regHandleFunction --function otimizer --callback_data _otimizar
ShellBot.regHandleFunction --function speed_test --callback_data _speedteste
ShellBot.regHandleFunction --function infovps --callback_data _infovps
ShellBot.regHandleFunction --function backup_users --callback_data _backupusers
ShellBot.regHandleFunction --function fun_backauto --callback_data _autobkp
ShellBot.regHandleFunction --function relatorio_rev --callback_data _relatorio
ShellBot.regHandleFunction --function fun_ajuda --callback_data _ajuda
ShellBot.regHandleFunction --function fun_menurevenda --callback_data _opcoesrev
unset keyboard1
keyboard1="$(ShellBot.InlineKeyboardMarkup -b 'menu1')"

# LISTA MENU REVENDEDOR
unset menu2
menu2=''
ShellBot.InlineKeyboardButton --button 'menu2' --line 1 --text 'CRIAR USUARIO' --callback_data '_criaruser2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 1 --text 'CRIAR TESTE' --callback_data '_criarteste2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 2 --text 'REMOVER' --callback_data '_deluser2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 2 --text 'USUARIOS ONLINE' --callback_data '_monitor2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 3 --text 'ALTERAR LIMITE' --callback_data '_altlimite2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 3 --text 'INFO USUARIOS' --callback_data '_verusers2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 4 --text 'ALTERAR SENHA' --callback_data '_altsenha2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 4 --text 'EXPIRADOS' --callback_data '_expirados2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 5 --text 'ALTERAR DATA' --callback_data '_altdata2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 5 --text 'REVENDA' --callback_data '_opcoesrev2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 6 --text 'RELATORIO' --callback_data '_relatorio2'
ShellBot.InlineKeyboardButton --button 'menu2' --line 6 --text 'AJUDA' --callback_data '_ajuda2'
ShellBot.regHandleFunction --function fun_adduser --callback_data _criaruser2
ShellBot.regHandleFunction --function fun_add_teste --callback_data _criarteste2
ShellBot.regHandleFunction --function fun_deluser --callback_data _deluser2
ShellBot.regHandleFunction --function alterar_senha --callback_data _altsenha2
ShellBot.regHandleFunction --function alterar_limite --callback_data _altlimite2
ShellBot.regHandleFunction --function alterar_data --callback_data _altdata2
ShellBot.regHandleFunction --function monitor_ssh --callback_data _monitor2
ShellBot.regHandleFunction --function ver_users --callback_data _verusers2
ShellBot.regHandleFunction --function fun_exp_user --callback_data _expirados2
ShellBot.regHandleFunction --function relatorio_rev --callback_data _relatorio2
ShellBot.regHandleFunction --function fun_menurevenda --callback_data _opcoesrev2
ShellBot.regHandleFunction --function fun_ajuda --callback_data _ajuda2
unset keyboard2
keyboard2="$(ShellBot.InlineKeyboardMarkup -b 'menu2')"

#LISTA MUNU SUB REVENDEDOR
unset menu3
menu3=''
ShellBot.InlineKeyboardButton --button 'menu3' --line 1 --text 'CRIAR USUARIO' --callback_data '_criaruser3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 1 --text 'CRIAR TESTE' --callback_data '_criarteste3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 2 --text 'REMOVER' --callback_data '_deluser3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 2 --text 'USUARIOS ONLINE' --callback_data '_monitor3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 3 --text 'ALTERAR LIMITE' --callback_data '_altlimite3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 3 --text 'INFO USUARIOS' --callback_data '_verusers3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 4 --text 'ALTERAR SENHA' --callback_data '_altsenha3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 4 --text 'EXPIRADOS' --callback_data '_expirados3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 5 --text 'ALTERAR DATA' --callback_data '_altdata3'
ShellBot.InlineKeyboardButton --button 'menu3' --line 5 --text 'AJUDA' --callback_data '_ajuda3'
ShellBot.regHandleFunction --function fun_adduser --callback_data _criaruser3
ShellBot.regHandleFunction --function fun_add_teste --callback_data _criarteste3
ShellBot.regHandleFunction --function fun_deluser --callback_data _deluser3
ShellBot.regHandleFunction --function alterar_senha --callback_data _altsenha3
ShellBot.regHandleFunction --function alterar_limite --callback_data _altlimite3
ShellBot.regHandleFunction --function alterar_data --callback_data _altdata3
ShellBot.regHandleFunction --function monitor_ssh --callback_data _monitor3
ShellBot.regHandleFunction --function ver_users --callback_data _verusers3
ShellBot.regHandleFunction --function fun_exp_user --callback_data _expirados3
ShellBot.regHandleFunction --function fun_ajuda --callback_data _ajuda3
unset keyboard3
keyboard3="$(ShellBot.InlineKeyboardMarkup -b 'menu3')"

#LISTA MENU OPCOES REVENDA
unset menu4
menu4=''
ShellBot.InlineKeyboardButton --button 'menu4' --line 1 --text 'ADICIONAR REVENDA' --callback_data '_addrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 2 --text 'REMOVER REVENDA' --callback_data '_delrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 3 --text 'ALTERAR LIMITE REVENDA' --callback_data '_limrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 4 --text 'ALTERAR DATA REVENDA' --callback_data '_datrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 5 --text 'LISTAR REVENDA' --callback_data '_listrev'
ShellBot.InlineKeyboardButton --button 'menu4' --line 6 --text 'SUSPENDER REVENDA' --callback_data '_susprevendas'
ShellBot.regHandleFunction --function fun_add_revenda --callback_data _addrev
ShellBot.regHandleFunction --function fun_del_rev --callback_data _delrev
ShellBot.regHandleFunction --function fun_lim_rev --callback_data _limrev
ShellBot.regHandleFunction --function fun_dat_rev --callback_data _datrev
ShellBot.regHandleFunction --function fun_list_rev --callback_data _listrev
ShellBot.regHandleFunction --function fun_susp_rev --callback _susprevendas
unset keyboard4
keyboard4="$(ShellBot.InlineKeyboardMarkup -b 'menu4')"

while :; do
    [[ -e "/etc/SSHPlus/backups/backup.vps" ]] && {
        backup_auto
    }
    #Obtem as atualizações
    ShellBot.getUpdates --limit 100 --offset $(ShellBot.OffsetNext) --timeout 35
    #Lista o índice das atualizações
    for id in $(ShellBot.ListUpdates); do
        #Inicio thread
        (
            ShellBot.watchHandle --callback_data ${callback_query_data[$id]}
            # Requisições somente no privado.
            [[ ${message_chat_type[$id]} != 'private' ]] && continue
            CAD_ARQ=/tmp/cad.${message_from_id[$id]}
            if [[ ${message_entities_type[$id]} == bot_command ]]; then
                #Verifica se a mensagem enviada pelo usuário é um comando válido.
                case ${message_text[$id]} in
                *)
                    :
                    #comandos
                    comando=(${message_text[$id]})
                    [[ "${comando[0]}" = "/start" ]] && msg_bem_vindo
                    [[ "${comando[0]}" = "/menu" ]] && fun_menu
                    [[ "${comando[0]}" = "/info" ]] && infouserbot
                    [[ "${comando[0]}" = "/hrlp" || "${comando[0]}" = "/ajuda" ]] && fun_ajuda
                    [[ "${comando[0]}" = "/bot" || "${comando[0]}" = "/sobre" ]] && sobremim
                    ;;
                esac
            fi
            if [[ ${message_reply_to_message_message_id[$id]} ]]; then
                # Analisa a interface de resposta.
                case ${message_reply_to_message_text[$id]} in
                '👤 CRIAR USUARIO 👤\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ "$(awk -F : '$3 >= 1000 { print $1 }' /etc/passwd | grep -w ${message_text[$id]} | wc -l)" != '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro! USUARIO INVALIDO ❌\n\n⚠️ Informe Outro Nome..")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [ "${message_text[$id]}" == 'root' ] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ ERRO! USUARIO INVALIDO ❌\n\n⚠️ Informe Outro Nome..")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    sizemin=$(echo -e ${#message_text[$id]})
                    [[ "$sizemin" -lt '4' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro !\n\nUse no mínimo 4 caracteres\n[EX: test]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    sizemax=$(echo -e ${#message_text[$id]})
                    [[ "$sizemax" -gt '10' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro !\n\nUse no maximo 8 caracteres\n[EX: crazy]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    echo "Nome: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Senha:' \
                        --reply_markup "$(ShellBot.ForceReply)" # Força a resposta.
                    ;;
                'Senha:')
                    sizepass=$(echo -e ${#message_text[$id]})
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ "$sizepass" -lt '4' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro !\n\nUse no mínimo 4 caracteres\n[EX: 1234]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    echo "Senha: ${message_text[$id]}" >>$CAD_ARQ
                    # Próximo campo.
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Limite:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Limite:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
                        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
                        fun_verif_limite_rev ${message_from_username}
                        _limsomarev2=$(echo "$_result + ${message_text[$id]}" | bc)
                        [[ "$_limsomarev2" -gt "$_limTotal" ]] && {
                            _restant1=$(($_limTotal - $_result))
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite disponivel: $_restant1 ")" \
                                --parse_mode html
                            >$CAD_ARQ
                            break
                        }
                    }
                    echo "Limite: ${message_text[$id]}" >>$CAD_ARQ
                    # Próximo campo.
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Validade em dias: ' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;

                'Validade em dias:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 30]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    info_data=$(date '+%d/%m/%C%y' -d " +${message_text[$id]} days")
                    echo "Validade: $info_data" >>$CAD_ARQ
                    criar_user $CAD_ARQ
                    [[ "(grep -w ${message_text[$id]} /etc/passwd)" = '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e ❌ Erro ao criar usuario !)" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [[ "$(ls /etc/bot/arquivos | wc -l)" != '0' ]] && {
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text '📥 ARQUIVOS DISPONIVEIS 📥\n\nDeseja baixar? Sim ou Nao?:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                    } || {
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>✅ CRIADO COM SUCESSO ✅</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                        break
                    }
                    ;;
                '📥 ARQUIVOS DISPONIVEIS 📥\n\nDeseja baixar? Sim ou Nao?:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([A-Za-z]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Opcao Invalida ❌\n\n⚠️ Ultilize apenas letras [EX: sim ou nao]")" \
                            --parse_mode html
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>✅ CRIADO COM SUCESSO ✅</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_text[$id]}" = @(Sim|sim|SIM) ]] && {
                        msg_cli="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n"
                        msg_cli+="<b>ARQUIVOS PRE-CONFIGURADOS </b>❗\n"
                        msg_cli+="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n\n"
                        for _file in $(ls /etc/bot/arquivos); do
                            i=$(($i + 1))
                            msg_cli+="<b>[$i]</b> - $_file\n"
                        done
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "$msg_cli")" \
                            --parse_mode html
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text 'Informe o Numero do Arquivo:' \
                            --reply_markup "$(ShellBot.ForceReply)"
                    } || {
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>✅ CRIADO COM SUCESSO ✅</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                    }
                    ;;
                'Informe o Numero do Arquivo:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Opcao Invalida ❌ \n\n⚠️ Ultilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "<b>✅ CRIADO COM SUCESSO ✅</b>\n\nIP: $(cat /etc/IP)\nUSUARIO: <code>$(awk -F " " '/Nome/ {print $2}' $CAD_ARQ)</code>\nSENHA: <code>$(awk -F " " '/Senha/ {print $2}' $CAD_ARQ)</code>\nLIMITE: $(awk -F " " '/Limite/ {print $2}' $CAD_ARQ)\nEXPIRA EM: $(awk -F " " '/Validade/ {print $2}' $CAD_ARQ)" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    fun_download ${message_text[$id]} $CAD_ARQ
                    # Limpa o arquivo temporário.
                    >$CAD_ARQ
                    break
                    ;;
                '🗑 REMOVER USUARIO 🗑\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    fun_del_user ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ *Removido com sucesso.* 🚮" \
                        --parse_mode markdown
                    ;;
                '🔐 Alterar Senha 🔐\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    fun_verif_user ${message_text[$id]}
                    echo "$_erro"
                    [[ "$_erro" == '1' ]] && break
                    echo "${message_text[$id]}" >/tmp/name-s
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Nova senha:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Nova senha:')
                    sizepass=$(echo -e ${#message_text[$id]})
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ "$sizepass" -lt '4' ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro !\n\n⚠️ Use mínimo 4 caracteres [EX: 1234]")" \
                            --parse_mode html
                        break
                    }
                    alterar_senha_user $(cat /tmp/name-s) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ SENHA ALTERADA !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n<b>Usuario:</b> $(cat /tmp/name-s)\n<b>Nova senha:</b> ${message_text[$id]}")" \
                        --parse_mode html
                    rm /tmp/name-s >/dev/null 2>&1
                    ;;
                '👥 Alterar Limite 👥\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    echo $_erro segundo
                    fun_verif_user ${message_text[$id]}
                    echo "$_erro"
                    [[ "$_erro" == '1' ]] && break
                    echo "${message_text[$id]}" >/tmp/name-l
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Novo limite:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Novo limite:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\n⚠️ Ultilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        break
                    }
                    alterar_limite_user $(cat /tmp/name-l) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ LIMITE ALTERADO !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n<b>Usuario:</b> $(cat /tmp/name-l)\n<b>Novo Limite:</b> ${message_text[$id]}")" \
                        --parse_mode html
                    rm /tmp/name-l >/dev/null 2>&1
                    ;;
                '⏳ Alterar Data ⏳\n\nNome do usuario:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    fun_verif_user ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    echo "${message_text[$id]}" >/tmp/name-d
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'informe os dias ou data:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'informe os dias ou data:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9/]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro! Siga o exemplo\n\nDias formato [EX: 30]\nData formato [EX: 30/12/2019]")" \
                            --parse_mode html
                        break
                    }
                    alterar_data_user $(cat /tmp/name-d) ${message_text[$id]}
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ DATA ALTERADA !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n<b>Usuario:</b> $(cat /tmp/name-d)\n<b>Nova Data:</b> $udata")" \
                        --parse_mode html
                    rm /tmp/name-d >/dev/null 2>&1
                    ;;
                '[1] - ADICIONAR ARQUIVO\n[2] - EXCLUIR ARQUIVO\n\nInforme a opcao [1-2]:')
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\n⚠️ Ultilize apenas numeros [EX: 1 ou 2]")" \
                            --parse_mode html
                        break
                    }
                    if [[ "${message_text[$id]}" = '1' ]]; then
                        ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                            --text "📤 HOSPEDAR ARQUIVOS 📤\n\nEnvie-me o arquivo:" \
                            --reply_markup "$(ShellBot.ForceReply)"
                    elif [[ "${message_text[$id]}" = '2' ]]; then
                        [[ $(ls /etc/bot/arquivos | wc -l) != '0' ]] && {
                            msg_cli1="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n"
                            msg_cli1+="🚀<b> ARQUIVOS HOSPEDADOS </b>\n"
                            msg_cli1+="≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠≠\n\n"
                            for _file in $(ls /etc/bot/arquivos); do
                                i=$(($i + 1))
                                msg_cli1+="<b>[$i]</b> - $_file\n"
                            done
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "$msg_cli1")" \
                                --parse_mode html
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "🗑Excluir Arquivo\nInforme o Numero do Arquivo:" \
                                --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "Nao existe arquivos disponiveis")" \
                                --parse_mode html
                            break
                        }
                    else
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Opcao Invalida")" \
                            --parse_mode html
                        break
                    fi
                    ;;
                '🗑Excluir Arquivo\nInforme o Numero do Arquivo:')
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && break
                    Opc1=${message_text[$id]}
                    echo $Opc1
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ao Excluir arquivo ! \n\n⚠️ Ultilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        break
                    } || {
                        echo "opcao $Opc1"
                        _DirArq=$(ls /etc/bot/arquivos)
                        i=0
                        unset _Pass
                        while read _Arq; do
                            i=$(expr $i + 1)
                            _oP=$i
                            [[ $i == [1-9] ]] && i=0$i && oP+=" 0$i"
                            echo -e "[$i] - $_Arq"
                            _Pass+="\n${_oP}:${_Arq}"
                        done <<<"${_DirArq}"
                        _file=$(echo -e "${_Pass}" | grep -E "\b$Opc1\b" | cut -d: -f2)
                        [[ -e /etc/bot/arquivos/$_file ]] && {
                            rm /etc/bot/arquivos/$_file
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "✅ *Excluido com sucesso* ✅" \
                                --parse_mode markdown
                            break
                        } || {
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text "$(echo -e "❌ Opcao invalida")"
                            break
                        }
                    }
                    ;;
                '📤 HOSPEDAR ARQUIVOS 📤\n\nEnvie-me o arquivo:')
                    if [ "${update_id[$id]}" ]; then
                        # Monitora o envio de arquivos
                        [[ ${message_document_file_id[$id]} ]] && file_id=${message_document_file_id[$id]} && download_file=1
                        # Verifica se o download está ativado.
                        [[ $download_file -eq 1 ]] && {
                            file_id=($file_id)
                            ShellBot.getFile --file_id "${file_id[0]}"
                            ShellBot.downloadFile --file_path ${return[file_path]} --dir "/tmp/file" && {
                                msg='*✅ Arquivo hospedado com sucesso.*\n\n'
                                msg+="*📤 Informações*\n\n"
                                msg+="*Nome*: ${message_document_file_name}\n"
                                msg+="*Salvo em*: /etc/bot/arquivos"
                                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                    --text "$(echo -e "$msg")" \
                                    --parse_mode markdown
                                mv /tmp/file/$(ls -1rt /tmp/file | tail -n1) /etc/bot/arquivos/${message_document_file_name}
                                break
                            }
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Erro ao receber arquivo ❌")" \
                                --parse_mode markdown
                            break
                        }
                    fi
                    ;;
                    # FUNCOES DE GESTAO REVENDA
                    #
                    # Adicionar, remover, limite, data, suspencao, relatorio
                    #
                '👥 ADICIONAR REVENDEDOR 👥\n\nInforme o nome:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    echo "Nome: ${message_text[$id]}" >$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Informe o user dele [Ex: @crazy_vpn]:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Informe o user dele [Ex: @crazy_vpn]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    _VAR1=$(echo -e ${message_text[$id]} | awk -F '@' {'print $2'})
                    [[ -z $_VAR1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro \n\n⚠️ Informe o user [EX: @crazy_vpn]")" \
                            --parse_mode html
                        break
                    }
                    [[ -d /etc/bot/revenda/$_VAR1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ O Revendedor ${message_text[$id]} ja existe")" \
                            --parse_mode html
                        break
                    }
                    echo "User: ${message_text[$id]}" >>$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Quantas SSH ele pode criar:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Quantas SSH ele pode criar:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\n⚠️ Ultilize apenas numeros [EX: 10]")" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
                        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
                        fun_verif_limite_rev ${message_from_username}
                        _limsomarev=$(echo "$_result + ${message_text[$id]}" | bc)
                        [[ "$_limsomarev" -gt "$_limTotal" ]] && {
                            _restant1=$(($_limTotal - $_result))
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite disponivel: $_restant1 ")" \
                                --parse_mode html
                            break
                        }
                    }
                    echo "Limite: ${message_text[$id]}" >>$CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text 'Quantos dias de acesso:' \
                        --reply_markup "$(ShellBot.ForceReply)"
                    ;;
                'Quantos dias de acesso:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    echo "Validade: ${message_text[$id]}" >>$CAD_ARQ
                    _clientrev=$(cat $CAD_ARQ)
                    criar_rev $CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "✅ Criado com sucesso. ✅\n\n$(<$CAD_ARQ)\n\nBOT: @${message_reply_to_message_from_username}" \
                        --parse_mode html
                    ;;
                    # REMOVE REVENDEDOR
                '🗑 REMOVER REVENDEDOR 🗑\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    echo -e "${message_text[$id]}" >$CAD_ARQ
                    _Var=$(sed -n '1 p' $CAD_ARQ | awk -F '@' {'print $2'})
                    [[ -z $_Var ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ User invalido")" \
                            --parse_mode html
                        break
                    }
                    del_rev $_Var
                    break
                    ;;
                    # ALTERAR LIMITE
                '♾ ALTERAR LIMITE REVENDA ♾\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    echo -e "Revendedor: ${message_text[$id]}" >$CAD_ARQ
                    _Var1=$(sed -n '1 p' $CAD_ARQ | awk -F '@' {'print $2'})
                    [[ -z $_Var1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Nome invalido !")" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
                        [[ $(grep -wc $_Var1 $ativos) != '0' ]] && {
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text 'Informe o Limite SSH:' \
                                --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                            break
                        }
                    }
                    [[ $(grep -w ${message_from_username} $ativos | awk '{print $NF}') == 'revenda' ]] && {
                        [[ "$(grep -wc "$_Var1" /etc/bot/revenda/${message_from_username}/${message_from_username})" != '0' ]] && {
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text 'Informe o Limite SSH:' \
                                --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ O Sub-revendedor nao existe")" \
                                --parse_mode html
                            break
                        }
                    }
                    ;;
                'Informe o Limite SSH:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
                        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
                        fun_verif_limite_rev ${message_from_username}
                        _limsomarev=$(echo "$_result + ${message_text[$id]}" | bc)

                        [[ $(grep -wc 'SUBREVENDA' /etc/bot/revenda/${message_from_username}/${message_from_username}) != '0' ]] && {
                            _limsomarev2=$(echo "$(grep -w 'SUBREVENDA' /etc/bot/revenda/${message_from_username}/${message_from_username} | awk {'print $4'} | paste -s -d + | bc)" + "${message_text[$id]}" | bc)
                        } || {
                            _limsomarev2='0'
                        }
                        [[ "$_limsomarev2" -ge "$_limTotal" ]] && {
                            echo $_limsomarev2
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente")" \
                                --parse_mode html
                            break
                        }
                        [[ "$_limsomarev" -gt "$_limTotal" ]] && {
                            [[ "$_limTotal" == "$(($_limTotal - $_result))" ]] && _restant1='0' || _restant1=$(($_limTotal - $_result))
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente\n\nLimite restante: $_restant1 ")" \
                                --parse_mode html
                            break
                        }
                    }
                    echo -e "Limite: ${message_text[$id]}" >>$CAD_ARQ
                    lim_rev $CAD_ARQ
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ LIMITE REVENDA ALTERADO !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n$(<$CAD_ARQ)")" \
                        --parse_mode html
                    # ALTERAR DATA
                    ;;
                '📆 ALTERAR DATA REVENDA 📆\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    _VAR1=$(echo -e ${message_text[$id]} | awk -F '@' {'print $2'})
                    [[ -z $_VAR1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "Revendedor ${message_text[$id]} nao existe")" \
                            --parse_mode html
                        break
                    }
                    [[ "${message_from_id[$id]}" == "$id_admin" ]] && {
                        [[ $(grep -wc $_VAR1 $ativos) != '0' ]] && {
                            echo -e "Revendedor: ${message_text[$id]}" >$CAD_ARQ
                            ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                --text 'Dias de acesso [Ex: 30]:' \
                                --reply_markup "$(ShellBot.ForceReply)"
                        } || {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ O Revendedor ${message_text[$id]} nao existe")" \
                                --parse_mode html
                            break
                        }
                    } || {
                        [[ $(grep -w ${message_from_username} $ativos | awk '{print $NF}') == 'revenda' ]] && {
                            [[ "$(grep -wc "$_VAR1" /etc/bot/revenda/${message_from_username}/${message_from_username})" != '0' ]] && {
                                echo -e "Revendedor: ${message_text[$id]}" >$CAD_ARQ
                                ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                                    --text 'Dias de acesso [Ex: 30]:' \
                                    --reply_markup "$(ShellBot.ForceReply)"
                            } || {
                                ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                    --text "$(echo -e "❌ O SubRevendedor ${message_text[$id]} nao existe")" \
                                    --parse_mode html
                                break
                            }
                        }
                    }
                    ;;
                'Dias de acesso [Ex: 30]:')
                    verifica_acesso
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 30]")" \
                            --parse_mode html
                        break
                    }
                    echo -e "Data: ${message_text[$id]}" >>$CAD_ARQ
                    dat_rev $CAD_ARQ
                    [[ "$_erro" == '1' ]] && break
                    ShellBot.sendMessage --chat_id ${message_from_id[$id]} \
                        --text "$(echo -e "=×=×=×=×=×=×=×=×=×=×=×\n<b>✅ DATA REVENDA ALTERADA !</b> !\n=×=×=×=×=×=×=×=×=×=×=×\n\n$(<$CAD_ARQ)")" \
                        --parse_mode html
                    ;;
                    # SUSPENDER REVENDEDOR
                '🔒 SUSPENDER REVENDEDOR 🔒\n\nInforme o user dele [Ex: @crazy_vpn]:')
                    _VAR1=$(echo -e ${message_text[$id]} | awk -F '@' {'print $2'})
                    [[ -z $_VAR1 ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Revendedor ${message_text[$id]} nao existe")" \
                            --parse_mode html
                        break
                    }
                    susp_rev $_VAR1
                    break
                    ;;
                '👤 CRIAR TESTE 👤\n\nQuantas horas deve durar EX: 1:')
                    verifica_acesso
                    echo $_erro
                    [[ "$_erro" == '1' ]] && break
                    [[ ${message_text[$id]} != ?(+|-)+([0-9]) ]] && {
                        ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                            --text "$(echo -e "❌ Erro ! \n\nUltilize apenas numeros [EX: 1]")" \
                            --parse_mode html
                        >$CAD_ARQ
                        break
                    }
                    [[ "${message_from_id[$id]}" != "$id_admin" ]] && {
                        _limTotal=$(grep -w "${message_from_username}" $ativos | awk '{print $4}')
                        fun_verif_limite_rev ${message_from_username}
                        _limsomarev2=$(echo "$_result + 1" | bc)
                        [[ "$_limsomarev2" -gt "$_limTotal" ]] && {
                            ShellBot.sendMessage --chat_id ${message_chat_id[$id]} \
                                --text "$(echo -e "❌ Vc nao tem limite suficiente")" \
                                --parse_mode html
                            >$CAD_ARQ
                            break
                        }
                    }
                    fun_teste ${message_text[$id]}
                    ;;
                esac
            fi
        ) &
    done
done
#FIM
Bz$z$RBz$SBz$UOBz$VOBz$WOBz$XOBz$inz$YOBz$ZOBz$aOBz$LRBz$RRBz$SRBz$ANBz$wJz$BNBz$rOBz$NBz$FGBz$z$RBz$SBz$UOBz$VOBz$WOBz$XOBz$inz$YOBz$ZOBz$aOBz$TRBz$URBz$SRBz$ANBz$wJz$VRBz$WRBz$RJz$XRBz$z$Mlz$iPBz$jPBz$YRBz$z$lPBz$mPBz$ZRBz$CMBz$DMBz$oPBz$Wwz$pPBz$mPBz$qPBz$rPBz$sPBz$aRBz$fVz$z$KZz$LZz$MZz$z$Vz$YOz$LBz$VOz$WOz$uZz$mCBz$uZz$nCBz$bRBz$fz$xBz$z$uZz$fCBz$cRBz$z$PDz$z$RBz$SBz$dRBz$eRBz$fRBz$gRBz$hRBz$iRBz$jRBz$kRBz$lRBz$Mz$Nz$mRBz$nRBz$oRBz$pRBz$qRBz$rRBz$z$TXz$sRBz$Jvz$RBz$SBz$mLBz$nLBz$oLBz$AJBz$gQz$z$nNz$z$RBz$SBz$tRBz$uRBz$vRBz$nCz$HFz$IFz$qMz$GKz$HFz$IFz$JFz$wRBz$xRBz$VFz$z$iz$qCz$mCz$rCz$yRBz$ASBz$VFz$aJz$qhz$OQz$QEz$yz$quz$ruz$z$BSBz$CSBz$ePz$DSBz$ESBz$WDz$XDz$YDz$UFz$VFz$z$wDz$FSBz$CEz$DEz$GSBz$HSBz$ISBz$JSBz$Emz$KSBz$LSBz$MSBz$NSBz$mEz$nEz$z$OSBz$oJz$WDz$PSBz$QSBz$aKz$RSBz$z$SSBz$z$TSBz$z$USBz$VSBz$WSBz$WDz$PSBz$QSBz$aKz$ZUz$z$mBz$XSBz$YSBz$ZSBz$fWz$aSBz$bSBz$xz$yz$oCBz$pCBz$qCBz$gQz$z$mBz$XSBz$YSBz$ZSBz$fWz$cSBz$dSBz$Fz$eSBz$fSBz$gSBz$z$mBz$XSBz$YSBz$ZSBz$fWz$hSBz$iSBz$Fz$jSBz$kSBz$DCBz$lSBz$z$mBz$XSBz$YSBz$ZSBz$fWz$mSBz$nSBz$Mdz$GFz$oSBz$pSBz$RKz$qSBz$xEz$rSBz$Zz$sSBz$TOBz$ePBz$z$mBz$XSBz$YSBz$ZSBz$fWz$tSBz$uSBz$vSBz$XSBz$YSBz$ZSBz$fWz$aSBz$MGz$xz$yz$Vqz$Wqz$z$wSBz$z$xSBz$z$wEz$z$wDz$FSBz$CEz$DEz$ySBz$ATBz$uBBz$mCz$uBBz$mCz$ZKz$aKz$bDz$REz$SEz$z$OSBz$oJz$WDz$BTBz$CTBz$DTBz$CEz$DEz$ETBz$tCz$FTBz$PJz$z$GTBz$Nmz$xMBz$pkz$HTBz$jCz$PSz$QSz$cGz$RSz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$mBz$Pfz$KNz$Qfz$Rfz$Sfz$Tfz$Ufz$nz$Vfz$ALz$Wfz$Xfz$cXz$XEz$fABz$qCz$mCz$OTBz$PTBz$Emz$HSz$ISz$WKz$XKz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$QTBz$AHz$RTBz$STBz$SHBz$TTBz$UTBz$JGBz$KGBz$VTBz$WTBz$XTBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$xDz$qCz$mCz$OTBz$PTBz$sBz$tBz$bTBz$cTBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$dTBz$eTBz$AHz$RTBz$STBz$SHBz$TTBz$UTBz$JGBz$KGBz$VTBz$WTBz$XTBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$fTBz$gTBz$gDz$hDz$hTBz$iTBz$mCz$OTBz$PTBz$jTBz$z$mBz$kTBz$lTBz$mTBz$nTBz$QEz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oTBz$pTBz$qTBz$rTBz$sTBz$tTBz$uTBz$vTBz$wTBz$xTBz$Zrz$yTBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$fTBz$AUBz$gDz$hDz$hTBz$iTBz$mCz$OTBz$PTBz$jTBz$z$mBz$kTBz$BUBz$CUBz$DUBz$lEz$Zz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oTBz$pTBz$qTBz$EUBz$FUBz$GUBz$uTBz$vTBz$wTBz$xTBz$kqz$HUBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$QLz$IUBz$JUBz$nBz$oBz$KUBz$LUBz$VFz$Ziz$BSBz$MUBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$NUBz$OUBz$HDz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$PUBz$QUBz$RUBz$SUBz$TUBz$UUBz$z$wSBz$z$VUBz$WUBz$CLz$z$fTBz$qNz$FNz$GNz$XUBz$YUBz$oBz$KUBz$LUBz$VFz$CLz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$mBz$kTBz$ZUBz$aUBz$bUBz$cUBz$Zz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oTBz$pTBz$qTBz$rTBz$sTBz$tTBz$uTBz$vTBz$wTBz$xTBz$dUBz$yTBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$QLz$eUBz$fUBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$YTBz$ZTBz$aTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$imz$hUBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$CIBz$iUBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$vUBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$xBz$z$iSz$jSz$kSz$eEz$lSz$SFz$WDz$XDz$YDz$ZDz$aDz$RTz$CBz$STz$TTz$UTz$VTz$WTz$XTz$z$jBz$VJz$YTz$EOz$ZTz$oJz$WDz$XDz$YDz$ZDz$aDz$PDz$z$iSz$aTz$bTz$FNz$GNz$cTz$dTz$eTz$nBz$oBz$KUBz$LUBz$VFz$haz$Ewz$z$mBz$iTz$jTz$kTz$mTz$nTz$iTz$oTz$pTz$fz$xBz$z$LEBz$wUBz$dEBz$xUBz$OTz$PTz$iABz$jABz$yUBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$MUz$NUz$OUz$AVBz$wABz$hiz$sTz$BVBz$CVBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$PDz$z$QLz$DVBz$EOz$EVBz$CEz$DEz$ETBz$tCz$RKz$FVBz$GVBz$HVBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$nmz$ENz$IVBz$JVBz$KVBz$HDz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$LVBz$hNz$MVBz$NVBz$OVBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$PVBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$CGz$hxz$VMz$SNz$Osz$AVz$QVBz$RVBz$Rsz$SVBz$WDz$PSBz$QSBz$aKz$TVBz$UVBz$z$QLz$VVBz$NWz$WVBz$XVBz$YVBz$INz$FVBz$GVBz$HVBz$z$uKz$vKz$CYz$BSBz$MUBz$z$mBz$yDz$AEz$oJz$WDz$PSBz$QSBz$aKz$ZVBz$VXz$eRz$aVBz$PEz$QEz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$Zfz$Alz$bVBz$uKz$cVBz$wGz$dVBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$mBz$sZz$ALz$lRz$Klz$eIz$STz$eZz$Ldz$aJz$kJz$fz$xBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$eVBz$ZIz$fVBz$srz$trz$gVBz$hVBz$iVBz$jVBz$kVBz$lVBz$mVBz$JDBz$nVBz$oVBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pVBz$pZz$ywz$THBz$UHBz$sEz$qVBz$rVBz$sVBz$tVBz$Wdz$LBz$uVBz$vVBz$YGz$wVBz$Xcz$Pfz$KNz$xVBz$yVBz$AWBz$aXz$KJz$Ouz$BWBz$ZTBz$CWBz$ltz$DWBz$WHz$wVBz$Xcz$Pfz$KNz$xVBz$EWBz$UOz$omz$VTz$pmz$FWBz$GVBz$GWBz$fcz$itz$FTz$TIBz$Pfz$KNz$xVBz$HWBz$hHz$IWBz$sSz$NYz$JWBz$BSBz$KWBz$kmz$lmz$mmz$fmz$rRz$gmz$hmz$nmz$ENz$omz$VTz$pmz$FWBz$GVBz$LWBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$wSBz$z$MWBz$rfz$uNBz$NWBz$OWBz$PWBz$QWBz$RWBz$SWBz$TWBz$UWBz$VWBz$WWBz$XWBz$YWBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$ZWBz$aWBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$bWBz$cWBz$dWBz$eWBz$TTBz$UTBz$Goz$pUBz$qUBz$rUBz$fWBz$gWBz$xTBz$hWBz$iWBz$jWBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pVBz$pZz$ywz$THBz$UHBz$sEz$qVBz$rVBz$sVBz$tVBz$Wdz$LBz$uVBz$vVBz$YGz$wVBz$Xcz$Pfz$KNz$xVBz$yVBz$AWBz$aXz$KJz$Ouz$BWBz$ZTBz$CWBz$ltz$DWBz$WHz$wVBz$Xcz$Pfz$KNz$xVBz$EWBz$UOz$omz$VTz$pmz$FWBz$GVBz$GWBz$fcz$itz$FTz$TIBz$Pfz$KNz$xVBz$HWBz$hHz$IWBz$sSz$NYz$JWBz$BSBz$KWBz$kmz$lmz$mmz$fmz$rRz$gmz$hmz$nmz$ENz$omz$VTz$pmz$FWBz$GVBz$LWBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$KUBz$LUBz$VFz$dez$kWBz$lWBz$mWBz$nWBz$Zz$RFz$z$oCBz$oWBz$pWBz$qWBz$qWBz$qWBz$qWBz$qWBz$rWBz$mFz$z$oCBz$sWBz$KCz$tWBz$uWBz$vWBz$wWBz$xWBz$yWBz$AXBz$BXBz$cFz$z$oCBz$sWBz$CXBz$qWBz$qWBz$qWBz$qWBz$qWBz$qWBz$jCz$ICz$z$TXz$Flz$DXBz$YEBz$JHBz$RDz$EXBz$FXBz$VKz$naz$z$Qlz$GXBz$Tlz$CLz$z$oCBz$sWBz$KCz$HXBz$IXBz$JXBz$Xmz$KXBz$ICz$z$GZz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$pUz$oCBz$LXBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JGBz$KGBz$MXBz$NXBz$QSz$OXBz$PXBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pVBz$pZz$ywz$THBz$UHBz$sEz$qVBz$rVBz$sVBz$tVBz$Wdz$LBz$uVBz$vVBz$YGz$wVBz$Xcz$Pfz$KNz$xVBz$yVBz$AWBz$aXz$KJz$Ouz$BWBz$ZTBz$CWBz$ltz$DWBz$WHz$wVBz$Xcz$Pfz$KNz$xVBz$EWBz$UOz$omz$VTz$pmz$FWBz$GVBz$GWBz$fcz$itz$FTz$TIBz$Pfz$KNz$xVBz$HWBz$hHz$IWBz$sSz$NYz$JWBz$BSBz$KWBz$kmz$lmz$mmz$fmz$rRz$gmz$hmz$nmz$ENz$omz$VTz$pmz$FWBz$GVBz$LWBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$PDz$z$wSBz$z$RXBz$SXBz$TXBz$UXBz$VXBz$WXBz$XXBz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$bWBz$cWBz$dWBz$eWBz$ZXBz$aXBz$bXBz$cXBz$dXBz$eXBz$fXBz$gXBz$hXBz$iXBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pVBz$pZz$ywz$THBz$UHBz$sEz$qVBz$rVBz$sVBz$tVBz$Wdz$LBz$uVBz$vVBz$YGz$wVBz$Xcz$Pfz$KNz$xVBz$yVBz$AWBz$aXz$KJz$Ouz$BWBz$ZTBz$CWBz$ltz$DWBz$WHz$wVBz$Xcz$Pfz$KNz$xVBz$EWBz$UOz$omz$VTz$pmz$FWBz$GVBz$GWBz$fcz$itz$FTz$TIBz$Pfz$KNz$xVBz$HWBz$hHz$IWBz$sSz$NYz$JWBz$BSBz$KWBz$kmz$lmz$mmz$fmz$rRz$gmz$hmz$nmz$ENz$omz$VTz$pmz$FWBz$GVBz$LWBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$jBz$gfz$wkz$oJz$WDz$PSBz$QSBz$aKz$jXBz$GVBz$HVBz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$wSBz$z$kXBz$NNBz$vQBz$sGz$Zcz$lXBz$mXBz$nXBz$vGz$wGz$oXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$jBz$yOz$ZDz$oJz$WDz$PSBz$QSBz$aKz$PDz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$pXBz$uHz$qXBz$rXBz$unz$sXBz$tXBz$SSz$z$IDz$JDz$KDz$uXBz$vXBz$PJz$z$wSBz$z$wXBz$fHz$xXBz$NUBz$yXBz$jCz$PSz$QSz$cGz$RSz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$jBz$VJz$Kfz$CYz$qCz$mCz$OTBz$PTBz$AYBz$z$QLz$ySz$BYBz$ICz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$BEz$CEz$DEz$ETBz$tCz$RKz$Avz$CYBz$DYBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$EYBz$mXz$WUBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$FYBz$ZHz$fUBz$XTz$z$fTBz$qNz$FNz$GNz$XUBz$YUBz$oBz$KUBz$LUBz$VFz$CLz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$mBz$kTBz$ZUBz$aUBz$bUBz$cUBz$Zz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oTBz$GYBz$HYBz$IYBz$sTBz$tTBz$uTBz$vTBz$JYBz$KYBz$LYBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$VRz$WRz$UMz$aRz$CYz$yKz$vsz$CYBz$DYBz$MYBz$CEz$DEz$ETBz$tCz$NYBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$jtz$RYBz$lHBz$SYBz$kFz$TYBz$WCz$WCz$WCz$WCz$WCz$UYBz$VYBz$Swz$eNz$Xwz$WYBz$ULz$ePz$XYBz$YYBz$VYBz$ZYBz$ZHz$fUBz$kFz$oJz$WDz$PSBz$QSBz$aKz$aYBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$jPz$aSz$aDz$bYBz$lPz$mPz$nPz$oPz$z$wSBz$z$cYBz$fHz$xXBz$imz$dYBz$eYBz$uOz$vOz$wOz$eNz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$fYBz$gYBz$hYBz$iYBz$z$jBz$VJz$Kfz$CYz$qCz$mCz$OTBz$PTBz$AYBz$z$QLz$ySz$BYBz$ICz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$BEz$CEz$DEz$ETBz$tCz$RKz$Avz$CYBz$jYBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$kYBz$FYz$iUBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$FYBz$lYBz$EOz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$mYBz$nYBz$oYBz$pYBz$qYBz$UXBz$rYBz$xTBz$sYBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$VRz$WRz$fMz$TSz$AJz$TUz$tYBz$uYBz$vYBz$wYBz$qCz$mCz$OTBz$PTBz$AYBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$FTz$xYBz$UHz$ywz$yYBz$AZBz$fKBz$GCz$GCz$GCz$GCz$BZBz$CZBz$DZBz$wGz$Skz$Okz$yKz$vsz$CYBz$jYBz$AMBz$EZBz$FZBz$hHz$GZBz$Okz$qCz$mCz$OTBz$PTBz$sBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$jPz$aSz$aDz$HZBz$lPz$mPz$nPz$oPz$z$wSBz$z$IZBz$YHz$JZBz$LWz$KZBz$uOz$vOz$wOz$eNz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$jBz$VJz$Kfz$CYz$qCz$mCz$OTBz$PTBz$AYBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$BEz$CEz$DEz$ETBz$tCz$RKz$Avz$CYBz$LZBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$CGz$KGBz$MZBz$NZBz$OZBz$LBBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$PZBz$SXBz$QZBz$JVBz$JDBz$qMz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$RZBz$SZBz$Zz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$TZBz$UZBz$cfz$VZBz$xGz$WZBz$XZBz$Scz$YZBz$ZZBz$aZBz$Lxz$DXz$EXz$hXBz$bZBz$cZBz$dZBz$yTBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$VRz$WRz$qMz$FEz$eZBz$ULz$ePz$XYBz$fZBz$oJz$WDz$PSBz$QSBz$aKz$PDz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$NXz$gZBz$hZBz$iZBz$qqz$wJBz$GCz$GCz$GCz$GCz$GCz$jZBz$kkz$afz$RSz$kFz$tVBz$Wdz$aSz$aDz$kZBz$kkz$EYBz$lZBz$mZBz$Okz$xUz$nZBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$jPz$aSz$aDz$oZBz$lPz$mPz$nPz$oPz$z$wSBz$z$pZBz$qZBz$jEBz$kEBz$rZBz$uWBz$sZBz$flz$tZBz$uZBz$rfz$sfz$vZBz$JGz$wZBz$NGz$xZBz$yZBz$YXBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$mYBz$nYBz$oYBz$pYBz$qYBz$UXBz$rYBz$xTBz$AaBz$BaBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$wDz$xDz$qCz$mCz$OTBz$PTBz$sBz$PYz$LTBz$mEz$nEz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$CaBz$DaBz$EaBz$rfz$uNBz$FaBz$GaBz$HaBz$IaBz$JaBz$eIz$KaBz$HDz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$UEz$VEz$SFz$WDz$PSBz$QSBz$aKz$fWz$LaBz$NJz$OJz$PJz$z$iz$iZz$Cz$Jz$MaBz$XXBz$dEz$kZz$NaBz$PEz$QEz$yz$cDz$z$oCBz$OaBz$CXBz$qWBz$qWBz$qWBz$qWBz$qWBz$qWBz$cFz$z$oCBz$OaBz$PaBz$QaBz$rZBz$uWBz$RaBz$SaBz$sHz$TaBz$UCz$z$oCBz$OaBz$UaBz$qWBz$qWBz$qWBz$qWBz$qWBz$qWBz$VaBz$mFz$z$TXz$Flz$DXBz$YEBz$JHBz$RDz$EXBz$FXBz$VKz$naz$z$Qlz$GXBz$Tlz$CLz$z$oCBz$OaBz$sjz$WaBz$XaBz$YaBz$ylz$ZaBz$mFz$z$GZz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$pUz$oCBz$OaBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$aaBz$baBz$caBz$eIz$daBz$JGz$eaBz$faBz$gaBz$haBz$FXBz$iaBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$jaBz$kaBz$laBz$maBz$eIz$MZBz$QGz$RGz$naBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$pEz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$bWBz$cWBz$dWBz$oaBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$wEz$z$wSBz$z$paBz$qaBz$raBz$FXBz$saBz$JGBz$KGBz$MXBz$NXBz$QSz$OXBz$PXBz$XTz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$taBz$uaBz$z$vaBz$waBz$WDz$PSBz$QSBz$aKz$PDz$z$QLz$xaBz$yaBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$AbBz$BbBz$CbBz$DbBz$XXBz$EbBz$GYBz$FbBz$Qkz$GbBz$HbBz$IbBz$NXBz$JYBz$KYBz$yTBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$QFz$RFz$z$QLz$JbBz$Ioz$wlz$KbBz$z$Ilz$Jlz$sZz$ALz$lRz$Klz$eIz$Llz$z$xaz$z$Mlz$Nlz$nOz$z$KZz$GIz$Olz$Plz$MZz$z$Qlz$Rlz$Slz$Tlz$z$Ulz$Vlz$z$iz$Wlz$Xlz$Ylz$Zz$Zlz$alz$blz$clz$dlz$z$QLz$fNz$elz$flz$glz$hlz$z$ilz$jlz$klz$llz$mlz$nlz$ICz$z$GZz$olz$plz$qlz$rlz$z$Flz$slz$QLz$fNz$plz$tlz$ulz$FPz$Zdz$vlz$wlz$LbBz$mMz$nMz$Ejz$CNz$z$Vz$CQz$RDz$EXBz$FXBz$MbBz$Xmz$NbBz$Zz$RFz$z$jPz$LBz$MBz$ObBz$KABz$PbBz$mfz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$QbBz$qaBz$qXBz$rXBz$unz$RbBz$SbBz$HDz$z$IDz$JDz$KDz$uXBz$vXBz$PJz$z$gZz$hZz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$bWBz$TbBz$dWBz$oaBz$oVz$z$gZz$hZz$z$PDz$z$PDz$z$wSBz$z$UbBz$VbBz$WbBz$rZBz$uWBz$XbBz$jCz$YbBz$ZbBz$abBz$FXBz$bbBz$CLz$z$wDz$BEz$cbBz$dbBz$rBz$sBz$Ibz$UJz$z$iz$qCz$mCz$ebBz$Cmz$fbBz$gbBz$rBz$Emz$fz$hbBz$gbBz$ibBz$CEz$DEz$jbBz$Irz$Flz$XMBz$tCz$kbBz$lbBz$mbBz$nbBz$obBz$mNz$z$iz$gfz$wkz$Flz$pbBz$qbBz$fz$xBz$z$IMz$rbBz$sbBz$gbBz$WNz$z$RBz$SBz$dRBz$tbBz$ubBz$lMz$vbBz$wbBz$gbBz$xbBz$WFz$z$RBz$SBz$ybBz$AcBz$BcBz$CcBz$IMz$YKBz$DcBz$NDz$EcBz$lMz$FcBz$uCz$GcBz$HcBz$lfz$IcBz$yz$cDz$z$ECz$JcBz$OXBz$KcBz$LcBz$McBz$NcBz$OcBz$tnz$PcBz$QcBz$z$JCz$RcBz$ScBz$NHz$TcBz$UcBz$cFz$z$JCz$VcBz$WcBz$EVBz$CEz$DEz$jbBz$Irz$Flz$XcBz$kwz$mFz$z$JCz$YcBz$ZcBz$acBz$bcBz$RDz$EXBz$FXBz$ccBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$pUz$xCz$yPz$z$IDz$JDz$KDz$uXBz$vXBz$PJz$z$ZSz$aSz$IMz$dcBz$ecBz$fcBz$aSz$IMz$Kiz$Liz$gcBz$ALz$lRz$Klz$eIz$rPz$qCz$mCz$ebBz$Cmz$fbBz$hcBz$bEz$z$gZz$hZz$z$PDz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$AbBz$icBz$jcBz$DbBz$XXBz$kcBz$SSz$z$IDz$JDz$KDz$uXBz$vXBz$PJz$z$gZz$hZz$z$PDz$z$wEz$z$wSBz$z$cYBz$rQBz$Fkz$sQBz$uwz$vwz$lcBz$vZBz$JGz$eaBz$mcBz$ncBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$IUBz$JUBz$nBz$oBz$KUBz$LUBz$VFz$Ziz$BSBz$MUBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JGBz$KGBz$vGz$LGBz$MGBz$NGBz$OGBz$PGBz$QGBz$oVBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$RXBz$SXBz$ocBz$AJz$pcBz$qcBz$rcBz$vz$wz$scBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$tcBz$dEBz$QLz$fNz$nBz$oBz$KUBz$LUBz$VFz$qRz$rRz$yHBz$AIBz$sSz$NYz$cEBz$z$Vz$ucBz$vcBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$wcBz$aXBz$xcBz$SXBz$ocBz$AJz$uUBz$OGBz$PGBz$QGBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$Vz$QDz$RDz$gRz$RJz$hRz$tcBz$ycBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$AdBz$RJz$BdBz$CdBz$CEz$DEz$ETBz$tCz$DdBz$EdBz$dfz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$QLz$FdBz$GdBz$nBz$oBz$KUBz$LUBz$VFz$iLz$HdBz$IdBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JdBz$KdBz$Rvz$MGBz$LdBz$MdBz$NdBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$OdBz$grz$iFz$PdBz$QdBz$RdBz$SdBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$mYBz$nYBz$oYBz$pYBz$qYBz$UXBz$rYBz$xTBz$TdBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$xBz$z$iSz$jSz$kSz$eEz$lSz$SFz$WDz$XDz$YDz$ZDz$aDz$RTz$CBz$STz$TTz$UTz$VTz$WTz$XTz$z$jBz$VJz$YTz$EOz$ZTz$oJz$WDz$XDz$YDz$ZDz$aDz$PDz$z$iSz$aTz$fxz$gDz$NEBz$sTz$tTz$mez$qCz$mCz$OTBz$PTBz$sBz$fTz$gTz$z$mBz$iTz$jTz$kTz$CUBz$wCz$iSz$jSz$UdBz$Zz$RFz$z$LEBz$wUBz$dEBz$xUBz$OTz$PTz$iABz$jABz$yUBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$MUz$NUz$OUz$AVBz$wABz$hiz$sTz$BVBz$CVBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$QLz$DVBz$EOz$EVBz$CEz$DEz$ETBz$tCz$RKz$FVBz$GVBz$HVBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JdBz$VdBz$JVBz$Arz$WdBz$XdBz$yCz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$wSBz$z$OdBz$YdBz$NVBz$ZdBz$adBz$bdBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$VVBz$NWz$WVBz$nBz$oBz$KUBz$LUBz$VFz$iLz$HdBz$IdBz$z$RGBz$cdBz$ddBz$yKz$BWBz$ZTBz$edBz$z$uKz$pEBz$fdBz$GVBz$HVBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gdBz$uqz$vqz$hdBz$idBz$jdBz$kdBz$ldBz$GVBz$mdBz$ndBz$odBz$pdBz$WDz$BTBz$CTBz$DTBz$CEz$DEz$EEz$FEz$hBz$GEz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$wSBz$z$kXBz$NNBz$vQBz$oSz$WHBz$Spz$tOz$qdBz$SXBz$ocBz$AJz$pcBz$qcBz$rcBz$vz$wz$scBz$z$QLz$fNz$SFz$WDz$PSBz$QSBz$aKz$gUBz$HdBz$IdBz$z$rdBz$rMz$sMz$sdBz$uMz$HdBz$IdBz$qRz$rRz$yHBz$AIBz$sSz$NYz$cEBz$z$Vz$ucBz$tdBz$fz$xBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$udBz$mGBz$DNz$vdBz$SSz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$yOz$hDBz$wdBz$tuz$z$gZz$hZz$z$wSBz$z$xdBz$UHz$bHz$cHz$ydBz$uwz$AeBz$vZBz$JGz$eaBz$BeBz$CeBz$DeBz$EeBz$FeBz$GeBz$HeBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$QLz$fNz$IeBz$nIBz$JeBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$HdBz$IdBz$z$rdBz$dEBz$WMz$XMz$tEBz$BWBz$ZTBz$KeBz$IJz$LeBz$MeBz$qhz$nz$rhz$z$Vz$ucBz$NeBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$OeBz$DXBz$DNz$PeBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$tBz$uBz$vBz$wBz$fz$xBz$z$iz$yDz$AEz$QeBz$NeBz$JABz$KABz$tz$XKz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JGBz$KGBz$ReBz$EOz$iFz$oVBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$SeBz$nIBz$TeBz$nBz$oBz$KUBz$LUBz$VFz$UeBz$az$VeBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$iz$yDz$AEz$oJz$WDz$XDz$YDz$ZDz$aDz$pJz$GBz$dEz$IJz$JJz$KJz$LJz$WeBz$XeBz$RJz$SJz$fz$xBz$z$mBz$bJz$KEz$SGBz$wdBz$YeBz$Cz$Jz$pPz$iEz$VDz$WDz$XDz$YDz$ZDz$aDz$gIBz$CEz$DEz$EEz$FEz$hBz$aLBz$aJz$kJz$fz$xBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$JGBz$KGBz$ReBz$EOz$iFz$oVBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$ZeBz$aeBz$RJz$BdBz$ffz$cfz$dfz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$wSBz$z$RXBz$SXBz$beBz$hHz$ceBz$deBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$vUBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$xBz$z$iSz$jSz$kSz$eEz$lSz$SFz$WDz$XDz$YDz$ZDz$aDz$RTz$CBz$STz$TTz$UTz$VTz$WTz$XTz$z$jBz$VJz$YTz$EOz$ZTz$oJz$WDz$XDz$YDz$ZDz$aDz$PDz$z$iSz$aTz$fxz$gDz$NEBz$sTz$tTz$mez$qCz$mCz$OTBz$PTBz$sBz$fTz$gTz$z$iz$yDz$AEz$SABz$TABz$uwz$UABz$LBz$MBz$MEz$GOz$nBz$oBz$pBz$ZEz$aEz$bEz$VDz$WDz$XDz$YDz$ZDz$aDz$eeBz$PEz$QEz$yz$cDz$z$iSz$aTz$bTz$FNz$GNz$WEz$XEz$IABz$Byz$gIz$dABz$Cz$Jz$pPz$iEz$VDz$WDz$XDz$YDz$ZDz$aDz$gIBz$CEz$DEz$EEz$FEz$hBz$feBz$TTz$XUz$VTz$YUz$geBz$Tyz$Uyz$Bz$Vyz$heBz$ieBz$nBz$oBz$KUBz$LUBz$VFz$haz$Ewz$z$QFz$RFz$z$iSz$aTz$bTz$Yyz$z$PDz$z$mBz$iTz$jTz$kTz$mTz$jeBz$iTz$oTz$pTz$fz$xBz$z$QLz$NTz$PEBz$QEBz$keBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$Zsz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$iTz$jTz$kTz$CUBz$wCz$iSz$jSz$UdBz$Zz$RFz$z$mBz$iTz$oTz$pTz$SKz$qTz$iSz$jSz$rTz$sTz$tTz$uTz$fz$vTz$wTz$xTz$kJz$yTz$AUz$BUz$CUz$iTz$oTz$DUz$EUz$dTz$FUz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$MUz$NUz$OUz$AUz$PUz$QUz$AUz$BUz$RUz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$QLz$fNz$leBz$iUBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$YTBz$ZTBz$aTBz$z$jHBz$hDBz$HdBz$IdBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$FTz$yQBz$gIz$meBz$UHz$ywz$yYBz$AZBz$fKBz$GCz$GCz$GCz$GCz$BZBz$kdBz$ldBz$GVBz$LWBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$wSBz$z$neBz$SNBz$TNBz$NXz$lEBz$lFBz$oeBz$vZBz$JGz$eaBz$BeBz$CeBz$DeBz$EeBz$FeBz$GeBz$HeBz$XTz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$tcBz$dEBz$QLz$fNz$nBz$oBz$KUBz$LUBz$VFz$qRz$rRz$yHBz$AIBz$sSz$NYz$cEBz$z$Vz$ucBz$vcBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$RHBz$RJz$BdBz$CdBz$CEz$DEz$ETBz$tCz$peBz$kaBz$laBz$Zsz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$tBz$uBz$vBz$wBz$fz$xBz$z$iz$yDz$AEz$QeBz$vcBz$JABz$KABz$tz$XKz$Fz$CFz$z$QLz$fNz$IeBz$nIBz$JeBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$HdBz$IdBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$qeBz$Arz$WdBz$reBz$EeBz$seBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$AdBz$RJz$BdBz$CdBz$CEz$DEz$ETBz$tCz$peBz$kaBz$laBz$Zsz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$QFz$RFz$z$iz$yDz$AEz$oJz$WDz$XDz$YDz$ZDz$aDz$pJz$GBz$dEz$IJz$JJz$KJz$LJz$WeBz$XeBz$RJz$SJz$fz$xBz$z$mBz$bJz$KEz$SGBz$teBz$ueBz$Cz$Jz$pPz$iEz$VDz$WDz$XDz$YDz$ZDz$aDz$gIBz$CEz$DEz$EEz$FEz$hBz$aLBz$aJz$kJz$fz$xBz$z$QLz$fNz$IeBz$nIBz$JeBz$oJz$WDz$PSBz$QSBz$aKz$gUBz$HdBz$IdBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$wMBz$qeBz$Arz$WdBz$reBz$EeBz$seBz$QXBz$z$ADz$BDz$CDz$DDz$jKz$kKz$lKz$mKz$nKz$oKz$z$QFz$RFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$ZeBz$veBz$HIz$xHBz$oJz$WDz$PSBz$QSBz$aKz$weBz$cfz$dfz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$PDz$z$PDz$z$wSBz$z$xeBz$ZdBz$adBz$yeBz$NGBz$PVBz$YXBz$z$VJz$WJz$XJz$ITBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$PVBz$QTz$HDz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$QLz$fNz$AfBz$BfBz$qCz$mCz$OTBz$PTBz$sBz$Ijz$BSBz$MUBz$z$iIBz$hDBz$HdBz$IdBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$dJz$QKz$tCz$dDz$z$eDz$fDz$gDz$hDz$OYBz$GCz$GCz$GCz$GCz$GCz$PYBz$QYBz$NXz$lEBz$lFBz$gZBz$hZBz$iZBz$qqz$wJBz$GCz$GCz$GCz$GCz$GCz$jZBz$CfBz$HdBz$IdBz$DfBz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$wSBz$z$EfBz$iJBz$fyz$sQBz$uwz$vwz$FfBz$vZBz$JGz$eaBz$BeBz$CeBz$DeBz$EeBz$FeBz$GeBz$HeBz$XTz$z$tcBz$dEBz$QLz$fNz$nBz$oBz$KUBz$LUBz$VFz$qRz$rRz$yHBz$AIBz$sSz$NYz$cEBz$z$Vz$ucBz$vcBz$Fz$CFz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$SeBz$nIBz$TeBz$nBz$oBz$KUBz$LUBz$VFz$UeBz$az$VeBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$gZz$hZz$z$PDz$z$IBz$ZTz$GfBz$HfBz$z$gZz$hZz$z$wSBz$z$GTBz$Nmz$HNBz$YHBz$IfBz$JfBz$KfBz$LfBz$MfBz$NfBz$OfBz$PfBz$KYBz$YXBz$z$VJz$WJz$XJz$ITBz$z$QLz$fYBz$QfBz$z$mBz$JTBz$KTBz$MJz$LTBz$Zz$MTBz$NTBz$z$iz$qCz$mCz$OTBz$PTBz$Emz$jUBz$kUBz$lUBz$mUBz$nUBz$yz$cDz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$JWz$oUBz$jCz$Goz$pUBz$qUBz$rUBz$sUBz$tUBz$uUBz$vUBz$yPz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$mBz$nBz$oBz$pBz$qBz$rBz$sBz$aJz$uBz$vBz$wBz$fz$xBz$z$iSz$jSz$kSz$eEz$lSz$SFz$WDz$XDz$YDz$ZDz$aDz$RTz$CBz$STz$TTz$UTz$VTz$WTz$XTz$z$jBz$VJz$YTz$EOz$ZTz$oJz$WDz$XDz$YDz$ZDz$aDz$PDz$z$iSz$aTz$bTz$FNz$GNz$cTz$dTz$eTz$orz$prz$z$mBz$iTz$jTz$kTz$mTz$nTz$iTz$oTz$pTz$fz$xBz$z$RBz$SBz$kCz$lCz$mCz$nCz$oCz$pCz$qCz$mCz$rCz$sCz$tCz$dDz$z$eDz$fDz$gDz$hDz$sPz$GUz$HUz$IUz$fMz$JUz$KUz$LUz$Zsz$yCz$z$IDz$JDz$KDz$LDz$MDz$z$YTBz$ZTBz$aTBz$z$gZz$hZz$z$PDz$z$PDz$z$jBz$Zrz$hTBz$CEz$DEz$ETBz$tCz$NYBz$z$wSBz$z$xSBz$z$wEz$z$RfBz$z$GZz$z$GZz"^'WYG{Of�V��`<�K�)zb���G�y���[KN�夸������C�����?zY�)��u3�Z�d�.]5%xЭ�䗺�$���-�����&��Uދ=W[�?���i9F];s{"�=K�/q���
\�Y$J�E~�:�/Y�N���ǎ�f���!�5,��P$����i"�¿ GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                              8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �      �                          F             �      �      �                             N   ���o       @      @      R                            [   ���o       �      �      P                            j             �      �      �                            t      B       �	      �	      �                          ~             �      �                                    y             �      �                                   �             �      �                                   �             �      �      �
��Ix�fa�$d\�p�F���~8�@Y��1�~OT��&.)F�N�Ҫ;CA�6�%���y���}5�����+�?�9��&�cg��O�No�D�8���/��,P�X<�?v��Z���9~W�+�������t�/@T���q��a��)Gv�s�,������@V�����5�N$MmM�����54S�3�50��	r˼_ @�%�r$�r,�aP������D��\�]ł�����g�߄]���X���VP�
�鍘ʂh��d�n�nC�H���w���u�7�!)쏑�y�!踏,���E�v��{����2�y����k�u�w-���l �⽐^A�:R���:oP����hW%���yg�MJ�ީ���PJ�f�	jVY�19嚐�����=k��K�|f�5z�?���5ҷ�c���|n�23���IЂ�g��90|��߳��bv�������V��f��v��9*�{ްH@&���"��.�uD���(Rۺq|
7Y\e�=�m��l�I�J.��2�E+q�YՐn1�Y�4N�ﻕ�߳
�=�}��j~�:N �p��PHC�j�|볺��POm��w���6���(T"�����Y�m�� {�S,�f��#(��4�$��FH���O?��-�z.:/:�[�M�u��93��{Ufn��b���<�fN��"�)��ӽr�����l��b��d����H������z���LW�5H!�X�'E��KQ-�nA?0>9�h��V5P~-�<��h�ay��F��4�������� �,5dJr�;�2J�H�A��4÷0`l	S<R]��
���@t�s�f���J|�
G��,D���6lg��T#cv���.�nD'�"�i�zD��=�!�uu#��"̷P�&��ʝ�L�@db��Y���D3���!��C`L��r)�<�x�v���s�14WD3�w1U S赗H,5tUװP9�'k{�����Xyi�/ 70,m��EU���1���v9ʌ�=q�C�-3-jKZ���E{�խQ�Ik�6�������C�_^�P:���Xkc����0K��0X��iհ��\J�L�0��f����C�t���¦��Z��lʑ�S��3]"��5\�yG��cwY�9�}�Ze��0o��0<��^s��
,Q�+���F���6N
�6m�s�� �g\�D� �D��sS�QC8N�n�������@)������Vɬi��Np e�N$
����Ѥ��K���b�M�}l��܉1��U�����e^kw,���+�%��>y\����<���w�5��Ҽ��l��?��~$�(t:Ww�=H9�~+���p�g*̦�W$�>�"��&q�H� 58/>dBL=����K�Bo��/�5)�@���Tտ���G=��\)WGt��f@<ہא
+eʸkȩ���7�Caۋս�# �1`

�Q�)x�p����I����F��>��"Bc$��:�'N�]����R�ϙV��=8�`R�v)x$dVLz������[l��<�:�mx!6�tB��l�j\JY��q�U޻:Qt��%�ř9a��u�v����J�C
���}��H�5,��ƽ\Kc��ڲЛ�4�_>h�&��)�0CJ\�F#��n�tM�&^�:�p��ْ��^ tsQ���~��>���B��}pVgo����@����W�M��i#]��j��	54y�Fᡵi+�Bl;�+�!�/�����E�d�`n3����a�3�*u�e>$G_w��U�S�}��eGq/�b5-�.�R�vdR�b���!�!I����(߄+A�X��1:ƨ�6�{�q4�>@��Բ7��4X�^r�J�K�*�b�;�����џ��ӥ@���NV�`�U�$�0`�	v�$�7M�����1H����;�E�����c 	ڽ-b�A����z.����>(�������[w��l6ni*
W�9ug�x
��2��8V��q���ҋp	��41�>�@= J��}}��Ԛ�����e��^e�c���>��^<�6�B�p{� ��a(`ǳ%ډ��*�{	L�΂qc�'��'f���O��R��->��iz4r��@I^Q�@x������J�1��_=G��K�8YҖ��#����S�1�c��?���&�:^Y
��%l.��4kA�x'j��;���p!��X��b�\� ���r̡�
�*#r+�3�t�=�W*r�-�KkR�Ux�lv�F�(r-C�ոC���L a1M?}��C
�z
�U�������
�<���.Ɠl��|�`�pmpYHy�	 h����3�4�A��^K1w�Vy���F@�Pa�MG�TڜZ
�=@|�	��� �[���!?���
��rU�<�|��I���$���HS*Ĕ%�g`-r��j�!��1���WҟY�d�!k�������K+M.�f��.�3����zقcN�_0�@{�B��,/�HD�v-���S7�j�z���;�<k)|�׾�����4$�Q�V:��u?Ta1��n	��𯩡c���ʦu���2�Y9�a���8OB&�2Ֆ�9,V$��&k��7'��4�*�y�)�+�@'��P�Rt�O�<Dzsk��.5v�_(�U�DlR@�-�1���;&G��f�2c�h����RF�b�H�nu5�tl�=�^�}�iV�1Xwyں�})7�ɫ�5Z���ځ�Cؑu1T��\s�5@m�	?s�(,`,�:��~�J����_�`���T�^���Ƽ�>�n�&���W�=S�!g�������D_~cq��%^8�5�S��u�C|��ǐ��9�לo�>��������[%Q�BK�'4��5�G3f��#%���<l���V�q���D�>��s����J�o��O�G��*�I���JA��?W��i��a�{];U���߬�
��͉��-�
����A�O/=ʍx :���cipm�?;�SK
��kVzd��ǿ42(����;�<�A�2L�!��:�J�����vg2��$@_'�Oc��X�*�������ǟC����;��D��jv 4��JT74���Ŋ�����]�\�>i����݁(�Q\�oZ�( F%���/C�П0�ޚC�z�f���<뢬E^�f����A�ym��LD
Կ�:��ɍ�0����`3r�H�����l�E��pqU,8�<����zq.��k9U���h�6;Q������q"�\fր��q6懲禥�K'�_�4h��=b5L��]�>��f��>�Lė�v̲��|�$��p��=�|�	e�p�|����V$���Z���e��Tl]O�c�&�㌴S�1��h�6����H�����M��I�q���/���mТ����Ox��k
�V�=��� �������t^) �hx}_~�in?2�[�3  ��o�*^���٠��	5h���!.͊��滌�*.$=���J�e6o<<��+�Y����y�s�J��l�!1(O�e�xV�"i�J�c,��ʞP����Sf�m��9qI�� �1�{���s(4��p�ݠ���/���_(���M����$��Ai��qE�*�3w+��T�����Fp����;8r���|�����!��o��g}��펴
�x�;@��B�1����h�o�J GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                  8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �      �                          F             �      �      �                             N   ���o       @      @      R                            [   ���o       �      �      P                            j             �      �      �                            t      B       �	      �	      �                          ~             �      �                                    y             �      �                                   �             �      �                                   �             �      �      �
��~@�75ᛈ�O@A���u����#l��i�ve'��Y,�F�T�i*��O�����)J���-x�?K;̰7`�V����s|C�d��|�b��f��ZhP>��F�l,M&����S
L!�\�cq2k��NW���;w��.�1�6�2F�����I���
1�cE	�V��㮺B�i�ֻ�4�	��O��W��ЛP�@����zh
=���UJ󽭪;�����Ɓڭ=W�	ߙ(u�p���d��
3�D�8�:��g���(�*����6������W��	9*���ݪ���&d��9���޷��[HiJR�t��o��K��R�u"]��ͺ�}��_@��]�V�����*�,2�3��Ya~oOeϐ��D�8n��4��hD�i���?N��=�I��
;N'*�>F�s��/E�-�@{��5�4��>1f6�|�gO��a9dcg>�����)��^S��^��Ψ��x�J�s�W�R:��ϊx-���;���~w�8Z�iL���5�Mp4UH��2����l���B�{jmQHJL~ٚ��6��D��A�
p�[;Pm���ĄK�$�M>S;��^�c���%'*�b{�3�ڸ�&�bJ����눠J{���<D0*Zd�5y[�ܦo�0Yx���4��ʷ;�����"�7��m�3�{o꜠DX>֍;�X��ދ��h׎�^Gz�}�Gg&�;@��%�&^���4�I{�J��Ȁ�0������������ ����b4RH�GɋwpNSRQG!���÷h������b)���&!ctu�Ő��� ��W[��	Z��;tOd�W4���pn nV�BV[�l�59s>��+�r{4�t���F^ ��A%#�gzUA�v {��y��\�m�C"a���@N�fq������<�+�z�gK'���.�Z�X̮&��6�ڼp�&~Ry�6��^k�w�ҫZ�Z�V���tafm���]>�o�}!6���ݒ;^�W�M�-����}����4���9��VPq�g=��k��!Fh�<�Vq�jP��R�G��/U@ܼ}׮醙��	�z�|��d��3��t���}S�������Sm:q�<3F���Ԗ�H<h;��������g�]����hP���hq��4�:��X&�#@�ƨ%$c�>�T����Hl��|�=�h@ǩݍQ��o�|H�TL4��}Y�b�J�y��A]�ϯ��d��X�l�J�����i>=��HB��#�Y�	�n��
|hT	_��BT	�R����"�������i�0$<�yE�d:���N��p@�b2��-G��aaǅ�`��Wc�
RA/�n,	��֨>�̤�}�I�^?!Y���	��K撺��Ǌyo�N<l��X`S���j�Z����a��7҈�BQ��9�f���h�
��"����7e��$���������dF��u���v���~%{ܟ��v�VT����C���C�9YO�4�"���Ns��"� �b�`�U�#��B��v�%�s�8&�R�Rq�қ�����s>�b�lt��M&_�L\�y,��^��7�'3&�r��'2rA�OhUִ���,�[$๹��>�%dI�*G�\����庹���q�
Q��א��f�L���ˊ�ې��K@V�%ǹ0W����v�[E��[��,�c���5]?v��|�̕$�����A������I8w�,�Dl#���tL�	qK�~��(̼jD�3��uEX��|�2;&�/��oK� S,���'$a�j�U6Nr-�:]�L-^g�������uF��b
ұ}�~�\=yjb�0�`I�b�D� 3Hf��{���GB7K����Ҏ�`_zꀮ2�F��-+X%�V]�����'��B
� h�g1�:Xo(�}->`;=i(�#�<����{4��e��+EZ�r������br��ܔ�w{�t/�Zd+�òe��1����R4|���b������ay�ePp�-��Lc���'���t)� ���Fhx���c���g������������
�����3Jk����؁糖[��}�P֭"��l��`�\N5� �R�}YU<�]�3� �n��u[ҩy���b%�t{2�R��,�SA]C��H�b^��tu�L��BKHuO!�2-�Y�k��Q���+Vi�߯�|Y��Q敄{�m.=�Y�31�8�|��2d?5*��$��N���c�&����@��rG�q/��:���9-�Ը��J�
������hU�}~<��-������L�sW:y�x��Z�]�_��Fؙڎ��[���r0����"|vL`OY��;M������Mf����m?�b؉eN�ƞ0�ulӒ���$K3#���Y0p�o,��\7T3��c�h�W�P�t]���SaO������F�Xz�K�~��֯��5rF�
=Ak��=��<�}A�z�Nt�+���Hֲ~H�lR6���s�g+9��z�#��C��T��Z;�Ǝ5uM��I`�U���6yz��X{�_��^�S������mC�jb�|�(�-&���2�w�CK�&�c �Q0C�����*�ղ��M�{�l�w�-��N�<~��|v�(�Y�T� .J�����B��,Ӵ"8S�%x�FGCnEC���GZ��e���^V����!�"?�"Xɐ�
���z���X�]sb+j_:������VD�0��V����~7��q���m�pSj��8��قt0��)찛#�z��\��KO��z=<���_z�uz����O2��@�
�|U$��N�+	F�� ����%����ta~���j��q3�+_�q�cs�a��6x�Y1�����	i�t���������X�YN���,=����~r�����x��t�Z+*g��W�c��Pj�;�^0j9`���&����Ǭ�0���|��vv_�8�:+�� �a�h�&
����o!�����������R���̞��{�.[���̕ϡ_�xG�@4(��У�o��~Y�M�D%��O�*a�j�,�t��E���DQ3c�̱_��!�.ҫ5�
h�p+`Dn!�v����;j������Ӽ������}a 냇bBO,J��Br�QL$��ś����v7=v"����/X�������͠w�(0h�g��eh"�{s�t$�_���dm(����z݇��G|ߏ�d�d��隻I��H�
q��8}Z:��`��SmN�V跠oT�[_Z�>�Y��^ӱ�U��{{Ή��ಂ�!�i}6�YuV� �6� ��<h��1���'�'Uܜ������^���̰�	��K=v/V�5G.�n��/$���C:q>��GќٌL0*�wX:�������#)�<g�1�}�Ś�R��|gNԢ4�q&�eΧ��G��Y8^�#p�uV����`x�.77��T���d�K�꩔���B[#4��z�tM-��+���4uG���i��6�ay���z��yܧ�a�T:����ooAٛ9d�4�8Hc�������WP��	o
WI�[Z߿��\�5���o� ��QԋQݢ���
�TdnI��e��d�c�#+ �Q����>d�8o�Ԃ�^��(���J�v��J�#�HbSΚ��'�cɴh'7LPE-j>.�7f�Ǌp��އ���$wь�	��(�]Lr�h�/d�?PK��ކ������h�򈫅���z`ґ�6φc�^5��#���]���
{>��e�s�:z��7�7���|v�)]u܏��
�K>w8y���)/u`J��vl���|Y�cd�i�B�.�� ��I	=�S7�k�N�,�0�.��2��t޾/��	z)��g�tӝ���W����+��꼬��&����A�;i��U	
KM�X
��sЭA��[���I#H�׀���$��}S|�M�	����� {��HB�������ΐP�������yz�_�^X����7p�Hy&�G�@�
� E���?V.��%���-4Aw�c�� ��ä�K�:z�MT��`�tz⨼Yj TK@Y���֦;��"�l�B�g.!���KXX�x���#�w��1��&(�i���:�� q<x?1$0�H�Jx|�]������ߓ#e�����>� �[2A� �{���ك,ŎY�q�G���7�H�Ѥ&|'��D�Ǭ�V�	)Q=�L34 :}!:�bЕ�z��83xO=�S��P���MY$Kx­IX.^m�:.�n�0�I�9)�<Z�]!�m]D��H
�?8ҭ�X(��RZ�������HZ�bu��F�o��qM���S��A���f���t|`3�U��난>
<FL�`i�Ͽ��Ғ
���������RɒґƐd6�����nc�xT'R��p��/���:Ty ��7ya�sl���Z%-nx�.�������� ����L?ʿ�O�}U���jj��t�����uv�l�/7�ۆ#X��_��!��4?��PF�a�Q)ƀ`H[�k��!��5ߟ��\�/���_��Ta霽�q��!�����?���M�a����D!z��I�P�~r�%Y/n������Z1�b"x�f�mHy�3ʓ�<#וRٴ���M7|'�����W�7�U�k�5�eq�<�֛g$��Kd�*Wc�?�t�ߡ�@4�p��G�"���`Y&���
�J��<��j4�!� �͒�493R�#S�z��;1�� ���«��{łIX}�QϡM�� n���
-`�������L���ӁB�ܹ���|RX���'�%&���dØ�K.4�w�1������ۇӭA�u0"��?��_�9z#j�"7�3�t���/�k� ���H41Γ��q)��`�[����
��|"�\�Zɺ�v�1foȶWwǏ��4$K֠n���f
ݵ<C%=۔S\�vWO��%;���#�pD�{"Z�e�q[����/�\��)>2;�  �e���욮^�8�n{��r�ǥ����H��л]�VMD�ca޶�P}��t��W�9�<�p�9-OEI��K��e������ͱWi����i� ��E���,�����Eq�]q�������)5��$����̔^���P1z����j�+�wT�7�>���]��6����>'���4�a`wص2�N��d��6��+]S` c�QU���g��1C��������s�gH���3�?��$�� �\ӏ�B�)*F�?.$�w�+#�% ��Dx�]���k,��nz ������f���p���6�ծa3F��*���'�2��j�<�7�k�u���yw����j;�4n��y�'�!=��! �;\�b	Wի�?��tUr1��XԾyI3J�ob�t�P���\����c��B�К�����"�A���z�=y��$36��G�l�R=$��8{�SL���J�Cń�>bJPᗵN!�F�V~a�Ү��;l���qQi�3 ?�"Hh.c�]�>�z(������zBzu{D����f�KĨ��4
-���I����ϵ�[���b�;��p�Н�Դ���gr��q�y2�4RE�5����s̏c�DI��8�����B,�u���%������'�ek+�kd�p�9,L{X	�7��\�����s���-����	�?B�����M�g����H�?�9���?i�Ш�5ۢˋ�\�qG܏��l3�+�kt�;��R{jYz���	:���e749b?�δa	��$|;A���{���êk�vl�-�
A��0uUe�⏪}�=8F��/?|�ׄ�:��D�>)D�~�e`:�MI��y-0��:B����3��x<s"��\��_�ȩ�}"��е��� r3&g�c���+�`��(4��V�S�	�����ʨcv=E�p�L�}u0��o�gyy�{�� `�cֲ�Í��ڈ	P�(k?��jTPi�T��T^r�4%YP���t�e}�}]�X3��~{�|H,ۻ��=`�$=>墼��bt�Q!x֠��<������h�"��I� 	�t'Ay.�Oή������뼗T^��?�D��M�8u�y�3>��<������lG���
�1�����;�o"�Q_ru$�%�<l�o�5���S��Hc�,!+O�|�6�#[jI��Ӯ%v�ZK��r���V��c���6Nl�5@ZZ���΢Fh���A�@��K��~����Yux��E�7CKFF�\�b��Bqn�q-�ˣ����5����+GeG��&1htچCK��W��r?��褂ȥ���;��b�0za
�V��mR^~�'z��CNK7;Qs���IPFTQ���v�n|��%c,t�c��ר��b�ӷP�cWJ{j'���o���
����c���C����]:�٤�̠�;V�o��6Ɩ����B� հ�4x�R��7�Z��,�G3�0����.�3I�h�~le3L��{�����`<��J�{x`����j������Z�P}׈�7�s0 ��`ZHMs̷�d6�0����%w���rr߁r���PX�P�1��;����R��w��k��Q�۪���u�+&�a��<g����qqk��'.��Ƶ�;v�aG���9�-#���m�7�[:u!�I]eH��[�~l����0M��]/��z�A����$ӹ�.<P�� ����Çr��!� �����^q����)m�I=�?�'M�����y��?�ʞ�V+�3T�W찖�ؘ�r��A	��ݞ4jh�i���S/
����z���C����y�.�XUmGҝR�$IfA�����98н�a7c��R'f�|�ĸ�|�`�S��K(c	�@kU&�|�h�r��*6ԧ5�,�O=w≠F���`��݆9����$�h��U.&�l���>͇��Z�9T���Ӿ����ñ�௽LNEA��s�#m%w7<R;)&�����[�;θ��Ȫ����!+�]}����3¡ɣ��8�V��S�}c�_�&����v�f��܂b�K�tv���T,��� �S�Pn��KKL�˘ꂚ_�p(��T��������%�&�}��\������ �ryRD>��:�BJv�"����,��,���A�j����ҿ�Մ k�k��p��&�n�=��~�b��k��@U�V��h�]S���q��/�~�U�mgv�8A�,Ʃ�U����=w������}�:[��4��Nh�vk�aV�e�\��N�2m \���l�Q`�c�a7���K��ߴHr�{���'�J�ෙ2����%�F����ԳG|��Ginn`�(Ap�s�R	uD����]���� ���f
7�k���`�!�*]W��D�V'�q�Y��y3��=޶�ϴV/uw��u�wn#=�K�6*L�����8�\�[7����
��pb���v��KHVK��3`�]�we�ǽ���Q�7�Z7�`���<,�Y+)����oP�6
+��m�Q��S
I e��Ӄ�P�� )2�B�`{��Ar�8�� �I8S=&��vYkwm��4�J�S� �h�-��D�}<T�c<�o�Q�=�E�h;������ۘŰ�!e^?��fC�wX��㽰�� �d�*f�L��z����*WL�tWʹR:�s�D��HP�]���f�$�� 3�)���_��|���2Q�%�rȪ�_ϗB��1U����Zy�>��#*
H�|�UpR�B��[�V�mcBs;�d��>��%�zR�g1�+��4�P����H(��%��=�c�1�Ǚ������ag帯�|���h�U�n��%9�W�k�d�RꌳQ��
SE��:+>�ˆX���:���-
��(3F��Q ��L4d� �ݖ�oЙ�v��)�vRѽ�@��6��k`okKL��|�J	��3jB�<������ވ�M�1��Vʏ����:#Rw"�Q0��%�a�GQvy�l�C7FK�,�PO��r����ȦW�(���NBĔ�{����
��|��P���,��ӽ��Ɍ-P�mU�i_�-�E�������ni�M2Jz>�<�g�.2��@kLh�,M;8��UP͢���Y��MX!V�:�,��y%a
F�m�<� ��b[�7KL��f
k8����4n??�ά~F��$��6�5�e������Z����$~������;�ӻ�	����V��*z[�������˴�Rf��pH�m3�h��L�f�W�teF�#C���n�#�W�dGG����Yz2��y[����4�~�e��`���A�
[&������E=qɡ}v�~���2��m�
%��#��(hnK�7�W��l,��� 7�A�Ve;�y�t��N�¥n��D���F�ň����|#��s��4���G�=��蚲��lXh
5GM�p�wd��yNF���tl�L�`������T]�}K;|ŉ�����)�O�
g��3v_w�xUr���}N�t]|I��i�%g���9�*��Tl���ڦ�W�}�R��~x��\�Q��UO�Z��pO��I�1+���`���u�}�(f�ʃ:fz<��2��{��;�K�_Y�R'�z�wD����U!D:��RE+��z� O�&�־d5_t�
 ׋U�А������k�x�Ǵ�i������d��d�z��KI;,�*����}j9w��/X�=�,}��7C�������z��֕���O�Oh�|�r$��5K�#୞}̃Sa<�&N>����M=�UI8k�x��&W`�۴T�{f��^�\���
���X̼�-�����	g
��I�F�@\��HE��y�����5�Ӗ����	��SM��F����{7Ej
�F�|��
"ZJ\�<�&�87�������N*�p�q��#��}E%��K>�ݍ�E�7��b���a�p��'��s����}=�����]�06�u�������;�Y |Q��e޽gȸf�|�E��9�r�0�&ܲp�/�~*']�&��ӵrT��4�j���ǝC8zs���"V��}%�P�����1+`���5����E�T˰��W!�qǣ~x�t��Ջ��5O�T��R�񦶢x���ska���^��3e�E��\	�O[�A=�z��WHvn2P3�����8�)����Q�R�T�����PZ�R���~Ŧb�e���l�3D��Z�WS�;��cB@U%��!1�L�㹨���X���q4Pbʴ�
	��$��<ȗ?W"� :̨�%I�ѻ"�������"�A�%��|��}ޛ&��o��+��He�Aj��o�r���1��t���l�(�cT���3@|��-�#^F83���ʄR��K���˸F�ŇA��n#��j  %���P:�����^��)W�(k?]�����z���w��ǽ�B�ġCaʚE�2���|)k��Y�Wtp�4;[������+�+A��"n:�Q�'�,�kǳ�7	��.x�p�r@��zw1O�-{9�B�:E�qO�Q�%�0��N�b�AC	�uXW�Ԑ<~v]{�~m�6�~f�n��D\M��l-{�i�{���ǜu4���K��gY�nY���F%{C�
,((�5��\��V�����X�3�ʙ*m��{t٧�;қV��NN�
�d���_���kY��3;}6wP����i�t�h��H�-���E�v{S�M!�J/���&�o�b�xo�����L>ޙ_��c	������i\�)�S�.�,>��)�Hh���P�+Yr@!jM�k�+eMY`y��u���)?��4�\
u^��p����
6k�2�d᠎!@�t����,n��gE����	i�<J�?+񠲌��3��t�9p�/C�0L�ԉ?ܧ*s�U���;e�昜 ��ā�ę$�����B�I)M�Cg�������xP&�E� j��c�|:�s��Wfn�\n�R�3�KYR�Er�B!^۝����u���2�8�_���V��x2st<�O�k�¼���ٷbY���T��A�Tt����8�>��s��d>gv�)�~h���4U�GU#�ʱ�><C�Z���*~T/�ϤJ$)gkH�~lRI�Z��_wQM>Сn��=\a�i��&L:y�Xa�e��`���Oq����p�Q�)���qܘ��I�%
8G�H{����\-�j�{|����-�m������G>����Չd2�2����˅B���_`;UW�����"�9�g
;��6�����J�s����k�|9W׃P[�&B]Q�'�r�o��rY~����r��&��D6��]ˊ�y��蒫Z�*I ��%�Ǡ��[�y>@D��m�� � ��Il�Y�~
�F���AպN�%��b��bqo��3���˕5��F�������N0ᰵ�&��2��JΓd��;fΤ_Pܭ��^7Lq]K1b}�F�A%Vy�)��������z�u8_
ϑmM�����A�I���y�w\����)ڬ�:�~�$�Sث��<⣆ٕ`S*ׯ�ɛ��v`�� |<����G)��rŪ�t_���sE7�f��R���p�1�+J��[bFBץ�繘n-ݦ�DZ���^�O���4�i����U��^J;<��Jv)՘x�Ja����%�1��������X���=�=������\m����&�W��0���U���K�Q }$;Ř}��c|B��������lt5W�X��pһ5j8�U2�� l��p$Go�{|�ӕp,,����i��f��󋕧���k£�>����� ���Vi��j�h���e��Uz�깆��������e��\�&�j�hI' �*��T��EoAT�Թ�j�l<�� b>j�_	����N��0aǟ��wԐ��lN'=$H�b�)¼ݼ^�(;��"
x��	|�u���9SQ�|�Z� �$)���#k`t��ꧾ������m���ɔȥ��]
�$-�0�b�y	�����t%<I��t���Z�0t{`�^}���Λ
f��L�GR»Im�Kǃ{<��@�:��UQG#�R���I�^�s��0�*��(�&���5=!a�>�g�>bX�C��)��RN�W�,,j3�2Q���P���a��Nс!$�{����y<T�� �G����[_c�1��U��И�i��0! �ͯ������zR�ֱ���K8�06r���'���Y�L���FS��X�Bi�����1��X�j$!q�8W&�O�+�^>��Z���7��tmK��l
�@C�gD�
%n��q����X����`�/��&^ׯ���P~��=���Q��H�\�"���a���.�e���o����XvƠ�"���a��ëz�D�x��O�)h2g��|��ʱ�,�;�\�Ϡ^GJ��� �J�|wOu�ː�Z�f�{�w�XGx��¯%���￳l6��qϖ̚�T����f��)]�����b)e
�3|��H#Ɲ9ei'\|�
�g�t�C@�lB[w���Y=� ���C⿕��LU���X	N�L��G:�˓+r�R:IZ�
�;_�
� v�](j|��+�i���7�Q��(R�\|&�w��� �ңo��$gw�[YqNbe+����x���;��<���!�kF� g<1ً�>����
+h���������;+�G�KD���Ǎ��@��k����x�U�I�����@�
#?������ѿԗ��&�6W']f"
�he7v[̿��5�-��'�uGյ<a�������'.����r��ܾ�}Kt3��|��^	�U����BL�e>�yu��i�2�]DmG�Q�!�r�q�$�j��!��6���3�������*��;�~�;[A8|EPˆ�P'�	���Z���r�#�Ko���C��Z�_��h;/n���zsퟖ󯪰��}�Q���_.o�j�5_)��84��˺�uj����
Q�
�\i,�1�kf��(��]��(Q-���-ծ���\���S)����뵅�Sq��m(7)�d��'߅�Ƀ<���m��#8���Ć�1��[�GZn9��/ ���0�PS���h���M#ۨ/J��=��m�^���	G

��3�<��c�5�-ٙ�f$B7Kylۖ�@��J@�~��|2�g�/A�ϧ���]'H8��ym�ĮFBuS�GQ��7$��[F7bn��+y�.�Ht��n�������p���NC$�ÿ�=ӂk���Ȉj78<�ݼ�,�b5�$��H@�)�۫[�u<Q���6��n���@����Z��Jl����F��DmNX���-لn_-�%�����x�Z0���QMj]
|6֪[o�����XZt��噣���aH��҈�-� ����G>�җG���Q��<��}�PT�~��4�+��j���	�_�E�����s��y��Rץ�~Ёm:%/<�8�,-4ݲ˸�?<Q�2�b
l�<j�w�%�]]����g<�2��r1�*A'�1]���������2jp�@��
��| ��aۘ
e�'�bd�$ط�i�b��k�_��a1�L"ǲ�1�Q7V*[.�Rwt�#����2��Z�
���߿Hs\���o]�B=�с-�0���-U��D���:`�X�{]U�Y��\���H�Ij�1�X��73����PbC�T�E�Ϥ;�:5$�f�T_������%	�L��&��T�Q�u�mI���k`l�+��ջ��ф�j�n����-e���+k׫o4Z�
F����'V��;�imh>��VC��Е����;�Ac!�]���:O.y��PF���yq��
B�L�|�"iN2������aU5��A6���G*�5�hH�!�f
�r����1�
���W2�l6!W���>��C�)>��~�s6�EA�
q�C_�/�_tbQ�t�4�	��cy
W��GSw\�� 1.��6�w��r��g�\n�'r/B��b$���1@5ݸ��+���L��s|5�xؑ��zl�y���{��P�4�n��t*��3�S��凤_�bْa�%^�����>�u�C7��N�|C�U�R��lBj��e��OR'7�RD�ah�ޫt4��f4���~�gS܏���ݰ���B_) �U�eg�~�8B<̂��N������O��ZjH�а�j.x�q��=o�)�5׃4gs�9¥,t�$�JSZ����;�.�ISm�+��Ӝ�G��l������Ņ� o Ǝ�s�
�K�U%�,��7�#�)��`�4:�m-8�j6)�R&�QK�'niP	����*�SX�r���ǽm�)%�{@CMg�����i��N֎�.M���^����{�Plr$-��ڏܰ~�k��L�$���ni��l����� I��#��/���R�w� ;@i�*�UӓQ�Wr8� \�0��N5�m�mm�׮ح�@U����q�1\�auEE*�{�(2n�E����f3���<�	�Xj��92*�3R0�c�"���2�5��
A��
�#[��	5��!��]� ���%��t��H���
��@��azڿI��
���iH�;�GiT��s��~�п�� ��a��ld^p�#�>k�����3�}�uNq��*�r�
�gW�z+S�������-��f��c���k�ck���5�����)i�V�&��$�L��6��)�[-'��Lazg�I(#��y4�r iì�z��5 �\�c
���'{����̰46s��톟#����>�I�N��uGy�+��_�>@�,�oPM��DV�Z��'}Rn�if�*��%5�H�d�Iii6��$;�@_j�V�ghAD\f`�\���A�*�
��5���m ��[٢�c����XĮ�����򴒵!�PJ���MD���ϲ��
c��aD�S�tj))�y0H%4rV'I8����;����!��� 9QN^c�ѹ���4��*���#�qD��|����l1Q���}R�9}0)2ěwH�Q���a߾PL�;���Sd��,�_����Q'����A?��{��Q�#�*@1m��o��8��$޷��Xq��&n%����#?�<Y���zY1XJ	�y�w�U���g��c��N���:.�>�����,����@5Ѩ؋��[���==�l���vw�%���G2��gx1@>ሙ��(O�ػ�Ǯ!?0G�*���U!�%#w����X%2����x��F�cIP�Ʀ�<:γ芯��Ե����7���Ts\��6���a�QEmZ?�M�>sv�#��wj�q��ʐ`,)�q����A��X ��Ʀz1��$���N#:zL��㦸���f�)������D���Z�)#�ؼǒ���M�ּb{bhk8Z���o;��^}�nVk6���]�_4O}����6Z��:%�¾D?m����~�_GM�{�<f�4kSަy�h7	���>}��f`���)J:�3LMg��F^�Qn�ѭtxj�م��`��w삪9��qXO�d�x��J2HÜ#�"�$�^��Kx��H�v��Eu�#�a�8�@�/d�Q��o�κ*t?s,�-=|r�X�����L��{2n�C,���pm	�}c�O�7���@}=S�A��(8͘��}ST���ޗ��΅��V�`=�e��Į{
��f�5�O��R���{��a�N�MDP�[S�+U��s��_ֽ[(�v�\�ES`���S�s�}��:0p��З�,�e����&膚��|��&F�����
<�4Ow� 6��� Su|?���m.$��NV�L�61�Vh=�j!ؾ�T��W�s�M�I}SN��
0#�?�=ZouJF�����aj	�
��'�+K�;b�{�xZ.{�/�T�p���f��p������q�FHmd4%ݎSX4��M��[��\kt�*ل ̉� �b��Æ�L�]�ո����A�^	c�d��󙪷~���ʔ�^7�^N�q���k�@�l1��{%Z6V���B��PX�ϳ���V&�=]W�k<^Ua� �G3�INa���+E0�nv��
[i��ʟ�|��1$p-�w$�6j�PD/�4�ҏ�;@y�����'zF3
|�������f���c��+�q������:��EthAJ
X4��^�c��*�5�<��� �/uq��CĜJOP�nGh@�8S�t�rر�M#�>l�*0u�o�*V�H�/�v�u�MC��gj�{�\�z��:w�eΗ���K/j���8�l���zᎂ\�
F��KP~�ED7��1�j�j
���r����-��r�(# !T �Ҋ��U:�`�Ku��2{�`2��.�//KCP
��+�,fw�"�����90�^��'N�wY�R0
]z��E�B��� T��aT�e�	���
u��sL	�/��U6EAM�d�zĩ��	^~iw{q+�x����7��|?��AZXK�[�"�E���ywN �Q��]�����6������~���32Scq�1� Т���c�gr[QLFk��O����P�3�e�5�a�"屆y��jEx��B��?�m��Q�P�C(�)�2��+w]p�� q W�|�8�%�_=[��,	��f*5<J�Uk��
e��8����C@��+GB��s=��-�̨6V�;l���Ql'5�nw5'�C-��%��(�y���P<��M��<;�ԩK	�6M�0�%�{MU��n!]O-2�im�>H�D��uc9�Z��w���͛C��p�ڋ���a���sf[�9�.
�F�������І��ʳ�MU��H�	.`�;���/	Q'�ҵ���n?���Lk��\��TI��x�'���m�`�q�7	��V��f����}P&��N&,[�D��ʙ���@UuF�p
S�U��5������A=�֜��0��*�4D�K���󪖃QF2=�p<�G�8

K(W:�0��g���_F��J�D�|���<��6б�
<��'%j�
�>������l2b�P0����ԹF�$?�}��E�hR��
�m�	��jҦ\�z7t:vx(�F�9*X��ߖ�����2�l�N^Sd�ȟ@���;�ǆ�^q�b(�Z�#3)���P-$��%�`ʾ'P���6��^є�����9ueQŒuV��n6�8�#���Kڑ)8c��u��UK �uqg���/�7��iJ��=�J��s���o U��������������wV��sk��z�vi%v��X�1S8����}�~ �H�5�Y�[���?�}��հ�)��5������Q���bH����_{u^K�t�����(}y�u3�c����+*�|��ȗ�=�"�h���`����9��α���]Rd��X��%������c&�"u�+ƙ���4�J���w��Q�оu�����IOZ�iWr�P�)���K����f�W%$NͼR�F4�n��x�6���6�I�6���ԧܢd/��C�@��?yA܏w�z�D�2��i<��ԳA�G ��?s��~0:���̿��oo��s�C��C���)��-2]�9`�s��R���".F��P��|P0*�^\M
���
�{!\�����'֌*_�-�}�mr�}�ie���d��\?��"�v����3!�ގh�I儳K-�+�ۗ|- 0O��NaJ1�k'r��XCv������ɚM��N��e]��q�dkO��ƚ���Xv�*?Cx#�8#�� �l�v�.3���.|t���2a)Um���|9��Z�E�H:\v������P�2���MyBfK��0���i��8v)�G&�6�w���Cti����9k�iO�}M0��YùU��0�v�]dFU����=�C�s�̆\M�_��M���.g�U'��$�0]/�*�wK}ie��۞*\͑{��Ty�?���Ǹ�|�?�TY1�����PT��tmX�4��,3M��ʼ:���ʭ���4��'���*�_{��_q�*-�>z�	'0��e?��fw{�`�ܟ����8)-�l�iu����ZE���j�_�Qb���5��m��%k��pt��5r^��*J4�;$,uG2H�&����|�K1���yu;ĩ �,�t��Ӳq��*f;�l�2����p0�p����&���?[�j��Ts@�P�R׋��3���.��U��/�	�Z˚�?ڡ�+A8��	Q.�����j�����`�_����.��o�<���t�����Z}���p�H�v���O�#ɲ��&������m.�~�� ���N�w4�5W��
��0���D҂:?��ʞ��u���: �5P5Z���k�����
��$3��7������y��00�uu�[��y��r�H���X�-��t�nhjm���
gC��* �ZX���}O_�|��R�f�N���^[v[�wN�������yru�X��f���C�	�a��CP�
I�F�Vvo��P�"�?�B�s���#�lv*����3j�*s����\2�{3@�B+�N�Jy#s;޸eQ��C�98&m>gu2���8Qq[X�a�����x=#OvI���2�Z��R>�g���+k�$�4y.K�R�.�X�M�ɧ]��h��όf���y�P/�^\����MO���\B7<��p�`L1�(��9K����}
J9T3#(�fL�*����R#�A����vlـ���F��_�k
� 4"Q�n,�?��f$�l�BϟWz@bCAcxO��e��ӊ��1�Q��u�m��,QM�����w�D�����	�sZV��=��J�@�w�'i��J�Ybi�Vr����ٞ��ܣ�&����m��O�8/���~��|�vb�Rcy��8�yTS�D�����&2���u��B��z?�CW��C��4ҚZ$Y�B�����؅vS�z�	ҕ���4K��J
��Mr�2	c��6�$��Y�:*�1kN=v���d��n�PҪ����:�e�����%���,뚙��@PMd믶�;V8�:����l��'֧�hGb&l
����j GCC: (Ubuntu 7.5.0-3ubuntu1~18.04) 7.5.0  .shstrtab .interp .note.ABI-tag .note.gnu.build-id .gnu.hash .dynsym .dynstr .gnu.version .gnu.version_r .rela.dyn .rela.plt .init .plt.got .text .fini .rodata .eh_frame_hdr .eh_frame .init_array .fini_array .dynamic .data .bss .comment                                                                                8      8                                                 T      T                                     !             t      t      $                              4   ���o       �      �      4                             >             �      �      �                          F             �      �      �                             N   ���o       @      @      R                            [   ���o       �      �      P                            j             �      �      �                            t      B       �	      �	      �                          ~             �      �                                    y             �      �                                   �             �      �                                   �             �      �      �