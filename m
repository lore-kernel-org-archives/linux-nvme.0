From: joshi.k@samsung.com (kanchan)
Date: Mon, 22 Apr 2019 19:03:23 +0530
Subject: [PATCH v4 4/7] block: introduce write-hint to stream-id conversion
In-Reply-To: <9BD0C782-5967-4DCB-9D01-E5BCC73E653C@dilger.ca>
References: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
 <CGME20190417175358epcas1p41a0a4e349dfe0a70bdcc244161c71604@epcas1p4.samsung.com>
 <1555523406-2380-5-git-send-email-joshi.k@samsung.com>
 <20190418140603.GL28541@quack2.suse.cz>
 <9BD0C782-5967-4DCB-9D01-E5BCC73E653C@dilger.ca>
Message-ID: <009b01d4f90f$fb2a3520$f17e9f60$@samsung.com>

> Someone told me that stream ids are potentially persistent on the 
> storage so it isn't great to change the id for the same thing e.g. if 
> we add another user hint. So maybe we should allocate kernel hints 
> from top as Dave Chinner suggested? I.e., something like the following
mapping function:

This function is good. Thank you for sharing. 

-----Original Message-----
From: Andreas Dilger [mailto:adilger@dilger.ca] 
Sent: Friday, April 19, 2019 12:28 AM
To: Jan Kara <jack at suse.cz>
Cc: Kanchan Joshi <joshi.k at samsung.com>; open list
<linux-kernel at vger.kernel.org>; linux-block <linux-block at vger.kernel.org>;
linux-nvme at lists.infradead.org; linux-fsdevel
<linux-fsdevel at vger.kernel.org>; linux-ext4 at vger.kernel.org;
prakash.v at samsung.com
Subject: Re: [PATCH v4 4/7] block: introduce write-hint to stream-id
conversion

On Apr 18, 2019,@8:06 AM, Jan Kara <jack@suse.cz> wrote:
> 
> On Wed 17-04-19 23:20:03, Kanchan Joshi wrote:
>> This patch moves write-hint-to-stream-id conversion in block-layer.
>> Earlier this was done by driver (nvme). Current conversion is of the 
>> form "streamid = write-hint - 1", for both user and kernel streams.
>> Conversion takes stream limit (maintained in request queue) into 
>> account. Write-hints beyond the exposed limit turn to 0.
>> A new field 'streamid' has been added in request. While 'write-hint'
>> field continues to exist. It keeps original value passed from upper 
>> layer, and used during merging checks.
>> 
>> Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
>> ---
>> block/blk-core.c       | 20 ++++++++++++++++++++
>> include/linux/blkdev.h |  1 +
>> 2 files changed, 21 insertions(+)
>> 
>> diff --git a/block/blk-core.c b/block/blk-core.c index 
>> a55389b..712e6b7 100644
>> --- a/block/blk-core.c
>> +++ b/block/blk-core.c
>> @@ -730,6 +730,25 @@ bool blk_attempt_plug_merge(struct request_queue *q,
struct bio *bio,
>> 	return false;
>> }
>> 
>> +enum rw_hint blk_write_hint_to_streamid(struct request *req,
>> +				        struct bio *bio)
>> +{
>> +	enum rw_hint streamid, nr_streams;
>> +	struct request_queue *q = req->q;
>> +	nr_streams = q->limits.nr_streams;
>> +
>> +	streamid = bio->bi_write_hint;
>> +	if (!nr_streams || streamid == WRITE_LIFE_NOT_SET ||
>> +	    streamid == WRITE_LIFE_NONE)
>> +		streamid = 0;
>> +	else {
>> +		--streamid;
>> +		if(streamid > nr_streams)
>> +			streamid = 0;
>> +	}
>> +	return streamid;
>> +}
>> +
> 
> Someone told me that stream ids are potentially persistent on the 
> storage so it isn't great to change the id for the same thing e.g. if 
> we add another user hint. So maybe we should allocate kernel hints 
> from top as Dave Chinner suggested? I.e., something like the following
mapping function:
> 
> 	if (streamid <= BLK_MAX_USER_HINTS) {
> 		streamid--;
> 		if (streamid > nr_streams)
> 			streamid = 0;
> 	} else {
> 		/* Kernel hints get allocated from top */
> 		streamid -= WRITE_LIFE_KERN_MIN;
> 		if (streamid > nr_streams - BLK_MAX_USER_HINTS)
> 			streamid = 0;
> 		else
> 			streamid = nr_streams - streamid - 1;
> 	}
> 
> what do you think?

Dave has expressed this sentiment several times, and I agree.  We don't want
the filesystem hint values/mapping to change over time, or it will conflict
with data that was written with the previous hints (e.g. if data was written
with a "short lifetime" hint suddenly changes to be grouped with a "long
lifetime" hint).  This is easily avoided with some simple changes now, but
harder to fix after this patch has landed.

Cheers, Andreas
