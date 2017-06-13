From: hch@lst.de (Christoph Hellwig)
Date: Tue, 13 Jun 2017 10:03:00 +0200
Subject: [PATCH] nvme: move protection information check into nvme_setup_rw
In-Reply-To: <95127f6a-9e74-3c21-3d76-8b65dbb53288@suse.de>
References: <20170612163632.23009-1-hch@lst.de>
 <95127f6a-9e74-3c21-3d76-8b65dbb53288@suse.de>
Message-ID: <20170613080300.GA611@lst.de>

On Tue, Jun 13, 2017@10:00:23AM +0200, Johannes Thumshirn wrote:
> > @@ -386,6 +395,7 @@ static inline void nvme_setup_rw(struct nvme_ns *ns, struct request *req,
> >  
> >  	cmnd->rw.control = cpu_to_le16(control);
> >  	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
> > +	return 0;
> >  }
> 
> And here you're returning 0 instead of BLK_STATUS_OK.
> 
> Intentional?

Yes, at least sort of.  Even for __bitwise types 0 is special, so
this is perfectly fine.
