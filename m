From: keith.busch@intel.com (Keith Busch)
Date: Fri, 29 May 2015 17:58:37 +0000 (UTC)
Subject: [PATCH 2/2] NVMe: Remove hctx reliance for multi-namespace
In-Reply-To: <20150529162944.GA31249@infradead.org>
References: <1432838222-4076-1-git-send-email-keith.busch@intel.com>
 <1432838222-4076-2-git-send-email-keith.busch@intel.com>
 <20150529162944.GA31249@infradead.org>
Message-ID: <alpine.LNX.2.00.1505291754580.15930@localhost.lm.intel.com>

On Fri, 29 May 2015, Christoph Hellwig wrote:
>> +static void nvme_exit_tags(void *data, unsigned int hctx_idx)
>>  {
>> +	struct nvme_dev *dev = data;
>> +	struct nvme_queue *nvmeq = dev->queues[
>> +					(hctx_idx % dev->queue_count) + 1];
>> +	nvmeq->tags = NULL;
>> +}
>>
>> +static int nvme_init_tags(struct blk_mq_tags *tags, void *data,
>> +			  unsigned int hctx_idx)
>> +{
>> +	struct nvme_dev *dev = data;
>> +	struct nvme_queue *nvmeq = dev->queues[
>> +					(hctx_idx % dev->queue_count) + 1];
>> +	WARN_ON(nvmeq->tags);
>> +	nvmeq->tags = tags;
>> +	return 0;
>
> I'd rather do the runtime indexing with the qid into the tags array than
> adding these methods.  I also don't see why you need the modulo
> arithmetic.

Good call. I copied the modulo from existing functions, but that's
useless since hctx_idx is never > queue_count.

Only now do I see I can get the tags with

 	dev->tagset->tags[nvmeq->qid - 1]

This will simplify a lot of things...

> Otherwise the series looks nice to me.
