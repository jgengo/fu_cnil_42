if [[ -z "${ID_42}" || -z ${PW_42} ]]; then
    echo "please export \$ID_42 and \$PW_42"
    exit 1
fi

token=`curl -s https://signin.intra.42.fr/users/sign_in | grep name=\"authenticity | sed -e 's/.*name="authenticity_token".*value="\(.*\)".*/\1/'`

data="authenticity_token=$token&commit=Sign%20in&user[login]=$ID_42&user[password]=$PW_42&utf8=%E2%9C%93"

if curl -sd $data https://signin.intra.42.fr/users/sign_in | grep -q profile.intra; then
    echo "`date` - OK" >> /tmp/fu_cnil_42.log
else
    echo "`date` - NOT OK" >> /tmp/fu_cnil_42.log
fi
