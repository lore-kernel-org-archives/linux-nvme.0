From: james.smart@broadcom.com (James Smart)
Date: Tue, 30 Jan 2018 10:54:15 -0800
Subject: [PATCH 3/5] nvme-fc: use NVME_CTRL_CONNECTING state to mark init
 process
In-Reply-To: <1517147887-15645-4-git-send-email-maxg@mellanox.com>
References: <1517147887-15645-1-git-send-email-maxg@mellanox.com>
 <1517147887-15645-4-git-send-email-maxg@mellanox.com>
Message-ID: <05dbf01f-da45-6619-fbc3-f6249f7239f9@broadcom.com>

On 1/28/2018 5:58 AM, Max Gurtovoy wrote:
> Align with RDMA and PCI transports.
>
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/fc.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index b679971..2992896 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c

The other patches in this set look ok, but with one caveat (5th patch) 
I'll get to shortly.? I agree with the desired statemachine look as 
well, with more comments on this below.

This fc patch though - I disagree with. There was a reason I avoided the 
"new" arguments that were in rdma and instead keyed off the the NEW 
controller state. We were coded differently and adding them in raises 
some conditions where they will not be set properly relative to how far 
the controller is initialized.

In FC, when we had failures in the initial connect - the controller 
state stayed in the NEW state for 3 retries of the initial controller 
create. The 3 retries were immediate and driven from the create_ctrl 
call.? It does bother me that fc did not go into the reconnect 
delay/retry loop like we would once we had passed initial connect, but 
if we do that, the controller state machine means we lose the NEW 
condition that tracked how much the controller was initialized and would 
miss some initial setup for the io queues as well as action on the 
queues when tearing down the association that got partially built before 
failing. It's actually the same situations you create with this patch - 
the "new" arguments aren't set to a correct value relative to how much 
the controller has initialized.

There's another effort going on as well.? Hannes has been pushing for 
simplified udev/systemd scripts.? Right now, the scripts require systemd 
as that call to create_cntrl can take a while - due to timeout on an io 
transaction or due to retries.? If the initial create_ctrl request can 
be relatively quick, we can get back to a simple udev script to 
scan/connect.? The trick being: the nvme cli for connect-all, which 
creates the discovery controller then connects to it to read discovery 
log messages - needs to glean the instance number for the discovery 
controller.? And to glean the number means create_ctrl needs to 
succeed.?? Mixing this need, and the desire to use the same reconnect 
delay/retry for initial connect - means I believe I have to formalize 
the "allocation state" of a controller, with 2 implementation options: 
a) a state flag tracking whether initial connect has been completed or 
not (e.g. what the new flag should be set to); or b) deal with how we 
always create an initial io tag set and allow the later association 
under the CONNECT state resize it based on the new association and 
resume it.

What I'd like to have you do is drop this patch and the 5th patch. The 
5th patch removes the NEW->LIVE transition.? Leave that, so the FC can 
continue to work as is without this 3rd patch.?? Then I can implement 
the work above independently.? I can resubmit the 5th patch when FC no 
longer needs it.

-- james

Note: as far as test the fc transport - that is what the fcloop driver 
is for.




> @@ -2704,7 +2704,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
>    * on the link side, recreates the controller association.
>    */
>   static int
> -nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
> +nvme_fc_create_association(struct nvme_fc_ctrl *ctrl, bool new)
>   {
>   	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
>   	int ret;
> @@ -2735,7 +2735,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
>   	if (ret)
>   		goto out_delete_hw_queue;
>   
> -	if (ctrl->ctrl.state != NVME_CTRL_NEW)
> +	if (!new)
>   		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>   
>   	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
> @@ -2801,7 +2801,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
>   	 */
>   
>   	if (ctrl->ctrl.queue_count > 1) {
> -		if (ctrl->ctrl.state == NVME_CTRL_NEW)
> +		if (new)
>   			ret = nvme_fc_create_io_queues(ctrl);
>   		else
>   			ret = nvme_fc_reinit_io_queues(ctrl);
> @@ -3007,7 +3007,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
>   	}
>   
>   	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE)
> -		ret = nvme_fc_create_association(ctrl);
> +		ret = nvme_fc_create_association(ctrl, false);
>   	else
>   		ret = -ENOTCONN;
>   
> @@ -3042,7 +3042,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
>   			container_of(to_delayed_work(work),
>   				struct nvme_fc_ctrl, connect_work);
>   
> -	ret = nvme_fc_create_association(ctrl);
> +	ret = nvme_fc_create_association(ctrl, false);
>   	if (ret)
>   		nvme_fc_reconnect_or_delete(ctrl, ret);
>   	else
> @@ -3096,6 +3096,7 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
>   	struct nvme_fc_ctrl *ctrl;
>   	unsigned long flags;
>   	int ret, idx, retry;
> +	bool changed;
>   
>   	if (!(rport->remoteport.port_role &
>   	    (FC_PORT_ROLE_NVME_DISCOVERY | FC_PORT_ROLE_NVME_TARGET))) {
> @@ -3212,8 +3213,11 @@ static inline blk_status_t nvme_fc_is_ready(struct nvme_fc_queue *queue,
>   	 * request fails, retry the initial connection creation up to
>   	 * three times before giving up and declaring failure.
>   	 */
> +	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING);
> +	WARN_ON_ONCE(!changed);
> +
>   	for (retry = 0; retry < 3; retry++) {
> -		ret = nvme_fc_create_association(ctrl);
> +		ret = nvme_fc_create_association(ctrl, true);
>   		if (!ret)
>   			break;
>   	}

note: the diff, with everything tagged as being in the routine 
nvme_fc_is_ready() made the patch very odd to read
