From: hare@suse.de (Hannes Reinecke)
Date: Wed, 22 Aug 2018 09:32:47 +0200
Subject: [PATCH 4/4] nvme: delete discovery controller after 2 minutes
In-Reply-To: <a1911312-0e01-d869-5473-4e70d4950629@broadcom.com>
References: <20180821134329.69577-1-hare@suse.de>
 <20180821134329.69577-5-hare@suse.de>
 <a1911312-0e01-d869-5473-4e70d4950629@broadcom.com>
Message-ID: <3fe8027e-dee3-902e-acb2-4b3d1a1e047c@suse.de>

On 08/21/2018 11:01 PM, James Smart wrote:
> 
> 
> On 8/21/2018 6:43 AM, Hannes Reinecke wrote:
>> If the CLI crashes before the 'disconnect' command is issued or when
>> the 'async_connect' option is used the controller is never removed.
>> This patch cleans up stale discovery controllers after 2 minutes,
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>> ? drivers/nvme/host/core.c??? | 5 +++++
>> ? drivers/nvme/host/fabrics.c | 2 +-
>> ? drivers/nvme/host/nvme.h??? | 1 +
>> ? 3 files changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>> index 358be6d217d9..b3738b327731 100644
>> --- a/drivers/nvme/host/core.c
>> +++ b/drivers/nvme/host/core.c
>> @@ -866,6 +866,11 @@ static void nvme_keep_alive_work(struct
>> work_struct *work)
>> ????? struct nvme_ctrl *ctrl = container_of(to_delayed_work(work),
>> ????????????? struct nvme_ctrl, ka_work);
>> ? +??? if (ctrl->opts->discovery_nqn) {
>> +??????? nvme_delete_ctrl(ctrl);
>> +??????? return;
>> +??? }
>> +
>> ????? if (nvme_keep_alive(ctrl)) {
>> ????????? /* allocation failure, reset the controller */
>> ????????? dev_err(ctrl->device, "keep-alive failed\n");
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index e484205b4cad..b98662760051 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -827,7 +827,7 @@ static int nvmf_parse_options(struct
>> nvmf_ctrl_options *opts,
>> ????? }
>> ? ????? if (opts->discovery_nqn) {
>> -??????? opts->kato = 0;
>> +??????? opts->kato = NVME_DISCOVERY_TIMEOUT;
>> ????????? opts->nr_io_queues = 0;
>> ????????? opts->duplicate_connect = true;
>> ????? }
>> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
>> index 8a4ed46b986b..551a6b1dbc8c 100644
>> --- a/drivers/nvme/host/nvme.h
>> +++ b/drivers/nvme/host/nvme.h
>> @@ -32,6 +32,7 @@ extern unsigned int admin_timeout;
>> ? ? #define NVME_DEFAULT_KATO??? 5
>> ? #define NVME_KATO_GRACE??????? 10
>> +#define NVME_DISCOVERY_TIMEOUT??? 120
>> ? ? extern struct workqueue_struct *nvme_wq;
>> ? extern struct workqueue_struct *nvme_reset_wq;
> 
> this doesn't necessarily track to the new TP that adds kato support to
> discovery controllers, nor the fabric spec update that has the host
> tracking kato and deleting the controller (whether discovery controller
> or not) (the actual kato as set on the controller with the grace period).
> 
Correct, it doesn't.
Both of the TPs referred here are not ratified yet, so I cannot make
assumptions about nor code against them.

> I would rather have this be a generic timer on a host that tracks to the
> kato timeout and deletes the controller (doesn't matter if discovery or
> not) if kato times out.??? If the controller is an older discovery
> controller that doesn't support kato - then the 1st kato timeout should
> fail and remove the controller.? If it's newer and supports kato, it
> would be assumed the controller stays live for an extended period- just
> like a storage controller.
> 

I've tried to implement something like this, but yeah, I'll be updating
the patch along these lines.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
