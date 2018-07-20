From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Fri, 20 Jul 2018 16:03:18 +0000
Subject: [PATCH 2/2] scsi: set timed out out mq requests to complete
In-Reply-To: <20180720155646.GE4093@localhost.localdomain>
References: <20180719212618.2406-1-keith.busch@intel.com>
 <20180719212618.2406-2-keith.busch@intel.com>
 <1073d0d2902327970c4e28a4c7c97a21fd8885c8.camel@wdc.com>
 <20180720155646.GE4093@localhost.localdomain>
Message-ID: <2b01f0a8d5864b2563573d46ce5b4ec5f593f538.camel@wdc.com>

On Fri, 2018-07-20@09:56 -0600, Keith Busch wrote:
> On Fri, Jul 20, 2018@03:12:59PM +0000, Bart Van Assche wrote:
> > On Thu, 2018-07-19@15:26 -0600, Keith Busch wrote:
> > > diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > > index 8932ae81a15a..86ee10b2c775 100644
> > > --- a/drivers/scsi/scsi_error.c
> > > +++ b/drivers/scsi/scsi_error.c
> > > @@ -286,6 +286,9 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
> > >  	enum blk_eh_timer_return rtn = BLK_EH_DONE;
> > >  	struct Scsi_Host *host = scmd->device->host;
> > >  
> > > +	if (req->q->mq_ops && blk_mq_mark_complete(req))
> > > +		return rtn;
> > > +
> > >  	trace_scsi_dispatch_cmd_timeout(scmd);
> > >  	scsi_log_completion(scmd, TIMEOUT_ERROR);
> > >  
> > > @@ -300,7 +303,8 @@ enum blk_eh_timer_return scsi_times_out(struct request *req)
> > >  			set_host_byte(scmd, DID_TIME_OUT);
> > >  			scsi_eh_scmd_add(scmd);
> > >  		}
> > > -	}
> > > +	} else if (req->q->mq_ops)
> > > +		WRITE_ONCE(req->state, MQ_RQ_IN_FLIGHT);
> > >  
> > >  	return rtn;
> > >  }
> > 
> > Modifying the completion state and req->state from the SCSI core are layering
> > violations. Have you considered to move the above changes into blk_mq_rq_timed_out()?
> > An additional benefit of that approach is that the req->q->mq_ops checks can be
> > left out.
> 
> SCSI is the only block driver that wants this behavior. Moving it back
> to generic where it used to be breaks other block drivers.

That's new to me. What would break in the NVMe driver if the above change would be
present in the block layer?

Thanks,

Bart.
