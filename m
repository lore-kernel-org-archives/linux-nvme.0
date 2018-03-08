From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu, 8 Mar 2018 14:26:56 +0100
Subject: NVMf initiator persistent across boots
In-Reply-To: <0385c9c1-dac3-e243-335d-af61ceb0c4fb@mellanox.com>
References: <6cdc2a01691ce8dd501987c646519a95@linux.vnet.ibm.com>
 <4c266ac3-a471-bb4a-c596-82270082c346@grimberg.me>
 <20170830094553.GC3941@linux-x5ow.site>
 <21e13bdf-d7a4-b47b-0885-855ba5ed995b@mellanox.com>
 <b4a9ae60-c374-653d-0207-62d1ea36ae76@grimberg.me>
 <67d0fb1b-bd3c-b17f-b0a6-3c2b748d74fb@mellanox.com>
 <20180308083917.hddo3wqmlqmx6fes@linux-x5ow.site>
 <bf33f7c7-8173-c98c-8a17-de0277e5f05c@mellanox.com>
 <20180308101313.ozwedysig3amjoel@linux-x5ow.site>
 <0385c9c1-dac3-e243-335d-af61ceb0c4fb@mellanox.com>
Message-ID: <20180308132656.yx2uiix4dcjzmp2a@linux-x5ow.site>

On Thu, Mar 08, 2018@03:15:42PM +0200, Max Gurtovoy wrote:
> Yes, I got it.
> IMO if you will add:
> -t rdma -a 1.1.1.1 -s 4420 -w 1.1.1.2
> -t rdma -a 1.1.1.1 -s 4420 -w 1.1.1.3
> 
> to the discovery file it should be fine.
> I think we'll need to fix few things in nvmecli and in the driver too.
> I'm checking this.

Hmm interesting. This probably was too obvious for me to try...

> > Good question. I'd be fine with both. The only thing that should be
> > considered as well is, if you already need the nvmf connection in the
> > initrd, you'll have to rebuild the initrd after each change of
> > /etc/nvme/discovery.conf and thus every nvme
> > persist-add/persist-remove (or discover --persistent) call.
> 
> Let's assume that we don't need it for now, otherwise it will be unpleasent
> :)

Given the number of "Boot from SAN failed with XXX" Bugs I have seen
the last years I doubt we won't need it ;-).

But yes we can think about this in step two I guess.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
