From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 20 Apr 2017 17:16:37 -0600
Subject: [PATCH] blk-mq: Fix poll_stat for new size-based bucketing.
In-Reply-To: <8F6E7173-D719-4E85-9F18-7B20319E972C@raithlin.com>
References: <1492729151-20983-1-git-send-email-sbates@raithlin.com>
 <44a0b09e-d150-a0e8-f5e2-5792f4d4f74a@kernel.dk>
 <8F6E7173-D719-4E85-9F18-7B20319E972C@raithlin.com>
Message-ID: <841b5b27-b498-207a-f360-ba4347c7809d@kernel.dk>

On 04/20/2017 05:13 PM, Stephen  Bates wrote:
> 
>> Thanks, added. BTW, in the future, we have a format for specifying
>> if a patch fixes another patch. This should have been:
> 
> Thanks!
> 
>> Fixes: 720b8ccc4500 ("blk-mq: Add a polling specific stats function")
> 
> Duly noted for next time. Apologies for the miss?

No worries, I fixed it up for you while committing.

-- 
Jens Axboe
