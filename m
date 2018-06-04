From: hch@lst.de (Christoph Hellwig)
Date: Mon, 4 Jun 2018 08:29:23 +0200
Subject: [PATCH 4/9] nvme: always failover on path or transport errors
In-Reply-To: <20180601152711.GA98855@redhat.com>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-5-hch@lst.de> <20180601152711.GA98855@redhat.com>
Message-ID: <20180604062923.GA20662@lst.de>

On Fri, Jun 01, 2018@11:27:11AM -0400, Mike Snitzer wrote:
> > @@ -59,6 +59,9 @@ bool nvme_req_needs_failover(struct request *req, blk_status_t error)
> >  {
> >  	if (!(req->cmd_flags & REQ_NVME_MPATH))
> >  		return false;
> > +	/* always failover for path related errors */
> > +	if ((nvme_req(req)->status & 0x700) == 0x300)
> > +		return true;
> >  	return blk_path_error(error);
> >  }
> 
> Shouldn't this go into nvme_error_status(), with a new NVME_SC if
> needed, so that blk_path_error() just works?

NVME_SC values are defined in the NVMe spec.  The check is intended
as a catchall for multiple of theses values, as we've defined a whole
extensible class for path errors.

But we could probably add a BLK_STS_PATH and I'll map it to that.
