From: leon@kernel.org (Leon Romanovsky)
Date: Sun, 23 Apr 2017 15:12:54 +0300
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <d697d360-99ca-c3ed-08e2-b89cc50a15b0@grimberg.me>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492101079.5176.9.camel@sandisk.com>
 <c52b5ce7-5346-419d-26f2-0d4d45d20471@grimberg.me>
 <20170423103439.GC14088@mtr-leonro.local>
 <d697d360-99ca-c3ed-08e2-b89cc50a15b0@grimberg.me>
Message-ID: <20170423121254.GD14088@mtr-leonro.local>

On Sun, Apr 23, 2017@02:49:43PM +0300, Sagi Grimberg wrote:
>
> > > I'm concerned about the fact that the SRP issue wasn't resolved. There
> > > might be a bug hiding there.
> > >
> > > Max, Leon, my recollection was that the error syndrome you saw with SRP
> > > described "too much sgls for a single mr". If this is true, then I still
> > > think we need a different device capability for it.
> >
> > I don't remember that Max succeeded to reproduce it.
>
> You said Artemy was on this issue:
> https://www.spinics.net/lists/linux-rdma/msg46390.html
>

At the end, he proposed unrelated fix.

> and I asked you a question that will help clear things up but
> never received an answer:
> https://www.spinics.net/lists/linux-rdma/msg46394.html

i asked and didn't get answer too.
https://www.spinics.net/lists/linux-rdma/msg46407.html

Thanks


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
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170423/f3f09b25/attachment.sig>
