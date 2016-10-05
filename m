From: james.smart@broadcom.com (James Smart)
Date: Wed, 5 Oct 2016 16:25:02 -0700
Subject: [PATCH 3/7] nvme-fabrics: Add FC transport LLDD api definitions
In-Reply-To: <e05c6248-f01e-34c1-0879-6a706b2bd910@suse.de>
References: <57f34bb3.U9l0eB8GDwRhZlnY%james.smart@broadcom.com>
 <e05c6248-f01e-34c1-0879-6a706b2bd910@suse.de>
Message-ID: <591d3189-39ed-3c24-72a5-664bc0ce2c44@broadcom.com>



On 10/4/2016 12:36 AM, Hannes Reinecke wrote:
> We really need to work on integration with the SCSI FC code.
> But I'd rather see to get this in first.
> So:
>
> Reviewed-by: Hannes Reinecke <hare at suse.com>
>
> Cheers,
>
> Hannes

I would not hold this up based on merging the scsi fc transport with the 
nvme fc transport - for topology items.  We can do this eventually, and 
it'll really change how things are layered with scsi (flips the fc 
transport devices/objects closer to the root device than the scsi host), 
making it very different from other scsi transports as well. lots of 
code change, especially to LLDD's.  Not something done lightly.

-- james
