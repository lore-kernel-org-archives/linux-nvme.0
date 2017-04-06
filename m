From: leonro@mellanox.com (Leon Romanovsky)
Date: Thu, 6 Apr 2017 16:02:07 +0300
Subject: [PATCH RFC] nvme-rdma: support devices with queue size < 32
In-Reply-To: <1224897571.353404199.1491481743295.JavaMail.zimbra@kalray.eu>
References: <1315914765.312051621.1490259849534.JavaMail.zimbra@kalray.eu>
 <406682b9-d7ca-4718-5830-7940d2822bc0@grimberg.me>
 <20170329162751.GA7113@obsidianresearch.com>
 <80770042-743e-a271-c636-f72099f9ac56@grimberg.me>
 <9eb08168-18a6-a176-01df-b68b6a225963@redhat.com>
 <3505b835-d0ba-70cb-dfe8-1265fc2bbb83@redhat.com>
 <2ba93b5b-ad36-5533-36e2-9db2e3198c19@grimberg.me>
 <1121115847.336382032.1490883808617.JavaMail.zimbra@kalray.eu>
 <1224897571.353404199.1491481743295.JavaMail.zimbra@kalray.eu>
Message-ID: <20170406130207.GI2269@mtr-leonro.local>

On Thu, Apr 06, 2017@02:29:03PM +0200, Marta Rybczynska wrote:
> >>>> You say above "we post *up to* 2 work requests", unless you wish to
> >>>> change that to "we always post at least 2 work requests per queue
> >>>> entry", Jason is right, your frequency of signaling needs to be X/2
> >>>> regardless of your CQ size, you need the signaling to control the queue
> >>>> depth tracking.
> >>>
> >>> If you would like to spread things out farther between signaling, then
> >>> you can modify your send routine to only increment the send counter for
> >>> actual send requests, ignoring registration WQEs and invalidate WQES,
> >>> and then signal every X/2 sends.
> >>
> >> Yea, you're right, and not only I got it wrong, I even contradicted my
> >> own suggestion that was exactly what you and Jason suggested (where is
> >> the nearest rat-hole...)
> >>
> >> So I suggested to signal every X/2 and Marta reported SQ overflows for
> >> high queue-dpeth. Marta, at what queue-depth have you seen this?
> >
> > The remote side had queue depth of 16 or 32 and that's the WQ on the
> > initiator side that overflows (mlx5_wq_overflow). We're testing with
> > signalling X/2 and it seems to work.
>
> Update on the situation: the signalling on X/2 seems to work fine in
> practice. To clarify more that's the send queue that overflows
> (mlx5_wq_overflow in begin_wqe of drivers/infiniband/hw/mlx5/qp.c).
>
> However, I have still doubt how it's going to work in the case of
> higher queue depths (i.e. the typical case). If we signal every X/2
> we'll do it much more rarely than today (every 32 messages). I'm not
> sure on the system effect this would have.
>
> Mellanox guys, do you have an idea what it might do?

It will continue to work as expected with long depths too.
All that you need is do not to forget to issue signal if queue is terminated.

Thanks

>
> Marta
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170406/98715074/attachment-0001.sig>
