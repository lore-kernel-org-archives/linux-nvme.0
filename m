From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 8 Mar 2018 09:39:17 +0100
Subject: NVMf initiator persistent across boots
In-Reply-To: <67d0fb1b-bd3c-b17f-b0a6-3c2b748d74fb@mellanox.com>
References: <6cdc2a01691ce8dd501987c646519a95@linux.vnet.ibm.com>
 <4c266ac3-a471-bb4a-c596-82270082c346@grimberg.me>
 <20170830094553.GC3941@linux-x5ow.site>
 <21e13bdf-d7a4-b47b-0885-855ba5ed995b@mellanox.com>
 <b4a9ae60-c374-653d-0207-62d1ea36ae76@grimberg.me>
 <67d0fb1b-bd3c-b17f-b0a6-3c2b748d74fb@mellanox.com>
Message-ID: <20180308083917.hddo3wqmlqmx6fes@linux-x5ow.site>

On Wed, Mar 07, 2018@02:47:52PM +0200, Max Gurtovoy wrote:
> > [Unit]
> > Description=NVMf auto discovery service
> > After=systemd-modules-load.service network-online.target
> > 
> > [Service]
> > Type=oneshot
> > ExecStart=/usr/bin/nvme connect-all
> > StandardOutput=journal
> > 
> > [Timer]
> > OnUnitActiveSec=1min
> > 
> > [Install]
> > WantedBy=multi-user.target timers.target
> > -- 
> > 
> > That would simply run nvme connect-all once every say minute.
> > The only problem is that it relies on the kernel to fail
> > duplicate subsystems. We could enforce that in nvme-cli for that
> > matter though (we can compare against sysfs address and subsysnqn).
> 
> Yes, we can also add flag to nvme discover command to add the parameters to
> the discovery file in case they are not exist.
> 
> 
> > 
> > Johannes is probably one to know better than me if this is the
> > correct way to go...
> 
> Johannes, any comment ?
> From what I tried, we need to create a .timer and .service files for
> systemd...

Sorry I was on FTO for some days.

One thing that I feel is missing in this whole "let's just call nvme
connect-all and we're done" discussion is, we currently can't really
specifiy how many connections to the target we want to initiate.

I usually run several nvme connect calls with different --host-traddr
arguments to connect from multiple HCAs to the target.

I tried to hack the ability to specify a list of host traddrs for nvme
connect and connect-all and then just loop the connect cann in
nvme-cli but this somehow feels wrong.

For the systemd service + timer units above, they look good on the
first sight, but I'm not sure I like the unconditional "polling" of
the connect-all call.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
