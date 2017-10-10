From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 10 Oct 2017 15:48:44 +0200
Subject: [PATCH] nvme_fc auto-connect scripts
In-Reply-To: <20171009201032.2018-1-jsmart2021@gmail.com>
References: <20171009201032.2018-1-jsmart2021@gmail.com>
Message-ID: <20171010134844.hlgn7mif6yek2vvp@linux-x5ow.site>

On Mon, Oct 09, 2017@01:10:32PM -0700, James Smart wrote:
> cp nvmefc_boot_connections.sh        /usr/sbin/lpfc/

[...]

> +ExecStart=/bin/sh -c "/usr/sbin/lpfc/nvmefc_boot_connections.sh"

/usr/sbin/lpfc wont get past our package reviewers, %_sbindir (for rpm, I'm
sure there is an equivalent for deb as well) should be used there.


Also wouldn't it make sense to have the scripts/services in nvme-cli?

Byte,
	Johannes
-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
