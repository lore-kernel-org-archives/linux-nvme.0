From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Tue, 17 Oct 2017 14:28:29 +0000
Subject: [PATCH v2 7/8] scsi/pmcraid: Remove an unused structure member
In-Reply-To: <5ea64c10-aa3e-f0ee-cfba-e93b3d8e1428@suse.de>
References: <20171016224940.1332-1-bart.vanassche@wdc.com>
 <20171016224940.1332-8-bart.vanassche@wdc.com>
 <5ea64c10-aa3e-f0ee-cfba-e93b3d8e1428@suse.de>
Message-ID: <1508250508.3596.0.camel@wdc.com>

On Tue, 2017-10-17@08:21 +0200, Hannes Reinecke wrote:
> On 10/17/2017 12:49 AM, Bart Van Assche wrote:
> > Signed-off-by: Bart Van Assche <bart.vanassche at wdc.com>
> > Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> > Cc: linux-scsi at vger.kernel.org
> > Cc: Martin K. Petersen <martin.petersen at oracle.com>
> > Cc: Anil Ravindranath <anil_ravindranath at pmc-sierra.com>
> > ---
> >  drivers/scsi/pmcraid.h | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/scsi/pmcraid.h b/drivers/scsi/pmcraid.h
> > index 8bfac72a242b..44da91712115 100644
> > --- a/drivers/scsi/pmcraid.h
> > +++ b/drivers/scsi/pmcraid.h
> > @@ -542,7 +542,6 @@ struct pmcraid_sglist {
> >  	u32 order;
> >  	u32 num_sg;
> >  	u32 num_dma_sg;
> > -	u32 buffer_len;
> >  	struct scatterlist scatterlist[1];
> >  };
> >  
> > 
> 
> This actually is the same story that we've had with ipr (and, looking at
> the code, those two drivers look awfully similar ...).
> pmcraid_sglist looks as if it's a hardware-dependent structure, so just
> removing one entry from the middle of a structure might not be a good idea.
> But this is something for the pmcraid folks to clarify.

Hello Hannes,

Sorry but I don't see how a structure that contains a struct scatterlist
could be hardware-dependent?

Thanks,

Bart.
