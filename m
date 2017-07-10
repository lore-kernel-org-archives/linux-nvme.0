From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 10 Jul 2017 13:50:03 +0200
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <ebc9dccc-ce68-f5f3-3e24-372b2cd7f44b@grimberg.me>
References: <20170707094838.GD16648@linux-x5ow.site>
 <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>
 <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
 <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>
 <20170710091054.GD5105@linux-x5ow.site>
 <a940a9ea-c090-6620-a080-eb7cf6140ad3@grimberg.me>
 <20170710102049.GF5105@linux-x5ow.site>
 <77c7d11c-bd67-8663-cc10-da3af8bfcd22@grimberg.me>
 <20170710113353.GG5105@linux-x5ow.site>
 <ebc9dccc-ce68-f5f3-3e24-372b2cd7f44b@grimberg.me>
Message-ID: <20170710115003.GH5105@linux-x5ow.site>

On Mon, Jul 10, 2017@02:41:28PM +0300, Sagi Grimberg wrote:
> >Host:
> >[353698.784927] nvme nvme0: creating 44 I/O queues.
> >[353699.572467] nvme nvme0: new ctrl: NQN
> >"nqn.2014-08.org.nvmexpress:NVMf:uuid:c36f2c23-354d-416c-95de-f2b8ec353a82",
> >addr 1.1.1.2:4420
> >[353960.804750] nvme nvme0: SEND for CQE 0xffff88011c0cca58 failed with status
> >transport retry counter exceeded (12)
> 
> Exhausted retries, wow... That is really strange...
> 
> Host sent the keep-alive and it never made it to the host, the HCA
> retried for 7+ times and gave up.
> 
> Are you running with a switch? which one? is the switch experience
> higher ingress?

This (unfortunately) was the OmniPath setup as I only was a guest on the IB
installation and the other team needed it back. Anyways I did see this on IB
as well (regardless of SLE12-SP3 and v4.12 final). The switch is an Intel Edge
100 OmniPath switch.

[...]

> 
> And why aren't you able to reconnect?
> 
> Something smells mis-configured here...

I am it just takes ages:
[354235.064586] nvme nvme0: Failed reconnect attempt 27
[354235.076054] nvme nvme0: Reconnecting in 10 seconds...
[354245.117100] nvme nvme0: rdma_resolve_addr wait failed (-104).
[354245.144574] nvme nvme0: Failed reconnect attempt 28
[354245.156097] nvme nvme0: Reconnecting in 10 seconds...
[354255.244008] nvme nvme0: creating 44 I/O queues.
[354255.877529] nvme nvme0: Successfully reconnected
[354255.900579] nvme0n1: detected capacity change from -67526893324191744 to
68719476736

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
