From: james.smart@broadcom.com (James Smart)
Date: Wed, 5 Oct 2016 16:21:12 -0700
Subject: [PATCH 1/7] nvme-fabrics: Add FC transport FC-NVME definitions
In-Reply-To: <20161004135825.GB23761@infradead.org>
References: <57f34bb1.R7Xz9kkZOAJuQODz%james.smart@broadcom.com>
 <60438ee8-66d4-4730-fed3-470a12bfa9a1@suse.de>
 <20161004135825.GB23761@infradead.org>
Message-ID: <8eec5d73-98f4-7663-8b4f-85a33b21a71f@broadcom.com>



On 10/4/2016 6:58 AM, Christoph Hellwig wrote:
> On Tue, Oct 04, 2016@09:32:39AM +0200, Hannes Reinecke wrote:
>> I would have loved to use the SCSI FC headers here; eg the definitions
>> for FC-LS are most definitely duplicated.
>> But until we've sorted that one out:
> I remember we discussed this before, but I've forgot the outcome on
> why this needed to be separate.  IIRC it was just a timing issue,
> but now that we've just missed the previous merge window we should
> have plenty of time to sort that out properly.  Correct me if I'm wrong.

I looked at the include/uapi/scsi/fc headers.

The only field that should be there is the addition of the NVME type code.

The LS's things - although they look very similar to ELS things, they 
aren't the same thing.  The LS items are specific to type code 0x28 - a 
value in the FC frame header, while ELS's are type code 0x01 in the 
frame header.  The content is specific to the type code.  True, some of 
the formats, like xx_ACC, and a little of xx_RJT are similar (on purpose 
by the fc-nvme group) - there's no real reason that they had to be, so 
actually forcing things into using the other's structures isn't a good 
idea in case things change.

After looking at it - the only thing that I was wondering is whether the 
fc-nvme definitions should be in "include/linux/nvme-fc.h" as it's 
specific to nvme fabrics or whether they should be in 
"include/uapi/scsi/fc/fc-nvme.h" - so it's in a location where all other 
fc'isms are at. Even though NVME and the scsi directory name doesn't 
seem to make sense.

-- james
