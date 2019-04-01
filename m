From: david@fromorbit.com (Dave Chinner)
Date: Mon, 1 Apr 2019 16:08:21 +1100
Subject: [PATCH v3 3/7] block: add write-hint to stream-id conversion
In-Reply-To: <1553846032-4451-4-git-send-email-joshi.k@samsung.com>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075749epcas2p22b85cbdbb7ccb4f7f3ecf69b84f75dc9@epcas2p2.samsung.com>
 <1553846032-4451-4-git-send-email-joshi.k@samsung.com>
Message-ID: <20190401050821.GQ23020@dastard>

On Fri, Mar 29, 2019@01:23:48PM +0530, Kanchan Joshi wrote:
> Earlier this conversion was done by driver (nvme). Current conversion
> is of the form "streamid = write-hint - 1", for both user and kernel
> streams (note that existing infra takes care that user-streams do not
> bump into kernel ones).

Unless we add new user streams, then all the kernel streams change
ID. I'll deal with this in more detail in a later patch.

> Conversion takes stream limit (maintained in
> request queue) into account. Write-hints beyond the queue-limit turn
> to 0.
> New field 'streamid' has been added in request. While 'write-hint' field
> continues to exist. It keeps original value passed from upper layer, and
> used during merging checks.
> 
> Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
> ---
>  block/blk-core.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/block/blk-core.c b/block/blk-core.c
> index 3c5f61c..c86daed 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -727,6 +727,25 @@ bool blk_attempt_plug_merge(struct request_queue *q, struct bio *bio,
>  	return false;
>  }
>  
> +enum rw_hint blk_write_hint_to_streamid(struct request *req,
> +				        struct bio *bio)
> +{
> +	enum rw_hint streamid, nr_streams;
> +	struct request_queue *q = req->q;
> +	nr_streams = q->limits.nr_streams;
> +
> +	streamid = bio->bi_write_hint;
> +	if (!nr_streams || streamid == WRITE_LIFE_NOT_SET ||
> +	    streamid == WRITE_LIFE_NONE)
> +		streamid = 0;
> +	else {
> +		--streamid;

What's this magic thing do?

> +		if(streamid > nr_streams)
> +			streamid = 0;

So, basically, we'll compress all the kernel hints down to "no hint"
if there are more user streams than the device supports?

Surely we should be reserving a stream for the kernel hints separate
from the user and "none" streams when we have limited device streams
available...

Cheers,

Dave.
-- 
Dave Chinner
david at fromorbit.com
