From: hare@suse.de (Hannes Reinecke)
Date: Wed, 18 Apr 2018 12:33:17 +0200
Subject: [PATCH] nvme: make NVME_SC_UNWRITTEN_BLOCK a thin-provisioned
 error
In-Reply-To: <20180418101835.GA15833@lst.de>
References: <20180418072723.25874-1-hare@suse.de>
 <20180418101835.GA15833@lst.de>
Message-ID: <20180418123317.24da7d3e@pentland.suse.de>

On Wed, 18 Apr 2018 12:18:35 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Wed, Apr 18, 2018@09:27:23AM +0200, Hannes Reinecke wrote:
> > According to the spec NVME_SC_UNWRITTEN_BLOCK signals
> > 'an attempt to read from an LBA range containing a deallocated
> > or unwritten logical block'.
> > So this is not so much about the medium being faulty, but
> > rather should be classified as a thin-provisioning error
> > and should be mapped onto ENOSPC.  
> 
> Use up your available space for the commit log, please :)
> 
> Otherwise this looks fine, although we are unlikely to ever hit it
> given that Linux never sets the DULBE bit, and setting that bit
> would break all the partition table and fs probing we have.

Ah. So that's related to the DULBE bit; good to know.
(Maybe it could be mentioned in the spec together with the definition
in status code.)

So we're having two issues here; the one is the misclassification of
the status code, and the other one is the array sending us this error
even though we didn't enable DULBE.
I'll let them know.

Cheers,

Hannes
