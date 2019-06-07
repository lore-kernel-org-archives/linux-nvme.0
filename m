From: martin.petersen@oracle.com (Martin K. Petersen)
Date: Fri, 07 Jun 2019 13:30:30 -0400
Subject: properly communicate queue limits to the DMA layer
In-Reply-To: <f07d0abf-b3eb-f530-37b9-e66454740b3f@kernel.dk> (Jens Axboe's
 message of "Thu, 6 Jun 2019 23:52:35 -0600")
References: <20190605190836.32354-1-hch@lst.de>
 <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
 <20190605192405.GA18243@lst.de>
 <f07d0abf-b3eb-f530-37b9-e66454740b3f@kernel.dk>
Message-ID: <yq1o939i9qh.fsf@oracle.com>


Jens,

>> The SCSI bits will need a bit more review, and possibly tweaking
>> fo megaraid and mpt3sas.  But they are really independent of the
>> other patches, so maybe skip them for now and leave them for Martin
>> to deal with.
>
> I dropped the SCSI bits.

I'll monitor and merge them.

-- 
Martin K. Petersen	Oracle Linux Engineering
