From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 13:07:50 +0300
Subject: [PATCH v2 2/7] nvme_fc: change ctlr state assignments during
 reset/reconnect
In-Reply-To: <95dd2176-c5bb-386f-6a7a-4705576713fd@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-3-jsmart2021@gmail.com>
 <20171005075730.GA5063@infradead.org>
 <95dd2176-c5bb-386f-6a7a-4705576713fd@gmail.com>
Message-ID: <9b0d8baa-483d-3d76-19f8-30144cdc2aa8@grimberg.me>


>>> ????? changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>>> -??? WARN_ON_ONCE(!changed);
>>> ????? ctrl->ctrl.nr_reconnects = 0;
>>> -??? nvme_start_ctrl(&ctrl->ctrl);
>>> +??? if (changed)
>>> +??????? nvme_start_ctrl(&ctrl->ctrl);
>>
>> It's just cosmetic, but can you folow the RDMA pattern here:
>>
>> ????changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
>> ????if (!changed) {
>> ??????? /* state change failure is ok if we're in DELETING state */
>> ??????? WARN_ON_ONCE(ctrl->ctrl.state != NVME_CTRL_DELETING);
>> ??????? return;
>> ????}
>>
>> else the patch looks fine:
>>
>> Reviewed-by: Christoph Hellwig <hch at lst.de>
>>
> 
> Actually, it's not just cosmetic. I don't want the warning to be 
> displayed.

That's wrong AFAICT, you do want a warning notification if you
failed to move the controller state to LIVE here and you are
_NOT_ in DELETING. This indicates a state transition that is
undefined.

> With FC's notification on device loss, in testing, we've seen 
> a device loss occur as this state transition occurs. I doubt that's 
> something rdma would ever see.

It does, hence the patch.

> With the device connectivity loss 
> notification, the state moves from NEW to RESETTING, then RECONNECTING.

you mean LIVE -> RESETTING -> RECONNECTING -> LIVE (on successful
reconnect).

That is exactly the point, the only way you fail RECONNECTING -> LIVE
is if you are in DELETING all of a sudden (triggered by the user
perhaps). Is there any way you will accept this state transition
to fail?
