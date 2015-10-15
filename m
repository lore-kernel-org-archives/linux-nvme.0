From: keith.busch@intel.com (Keith Busch)
Date: Thu, 15 Oct 2015 15:13:23 +0000 (UTC)
Subject: [PATCH] nvme: use an integer value to Linux errno values
In-Reply-To: <20151015145752.GA8622@infradead.org>
References: <1444677819-23822-1-git-send-email-hch@lst.de>
 <20151015145752.GA8622@infradead.org>
Message-ID: <alpine.LNX.2.00.1510151500510.27742@localhost.lm.intel.com>

On Thu, 15 Oct 2015, Christoph Hellwig wrote:
> On Mon, Oct 12, 2015@09:23:39PM +0200, Christoph Hellwig wrote:
>>  drivers/nvme/host/pci.c | 12 +++++++-----
>>  1 file changed, 7 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index a526696..9049888 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -606,8 +606,8 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
>>  	struct nvme_iod *iod = ctx;
>>  	struct request *req = iod_get_private(iod);
>>  	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
>> -
>>  	u16 status = le16_to_cpup(&cqe->status) >> 1;
>> +	int error;

My compiler didn't warn, so maybe I'm missing something, but this looks
like this needs to initialize error to 0, right? It's setting error only
in the non-zero status case, but used in both cases.


>>  	if (unlikely(status)) {
>>  		if (!(status & NVME_SC_DNR || blk_noretry_request(req))
>> @@ -624,9 +624,11 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
>>
>>  		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
>>  			if (cmd_rq->ctx == CMD_CTX_CANCELLED)
>> -				status = -EINTR;
>> +				error = -EINTR;
>> +			else
>> +				error = status;
>>  		} else {
>> -			status = nvme_error_status(status);
>> +			error = nvme_error_status(status);
>>  		}
>>  	}
>>
>> @@ -638,7 +640,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
>>  	if (cmd_rq->aborted)
>>  		dev_warn(nvmeq->dev->dev,
>>  			"completing aborted command with status:%04x\n",
>> -			status);
>> +			error);
>>
>>  	if (iod->nents) {
>>  		dma_unmap_sg(nvmeq->dev->dev, iod->sg, iod->nents,
>> @@ -652,7 +654,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
>>  	}
>>  	nvme_free_iod(nvmeq->dev, iod);
>>
>> -	blk_mq_complete_request(req, status);
>> +	blk_mq_complete_request(req, error);
>>  }
