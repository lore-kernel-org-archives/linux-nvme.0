From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 10 Jul 2017 11:10:55 +0200
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>
References: <20170707094838.GD16648@linux-x5ow.site>
 <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>
 <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
 <6eff23f4-1bb7-3c64-6916-987f4b38ae78@mellanox.com>
Message-ID: <20170710091054.GD5105@linux-x5ow.site>

On Mon, Jul 10, 2017@11:46:47AM +0300, Max Gurtovoy wrote:
> >>- What kato is required to not stumble on this?

Tried up to 120 now, still broken.

> >Well, this sounds identically to the path_checker problem we're having
> >in multipathing (and hch complained about several times).
> >There's a rather easy solution to it: don't send keepalives if I/O is
> >running, but rather tack it on the most current I/O packet.
> >In the end, you only want to know if the link is alive; you don't have
> >to transfer any data as such.
> >So if you just add a flag (maybe on the RDMA layer) to the next command
> >to be sent you could easily simulate keepalive without having to send
> >additional commands.
> 
> Hannes,
> This is a good solution and actually the way we work in iSCSI/iSER with
> nopin/nopout.
> Don't you think it should be a ctrl attribute ?

Let me see if I can come up with something.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
