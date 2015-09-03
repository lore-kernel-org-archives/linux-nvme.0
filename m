From: axboe@kernel.dk (Jens Axboe)
Date: Thu, 3 Sep 2015 08:53:18 -0600
Subject: [PATCH 3/3] block: Refuse adding appending a gapped integrity
 page to a bio
In-Reply-To: <55E80DD4.9000505@dev.mellanox.co.il>
References: <55A67C17.4080706@kernel.dk>
 <20150716092646.GA17712@infradead.org> <55A7D4B6.9020101@kernel.dk>
 <55ABBFB1.7070201@dev.mellanox.co.il> <20150819094003.GB14734@infradead.org>
 <55D45AE0.50805@dev.mellanox.co.il> <20150819104246.GA4956@infradead.org>
 <55E6ADA4.5040905@dev.mellanox.co.il> <20150902143756.GA11062@kernel.dk>
 <55E7324B.3060601@dev.mellanox.co.il> <20150902191714.GD14454@kernel.dk>
 <55E80DD4.9000505@dev.mellanox.co.il>
Message-ID: <55E85EDE.2080700@kernel.dk>

On 09/03/2015 03:07 AM, Sagi Grimberg wrote:
> On 9/2/2015 10:18 PM, Jens Axboe wrote:
>> On Wed, Sep 02 2015, Sagi Grimberg wrote:
>>>> Does the below work for you?
>>>
>>> It's not on top of Keith virt_boundary patch right?
>>> First glance looks ok though.
>>
>> Updated for that.
>>
>
> Thanks Jens,
>
> I'll test it.
>
>>
>> diff --git a/block/blk-merge.c b/block/blk-merge.c
>> index b2625271a572..5f35a05337b1 100644
>> --- a/block/blk-merge.c
>> +++ b/block/blk-merge.c
>> @@ -436,9 +436,27 @@ no_merge:
>>       return 0;
>>   }
>>
>> +static bool req_gap_to_prev(struct request *req, struct bio *next)
>> +{
>> +    struct bio *prev = req->biotail;
>> +
>> +    return bvec_gap_to_prev(req->q, &prev->bi_io_vec[prev->bi_vcnt - 1],
>> +                next->bi_io_vec[0].bv_offset);
>> +}
>> +
>> +static bool req_gap_to_next(struct request *req, struct bio *bio)
>> +{
>> +    struct bio *next = req->bio;
>> +
>> +    return bvec_gap_to_prev(req->q, &bio->bi_io_vec[bio->bi_vcnt - 1],
>> +                next->bi_io_vec[0].bv_offset);
>> +}
>> +
>>   int ll_back_merge_fn(struct request_queue *q, struct request *req,
>>                struct bio *bio)
>>   {
>> +    if (bio_has_data(bio) && req_gap_to_prev(req, bio))
>> +        return 0;
>>       if (blk_rq_sectors(req) + bio_sectors(bio) >
>>           blk_rq_get_max_sectors(req)) {
>>           req->cmd_flags |= REQ_NOMERGE;
>> @@ -457,6 +475,9 @@ int ll_back_merge_fn(struct request_queue *q,
>> struct request *req,
>>   int ll_front_merge_fn(struct request_queue *q, struct request *req,
>>                 struct bio *bio)
>>   {
>> +
>> +    if (bio_has_data(bio) && req_gap_to_next(req, bio))
>> +        return 0;
>
> I think it will be cleaner to git bio_has_data(bio) check into
> req_gap_to_[prev|next]

Yeah I agree, I'll make that change.

-- 
Jens Axboe
