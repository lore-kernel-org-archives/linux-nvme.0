From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Nov 2018 09:23:59 +0100
Subject: [PATCHv3 0/3] nvme: NUMA locality for fabrics
In-Reply-To: <c6b0e0f8-f22c-65b6-3657-1f078b0803e2@suse.de>
References: <20181102095641.28504-1-hare@suse.de>
 <20181116081241.GA14072@lst.de>
 <c6b0e0f8-f22c-65b6-3657-1f078b0803e2@suse.de>
Message-ID: <20181116082359.GB14269@lst.de>

On Fri, Nov 16, 2018@09:21:46AM +0100, Hannes Reinecke wrote:
> If we can agree that we'll go for the round-robin scheduler I guess this 
> patchset can be retracted (for now).
> There still might be some gain to be had, but it can be implemented as an 
> additional I/O policy.

I don't think we can.  round-robin is fundamentally the wrong thing
to do as you keep touching different cache lines.  If a customer really
insists on round robin they are probably better off in a SCSI world..
