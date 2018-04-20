From: dledford@redhat.com (Doug Ledford)
Date: Thu, 19 Apr 2018 22:48:34 -0400
Subject: [PATCH v1 0/3] nvmet-rdma automatic port re-activation
In-Reply-To: <0f781a93-2cbf-8d60-2028-4581912bf07a@grimberg.me>
References: <20180412080656.1691-1-sagi@grimberg.me>
 <20180413170010.GA23178@lst.de>
 <0f781a93-2cbf-8d60-2028-4581912bf07a@grimberg.me>
Message-ID: <1524192514.11756.26.camel@redhat.com>

On Sun, 2018-04-15@11:53 +0300, Sagi Grimberg wrote:
> > > When a RDMA device goes away we must destroy all it's associated
> > > RDMA resources. RDMa device resets also manifest as device removal
> > > events and a short while after they come back. We want to re-activate
> > > a port listener on this RDMA device when it comes back in to the system.
> > 
> > I really detest this series.  It just shows how messed up the whole
> > IB core interaction is.  The right way to fix this is to stop treating
> > a IB device reset as a device removal, and give it a different event.
> > 
> > And also make sure we have a single unified event system instead of
> > three separate ones.
> 
> I've raised this claim before, but got resistance from Doug:
> https://www.spinics.net/lists/linux-rdma/msg59815.html

I'm not the sole maintainer any more.  If you want to appeal to Jason's
better sensibilities in an attempt to get someone on your side and make
a difference, I won't take offense.

> At that point, in the lack of change in the RDMA interface, this
> is pretty much what we can do to support device resets...
> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

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
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20180419/cfab87ee/attachment.sig>
