From: axboe@fb.com (Jens Axboe)
Date: Thu, 15 Oct 2015 09:51:35 -0600
Subject: [PATCH] nvme: use an integer value to Linux errno values
In-Reply-To: <20151015153032.GA2156@infradead.org>
References: <1444677819-23822-1-git-send-email-hch@lst.de>
 <20151015145752.GA8622@infradead.org>
 <alpine.LNX.2.00.1510151500510.27742@localhost.lm.intel.com>
 <20151015153032.GA2156@infradead.org>
Message-ID: <561FCB87.6090006@fb.com>

On 10/15/2015 09:30 AM, Christoph Hellwig wrote:
> On Thu, Oct 15, 2015@03:13:23PM +0000, Keith Busch wrote:
>> On Thu, 15 Oct 2015, Christoph Hellwig wrote:
>>> On Mon, Oct 12, 2015@09:23:39PM +0200, Christoph Hellwig wrote:
>>>> drivers/nvme/host/pci.c | 12 +++++++-----
>>>> 1 file changed, 7 insertions(+), 5 deletions(-)
>>>>
>>>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>>>> index a526696..9049888 100644
>>>> --- a/drivers/nvme/host/pci.c
>>>> +++ b/drivers/nvme/host/pci.c
>>>> @@ -606,8 +606,8 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
>>>> 	struct nvme_iod *iod = ctx;
>>>> 	struct request *req = iod_get_private(iod);
>>>> 	struct nvme_cmd_info *cmd_rq = blk_mq_rq_to_pdu(req);
>>>> -
>>>> 	u16 status = le16_to_cpup(&cqe->status) >> 1;
>>>> +	int error;
>>
>> My compiler didn't warn, so maybe I'm missing something, but this looks
>> like this needs to initialize error to 0, right? It's setting error only
>> in the non-zero status case, but used in both cases.
>
> Yes, it should be set to zero.  That's what I did in the tested version
> because this one will actually blow up.

Good catch Keith, I've fixed it up.

-- 
Jens Axboe
