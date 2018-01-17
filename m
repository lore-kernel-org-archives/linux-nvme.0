From: james.smart@broadcom.com (James Smart)
Date: Wed, 17 Jan 2018 13:01:22 -0800
Subject: [PATCH V4 1/2] nvme: add NVME_CTRL_RESET_PREPARE state
In-Reply-To: <11106a93-2e78-c853-e6eb-35c652dab3a9@mellanox.com>
References: <1516164877-2170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1516164877-2170-2-git-send-email-jianchao.w.wang@oracle.com>
 <11106a93-2e78-c853-e6eb-35c652dab3a9@mellanox.com>
Message-ID: <50ca626e-7933-5a60-33f9-52e2ac8d0f25@broadcom.com>

I'm having a hard time following why this patch is being requested. Help 
me catch on.....

On 1/16/2018 8:54 PM, Jianchao Wang wrote:
> Currently, the ctrl->state will be changed to NVME_CTRL_RESETTING
> before queue the reset work. This is not so strict. There could be
> a big gap before the reset_work callback is invoked.
ok.... so what you're saying is you want something to know that you've 
transitioned to RESETTING but not yet performed an action for the 
reset.?? What is that something and what is it to do ?

guessing - I assume it's in the transport? xxx_is_ready() and/or 
nvmf_check_init_req(), which is called at the start of queue_rq(), that 
wants to do something ?


>   In addition,
> there is some disable work in the reset_work callback, strictly
> speaking, not part of reset work, and could lead to some confusion.

Can you explain this ?? what's the confusion ?

I assume by "disable" you mean it is quiescing queues ?


>
> In addition, after set state to RESETTING and disable procedure,
> nvme-rdma/fc use NVME_CTRL_RECONNECTING to mark the setup and
> reconnect procedure. The RESETTING state has been narrowed.

I still don't follow. Yes RECONNECTING is where we repetitively: try to 
create a link-side association again: if it fails, delay and try again; 
or if success, reinit the controller, and unquiesce all queues - 
allowing full operation again, at which time we transition to LIVE.

by "narrowed" what do you mean ???? what "narrowed" ?

In FC, as we have a lot of work that must occur to terminate io as part 
of the reset, it can be a fairly long window.? I don't know that any 
functionally in this path, regardless of time window, has narrowed.


>
> This patch add NVME_CTRL_RESET_PREPARE state to mark the reset_work
> or error recovery work, scheduling gap and disable procedure.
> After that,
>   - For nvme-pci, nvmet-loop, set state to RESETTING, start
>     initialization.
>   - For nvme-rdma, nvme-fc, set state to RECONNECTING, start
>     initialization or reconnect.

So I'm lost - so you've effectively renamed RESETTING to RESET_PREPARE 
for fc/rdma.? What do you define are the actions in RESETTING that went 
away and why is that different between pci and the other transports ??? 
Why doesn't nvme-pci need to go through RESET_PREPARE ? doesn't it have 
the same scheduling window for a reset_work thread ?


On 1/17/2018 1:06 AM, Max Gurtovoy wrote:
>
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
>> -??????? case NVME_CTRL_RESETTING:
>> +??????? case NVME_CTRL_RESET_PREPARE:
>
> As I suggested in V3, please don't allow this transition.
> We'll move to NVME_CTRL_RECONNECTING from NVME_CTRL_RESETTING.
>
> I look on it like that:
>
> NVME_CTRL_RESET_PREPARE - "suspend" state
> NVME_CTRL_RESETTING - "resume" state
>
> you don't reconnect from "suspend" state, you must "resume" before you 
> reconnect.

This makes no sense to me.

I could use a definition of what "suspend" and "resume" mean to you....

from what I've seen so far:
NVME_CTRL_RESET_PREPARE:?? means I've decided to reset, changed state, 
but the actual work for reset hasn't started yet.?? As we haven't 
commonized who does the quiescing of the queues, the queues are still 
live at this state, although some nvme check routine may bounce them. In 
truth, the queues should be quiesced here.

NVME_CTRL_RESETTING: I'm resetting the controller, tearing down 
queues/connections, the link side association.? AFAIK - pci and all the 
other transports have to do things things. ? Now is when the blk-mq 
queues get stopped.?? We have a variance on whether the queues are 
unquiesced or left quiesced (I think this is what you meant by "resume", 
where resume means unquiesce) at the end of this.?? The admin_q is 
unquiesced, meaning new admin cmds should fail.? rdma also has io queues 
unquiesced meaning new ios fail, while fc leaves them quiesced while 
background timers run - meaning no new ios issued, nor any fail back to 
a multipather. With the agreement that we would patch all of the 
transports to leave them quiesced with fast-fail-timeouts occuring to 
unquiesce them and start failing ios.

NVME_RECONNECTING: transitioned to after the link-side association is 
terminated and the transport will now attempt to reconnect (perhaps 
several attempts) to create a new link-side association. Stays in this 
state until the controller is fully reconnected and it transitions to 
NVME_LIVE.?? Until the link side association is active, queues do what 
they do (as left by RESETTING and/or updated per timeouts) excepting 
that after an active assocation, they queues will be unquiesced at the 
time of the LIVE transition.?? Note: we grandfathered PCI into not 
needing this state: ? As you (almost) can't fail the establishment of 
the link-side association as it's a PCI function and registers so unless 
the device has dropped off the bus, you can immediately talk to 
registers and start to reinit the controller.? Given it was almost 
impossible not to succeed, and as the code path already existed, we 
didn't see a reason to make pci change.


On 1/17/2018 1:19 AM, jianchao.wang wrote:
>
> I used to respond you in the V3 and wait for your feedback.
> Please refer to:
> After Sagi's nvme-rdma: fix concurrent reset and reconnect, the rdma ctrl state is changed to RECONNECTING state
> after some clearing and shutdown work, then some initializing procedure,  no matter reset work path or error recovery path.
> The fc reset work also does the same thing.
> So if we define the range that RESET_PREPARE includes scheduling gap and disable and clear work, RESETTING includes initializing
> procedure,  RECONNECTING is very similar with RESETTING.

I get the impression we have very different understandings of what 
occurs under what states. I'd like to see a summary of what you think 
that is as this is what we must agree upon.

Of course, if you move the gap, disable, and clear work into 
RESET_PREPARE, you've taken most of the RESETTING state away. What was 
left ?

I don't believe RESETTING and RECONNECTING are that similar - unless - 
you are looking at that "reinit" part that we left grandfathered into PCI.


On 1/17/2018 1:24 AM, jianchao.wang wrote:
>
>> Maybe we could do like this;
>> In nvme fc/rdma
>> - set state to RESET_PREPARE, queue reset_work/err_work
>> - clear/shutdown works, set state to RECONNECTING
>> - initialization, set state to LIVE
>>
>> In nvme pci
>> - set state to RESET_PREPARE, queue reset_work
>> - clear/shutdown works, set state to RESETTING
>> - initialization, set state to LIVE
>> Currently, RECONNECTING has overlapped with RESETTING.
>> So I suggest to use RESET_PREPARE to mark the "suspend" part as you said.
>> And use RECONNECTING to mark the "resume" part in nvme-rdma/fc
>> use RESETTING part to mark the "resume" part in nvme-pci, nvmt-loop.
> I have added a comment above the definition of nvme_ctrl_state as below:
>    +/*
> + * RESET_PREPARE - mark the state of scheduling gap and disable procedure
> + * RESETTING     - nvme-pci, nvmet loop use it to mark the state of setup
> + *                   procedure
> + * RECONNECTING  - nvme-fc, nvme-rdma use it to mark the state of setup
> + *                   and reconnect procedure
> + */
>
> Consequently, nvme-fc/rdma don't use RESETTING state any more, but only RESET_PREPARE.

So now I'm confused again...? The purpose of the new state was to have a 
state indicator to cover the transition into the state while the 
reset_work item was yet to be scheduled. If all you've done is change 
the state name on fc/rdma - don't you still have that window ?

-- james
