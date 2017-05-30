From: leon@kernel.org (Leon Romanovsky)
Date: Tue, 30 May 2017 20:15:02 +0300
Subject: [PATCH v2 2/2] IB/mlx5: set UMR wqe fence according to HCA cap
In-Reply-To: <d23a5a6f-bd9f-3b1a-34d5-25e8eb2a041c@grimberg.me>
References: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
 <1495957991-19223-2-git-send-email-maxg@mellanox.com>
 <20170528090705.GM13083@lst.de>
 <19a1d347-91da-7e5f-8877-86772204a80a@mellanox.com>
 <20170529100504.GZ17751@mtr-leonro.local>
 <89409b6d-466d-070a-7082-1f7bbb9ad7c7@mellanox.com>
 <20170529160609.GA17751@mtr-leonro.local>
 <d23a5a6f-bd9f-3b1a-34d5-25e8eb2a041c@grimberg.me>
Message-ID: <20170530171502.GC5406@mtr-leonro.local>

On Tue, May 30, 2017@01:51:33PM +0300, Sagi Grimberg wrote:
> Leon,
>
> > > We don't fence those WR's.
> > > Christoph just re-write it to be more intuitive code. I don't see logic
> > > difference, am I wrong here ?
> >
> > A little bit, before Christoph's suggestion, we calculated fence for
> > the paths which need such fence, after we will calculate for all paths.
>
> Every WQE posted to a send queue must include a fence bit. All work
> request posted on the send queue calculate the required fence, this
> used to happen in finish_wqe call-sites with get_fence(), Christoph
> just inlin'ed it.

Sagi,

Thanks, I found my mistake, I saw that IB_SEND_INLINE WR doesn't call to
get_fence and we have an if() which can skip finish_wqe, so I thought
that finish_wqe isn't called always, however it was for error path.

Thanks again.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170530/8489129f/attachment.sig>
