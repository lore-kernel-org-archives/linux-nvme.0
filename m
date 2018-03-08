From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 8 Mar 2018 11:13:13 +0100
Subject: NVMf initiator persistent across boots
In-Reply-To: <bf33f7c7-8173-c98c-8a17-de0277e5f05c@mellanox.com>
References: <6cdc2a01691ce8dd501987c646519a95@linux.vnet.ibm.com>
 <4c266ac3-a471-bb4a-c596-82270082c346@grimberg.me>
 <20170830094553.GC3941@linux-x5ow.site>
 <21e13bdf-d7a4-b47b-0885-855ba5ed995b@mellanox.com>
 <b4a9ae60-c374-653d-0207-62d1ea36ae76@grimberg.me>
 <67d0fb1b-bd3c-b17f-b0a6-3c2b748d74fb@mellanox.com>
 <20180308083917.hddo3wqmlqmx6fes@linux-x5ow.site>
 <bf33f7c7-8173-c98c-8a17-de0277e5f05c@mellanox.com>
Message-ID: <20180308101313.ozwedysig3amjoel@linux-x5ow.site>

On Thu, Mar 08, 2018@12:03:18PM +0200, Max Gurtovoy wrote:
> 
> 
> On 3/8/2018 10:39 AM, Johannes Thumshirn wrote:
> > On Wed, Mar 07, 2018@02:47:52PM +0200, Max Gurtovoy wrote:
> > > > [Unit]
> > > > Description=NVMf auto discovery service
> > > > After=systemd-modules-load.service network-online.target
> > > > 
> > > > [Service]
> > > > Type=oneshot
> > > > ExecStart=/usr/bin/nvme connect-all
> > > > StandardOutput=journal
> > > > 
> > > > [Timer]
> > > > OnUnitActiveSec=1min
> > > > 
> > > > [Install]
> > > > WantedBy=multi-user.target timers.target
> > > > -- 
> > > > 
> > > > That would simply run nvme connect-all once every say minute.
> > > > The only problem is that it relies on the kernel to fail
> > > > duplicate subsystems. We could enforce that in nvme-cli for that
> > > > matter though (we can compare against sysfs address and subsysnqn).
> > > 
> > > Yes, we can also add flag to nvme discover command to add the parameters to
> > > the discovery file in case they are not exist.
> > > 
> > > 
> > > > 
> > > > Johannes is probably one to know better than me if this is the
> > > > correct way to go...
> > > 
> > > Johannes, any comment ?
> > >  From what I tried, we need to create a .timer and .service files for
> > > systemd...
> > 
> > Sorry I was on FTO for some days.
> > 
> > One thing that I feel is missing in this whole "let's just call nvme
> > connect-all and we're done" discussion is, we currently can't really
> > specifiy how many connections to the target we want to initiate.
> > 
> > I usually run several nvme connect calls with different --host-traddr
> > arguments to connect from multiple HCAs to the target.
> > 
> > I tried to hack the ability to specify a list of host traddrs for nvme
> > connect and connect-all and then just loop the connect cann in
> > nvme-cli but this somehow feels wrong.
> 
> Why not adding -w <host-traddr> to the /etc/nvme/discovery.conf file lines ?
> I guess connect-all will use it too, right ? (need to check it).

I meant multiple -w arguments. My usual connect is:
nvme connect -t rdma -a 1.1.1.1 -n nvme-test -s 4420 -w 1.1.1.2
nvme connect -t rdma -a 1.1.1.1 -n nvme-test -s 4420 -w 1.1.1.3
to connect from both HCAs to the target.

> 
> > 
> > For the systemd service + timer units above, they look good on the
> > first sight, but I'm not sure I like the unconditional "polling" of
> > the connect-all call.
> 
> Yes this is no the perfect solution but I guess future discovery_manager
> should solve it, but we need to find solution till then.
> 
> I tought about adding new commands/flags to add/remove parameters to
> /etc/nvme/discovery.conf.
> how about adding:
> nvme persist-add -t rdma -a 11.11.11.11 -s 4420 -w 11.12.12.12 (will add to
> discovery file "-t rdma -a 11.11.11.11 -s 4420 -w 11.12.12.12")
> nvme persist-remove -t rdma -a 11.11.11.11 -s 4420 -w 11.11.12.12 (will
> remove "-t rdma -a 11.11.11.11 -s 4420 -w 11.12.12.12" from discovery file).
> 
> Or it's better to add flags to nvme discover ?

Good question. I'd be fine with both. The only thing that should be
considered as well is, if you already need the nvmf connection in the
initrd, you'll have to rebuild the initrd after each change of
/etc/nvme/discovery.conf and thus every nvme
persist-add/persist-remove (or discover --persistent) call.

Byte,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
