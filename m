From: xjtuwjp@gmail.com (Jack Wang)
Date: Mon, 10 Jul 2017 10:59:37 +0200
Subject: I/O Errors due to keepalive timeouts with NVMf RDMA
In-Reply-To: <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
References: <20170707094838.GD16648@linux-x5ow.site>
 <a34f03ac-4306-ba87-e6f4-fc29bfd80828@grimberg.me>
 <2b758039-5957-96b5-bf30-5cbb5515fe9c@suse.de>
Message-ID: <CAD+HZHVELp6TGCHHsxONJkJzMWNqwV0aMtAPR+bEgXGggD90FQ@mail.gmail.com>

2017-07-10 9:17 GMT+02:00 Hannes Reinecke <hare at suse.de>:
snip
> Well, this sounds identically to the path_checker problem we're having
> in multipathing (and hch complained about several times).
> There's a rather easy solution to it: don't send keepalives if I/O is
> running, but rather tack it on the most current I/O packet.
> In the end, you only want to know if the link is alive; you don't have
> to transfer any data as such.

We did exactly the same for IBTRS for our heatbeat, :)

Cheers,
Jack
> --
> Dr. Hannes Reinecke                Teamlead Storage & Networking
> hare at suse.de                                   +49 911 74053 688
> SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
> GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
> HRB 21284 (AG N?rnberg)
>
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
