From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 16 Aug 2019 10:24:05 -0700
Subject: [PATCH rfc] nvme: make all fabrics command run on a separate
 request queue
In-Reply-To: <4c7083d3-2067-13d8-b3d8-0418769c80c4@broadcom.com>
References: <20190808234643.8180-1-sagi@grimberg.me>
 <4c7083d3-2067-13d8-b3d8-0418769c80c4@broadcom.com>
Message-ID: <1b3e039b-15ef-703b-1d01-454eaa22ef0e@grimberg.me>


>> We have a fundamental issue that fabric commands use the admin_q.
>> The reason is, that admin-connect, register reads and writes and
>> admin commands cannot be guaranteed ordering while we are running
>> controller resets.
>>
>> For example, when we reset a controller we perform:
>> 1. disable the controller
>> 2. teardown the admin queue
>> 3. re-establish the admin queue
>> 4. enable the controller
>>
>> In order to perform (3), we need to unquiesce the admin queue, however
>> we may have some admin commands that are already pending on the
>> quiesced admin_q and will immediate execute when we unquiesce it before
>> we execute (4). The host must not send admin commands to the controller
>> before enabling the controller.
> I'm not sure there are "commands pending" on the admin_q as they should 
> have been removed/rejected as part of (2).

Nothing guarantees that when the queue is quiesced because it may come
in after you reject the command.

  But that's not to say that
> once you do (3) that there can't be a pending scan thread that then 
> releases (perhaps it did requeue) and issues a command to the admin 
> queue while (3) is being established. They will get intermixed with the 
> cmds to initialize the ctlr.

Exactly. There is a subtle race condition that in a reset storm will
almost always allow commands to reach the target once the admin
queue is unquieced and established again but before the controller is
enabled.

>> To fix this, we have the fabric commands (admin connect and property
>> get/set) use a separate fabrics_q and make sure to quiesce the admin_q
>> before we disable the controller, and unquiesce it only after we enable
>> the controller. This also fits the pci model where the admin commands
>> and controller bar registers are accessed in different "channels".
> 
> I think this part is fine. It doesn't solve the issue of admin q cmd for 
> ctlr init happening at same time a background scan is occurring. But it 
> does help the contention vs the first few init cmds.

I think it does, because it guarantees that no admin commands will make
it to the target when the controller is not yet enabled. This means that
the only error the host should see is a HOST_PATH errors, and for that
we have the patchset to not remove the ns due to these errors (which
causes the hang).

> I'd feel most safe if everything that was part of initializing a 
> controller (through to the set of state to LIVE) use this separate 
> request q.

This is effectively what this patch is doing. Until we enable the
controller we only do:
- connect the admin queue (use the fabrics_q)
- enable the controller

After that we unquiesce the admin_q to let any admin I/O to pass (and 
later on allow I/O commands to pass).

If you think about it, it aligns to nvme-pci in the sense that admin
commands and controller registers do not serialize on the same channel.

> This keeps anything in that scan thread from getting in the 
> way.?? We're not too far from this with your patches. It may be the 
> interaction of the two isn't so bad (if you are live enough for a 
> controller Identify, are you live enough for the ns scanning ios ?),

Exactly, this is why everything stays the same, and we just unquiesce
the admin_q after the controller is enabled (and also quiesce before
we disable).

> but my initial reaction is I'd like to separate them.? Thoughts ?

I'm not sure I understand what you are suggesting. Adding states that
will determine which request queue to use? Not sure how this is going
to work. Can you explain more on your thoughts?

>> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
>> index c289f46f6d13..5680ec15f52c 100644
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -2029,6 +2029,7 @@ nvme_fc_ctrl_free(struct kref *ref)
>> ????? blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>> ????? blk_cleanup_queue(ctrl->ctrl.admin_q);
>> +??? blk_cleanup_queue(ctrl->ctrl.fabrics_q);
>> ????? blk_mq_free_tag_set(&ctrl->admin_tag_set);
>> ????? kfree(ctrl->queues);
>> @@ -2656,8 +2657,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl 
>> *ctrl)
>> ????? if (ret)
>> ????????? goto out_delete_hw_queue;
>> -??? blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>> -
>> ????? ret = nvmf_connect_admin_queue(&ctrl->ctrl);
>> ????? if (ret)
>> ????????? goto out_disconnect_admin_queue;
>> @@ -2678,6 +2677,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl 
>> *ctrl)
>> ????? ctrl->ctrl.max_hw_sectors =
>> ????????? (ctrl->lport->ops->max_sgl_segments - 1) << (PAGE_SHIFT - 9);
>> +??? blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>> +
>> ????? ret = nvme_init_identify(&ctrl->ctrl);
>> ????? if (ret)
>> ????????? goto out_disconnect_admin_queue;
>> @@ -3122,10 +3123,16 @@ nvme_fc_init_ctrl(struct device *dev, struct 
>> nvmf_ctrl_options *opts,
>> ????????? goto out_free_queues;
>> ????? ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
>> +??? ctrl->ctrl.fabrics_q = blk_mq_init_queue(&ctrl->admin_tag_set);
>> +??? if (IS_ERR(ctrl->ctrl.fabrics_q)) {
>> +??????? ret = PTR_ERR(ctrl->ctrl.fabrics_q);
>> +??????? goto out_free_admin_tag_set;
>> +??? }
>> +
>> ????? ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
>> ????? if (IS_ERR(ctrl->ctrl.admin_q)) {
>> ????????? ret = PTR_ERR(ctrl->ctrl.admin_q);
>> -??????? goto out_free_admin_tag_set;
>> +??????? goto out_cleanup_fabrics_q;
>> ????? }
>> ????? /*
>> @@ -3197,6 +3204,8 @@ nvme_fc_init_ctrl(struct device *dev, struct 
>> nvmf_ctrl_options *opts,
>> ? out_cleanup_admin_q:
>> ????? blk_cleanup_queue(ctrl->ctrl.admin_q);
>> +out_cleanup_fabrics_q:
>> +??? blk_cleanup_queue(ctrl->ctrl.fabrics_q);
>> ? out_free_admin_tag_set:
>> ????? blk_mq_free_tag_set(&ctrl->admin_tag_set);
>> ? out_free_queues:
> 
> I think the fabrics_q had to be quiesced and unquiesed at the points 
> where today's admin_q is in fc.? It's possible the controller may under 
> go a reset while in the middle of creating/initializing a new controller 
> (on FC, async detection of connectivity is detected, resetting the 
> controller). As such, I need to be sure the fabric commands initializing 
> the controller are stopped/aborted, and the admin queue will be marked 
> non-live to abort any retries other attempts, until the new 
> create_association is attempted.?? Quiescing also helps as, as is, we 
> are looping on the admin tag set to abort/clear anything outstanding on 
> the reset, with the request_q not quiesced, which is probably not a good 
> thing.

OK, I can add that.
