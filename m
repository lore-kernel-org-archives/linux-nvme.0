From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 15 Aug 2019 10:02:47 -0600
Subject: [PATCH v7 07/14] nvmet-passthru: add enable/disable helpers
In-Reply-To: <e0323600-c4e8-00e7-d8cc-ff8d31b4ed10@mellanox.com>
References: <20190801234514.7941-1-logang@deltatee.com>
 <20190801234514.7941-8-logang@deltatee.com>
 <e0323600-c4e8-00e7-d8cc-ff8d31b4ed10@mellanox.com>
Message-ID: <90e7402f-bd2b-1e3b-1f15-53eff50a1abd@deltatee.com>



On 2019-08-15 6:20 a.m., Max Gurtovoy wrote:
> 
> On 8/2/2019 2:45 AM, Logan Gunthorpe wrote:
>> This patch adds helper functions which are used in the NVMeOF configfs
>> when the user is configuring the passthru subsystem. Here we ensure
>> that only one subsys is assigned to each nvme_ctrl by using an xarray
>> on the cntlid.
>>
>> [chaitanya.kulkarni at wdc.com: this patch is very roughly based
>> ? on a similar one by Chaitanya]
>> Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
>> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
>> ---
>> ? drivers/nvme/target/core.c??????????? |? 8 +++
>> ? drivers/nvme/target/io-cmd-passthru.c | 77 +++++++++++++++++++++++++++
>> ? drivers/nvme/target/nvmet.h?????????? | 10 ++++
>> ? 3 files changed, 95 insertions(+)
>>
>> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
>> index 50c01b2da568..2e75968af7f4 100644
>> --- a/drivers/nvme/target/core.c
>> +++ b/drivers/nvme/target/core.c
>> @@ -519,6 +519,12 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
>> ? ????? mutex_lock(&subsys->lock);
>> ????? ret = 0;
>> +
>> +??? if (nvmet_passthru_ctrl(subsys)) {
>> +??????? pr_info("cannot enable both passthru and regular namespaces
>> for a single subsystem");
>> +??????? goto out_unlock;
>> +??? }
>> +
>> ????? if (ns->enabled)
>> ????????? goto out_unlock;
>> ? @@ -1439,6 +1445,8 @@ static void nvmet_subsys_free(struct kref *ref)
>> ? ????? WARN_ON_ONCE(!list_empty(&subsys->namespaces));
>> ? +??? nvmet_passthru_subsys_free(subsys);
>> +
>> ????? kfree(subsys->subsysnqn);
>> ????? kfree(subsys);
>> ? }
>> diff --git a/drivers/nvme/target/io-cmd-passthru.c
>> b/drivers/nvme/target/io-cmd-passthru.c
>> index 46c58fec5608..b199785500ad 100644
>> --- a/drivers/nvme/target/io-cmd-passthru.c
>> +++ b/drivers/nvme/target/io-cmd-passthru.c
>> @@ -11,6 +11,11 @@
>> ? #include "../host/nvme.h"
>> ? #include "nvmet.h"
>> ? +/*
>> + * xarray to maintain one passthru subsystem per nvme controller.
>> + */
>> +static DEFINE_XARRAY(passthru_subsystems);
>> +
>> ? static struct workqueue_struct *passthru_wq;
>> ? ? int nvmet_passthru_init(void)
>> @@ -27,6 +32,78 @@ void nvmet_passthru_destroy(void)
>> ????? destroy_workqueue(passthru_wq);
>> ? }
>> ? +int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
>> +{
>> +??? struct nvme_ctrl *ctrl;
>> +??? int ret = -EINVAL;
>> +??? void *old;
>> +
>> +??? mutex_lock(&subsys->lock);
>> +??? if (!subsys->passthru_ctrl_path)
>> +??????? goto out_unlock;
>> +??? if (subsys->passthru_ctrl)
>> +??????? goto out_unlock;
>> +
>> +??? if (subsys->nr_namespaces) {
>> +??????? pr_info("cannot enable both passthru and regular namespaces
>> for a single subsystem");
>> +??????? goto out_unlock;
>> +??? }
>> +
>> +??? ctrl = nvme_ctrl_get_by_path(subsys->passthru_ctrl_path);
>> +??? if (IS_ERR(ctrl)) {
>> +??????? ret = PTR_ERR(ctrl);
>> +??????? pr_err("failed to open nvme controller %s\n",
>> +?????????????? subsys->passthru_ctrl_path);
>> +
>> +??????? goto out_unlock;
>> +??? }
>> +
>> +??? old = xa_cmpxchg(&passthru_subsystems, ctrl->cntlid, NULL,
>> +???????????? subsys, GFP_KERNEL);
>> +??? if (xa_is_err(old)) {
>> +??????? ret = xa_err(old);
>> +??????? goto out_put_ctrl;
>> +??? }
>> +
>> +??? if (old)
>> +??????? goto out_put_ctrl;
>> +
>> +??? subsys->passthru_ctrl = ctrl;
>> +??? ret = 0;
>> +
>> +??? goto out_unlock;
> 
> can we re-arrange the code here ?
> 
> it's not so common to see goto in a good flow.
> 
> maybe have 1 good flow the goto's will go bellow it as we usually do in
> this subsystem.

OK, queued up for v8.

Thanks,

Logan
