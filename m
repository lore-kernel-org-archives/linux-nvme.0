From: hare@suse.de (Hannes Reinecke)
Date: Fri, 25 May 2018 08:43:06 +0200
Subject: [PATCH 2/3] nvme: avoid reconnection for the discovery controller
In-Reply-To: <4a3d1fbb-ba38-9488-ab38-9ae85ec18922@broadcom.com>
References: <20180524141817.127576-1-hare@suse.de>
 <20180524141817.127576-3-hare@suse.de>
 <4a3d1fbb-ba38-9488-ab38-9ae85ec18922@broadcom.com>
Message-ID: <9f06192d-28b6-c1af-417f-29bebef670fa@suse.de>

On 05/24/2018 10:30 PM, James Smart wrote:
> 
> 
> On 5/24/2018 7:18 AM, Hannes Reinecke wrote:
>> If the connection to the discovery controller fails for whatever
>> reason we should not attempt to reconnect; rather the user should
>> retry the discovery altogether.
>>
>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>> ---
>> ? drivers/nvme/host/fabrics.c | 3 +++
>> ? 1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
>> index d25aa4322d16..997d8677ab44 100644
>> --- a/drivers/nvme/host/fabrics.c
>> +++ b/drivers/nvme/host/fabrics.c
>> @@ -474,6 +474,9 @@ EXPORT_SYMBOL_GPL(nvmf_connect_io_queue);
>> ? bool nvmf_should_reconnect(struct nvme_ctrl *ctrl)
>> ? {
>> +??? if (ctrl->opts->discovery_nqn)
>> +??????? return false;
>> +
>> ????? if (ctrl->opts->max_reconnects != -1 &&
>> ????????? ctrl->nr_reconnects < ctrl->opts->max_reconnects)
>> ????????? return true;
> 
> um no.? It should follow the same reconnect policies as anything other 
> controller.?? There is no guarantee the event that triggered the 
> discovery controller will do so again. Not all discovery controller 
> connects are manually initiated by an admin.?? So failing the reconnect 
> may mean you will never reconnect with the subsystems described by the 
> discovery controller.
> 
Ah. Fair enough.
So we should be limiting the number of reconnects only when triggered by 
the admin. Should be doable; I'll be looking into it.

Cheers,

Hannes
