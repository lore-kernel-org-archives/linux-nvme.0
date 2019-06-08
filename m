From: axboe@kernel.dk (Jens Axboe)
Date: Sat, 8 Jun 2019 02:10:44 -0600
Subject: properly communicate queue limits to the DMA layer
In-Reply-To: <yq1o939i9qh.fsf@oracle.com>
References: <20190605190836.32354-1-hch@lst.de>
 <591cfa1e-fecb-7d00-c855-3b9eb8eb8a2a@kernel.dk>
 <20190605192405.GA18243@lst.de>
 <f07d0abf-b3eb-f530-37b9-e66454740b3f@kernel.dk> <yq1o939i9qh.fsf@oracle.com>
Message-ID: <379c82a1-f61d-7463-791e-57f1cdeaa9db@kernel.dk>

On 6/7/19 11:30 AM, Martin K. Petersen wrote:
> 
> Jens,
> 
>>> The SCSI bits will need a bit more review, and possibly tweaking
>>> fo megaraid and mpt3sas.  But they are really independent of the
>>> other patches, so maybe skip them for now and leave them for Martin
>>> to deal with.
>>
>> I dropped the SCSI bits.
> 
> I'll monitor and merge them.

Great, thanks Martin.

-- 
Jens Axboe
