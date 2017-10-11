From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 14:39:42 +0300
Subject: [PATCH] nvme_fc auto-connect scripts
In-Reply-To: <20171010134844.hlgn7mif6yek2vvp@linux-x5ow.site>
References: <20171009201032.2018-1-jsmart2021@gmail.com>
 <20171010134844.hlgn7mif6yek2vvp@linux-x5ow.site>
Message-ID: <bffb5035-3435-f66c-d4f3-cdc612a68e56@grimberg.me>


>> cp nvmefc_boot_connections.sh        /usr/sbin/lpfc/
> 
> [...]
> 
>> +ExecStart=/bin/sh -c "/usr/sbin/lpfc/nvmefc_boot_connections.sh"
> 
> /usr/sbin/lpfc wont get past our package reviewers, %_sbindir (for rpm, I'm
> sure there is an equivalent for deb as well) should be used there.
> 
> 
> Also wouldn't it make sense to have the scripts/services in nvme-cli?

It definitely would.
