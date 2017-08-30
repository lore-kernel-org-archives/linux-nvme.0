From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed, 30 Aug 2017 11:45:53 +0200
Subject: NVMf initiator persistent across boots
In-Reply-To: <4c266ac3-a471-bb4a-c596-82270082c346@grimberg.me>
References: <6cdc2a01691ce8dd501987c646519a95@linux.vnet.ibm.com>
 <4c266ac3-a471-bb4a-c596-82270082c346@grimberg.me>
Message-ID: <20170830094553.GC3941@linux-x5ow.site>

[+Cc James]

On Wed, Aug 30, 2017@12:37:47PM +0300, Sagi Grimberg wrote:
[...]
> Something like:
> --
> [Unit]
> Description=NVMf auto discovery service
> After=systemd-modules-load.service network-online.target
> 
> [Service]
> Type=oneshot
> ExecStart=/usr/bin/nvme connect-all
> StandardOutput=journal
> 
> [Install]
> WantedBy=multi-user.target
> --
> 
> Where discovery.conf would have the relevant parameters
> like:
> --
> --traddr=<traddr1> --trsvcid=<trsvcid1>
> --traddr=<traddr2> --trsvcid=<trsvcid2>
> --
> 
> One thing we may want to have is to make sure
> that nvme relevant modules are loaded at boot time
> so we may want nvme-cli to either manually load them
> or the installation would add them to systemd-modules-load.service
> (i.e. add relevant files to /etc/modules-load.d/)
> 
> Thoughts?

That's exactly what I wanted to do for SUSE distros as well, so I'm fine with
it.

James Smart has a bunch of scripts and udev rules for FC-NVMe autoconnecting
and I asked him earlier today to sumbit them here as well. 

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
