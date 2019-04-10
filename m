From: hare@suse.de (Hannes Reinecke)
Date: Wed, 10 Apr 2019 16:36:07 +0200
Subject: [PATCH] nvme: improve logging
In-Reply-To: <a6b38bc2-8b59-e36c-7d43-db56ebaac452@gmail.com>
References: <20190410141706.146455-1-hare@suse.de>
 <a6b38bc2-8b59-e36c-7d43-db56ebaac452@gmail.com>
Message-ID: <35ed9e98-079e-3b34-8339-c3c5353d793f@suse.de>

On 4/10/19 4:25 PM, Minwoo Im wrote:
> On 4/10/19 11:17 PM, Hannes Reinecke wrote:
>> Currently nvme is very reluctant if it comes to logging anything,
>> _unless_ it's an ANA AEN. So this patch tries to remedy this by
>> decreasing the priority for the ANA AEN logging message, and improve
>> the logging when calling nvme_reset_ctrl().
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>> ? drivers/nvme/host/core.c????? | 44 
>> +++++++++++++++++++++++++++++--------------
>> ? drivers/nvme/host/multipath.c |? 5 ++++-
>> ? 2 files changed, 34 insertions(+), 15 deletions(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 8d285bfcd352..98260b2c7a6f 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -94,6 +94,24 @@ static void nvme_put_subsystem(struct 
>> nvme_subsystem *subsys);
>> ? static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
>> ???????????????????????? unsigned nsid);
>> +static const char *nvme_ctrl_state_name(struct nvme_ctrl *ctrl)
>> +{
>> +??? static const char *const state_name[] = {
>> +??????? [NVME_CTRL_NEW]??????? = "new",
>> +??????? [NVME_CTRL_LIVE]??? = "live",
>> +??????? [NVME_CTRL_ADMIN_ONLY]??? = "only-admin",
>> +??????? [NVME_CTRL_RESETTING]??? = "resetting",
>> +??????? [NVME_CTRL_CONNECTING]??? = "connecting",
>> +??????? [NVME_CTRL_DELETING]??? = "deleting",
>> +??????? [NVME_CTRL_DEAD]??? = "dead",
>> +??? };
>> +
>> +??? if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
>> +??????? state_name[ctrl->state])
>> +??????? return state_name[ctrl->state];
>> +??? return NULL;
> 
> Hi, Hannes,
> 
> IMHO, If you want to print out "unknown" in the caller level, why don't 
> we just
> return "unknown" string itself to the caller to make caller don't need 
> to print
> out "unknown" OR "unknown state\n" just like below ?
> 
> I think this might make duplications for "unknown" string in callers.
> 
> Thanks,
> 
>> +}
>> +
>> ? static void nvme_set_queue_dying(struct nvme_ns *ns)
>> ? {
>> ????? /*
>> @@ -119,10 +137,17 @@ static void nvme_queue_scan(struct nvme_ctrl *ctrl)
>> ? int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>> ? {
>> -??? if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
>> +??? if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING)) {
>> +??????? const char *state_name = nvme_ctrl_state_name(ctrl);
>> +
>> +??????? dev_warn(ctrl->device, "cannot reset ctrl in state %s\n",
>> +???????????? state_name ? state_name : "unknown");
>> ????????? return -EBUSY;
>> -??? if (!queue_work(nvme_reset_wq, &ctrl->reset_work))
>> +??? }
>> +??? if (!queue_work(nvme_reset_wq, &ctrl->reset_work)) {
>> +??????? dev_dbg(ctrl->device, "ctrl reset already queued\n");
>> ????????? return -EBUSY;
>> +??? }
>> ????? return 0;
>> ? }
>> ? EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
>> @@ -2971,19 +2996,10 @@ static ssize_t nvme_sysfs_show_state(struct 
>> device *dev,
>> ?????????????????????? char *buf)
>> ? {
>> ????? struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
>> -??? static const char *const state_name[] = {
>> -??????? [NVME_CTRL_NEW]??????? = "new",
>> -??????? [NVME_CTRL_LIVE]??? = "live",
>> -??????? [NVME_CTRL_ADMIN_ONLY]??? = "only-admin",
>> -??????? [NVME_CTRL_RESETTING]??? = "resetting",
>> -??????? [NVME_CTRL_CONNECTING]??? = "connecting",
>> -??????? [NVME_CTRL_DELETING]??? = "deleting",
>> -??????? [NVME_CTRL_DEAD]??? = "dead",
>> -??? };
>> +??? const char *state_name = nvme_ctrl_state_name(ctrl);
>> -??? if ((unsigned)ctrl->state < ARRAY_SIZE(state_name) &&
>> -??????? state_name[ctrl->state])
>> -??????? return sprintf(buf, "%s\n", state_name[ctrl->state]);
>> +??? if (state_name)
>> +??????? return sprintf(buf, "%s\n", state_name);
>> ????? return sprintf(buf, "unknown state\n");
>> ? }
>> diff --git a/drivers/nvme/host/multipath.c 
>> b/drivers/nvme/host/multipath.c
>> index 503539d4616a..cca60044163b 100644
>> --- a/drivers/nvme/host/multipath.c
>> +++ b/drivers/nvme/host/multipath.c
>> @@ -81,6 +81,9 @@ void nvme_failover_req(struct request *req)
>> ?????????? * Reset the controller for any non-ANA error as we don't know
>> ?????????? * what caused the error.
>> ?????????? */
>> +??????? dev_info(ns->ctrl->device,
>> +??????????? "nvme status 0x%04x, resetting controller\n",
>> +??????????? status);
>> ????????? nvme_reset_ctrl(ns->ctrl);
>> ????????? break;
>> ????? }
>> @@ -423,7 +426,7 @@ static int nvme_update_ana_state(struct nvme_ctrl 
>> *ctrl,
>> ????? unsigned *nr_change_groups = data;
>> ????? struct nvme_ns *ns;
>> -??? dev_info(ctrl->device, "ANA group %d: %s.\n",
>> +??? dev_dbg(ctrl->device, "ANA group %d: %s.\n",
>> ????????????? le32_to_cpu(desc->grpid),
>> ????????????? nvme_ana_state_names[desc->state]);
>>
> 
Good point. Will be resending.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
