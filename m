From: hare@suse.de (Hannes Reinecke)
Date: Thu, 6 Oct 2016 08:30:33 +0200
Subject: [PATCH 3/7] nvme-fabrics: Add FC transport LLDD api definitions
In-Reply-To: <591d3189-39ed-3c24-72a5-664bc0ce2c44@broadcom.com>
References: <57f34bb3.U9l0eB8GDwRhZlnY%james.smart@broadcom.com>
 <e05c6248-f01e-34c1-0879-6a706b2bd910@suse.de>
 <591d3189-39ed-3c24-72a5-664bc0ce2c44@broadcom.com>
Message-ID: <b39ef0d4-741b-6885-ae07-0dac058ee936@suse.de>

On 10/06/2016 01:25 AM, James Smart wrote:
>
>
> On 10/4/2016 12:36 AM, Hannes Reinecke wrote:
>> We really need to work on integration with the SCSI FC code.
>> But I'd rather see to get this in first.
>> So:
>>
>> Reviewed-by: Hannes Reinecke <hare at suse.com>
>>
>> Cheers,
>>
>> Hannes
>
> I would not hold this up based on merging the scsi fc transport with the
> nvme fc transport - for topology items.  We can do this eventually, and
> it'll really change how things are layered with scsi (flips the fc
> transport devices/objects closer to the root device than the scsi host),
> making it very different from other scsi transports as well. lots of
> code change, especially to LLDD's.  Not something done lightly.
>
In the light of your explanation of the previous patch I agree with you.
We should be looking into integration, but this should be done at a 
later step. Especially as nvmet has similar issues right now.
So I retract my objection.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		      zSeries & Storage
hare at suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: J. Hawn, J. Guild, F. Imend?rffer, HRB 16746 (AG N?rnberg)
