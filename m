From: axboe@kernel.dk (Jens Axboe)
Date: Tue, 27 Nov 2018 16:59:14 -0700
Subject: [PATCH 2/8] block: improve logic around when to sort a plug list
In-Reply-To: <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
References: <20181126163556.5181-1-axboe@kernel.dk>
 <20181126163556.5181-3-axboe@kernel.dk> <20181127233142.GB846@vader>
 <b6cfc7c8-39f4-252b-8c27-3a75f561061a@kernel.dk>
Message-ID: <62f96268-f596-78b8-d227-6be1f5ae1cea@kernel.dk>

On 11/27/18 4:49 PM, Jens Axboe wrote:
> On 11/27/18 4:31 PM, Omar Sandoval wrote:
>> On Mon, Nov 26, 2018@09:35:50AM -0700, Jens Axboe wrote:
>>> Do it for the nr_hw_queues == 1 case, but only do it for the multi queue
>>> case if we have requests for multiple devices in the plug.
>>>
>>> Signed-off-by: Jens Axboe <axboe at kernel.dk>
>>> ---
>>>  block/blk-core.c       | 1 +
>>>  block/blk-mq.c         | 7 +++++--
>>>  include/linux/blkdev.h | 1 +
>>>  3 files changed, 7 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/block/blk-core.c b/block/blk-core.c
>>> index be9233400314..c9758d185357 100644
>>> --- a/block/blk-core.c
>>> +++ b/block/blk-core.c
>>> @@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
>>>  	INIT_LIST_HEAD(&plug->mq_list);
>>>  	INIT_LIST_HEAD(&plug->cb_list);
>>>  	plug->rq_count = 0;
>>> +	plug->do_sort = false;
>>>  
>>>  	/*
>>>  	 * Store ordering should not be needed here, since a potential
>>> diff --git a/block/blk-mq.c b/block/blk-mq.c
>>> index 99c66823d52f..6a249bf6ed00 100644
>>> --- a/block/blk-mq.c
>>> +++ b/block/blk-mq.c
>>> @@ -1678,7 +1678,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
>>>  	list_splice_init(&plug->mq_list, &list);
>>>  	plug->rq_count = 0;
>>>  
>>> -	list_sort(NULL, &list, plug_rq_cmp);
>>> +	if (plug->do_sort)
>>> +		list_sort(NULL, &list, plug_rq_cmp);
>>>  
>>>  	this_q = NULL;
>>>  	this_hctx = NULL;
>>> @@ -1935,6 +1936,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>>  
>>>  		list_add_tail(&rq->queuelist, &plug->mq_list);
>>>  		plug->rq_count++;
>>> +		plug->do_sort = true;
>>>  	} else if (plug && !blk_queue_nomerges(q)) {
>>>  		blk_mq_bio_to_request(rq, bio);
>>>  
>>> @@ -1958,7 +1960,8 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
>>>  			data.hctx = same_queue_rq->mq_hctx;
>>>  			blk_mq_try_issue_directly(data.hctx, same_queue_rq,
>>>  					&cookie);
>>> -		}
>>> +		} else if (plug->rq_count > 1)
>>> +			plug->do_sort = true;
>>
>> If plug->rq_count == 2, there's no benefit to sorting, either. The
>> nr_hw_queues == 1 case could also avoid sorting in that case. So maybe
>> this whole patch could just be replaced with:
> 
> Heh yes, good point, it should be 3 at least. But if you look at the
> later mq plug patch, we only sort for that one if we have multiple
> queues. So the logic should be something ala:
> 
> if (plug->rq_count > 2 && plug->has_multiple_queues)
> 
> since that's the only case we want to sort for.

How about something like this?


diff --git a/block/blk-core.c b/block/blk-core.c
index be9233400314..d107d016b92b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1780,6 +1780,7 @@ void blk_start_plug(struct blk_plug *plug)
 	INIT_LIST_HEAD(&plug->mq_list);
 	INIT_LIST_HEAD(&plug->cb_list);
 	plug->rq_count = 0;
+	plug->multiple_queues = false;
 
 	/*
 	 * Store ordering should not be needed here, since a potential
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 7b7dff85cf6c..02daa32c5d77 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1677,7 +1677,8 @@ void blk_mq_flush_plug_list(struct blk_plug *plug, bool from_schedule)
 	list_splice_init(&plug->mq_list, &list);
 	plug->rq_count = 0;
 
-	list_sort(NULL, &list, plug_rq_cmp);
+	if (plug->rq_count > 2 && plug->multiple_queues)
+		list_sort(NULL, &list, plug_rq_cmp);
 
 	this_q = NULL;
 	this_hctx = NULL;
@@ -1866,6 +1867,20 @@ void blk_mq_try_issue_list_directly(struct blk_mq_hw_ctx *hctx,
 	}
 }
 
+static void blk_add_rq_to_plug(struct blk_plug *plug, struct request *rq)
+{
+	list_add_tail(&rq->queuelist, &plug->mq_list);
+	plug->rq_count++;
+	if (!plug->multiple_queues && !list_is_singular(&plug->mq_list)) {
+		struct request *tmp;
+
+		tmp = list_first_entry(&plug->mq_list, struct request,
+						queuelist);
+		if (tmp->q != rq->q)
+			plug->multiple_queues = true;
+	}
+}
+
 static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 {
 	const int is_sync = op_is_sync(bio->bi_opf);
@@ -1932,8 +1947,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			trace_block_plug(q);
 		}
 
-		list_add_tail(&rq->queuelist, &plug->mq_list);
-		plug->rq_count++;
+		blk_add_rq_to_plug(plug, rq);
 	} else if (plug && !blk_queue_nomerges(q)) {
 		blk_mq_bio_to_request(rq, bio);
 
@@ -1948,8 +1962,7 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 			same_queue_rq = NULL;
 		if (same_queue_rq)
 			list_del_init(&same_queue_rq->queuelist);
-		list_add_tail(&rq->queuelist, &plug->mq_list);
-		plug->rq_count++;
+		blk_add_rq_to_plug(plug, rq);
 
 		blk_mq_put_ctx(data.ctx);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02732cae6080..08d940f85fa0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1131,6 +1131,7 @@ struct blk_plug {
 	struct list_head mq_list; /* blk-mq requests */
 	struct list_head cb_list; /* md requires an unplug callback */
 	unsigned short rq_count;
+	bool multiple_queues;
 };
 #define BLK_MAX_REQUEST_COUNT 16
 #define BLK_PLUG_FLUSH_SIZE (128 * 1024)

-- 
Jens Axboe
