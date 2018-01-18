From: james.smart@broadcom.com (James Smart)
Date: Wed, 17 Jan 2018 22:24:26 -0800
Subject: [PATCH V4 1/2] nvme: add NVME_CTRL_RESET_PREPARE state
In-Reply-To: <9a42cfac-642a-6838-625a-eeb51bec5c78@oracle.com>
References: <1516164877-2170-1-git-send-email-jianchao.w.wang@oracle.com>
 <1516164877-2170-2-git-send-email-jianchao.w.wang@oracle.com>
 <11106a93-2e78-c853-e6eb-35c652dab3a9@mellanox.com>
 <50ca626e-7933-5a60-33f9-52e2ac8d0f25@broadcom.com>
 <9a42cfac-642a-6838-625a-eeb51bec5c78@oracle.com>
Message-ID: <cb2f0c09-42e9-8310-89b6-eee0bb61f9be@broadcom.com>

Thanks jianchoa. This helped.

On 1/17/2018 7:13 PM, jianchao.wang wrote:
> Actually, this patchset is to fix a issue in nvme_timeout.
> Please consider the following scenario.
>
> nvme_reset_ctrl
>      -> set state to RESETTING
>      -> queue reset_work
>              (scheduling)
>                       nvme_reset_work                      -> nvme_dev_disable
>                          -> quiesce queues
>                            -> nvme_cancel_request
>                               on outstanding requests
>   --------------------------------------------------------------------_boundary_
>                        -> nvme initializing (may issue request on adminq)
>
> Before the boundary, not only quiesce the queues, but only cancel all the outstanding requests.
>
> A request could expire when the ctrl state is RESETTING.
>   - If the timeout occur before the _boundary_, the expired requests are from the previous work.
>   - Otherwise, the expired requests are from the controller initializing procedure, such as sending cq/sq
>     create commands to adminq to setup io queues.
> In current implementation, nvme_timeout cannot identify the _boundary_ so only handles second case above.

So what you've described very well is the pci adapter and the fact that 
it doesn't use a RECONNECTING state when it starts to reinit the 
controller like rdma/fc does.? Note: we had left it that way as a 
"grandfathering" as the code already existed and we didn't see an issue 
just leaving the reinit in the resetting handler.


> ....
>
> So in the patch, RESETTING in nvme-fc/rdma is changed to RESET_PREPARE. Then we get:
> nvme-fc/rdma RESET_PREPARE -> RECONNECTING -> LIVE
> nvme-pci     RESET_PREPARE -> RESETTING    -> LIVE

Right - so another way to look at this is you renamed RESETTING to 
RESET_PREPARE and added a new RESETTING state in the nvme-pci when in 
reinits.? Why not simply have the nvme-pci transport transition to 
RECONNECTING like the other transports. No new states, semantics are all 
the same.

Here's what the responsibility of the states are:
RESETTING:
-quiescing the blk-mq queues os errors don't bubble back to callees and 
new io is suspended
-terminating the link-side association: resets the controller via 
register access/SET_PROPERTY, deletes connections/queues, cleans out 
active io and lets them queue for resending, etc.
-end result is nvme block device is present, but idle, and no active 
controller on the link side? (link being a transport specific link such 
as pci, or ethernet/ib for rdma or fc link).

RECONNECTING:
- "establish an association at the transport" on PCI this is immediate - 
you can either talk to the pci function or you can't. With rdma/fc we 
send transport traffic to create an admin q connection.
- if association succeeded: the controller is init'd via register 
accesses/fabric GET/SET_PROPERTIES and admin-queue command, io 
connections/queues created, blk-mq queues unquiesced, and finally 
transition to NVME_CTRL_LIVE.
- if association failed: check controller timeout., if not exceeded, 
schedule timer and retry later.? With pci, this could cover the 
temporary loss of the pci function access (a hot plug event) while 
keeping the nvme blk device live in the system.

It matches what you are describing but using what we already have in 
place - with the only difference being the addition of your "boundary" 
by adding the RECONNECTING state to nvme-pci.


>
>>> I don't believe RESETTING and RECONNECTING are that similar - unless - you are looking at that "reinit" part that we left grandfathered into PCI.
> Yes. I have got the point. Thanks for your directive.
>
> Both nvme-pc and nvme-fc/rdma have "shutdown" part to tear down queues/connects, quiesce queues, cancel outstanding requests...
> We could call this part as "shutdowning" as well as the scheduling gap.
> Because the difference of initializing between the nvme-pci and nvme-fc/rdma,  we could call "reiniting" for nvme-pci and
> call "reconnecting" for nvme-fc/rdma

I don't think we need different states for the two. The actions taken 
are really very similar. How they do the actions varies slightly, but 
not what they are trying to do.?? Thus, I'd prefer we keep the existing 
RECONNECTING state and use it in nvme-pci as well. I'm open to renaming 
it if there's something about the name that is not agreeable.


-- james
