From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 May 2015 10:00:55 +0200
Subject: [PATCH 7/7] block: allocate block_pc data separate from struct
 request
In-Reply-To: <5549FF0A.6010901@electrozaur.com>
References: <1429303042-12078-1-git-send-email-hch@lst.de>
 <1429303042-12078-8-git-send-email-hch@lst.de>
 <5549FF0A.6010901@electrozaur.com>
Message-ID: <20150511080054.GA32417@lst.de>

On Wed, May 06, 2015@02:46:18PM +0300, Boaz Harrosh wrote:
> > -	memset(rq->__cmd, 0, sizeof(rq->__cmd));
> > +
> > +	rq->block_pc = kzalloc(sizeof(*rq->block_pc) + cmd_len, gfp);
> 
> I wish you would not embed a dynamic allocation here for any
> driver regardless. This extra allocation does hurt a lot. See how in
> SCSI fs commands you embedded it in scsi_cmnd so it catches as well
> for multi-Q pre-allocation.
> 
> I think you need to just make it the same as *sense pass it from outside
> and the allocation is the caller responsibility. The caller must have
> an end-request call back set. (Or is a sync call)
> 
> Usually all users already have a structure to put this in. The only bit
> more work is to take care of the free. If they are already passing sense
> then they already need to free at end of request. Those that are synchronous
> can have it on the stack. Only very few places need a bit of extra work.

Actually most don't have a structure ready, that's why I ressorted to this
version.  But once this is in you can easily add low-level version that
allows passing a preallocate cdb buffer for the OSD case.

> > +struct block_pc_request {
> > +	unsigned short cmd_len;
> > +	unsigned int sense_len;
> > +	void *sense;
> 
> Better move cmd_len here the short will combine well
> with the char array.

Thanks.

> > +	union {
> > +		struct block_pc_request *block_pc;
> > +		void *drv_private;
> > +	};
> > +
> 
> Exactly. drv_private is allocated by caller we can do the same for
> block_pc. Also If (theoretically) a driver needs both it is just the
> same pointer right? (container_of)

I probably need to rename the field.  It's only driver private when
the low-level driver itself submits the request, e.g. internal commands
in the LLDD.  But in that particular case what you suggest is fine.
