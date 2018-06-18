From: james.smart@broadcom.com (James Smart)
Date: Mon, 18 Jun 2018 16:57:14 -0700
Subject: [PATCH 3/3] nvme: allow duplicate connections to the discovery
 controller
In-Reply-To: <03f070cd-fac6-3161-c2cb-dab19f9ae159@suse.de>
References: <20180524141817.127576-1-hare@suse.de>
 <20180524141817.127576-4-hare@suse.de>
 <acb8b961-3f27-52af-00bc-f966e047dc52@broadcom.com>
 <03f070cd-fac6-3161-c2cb-dab19f9ae159@suse.de>
Message-ID: <7b7ed313-f2cd-8b99-a4ab-f4cf3ecaf519@broadcom.com>



On 6/18/2018 3:54 PM, Hannes Reinecke wrote:
> On 06/18/2018 06:11 PM, James Smart wrote:
>>
>> On 5/24/2018 7:18 AM, Hannes Reinecke wrote:
>>> The whole point of the discovery controller is that it can accept
>>> multiple connections. Additionally the cmic field is not even 
>>> defined for
>>> the discovery controller identify page.
>>>
>>> Signed-off-by: Hannes Reinecke <hare at suse.com>
>>> ---
>>> ? drivers/nvme/host/core.c??? | 3 ++-
>>> ? drivers/nvme/host/fabrics.c | 1 +
>>> ? 2 files changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
>>> index 10b180b8ccf4..28ac580b07e5 100644
>>> --- a/drivers/nvme/host/core.c
>>> +++ b/drivers/nvme/host/core.c
>>> @@ -2494,7 +2494,8 @@ static int nvme_init_subsystem(struct 
>>> nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
>>> ?????????? * Verify that the subsystem actually supports multiple
>>> ?????????? * controllers, else bail out.
>>> ?????????? */
>>> -??????? if (nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
>>> +??????? if (!ctrl->opts->discovery_nqn &&
>>> +??????????? nvme_active_ctrls(found) && !(id->cmic & (1 << 1))) {
>>> ????????????? dev_err(ctrl->device,
>>> ????????????????? "ignoring ctrl due to duplicate subnqn (%s).\n",
>>> ????????????????? found->subnqn);
>>>
>>
>> Question: this snippet excludes the discovery controller from failing 
>> the init call. But in doing so, it allows the discovery controller to 
>> be seen as "single unique device" based on its subnqn with another 
>> path added.? I assume, the read of the discovery log command will be 
>> done against the /dev/nvme? controller instance, so it will still go 
>> to the right "path" that corresponds to where the "nvme connect or 
>> connect-all" was issued to.? Correct ??? and other commands against 
>> the discovery controller should also use ioctls to the /dev/nvme? 
>> name so the proper device/path is used/deleted - Correct ?
>>
>> Are there any side effects of the fact that we allow the discovery 
>> controller to have multiple paths ?
>>
> That would only be relevant if the discovery log page entry could be 
> different for the individual paths.
> It's somewhat hard to see how that could happen; it's not that one 
> path can set the ANA CMIC bit, and the other path doesn't ...
> So even if we somehow fail to get the path right we still would be 
> getting the correct information, no?

This has little/none to do with pathing - but rather that all discovery 
controllers use a single well-known NQN - and they don't support 
multipathing.

There can be any number of discovery controllers, each with a different 
"view" of the storage subsystems available. Thus it matters very much 
which path you use. E.g. using a more extreme example: the discovery 
controller on a FC link could be very different from a discovery 
controller at an ip address.

-- james
