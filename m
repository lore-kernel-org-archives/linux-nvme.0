From: leonro@mellanox.com (Leon Romanovsky)
Date: Wed, 3 May 2017 19:27:08 +0300
Subject: [PATCH v4, under testing] nvme-rdma: support devices with queue
 size < 32
In-Reply-To: <77ada146-67eb-9dce-d252-6ac630c9a1e8@grimberg.me>
References: <79901165.5342369.1493805915415.JavaMail.zimbra@kalray.eu>
 <823aa3f0-685f-4569-11d6-238cc4f0b126@grimberg.me>
 <780938034.8003164.1493824767084.JavaMail.zimbra@kalray.eu>
 <20170503155316.GA14334@obsidianresearch.com>
 <1493827096.3901.4.camel@sandisk.com>
 <77ada146-67eb-9dce-d252-6ac630c9a1e8@grimberg.me>
Message-ID: <20170503162708.GO22833@mtr-leonro.local>

On Wed, May 03, 2017@07:01:14PM +0300, Sagi Grimberg wrote:
>
> > Hello Jason,
> >
> > As far as I know the compiler only does that for compile-time constants. In
> > this case the divisor (max(queue_size / 2, 1)) is not a compile-time constant.
>
> We could theoretically do a (sig_count & max(queue_size / 2, 1)) but
> that would only do well with power of 2 sized queues...

IMHO, It is not-so-big-deal limitation.

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
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170503/bb3a3888/attachment.sig>
