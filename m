From: axboe@kernel.dk (Jens Axboe)
Date: Mon, 19 Nov 2018 08:21:32 -0700
Subject: [PATCH 6/7] block: make blk_poll() take a parameter on whether to
 spin or not
In-Reply-To: <20181119080544.GF9622@infradead.org>
References: <20181117214354.822-1-axboe@kernel.dk>
 <20181117214354.822-7-axboe@kernel.dk> <20181119080544.GF9622@infradead.org>
Message-ID: <04b6015e-2949-750d-01a0-640373b406ea@kernel.dk>

On 11/19/18 1:05 AM, Christoph Hellwig wrote:
>> -bool blk_poll(struct request_queue *q, blk_qc_t cookie)
>> +bool blk_poll(struct request_queue *q, blk_qc_t cookie, bool spin)
> 
> I find the paramter name a little confusing.  Maybe wait_for_request,
> although I don't particularly like that one either.  But we really need
> to document the parameter well here, no matter what we end up naming
> it.  And we should use a consistent name through the whole stack.

spin_until_found? I don't like using 'wait*' as we're not waiting.

>> index c1ec3475a140..f6971b45bc54 100644
>> --- a/drivers/nvme/target/io-cmd-bdev.c
>> +++ b/drivers/nvme/target/io-cmd-bdev.c
>> @@ -116,7 +116,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
>>  
>>  	cookie = submit_bio(bio);
>>  
>> -	blk_poll(bdev_get_queue(req->ns->bdev), cookie);
>> +	blk_poll(bdev_get_queue(req->ns->bdev), cookie, true);
> 
> This opportunistic poll is pretty bogus now as we never set the HIPRI
> flag and it should probably be removed in a prep patch.  We should then
> later try to use a scheme similar to your aio polling for the nvme
> target as well.

I'll kill it in a pre-patch.

-- 
Jens Axboe
