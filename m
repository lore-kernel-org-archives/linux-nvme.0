From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 8 Feb 2018 18:19:32 +0200
Subject: [PATCH 1/3] nvme: rename NVME_CTRL_RECONNECTING state to
 NVME_CTRL_CONNECTING
In-Reply-To: <d8241724-ef3a-4946-4629-3598413ca836@grimberg.me>
References: <1517416286-31109-1-git-send-email-maxg@mellanox.com>
 <1517416286-31109-2-git-send-email-maxg@mellanox.com>
 <d8241724-ef3a-4946-4629-3598413ca836@grimberg.me>
Message-ID: <c896305c-90d0-e4aa-d861-ea9ad0076161@grimberg.me>



On 02/08/2018 05:28 PM, Sagi Grimberg wrote:
> 
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 6c2fdfa..219c6a0 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -887,7 +887,7 @@ static void nvme_rdma_free_ctrl(struct nvme_ctrl 
>> *nctrl)
>> ? static void nvme_rdma_reconnect_or_remove(struct nvme_rdma_ctrl *ctrl)
>> ? {
>> ????? /* If we are resetting/deleting then do nothing */
>> -??? if (ctrl->ctrl.state != NVME_CTRL_RECONNECTING) {
>> +??? if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
>> ????????? WARN_ON_ONCE(ctrl->ctrl.state == NVME_CTRL_NEW ||
>> ????????????? ctrl->ctrl.state == NVME_CTRL_LIVE);
>> ????????? return;
>> @@ -978,7 +978,7 @@ static void nvme_rdma_error_recovery_work(struct 
>> work_struct *work)
>> ? static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
>> ? {
>> -??? if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECONNECTING))
>> +??? if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
>> ????????? return;
>> ????? queue_work(nvme_wq, &ctrl->err_work);
>>
> What is this based on? It does not apply on nvme-4.16.

Max, I fixed it up locally in nvme-4.16-rc, please verify that its
correct and passes your local tests.
