From: leon@kernel.org (Leon Romanovsky)
Date: Mon, 29 May 2017 19:06:09 +0300
Subject: [PATCH v2 2/2] IB/mlx5: set UMR wqe fence according to HCA cap
In-Reply-To: <89409b6d-466d-070a-7082-1f7bbb9ad7c7@mellanox.com>
References: <1495957991-19223-1-git-send-email-maxg@mellanox.com>
 <1495957991-19223-2-git-send-email-maxg@mellanox.com>
 <20170528090705.GM13083@lst.de>
 <19a1d347-91da-7e5f-8877-86772204a80a@mellanox.com>
 <20170529100504.GZ17751@mtr-leonro.local>
 <89409b6d-466d-070a-7082-1f7bbb9ad7c7@mellanox.com>
Message-ID: <20170529160609.GA17751@mtr-leonro.local>

On Mon, May 29, 2017@03:21:11PM +0300, Max Gurtovoy wrote:
>
>
> On 5/29/2017 1:05 PM, Leon Romanovsky wrote:
> > On Sun, May 28, 2017@12:53:00PM +0300, Max Gurtovoy wrote:
> > >
> > >
> > > On 5/28/2017 12:07 PM, Christoph Hellwig wrote:
> > > > On Sun, May 28, 2017@10:53:11AM +0300, Max Gurtovoy wrote:
> > > > > Cache the needed umr_fence and set the wqe ctrl segmennt
> > > > > accordingly.
> > > >
> > > > Looks good,
> > > >
> > > > Reviewed-by: Christoph Hellwig <hch at lst.de>
> > >
> > > Thanks.
> > >
> > > >
> > > > But that whole fence logic looks awkward to me.  Does the following
> > > > patch to reorder it make sense to you?
> > > >
> > >
> > >
> > > Yes it make sense to me.
> > > Sagi/Leon, any comments ?
> >
> > Max,
> >
> > Do you see any performance impact for IB_WR_RDMA_READ, IB_WR_RDMA_WRITE
> > and IB_WR_RDMA_WRITE_WITH_IMM flows? They don't need fences and such
> > change can cause to performance losses.
> >
> > Thanks
> >
>
> We don't fence those WR's.
> Christoph just re-write it to be more intuitive code. I don't see logic
> difference, am I wrong here ?

A little bit, before Christoph's suggestion, we calculated fence for
the paths which need such fence, after we will calculate for all paths.

Thanks

>
> >
> > >
> > >
> > > --
> > > To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> > > the body of a message to majordomo at vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170529/c68523d0/attachment-0001.sig>
