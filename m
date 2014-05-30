From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 30 May 2014 13:46:44 -0600
Subject: [PATCH v4] NVMe: basic conversion to blk-mq
In-Reply-To: <20140530150050.GD5499@linux.intel.com>
References: <1401400285-25003-1-git-send-email-m@bjorling.me>
 <1401400285-25003-2-git-send-email-m@bjorling.me>
 <20140530150050.GD5499@linux.intel.com>
Message-ID: <5388E024.30203@kernel.dk>

On 05/30/2014 09:00 AM, Matthew Wilcox wrote:
> On Thu, May 29, 2014@11:51:25PM +0200, Matias Bj?rling wrote:
>> -static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
>> -		struct bio *bio, enum dma_data_direction dma_dir, int psegs)
>> +static int nvme_map_rq(struct nvme_queue *nvmeq, struct nvme_iod *iod,
>> +		struct request *req, enum dma_data_direction dma_dir,
>> +		int psegs)
>>  {
>> -	struct bio_vec bvec, bvprv;
>> -	struct bvec_iter iter;
>> -	struct scatterlist *sg = NULL;
>> -	int length = 0, nsegs = 0, split_len = bio->bi_iter.bi_size;
>> -	int first = 1;
>> -
>> -	if (nvmeq->dev->stripe_size)
>> -		split_len = nvmeq->dev->stripe_size -
>> -			((bio->bi_iter.bi_sector << 9) &
>> -			 (nvmeq->dev->stripe_size - 1));
> 
> You take out stripe_size here, but don't appear to put it back in
> anywhere else.

So I've been thinking about this one. What kind of performance impact
does it have on the device in question? Because the current logic of
adding to the congested list and waking up the thread is surely not very
fast. I'm assuming you must have seen some win, which means that the
hardware is pretty poor on requests that overlap the stripe size.

Reason I ask is trying to come up with the best strategy to make this
work. My first thought was just doing partial completions. The request
is fully mapped, but only issue the first X bytes that fit within the
stripe. On completion, simply reissue. Rinse and repeat until request is
done. But this serializes the request to the hardware, which is going to
have a performance impact as well. So the better approach would be to
simple alloc more commands and fill those in, issue them all together.
If we run out of commands, simply issue the ones we do have and continue
on completion.

Another approach would be to prevent these requests to begin with, but
that would come with some runtime overhead as well.

I guess what I'm asking (in a long winded way), is how big of an issue
is this? Is this something that the device has fixed in a firmware
update (it should), or is it something we need to care deeply about?

And finally, how big is the stripe size on device in question? That
might impact the design decision.

-- 
Jens Axboe
