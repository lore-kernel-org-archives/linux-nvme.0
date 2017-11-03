From: keith.busch@intel.com (Keith Busch)
Date: Fri, 3 Nov 2017 09:02:04 -0600
Subject: [PATCH 1/3] nvme: do not check for ns on rw path
In-Reply-To: <20171103125339.GA25186@lst.de>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
 <1509703370-20379-2-git-send-email-javier@cnexlabs.com>
 <20171103125339.GA25186@lst.de>
Message-ID: <20171103150203.GA11300@localhost.localdomain>

On Fri, Nov 03, 2017@01:53:40PM +0100, Christoph Hellwig wrote:
> > -	if (ns && ns->ms &&
> > +	if (ns->ms &&
> >  	    (!ns->pi_type || ns->ms != sizeof(struct t10_pi_tuple)) &&
> >  	    !blk_integrity_rq(req) && !blk_rq_is_passthrough(req))
> >  		return BLK_STS_NOTSUPP;
> 
> blk_rq_is_passthrough also can't be true here.
> 
> How about:
> 
> 	if (ns->ms && !blk_integrity_rq(req) &&
> 	    (!ns->pi_type || ns->ms != sizeof(struct t10_pi_tuple)))
> 		return BLK_STS_NOTSUPP;
> 
> Although I have to admit I don't really understand what this check
> is even trying to do.  It basically checks for a namespace that has
> a format with metadata that is not T10 protection information and
> then rejects all I/O to it.  Why are we even creating a block device
> node for such a thing?

If the namespace has metadata, but the request doesn't have a metadata
payload attached to it for whatever reason, we can't construct the command
for that format. We also can't have the controller strip/generate the
payload with PRACT bit set if it's not a T10 format, so we just fail
the command.
