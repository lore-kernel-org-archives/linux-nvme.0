From: dledford@redhat.com (Doug Ledford)
Date: Thu, 19 Apr 2018 22:04:51 -0400
Subject: [PATCH 1/2] IB/mlx5: posting klm/mtt list inline in the send
 queue for reg_wr
In-Reply-To: <CAL1RGDXbUXcrRyEtHWpBmWpbbCB6nuQVfWC1bi+4K_yp3pB0LQ@mail.gmail.com>
References: <1509295101-14081-1-git-send-email-idanb@mellanox.com>
 <1509295101-14081-2-git-send-email-idanb@mellanox.com>
 <CAL1RGDXbUXcrRyEtHWpBmWpbbCB6nuQVfWC1bi+4K_yp3pB0LQ@mail.gmail.com>
Message-ID: <1524189891.11756.12.camel@redhat.com>

On Thu, 2018-04-19@14:11 -0700, roland wrote:
> > The fetch of the MTT/KLM list becomes the bottleneck in
> > number of IO operation could be done by NVMe over Fabrics
> > host driver on a single adapter as shown below.
> > 
> > This patch is adding the support for inline registration
> > work request upon MTT/KLM list of size <=64B.
> 
> It looks like this patch never made it upstream, and I don't see any
> discussion or reason why it might have been dropped.
> 
> This still seems like a good idea - should we respin it against the latest tree?

If you want it included, then you'll have to respin it if for no other
reason than the fact that it isn't readily available in patchworks and
that's what we're using to track/grab patches now a days.  I supposed I
could go hunting for it, but that's a good way to grab an out of date
patch and make a mistake by accident...

-- 
Doug Ledford <dledford at redhat.com>
    GPG KeyID: B826A3330E572FDD
    Key fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180419/05204a93/attachment.sig>
