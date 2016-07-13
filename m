From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 13 Jul 2016 13:14:33 +0300
Subject: [PATCH -nvmeof] selftest: Add test for keep-alive expired with
 live io
In-Reply-To: <1467137877-20899-1-git-send-email-mlin@kernel.org>
References: <1467137877-20899-1-git-send-email-mlin@kernel.org>
Message-ID: <57861489.7030904@grimberg.me>


> +echo "Running ifconfig $HOST_NIC up/down for $NUM_TEST times"
> +for i in `seq $NUM_TEST` ; do
> +	ifconfig $HOST_NIC down
> +	sleep $(( 10 + ($RANDOM & 0x7) ))
> +	ifconfig $HOST_NIC up
> +	sleep $(( 10 + ($RANDOM & 0x7) ))
> +done
> +
> +sleep 5
> +killall -9 fio

Why SIGKILL? why so harsh?
