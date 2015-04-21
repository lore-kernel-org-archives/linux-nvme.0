From: kwan.huen@samsung.com (Hingkwan Huen)
Date: Tue, 21 Apr 2015 12:03:37 -0700
Subject: [PATCH 1/2] added stream id write support
In-Reply-To: <x49y4ll8uk3.fsf@segfault.boston.devel.redhat.com>
References: <1429580863-3451-1-git-send-email-kwan.huen@samsung.com>
 <1429580863-3451-2-git-send-email-kwan.huen@samsung.com>
 <x49y4ll8uk3.fsf@segfault.boston.devel.redhat.com>
Message-ID: <000f01d07c65$e0721b60$a1565220$@samsung.com>



> -----Original Message-----
> From: Jeff Moyer [mailto:jmoyer at redhat.com]
> Sent: Tuesday, April 21, 2015 6:45 AM
> To: kwan.huen
> Cc: Matthew Wilcox; Keith Busch; Jens Axboe; Dimitri John Ledkov; linux-
> nvme at lists.infradead.org; linux-kernel at vger.kernel.org; linux-
> api at vger.kernel.org
> Subject: Re: [PATCH 1/2] added stream id write support
> 
> "kwan.huen" <kwan.huen at samsung.com> writes:
> 
> > ---
> >  drivers/block/nvme-core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
> > index 85b8036..332341a 100644
> > --- a/drivers/block/nvme-core.c
> > +++ b/drivers/block/nvme-core.c
> > @@ -769,6 +769,9 @@ static int nvme_submit_iod(struct nvme_queue
> *nvmeq, struct nvme_iod *iod,
> >  	if (req->cmd_flags & REQ_RAHEAD)
> >  		dsmgmt |= NVME_RW_DSM_FREQ_PREFETCH;
> >
> > +	if (rq_data_dir(req))
> > +		dsmgmt |= bio_get_streamid(req->bio) << 8;
> > +
> 
> There's no public specification for this, yet.  How many bits are set
aside for
> the stream id?  Do you need to do bounds checking/input validation?  What
> happens on adapters with older firmware when these bits are set?
> 
> Cheers,
> Jeff

Thanks Jeff for the review! 
The patch depends on Jens' recent io-streamid patch set, and the new NVMe
spec we are trying to get approved.
The patch is probably still too early and we'll push this again when Jens'
patches are released and the new spec goes public.
Thanks,
kwan
