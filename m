From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Wed, 17 Jan 2018 17:19:01 +0800
Subject: [PATCH V4 1/2] nvme: add NVME_CTRL_RESET_PREPARE state
In-Reply-To: <11106a93-2e78-c853-e6eb-35c652dab3a9@mellanox.com>
References: <1516164877-2170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1516164877-2170-2-git-send-email-jianchao.w.wang@oracle.com>
 <11106a93-2e78-c853-e6eb-35c652dab3a9@mellanox.com>
Message-ID: <e8b77f1d-10d5-42b0-9906-b0f32cb55e02@oracle.com>

Hi Max

Thanks for your kindly response.

I have merged the response to you together below.
On 01/17/2018 05:06 PM, Max Gurtovoy wrote:
>> ? case NVME_CTRL_RECONNECTING:
>> ????????? switch (old_state) {
>> ????????? case NVME_CTRL_LIVE:
>> -??????? case NVME_CTRL_RESETTING:
>> +??????? case NVME_CTRL_RESET_PREPARE:
> 
> As I suggested in V3, please don't allow this transition.
> We'll move to NVME_CTRL_RECONNECTING from NVME_CTRL_RESETTING.
> 
> I look on it like that:
> 
> NVME_CTRL_RESET_PREPARE - "suspend" state
> NVME_CTRL_RESETTING - "resume" state
> 
> you don't reconnect from "suspend" state, you must "resume" before you reconnect.

>> index d49b1e7..6b5f2f4 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -985,7 +985,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>> ? ? static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
>> ? {
>> -??? if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
>> +??? if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESET_PREPARE))
>> ????????? return;
> 
> We can add a NVME_CTRL_RESET_PREPARE --> NVME_CTRL_RESETTING transition and then move to NVME_CTRL_RECONNECTING (in nvme_rdma_reset_ctrl_work and nvme_rdma_error_recovery_work).
> I want to add an ability to recover from device removal (actually wanted to send it today but I'm waiting to see what will happen with this patchset) for RDMA and your approach (enable transition to from both "suspend" and "resume" to "reconnect") might be problematic.
> 
> Sagi/Christoph ?

I used to respond you in the V3 and wait for your feedback.
Please refer to:
>>>
After Sagi's nvme-rdma: fix concurrent reset and reconnect, the rdma ctrl state is changed to RECONNECTING state
after some clearing and shutdown work, then some initializing procedure,  no matter reset work path or error recovery path.
The fc reset work also does the same thing.
So if we define the range that RESET_PREPARE includes scheduling gap and disable and clear work, RESETTING includes initializing
procedure,  RECONNECTING is very similar with RESETTING.

Maybe we could do like this;
In nvme fc/rdma
- set state to RESET_PREPARE, queue reset_work/err_work 
- clear/shutdown works, set state to RECONNECTING
- initialization, set state to LIVE

In nvme pci
- set state to RESET_PREPARE, queue reset_work
- clear/shutdown works, set state to RESETTING
- initialization, set state to LIVE
>>>

Currently, RECONNECTING has overlapped with RESETTING.
So I suggest to use RESET_PREPARE to mark the "suspend" part as you said.
And use RECONNECTING to mark the "resume" part in nvme-rdma/fc
use RESETTING part to mark the "resume" part in nvme-pci, nvmt-loop.

I want to confirm with all of you, but no none had feedback, so I sent out the patch directly.
Please forgive my abrupt actions.

Thanks
Jianchao

Thanks
Jianchao
