From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 17 Apr 2017 10:01:09 -0600
Subject: [PATCH 02/25] block: remove the blk_execute_rq return value
In-Reply-To: <20170414082231.GC24901@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
 <20170406153944.10058-3-hch@lst.de> <1492113800.24345.9.camel@sandisk.com>
 <20170414082231.GC24901@lst.de>
Message-ID: <3257b684-8bec-f48a-e97e-5f2e8f3ca6e4@kernel.dk>

On 04/14/2017 02:22 AM, hch@lst.de wrote:
> On Thu, Apr 13, 2017@08:03:22PM +0000, Bart Van Assche wrote:
>> That blk_execute_rq() call can only be reached if a few lines above 0 was
>> assigned to the "error" variable. Since nfsd4_scsi_identify_device() returns
>> the value of the "error" variable I think -EIO should be assigned to that
>> variable before the "goto out_put_request" statement is reached.
> 
> You're right!  I'll fix it up.

Are you respinning this series for 4.12?

-- 
Jens Axboe
