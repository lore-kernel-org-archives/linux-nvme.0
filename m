From: keith.busch@intel.com (Keith Busch)
Date: Tue, 1 Sep 2015 16:20:18 +0000 (UTC)
Subject: [PATCHv4] blk: Replace SG_GAPGS with new queue limits mask
In-Reply-To: <55E5AFD2.6080200@dev.mellanox.co.il>
References: <1438716733-566-1-git-send-email-keith.busch@intel.com>
 <55E5AFD2.6080200@dev.mellanox.co.il>
Message-ID: <alpine.LNX.2.00.1509011609120.23840@localhost.lm.intel.com>

On Tue, 1 Sep 2015, Sagi Grimberg wrote:
>> -static int req_gap_to_prev(struct request *req, struct request *next)
>> +static int req_gap_to_prev(struct request *req, struct bio *next)
>>   {
>>   	struct bio *prev = req->biotail;
>> 
>> -	return bvec_gap_to_prev(&prev->bi_io_vec[prev->bi_vcnt - 1],
>> -				next->bio->bi_io_vec[0].bv_offset);
>> +	return bvec_gap_to_prev(req->q, &prev->bi_io_vec[prev->bi_vcnt - 1],
>> +			next->bi_io_vec[1].bv_offset);
>
> Keith,
>
> is the index change in the bi_io_vec intentional?

Oh no, that is a mistake. Thank you for the notice, fix coming shortly.
