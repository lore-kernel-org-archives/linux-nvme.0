From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 15 Jan 2018 22:07:32 +0800
Subject: [PATCH V3 1/2] nvme: split resetting state into reset_prepate and
 resetting
In-Reply-To: <de132a4d-eb8b-10e8-7c96-7836edf1b52a@mellanox.com>
References: <1515647268-1717-1-git-send-email-jianchao.w.wang@oracle.com>
 <1515647268-1717-2-git-send-email-jianchao.w.wang@oracle.com>
 <b502ea5a-d319-3a03-0204-e2b6068bb55e@grimberg.me>
 <de132a4d-eb8b-10e8-7c96-7836edf1b52a@mellanox.com>
Message-ID: <fd0e9504-fd57-64ed-395d-b5dd5afd4fb7@oracle.com>

Hi max

Thanks for your kindly response and comment.

On 01/15/2018 09:28 PM, Max Gurtovoy wrote:
>>>
>>
>> setting RESET_PREPARE here??
>>
>> Also, the error recovery code is mutually excluded from reset_work
>> by trying to set the same state which is protected by the ctrl state
>> machine, so a similar change is needed there.
> 
> Sagi,
> Do you mean to add this (if so, I agree):
> 
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index d06641b..44ef52a 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -957,6 +957,12 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
> ??? struct nvme_rdma_ctrl *ctrl = container_of(work,
> ??????????? struct nvme_rdma_ctrl, err_work);
> 
> +?? if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETING)) {
> +?????? /* state change failure should never happen */
> +?????? WARN_ON_ONCE(1);
> +?????? return;
> +?? }
> +
> ??? nvme_stop_keep_alive(&ctrl->ctrl);
> 
> ??? if (ctrl->ctrl.queue_count > 1) {
> @@ -989,7 +995,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
> 
> ?static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
> ?{
> -?? if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
> +?? if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESET_PREPARE))
> ??????? return;
> 
> ??? queue_work(nvme_wq, &ctrl->err_work);
> @@ -1760,6 +1766,12 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
> ??? int ret;
> ??? bool changed;
> 
> +?? if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETING)) {
> +?????? /* state change failure should never happen */
> +?????? WARN_ON_ONCE(1);
> +?????? return;
> +?? }
> +
> ??? nvme_stop_ctrl(&ctrl->ctrl);
> ??? nvme_rdma_shutdown_ctrl(ctrl, false);

RESET_PREPARE state should include not only the scheduling gap of reset_work, but also
the device disable procedure.  All the previous state and work are cleared and canceled, 
then start new one. It is a very obvious boundary there. 
 
nvme_stop_ctrl(&ctrl->ctrl);
  nvme_rdma_shutdown_ctrl(ctrl, false);
 +   if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETING)) {
 +       /* state change failure should never happen */
 +       WARN_ON_ONCE(1);
 +       return;
 +   }
What do you think about ? :)

Thanks
Jianchao
