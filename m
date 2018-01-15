From: jianchao.w.wang@oracle.com (jianchao.wang)
Date: Mon, 15 Jan 2018 10:02:04 +0800
Subject: [PATCH V3 1/2] nvme: split resetting state into reset_prepate and
 resetting
In-Reply-To: <b502ea5a-d319-3a03-0204-e2b6068bb55e@grimberg.me>
References: <1515647268-1717-1-git-send-email-jianchao.w.wang@oracle.com>
 <1515647268-1717-2-git-send-email-jianchao.w.wang@oracle.com>
 <b502ea5a-d319-3a03-0204-e2b6068bb55e@grimberg.me>
Message-ID: <2c062c31-ec3d-9d4a-8f5c-0ba6f623dfa4@oracle.com>

Hi keith

Thanks for your kindly review and response.

On 01/14/2018 05:48 PM, Sagi Grimberg wrote:
> 
>> Currently, the ctrl->state will be changed to NVME_CTRL_RESETTING
>> before queue the reset work. This is not so strict. There could be
>> a big gap before the reset_work callback is invoked. In addition,
>> there is some disable work in the reset_work callback, strictly
>> speaking, not part of reset work, and could lead to some confusion.
>>
>> This patch splits the NVME_CTRL_RESETTING into NVME_CTRL_RESET_PREPARE
>> and NVME_CTRL_RESETTING. Before queue the reset work, changes state
>> to NVME_CTRL_RESET_PREPARE, after disable work completes, changes
>> state to NVME_CTRL_RESETTING.
> 
> What guarantees that nvme_timeout will do the right thing? If it
> is relying on the fact that nvme-pci sets the state to RESETTING
> only _after_ quiescing the requests queues it needs to be documented
> as its a real delicate dependency.
nvme_dev_disable will iterate all the outstanding request with nvme_cancel_request to requeue
the IO requests and complete admin requests. This is the boundary.
Transit the state from RESET_PREPARE to RESETTING after nmve_dev_disable.
So when the state is RESETTING, all the previous outstanding requests all has been handled by
nvme_cancel_request, the only requests can expire at this moment is from the adminq of initializing
procedure. 

> 
> 
> 
>>
>> Suggested-by: Christoph Hellwig <hch at lst.de>
>> Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
>> ---
>> ? drivers/nvme/host/core.c?? | 17 +++++++++++++++--
>> ? drivers/nvme/host/fc.c???? |? 2 ++
>> ? drivers/nvme/host/nvme.h?? |? 1 +
>> ? drivers/nvme/host/pci.c??? | 28 ++++++++++++++++++++++------
>> ? drivers/nvme/host/rdma.c?? |? 8 ++++++++
>> ? drivers/nvme/target/loop.c |? 5 +++++
>> ? 6 files changed, 53 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 1e46e60..106a437 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -87,7 +87,7 @@ static __le32 nvme_get_log_dw10(u8 lid, size_t size)
>> ? ? int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>> ? {
>> -??? if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>> +??? if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESET_PREPARE))
>> ????????? return -EBUSY;
>> ????? if (!queue_work(nvme_wq, &ctrl->reset_work))
>> ????????? return -EBUSY;
>> @@ -243,7 +243,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>> ????????????? break;
>> ????????? }
>> ????????? break;
>> -??? case NVME_CTRL_RESETTING:
>> +??? case NVME_CTRL_RESET_PREPARE:
>> ????????? switch (old_state) {
>> ????????? case NVME_CTRL_NEW:
>> ????????? case NVME_CTRL_LIVE:
>> @@ -253,10 +253,21 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>> ????????????? break;
>> ????????? }
>> ????????? break;
>> +
>> +??? case NVME_CTRL_RESETTING:
>> +??????? switch (old_state) {
>> +??????? case NVME_CTRL_RESET_PREPARE:
>> +??????????? changed = true;
>> +??????????? /* FALLTHRU */
>> +??????? default:
>> +??????????? break;
>> +??????? }
>> +??????? break;
>> ????? case NVME_CTRL_RECONNECTING:
>> ????????? switch (old_state) {
>> ????????? case NVME_CTRL_LIVE:
>> ????????? case NVME_CTRL_RESETTING:
>> +??????? case NVME_CTRL_RESET_PREPARE:
>> ????????????? changed = true;
>> ????????????? /* FALLTHRU */
>> ????????? default:
>> @@ -267,6 +278,7 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
>> ????????? switch (old_state) {
>> ????????? case NVME_CTRL_LIVE:
>> ????????? case NVME_CTRL_RESETTING:
>> +??????? case NVME_CTRL_RESET_PREPARE:
>> ????????? case NVME_CTRL_RECONNECTING:
>> ????????????? changed = true;
>> ????????????? /* FALLTHRU */
>> @@ -2603,6 +2615,7 @@ static ssize_t nvme_sysfs_show_state(struct device *dev,
>> ????????? [NVME_CTRL_NEW]??????? = "new",
>> ????????? [NVME_CTRL_LIVE]??? = "live",
>> ????????? [NVME_CTRL_RESETTING]??? = "resetting",
>> +??????? [NVME_CTRL_RESET_PREPARE]??? = "reset-prepare",
>> ????????? [NVME_CTRL_RECONNECTING]= "reconnecting",
>> ????????? [NVME_CTRL_DELETING]??? = "deleting",
>> ????????? [NVME_CTRL_DEAD]??? = "dead",
>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index 794e66e..516c1ea 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -547,6 +547,7 @@ nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
>> ????????? break;
>> ? ????? case NVME_CTRL_RESETTING:
>> +??? case NVME_CTRL_RESET_PREPARE:
>> ????????? /*
>> ?????????? * Controller is already in the process of terminating the
>> ?????????? * association. No need to do anything further. The reconnect
>> @@ -790,6 +791,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
>> ????????? break;
>> ? ????? case NVME_CTRL_RESETTING:
>> +??? case NVME_CTRL_RESET_PREPARE:
>> ????????? /*
>> ?????????? * Controller is already in the process of terminating the
>> ?????????? * association.? No need to do anything further. The reconnect
> 
> James, can you take a look at this?
> 
>> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
>> index f5800c3..e477c35 100644
>> --- a/drivers/nvme/host/pci.c
>> +++ b/drivers/nvme/host/pci.c
>> @@ -1141,8 +1141,13 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
>> ????? bool nssro = dev->subsystem && (csts & NVME_CSTS_NSSRO);
>> ? ????? /* If there is a reset ongoing, we shouldn't reset again. */
>> -??? if (dev->ctrl.state == NVME_CTRL_RESETTING)
>> +??? switch (dev->ctrl.state) {
>> +??? case NVME_CTRL_RESETTING:
>> +??? case NVME_CTRL_RESET_PREPARE:
>> ????????? return false;
>> +??? default:
>> +??????? break;
>> +??? }
> 
> Isn't the indentation off? also in other places...
I see all the "switch" in core.c and pci.c is this style.
switch(x) {
case xxx:
...
case xxx:
...
}
So I followed.... :)
> 
>> @@ -2292,7 +2303,7 @@ static void nvme_reset_work(struct work_struct *work)
>> ????? bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
>> ????? int result = -ENODEV;
>> ? -??? if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
>> +??? if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESET_PREPARE))
>> ????????? goto out;
>> ? ????? /*
>> @@ -2302,6 +2313,11 @@ static void nvme_reset_work(struct work_struct *work)
>> ????? if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
>> ????????? nvme_dev_disable(dev, false);
>> ? +??? if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
>> +??????? WARN_ON_ONCE(dev->ctrl.state != NVME_CTRL_DELETING);
>> +??????? goto out;
>> +??? }
>> +
> 
> This needs documentation on _why_ here.
OK, sure.
> 
>> -??? nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING);
>> +??? nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESET_PREPARE);
>> ????? dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
> 
> Can you rebase on top of my commit:
> 4caff8fc19f1 nvme-pci: don't open-code nvme_reset_ctrl
OK, I will
> 
>> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
>> index 37af565..8ae073e 100644
>> --- a/drivers/nvme/host/rdma.c
>> +++ b/drivers/nvme/host/rdma.c
>> @@ -1753,6 +1753,14 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
>> ????? nvme_stop_ctrl(&ctrl->ctrl);
>> ????? nvme_rdma_shutdown_ctrl(ctrl, false);
>> ? +??? changed = nvme_change_ctrl_state(&ctrl->ctrl,
>> +??????????? NVME_CTRL_RESET_PREPARE);
>> +??? if (!changed) {
>> +??????? /* state change failure is ok if we're in DELETING state */
>> +??????? WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
>> +??????? return;
>> +??? }
>> +
> 
> setting RESET_PREPARE here??
This is my fault. I checked the code time by time, but still a stupid fault here.
> 
> Also, the error recovery code is mutually excluded from reset_work
> by trying to set the same state which is protected by the ctrl state
> machine, so a similar change is needed there.
> 
> So in order not to break rdma ctrl reset (again) please look at:
> bcdacf7fc3d8 nvme-rdma: fix concurrent reset and reconnect
> 
Ok, I will look into it.
Thanks for your directive. That's really appreciated.

Thanks
Jianchao
