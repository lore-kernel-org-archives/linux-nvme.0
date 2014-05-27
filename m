From: wyung@micron.com (Winson Yung (wyung))
Date: Mon, 26 May 2014 22:02:29 -0700
Subject: [PATCH] NVMe: Add support to receive NVMe asynchronous events
In-Reply-To: <alpine.LRH.2.03.1405261518380.4700@AMR>
References: <53839E67.1010006@micron.com>
 <alpine.LRH.2.03.1405261518380.4700@AMR>
Message-ID: <53841C65.8030805@micron.com>

Thanks Keith for the feedback. I wasn't sure how to use the current code 
to receive async event. I see the code create a cmdid in order to send 
an admin cmd. The operation is either synchronous or asynchronous, but 
it is always expecting the cmd completion response in the end within a 
predetermined period.

For receiving async events, I thought to just create a completion queue 
entry after 'set feature' enabling the async event, I was assuming 
anytime when there is an async event, nvme_process_cq() will pick up the 
completion queue entry I created to store the event detail, and there 
was no timeout involved regardless what I passed in for 'timeout' when 
calling alloc_cmdid.

See my additional comments inline below

On 5/26/2014 2:42 PM, Keith Busch wrote:
> On Mon, 26 May 2014, Winson Yung (wyung) wrote:
>> As a NVMe mandatory admin command, this driver should be setup so
>> that it can receive drive critical asynchronous notification for
>> issue such as device reliability, temperature above threshold, or
>> available spare space fallen below threshould. This patch enables
>> very basic mechanism to log the asynchronous events in kernel log.
>>
>> Signed-off-by: Winson Yung <wyung at micron.com>
>> ---
>> drivers/block/nvme-core.c |   57 +++++++++++++++++++++++++++++++++++++++++++++
>> 1 file changed, 57 insertions(+)
>>
>> diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
>> index cd8a8bc7..4cd9f8e 100644
>> --- a/drivers/block/nvme-core.c
>> +++ b/drivers/block/nvme-core.c
>> @@ -198,6 +198,7 @@ static int alloc_cmdid_killable(struct nvme_queue *nvmeq, void *ctx,
>> #define CMD_CTX_COMPLETED	(0x310 + CMD_CTX_BASE)
>> #define CMD_CTX_INVALID		(0x314 + CMD_CTX_BASE)
>> #define CMD_CTX_ABORT		(0x318 + CMD_CTX_BASE)
>> +#define CMD_CTX_ASYNC_EVENT	(0x319 + CMD_CTX_BASE)
>
> Context needs to be dword aligned, so the next new context would be 0x31c.
>
thanks, I will fix the dword alignment definition problem

>> static void special_completion(struct nvme_queue *nvmeq, void *ctx,
>> 						struct nvme_completion *cqe)
>> @@ -227,7 +228,27 @@ static void special_completion(struct nvme_queue *nvmeq, void *ctx,
>> static void async_completion(struct nvme_queue *nvmeq, void *ctx,
>> 						struct nvme_completion *cqe)
>> {
>> +	int cmdid;
>> +	struct nvme_queue *adminq;
>> +	struct nvme_dev *dev = nvmeq->dev;
>> 	struct async_cmd_info *cmdinfo = ctx;
>> +
>> +	if (ctx == CMD_CTX_ASYNC_EVENT) {
>> +		dev_warn(nvmeq->q_dmadev, "An async event is detected (DW0:%X)\n",
>> +								cqe->result);
>> +
>> +		adminq = rcu_dereference(dev->queues[0]);
>> +
>> +		/* Allocate a cmdid entry for next async event */
>> +		cmdid = alloc_cmdid(adminq, CMD_CTX_ASYNC_EVENT,
>> +						async_completion, 0);
>
> You've allocated this new cmdid with no timeout, and then you do nothing
> with the command id. It's just going to get timed out.
>
The reason I did this way is because I assume I need to allocate an 
empty completion queue entry in preparation to receive an incoming async 
event in the future. It doesn't need to submit anything with this cmdid. 
That's why it didn't do anything with it, and there is no timeout 
needed. Maybe my understanding was wrong.

>> +		if (cmdid < 0)
>> +			dev_warn(nvmeq->q_dmadev,
>> +				"Failure creating new entry for next async event\n");
>> +
>> +		return; /* Report asynchronous critical event, and exit */
>> +	}
>> +
>> 	cmdinfo->result = le32_to_cpup(&cqe->result);
>> 	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
>> 	queue_kthread_work(cmdinfo->worker, &cmdinfo->work);
>> @@ -2381,6 +2402,37 @@ static int nvme_delete_cq(struct nvme_queue *nvmeq)
>> 						nvme_del_cq_work_handler);
>> }
>>
>> +static int nvme_enable_async_events(struct nvme_dev *dev)
>> +{
>> +	int status, cmdid;
>> +	u32 result, async_events;
>> +	struct nvme_queue *adminq;
>> +
>> +	async_events = NVME_SMART_CRIT_SPARE |
>> +			NVME_SMART_CRIT_TEMPERATURE |
>> +			NVME_SMART_CRIT_RELIABILITY |
>> +			NVME_SMART_CRIT_MEDIA |
>> +			NVME_SMART_CRIT_VOLATILE_MEMORY;
>> +
>> +	status = nvme_set_features(dev, NVME_FEAT_ASYNC_EVENT,
>> +					async_events, 0, &result);
>
> I think we'd rather let the user pick what events they want to see using
> the passthrough IOCTL rather than have the driver decide these things.

Good idea, I think a sysfs might be better, do you have objection use 
that instead.

>
>> +
>> +	if (status < 0)
>> +		return status;
>> +
>> +	if (status > 0) {
>> +		dev_err(&dev->pci_dev->dev, "Could not enable async event (%d)\n",
>> +									status);
>> +		return -EBUSY;
>> +	}
>> +
>> +	adminq = rcu_dereference(dev->queues[0]);
>> +
>> +	/* Allocate a cmdid entry in preparation of next incoming async event */
>> +	cmdid = alloc_cmdid(adminq, CMD_CTX_ASYNC_EVENT, async_completion, 0);
>
> Same thing as in the completion, you're allocating a cmdid, but no
> command is associated with it.

Ditto here, I knew this will probably require some rework. The basic 
difference between an asynchronous event and regular admin cmd is that 
async event doesn't have a timeout, it can come any time after host 
issues enabling the async event feature, whereas a normal admin cmd will 
get some sort of completion response within certain timeout period.

>
> I don't think you want to use the "async_completion" callback either
> (is it confusing to name that callback that way? :)) unless you have
> some deferred work that needs to be done upon the completion that can't
> be done in interrupt context.
>

I can change to use a different callback name. But using alloc_cmdid 
with a zero timeout and callback may not be the right way for async 
event. Any suggestion is welcome.

>> +	return cmdid;
>> +}
>> +
>> static void nvme_del_sq_work_handler(struct kthread_work *work)
>> {
>> 	struct nvme_queue *nvmeq = container_of(work, struct nvme_queue,
>> @@ -2638,6 +2690,11 @@ static int nvme_dev_start(struct nvme_dev *dev)
>> 		goto disable;
>> 	}
>>
>> +	/* Enable receive asynchronous event */
>> +	result = nvme_enable_async_events(dev);
>> +	if (result < 0 && result != -EBUSY)
>> +		goto disable;
>> +
>> 	result = nvme_setup_io_queues(dev);
>> 	if (result && result != -EBUSY)
>> 		goto disable;
