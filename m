From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 23 Jul 2018 08:04:06 -0600
Subject: [PATCH 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <20180723081231.GB19247@lst.de>
References: <20180719212618.2406-2-keith.busch@intel.com>
 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
 <20180720155646.GE4093@localhost.localdomain>
 <2b01f0a8d5864b2563573d46ce5b4ec5f593f538.camel@wdc.com>
 <20180720161240.GF4093@localhost.localdomain>
 <092dd4f2dae0cc533018c9fb829a50b4cbb6cb0b.camel@wdc.com>
 <20180720162321.GG4093@localhost.localdomain>
 <797120d19f5d15e7d98a3d2f90ce91ebf60690d7.camel@wdc.com>
 <20180720172444.GH4093@localhost.localdomain>
 <20180723081231.GB19247@lst.de>
Message-ID: <20180723140406.GB10750@localhost.localdomain>

On Mon, Jul 23, 2018@10:12:31AM +0200, hch@lst.de wrote:
> > diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > index 8932ae81a15a..902c30d3c0ed 100644
> > --- a/drivers/scsi/scsi_error.c
> > +++ b/drivers/scsi/scsi_error.c
> > @@ -296,6 +296,8 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
> >  		rtn = host->hostt->eh_timed_out(scmd);
> >  
> >  	if (rtn == BLK_EH_DONE) {
> > +		if (req->q->mq_ops && blk_mq_mark_complete(req))
> > +			return rtn;
> 
> This looks pretty sensible to me as a band-aid.  It just needs a very
> detailed comment explaining what is going on here.

Sounds good, v2 will be sent shortly.
