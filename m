From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 10 Jul 2017 09:59:22 +0200
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <4f2962b4-b099-276c-b3da-32c8fa63adcf@mellanox.com>
References: <20170707094838.GD16648@linux-x5ow.site>
 <4f2962b4-b099-276c-b3da-32c8fa63adcf@mellanox.com>
Message-ID: <20170710075921.GC5105@linux-x5ow.site>

On Sat, Jul 08, 2017@09:14:26PM +0300, Max Gurtovoy wrote:
> I need more info to repro.
> What is the backing store at the target ?

Either null_blk or zram, doesn't really make a difference.

> are you using RoCE or IB link layer ?

ibstat says IB

> ConnectX-3 vs. ConnectX-3 B2B ?
Mellanox Technologies MT26418

> what is the FW on both target and host ?
> what is the KATO ?
default

> can you increase it as a WA ?
Haven't tried yet.

Thanks,
	Johannes

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
