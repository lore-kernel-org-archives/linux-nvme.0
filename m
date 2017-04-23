From: leon@kernel.org (Leon Romanovsky)
Date: Sun, 23 Apr 2017 13:34:39 +0300
Subject: [PATCH v2 0/4] arbitrary sg lists support
In-Reply-To: <c52b5ce7-5346-419d-26f2-0d4d45d20471@grimberg.me>
References: <1492098977-5231-1-git-send-email-maxg@mellanox.com>
 <1492101079.5176.9.camel@sandisk.com>
 <c52b5ce7-5346-419d-26f2-0d4d45d20471@grimberg.me>
Message-ID: <20170423103439.GC14088@mtr-leonro.local>

On Thu, Apr 20, 2017@02:30:46PM +0300, Sagi Grimberg wrote:
>
> > > This patch adds an arbitrary sg list support to NVMEoF host for
> > > capable devices (such as RDMA CX4/CX5 HCAs).
> > > During the review we decided to add an helper function to ib_core
> > > that will be used by ULPs in order to avoid code duplication.
> >
> > Hello Max,
> >
> > A question that is not related to the ULP drivers touched by this patch series:
> > some time ago registration of sg-lists with gaps was disabled in the SRP
> > initiator because arbitrary sg-lists triggered CQE dumps in combination with the
> > mlx5 driver. Does this mean that this issue has been resolved? If so, what mlx5
> > driver and/or firmware version are needed to reenable arbitrary sg-list support
> > in the SRP initiator?
>
> I'm concerned about the fact that the SRP issue wasn't resolved. There
> might be a bug hiding there.
>
> Max, Leon, my recollection was that the error syndrome you saw with SRP
> described "too much sgls for a single mr". If this is true, then I still
> think we need a different device capability for it.

I don't remember that Max succeeded to reproduce it.

>
> I'm even thinking we need to remove gaps support from iSER until this
> is addressed.

Better to find the root cause.

Thanks
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170423/6c617d56/attachment.sig>
