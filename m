From: james.smart@broadcom.com (James Smart)
Date: Thu, 28 Mar 2019 10:50:51 -0700
Subject: [PATCH 2/3] nvme: shorten race window in nvme_ns_remove()
In-Reply-To: <6ff911b0-7884-0cb4-eb59-aa794d9b4e75@suse.de>
References: <20190327080929.27918-1-hare@suse.de>
 <20190327080929.27918-3-hare@suse.de>
 <20190327142044.GB8448@localhost.localdomain>
 <7c724e84-519e-e0f9-f82d-31a89ec37680@suse.com>
 <9500d83c-c5da-d87c-c5ef-d67e2c9f8898@broadcom.com>
 <7c112deb-e8c3-eeca-7bda-771c793cb9c6@suse.de>
 <CACVXFVM0SW1CMzJRr2HwSvfbYYwR19eR_whxYjn+GiYgZOQb5g@mail.gmail.com>
 <4fea0599-a4be-6aff-7728-ca49282eb321@suse.com>
 <e53b556e-52ab-8be4-5a23-43aa910889af@suse.de>
 <38720c59-1b37-9135-06d0-4ca99bc27b97@broadcom.com>
 <6ff911b0-7884-0cb4-eb59-aa794d9b4e75@suse.de>
Message-ID: <115fa585-0565-c7da-a6f4-3b0393c48840@broadcom.com>

On 3/28/2019 8:57 AM, Hannes Reinecke wrote:
> On 3/28/19 4:46 PM, James Smart wrote:
>>
>>
>> On 3/28/2019 5:11 AM, Hannes Reinecke wrote:
>>> On 3/28/19 12:48 PM, Hannes Reinecke wrote:
>>>> On 3/28/19 12:07 PM, Ming Lei wrote:
>>>>> On Thu, Mar 28, 2019@5:28 PM Hannes Reinecke <hare@suse.de> wrote:
>>>>>>
>>>>>> On 3/27/19 7:50 PM, James Smart wrote:
>>> [ .. ]
>>>>>>> But, Keiths statements make me nervous. With Hannes's patches, I 
>>>>>>> could
>>>>>>> easily see the case where the ns->queue was quiesced when 
>>>>>>> ns_remove is
>>>>>>> called, which I think causes issues with blk_freeze_queue. We 
>>>>>>> would need
>>>>>>> to have ns_remove, after unlinking, to release the queue. is 
>>>>>>> this right ?
>>>>>>>
>>>>>> Hmm. But maybe it's as simple as this:
>>>>>>
>>>>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>>>>> index 4e5ad111b68b..67451e5eec31 100644
>>>>>> --- a/drivers/nvme/host/core.c
>>>>>> +++ b/drivers/nvme/host/core.c
>>>>>> @@ -131,6 +131,7 @@ int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>>>>>> ?? {
>>>>>> ????????? if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>>>>>> ????????????????? return -EBUSY;
>>>>>> +?????? flush_work(&ctrl->scan_work);
>>>>>> ????????? if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
>>>>>> ????????????????? return -EBUSY;
>>>>>>
>>>>>
>>>>> This way might cause deadlock because there is sync IO in scan
>>>>> work context.
>>>>>
>>>> But I sort of hoped that I/O would be aborted when the controller 
>>>> is resetting, which should cause the sync I/O to complete, right?
>>>>
>>> But indeed, you're right (of course).
>>>
>>> This should be better:
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 67451e5eec31..81900735a380 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -3452,6 +3452,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
>>> ?{
>>> ??????? nvme_mpath_stop(ctrl);
>>> ??????? nvme_stop_keep_alive(ctrl);
>>> +?????? flush_work(&ctrl->scan_work);
>>> ??????? flush_work(&ctrl->async_event_work);
>>> ??????? cancel_work_sync(&ctrl->fw_act_work);
>>> ?}
>>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>>> index d42bada25b54..ef20935a7202 100644
>>> --- a/drivers/nvme/host/rdma.c
>>> +++ b/drivers/nvme/host/rdma.c
>>> @@ -1761,8 +1761,8 @@ static void nvme_rdma_reset_ctrl_work(struct 
>>> work_struct *work)
>>> ??????? int ret;
>>> ??????? bool changed;
>>>
>>> -?????? nvme_stop_ctrl(&ctrl->ctrl);
>>> ??????? nvme_rdma_shutdown_ctrl(ctrl, false);
>>> +?????? nvme_stop_ctrl(&ctrl->ctrl);
>>>
>>> ??????? if (!nvme_change_ctrl_state(&ctrl->ctrl, 
>>> NVME_CTRL_CONNECTING)) {
>>> ??????????????? /* state change failure should never happen */
>>>
>>> (We need to twiddle the order on RDMA, as we'd need to abort the I/O 
>>> first before we can flush the scan_work element).
>>> Cheers,
>>>
>>> Hannes
>>
>> Looking at the flows - it looks like it should be ok. You're proving 
>> me wrong. Like changes need to be done in the other transports and 
>> they have to be audited for the same flows or the check_ready checks 
>> won't work right to continue to bounce ios so the flush can exit. I'm 
>> not sure having some of the async flows continue to run when doing 
>> the aborts as it may have side effects. But, I expect the issues 
>> aren't new. Simple change, but any change in this area can be dramatic.
>>
>> It still bothers me how "happy path" the ns_scan path is. That the 
>> "validate" tears down the namespace on any error, even on a short 
>> connectivity disruption, shouldn't be happening. Deleting the 
>> namespace can have harsh consequences.
>>
> Oh, I'm fully with you there.
> It only took me some months to properly debug this issue.
> Personally, I'd mark the namespace as 'faulty', and requeue I/O for 
> these cases (much like we do already when an error is returned).
> And then we can tear down namespaces after controller reset as we then 
> have a stable state.
>
> But that'll be quite a change to the flow of control, and I guess the 
> powers that be have some opinion here.
>
> Cheers,
>
> Hannes

Actually, we didn't solve anything.... got caught up with - can 
scan_work make progress.

The error scenario is:
transport enters reset: it must quiesce queues, mark connections 
invalid, terminate io, unquiesce queues.
This part has to run as the terminate is required to return the scan io 
so that scan can make progress. Issue is, scan can make progress by 
terminating the ns, which means the ns may be tripping on the bitmap 
when the transport calls the unquiesce queues.

your patch didn't change this sequence as the sequence is in the 
"shutdown" path. It doesn't matter that scan is waited for later.

I'm back to the original fix: changing quiesce/unquiesce and adding an 
unquiesce to ns_remove.

-- james
