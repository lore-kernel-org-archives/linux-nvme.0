From: james.smart@broadcom.com (James Smart)
Date: Thu, 15 Aug 2019 14:57:56 -0700
Subject: [PATCH rfc] nvme: make all fabrics command run on a separate
 request queue
In-Reply-To: <20190808234643.8180-1-sagi@grimberg.me>
References: <20190808234643.8180-1-sagi@grimberg.me>
Message-ID: <4c7083d3-2067-13d8-b3d8-0418769c80c4@broadcom.com>



On 8/8/2019 4:46 PM, Sagi Grimberg wrote:
> We have a fundamental issue that fabric commands use the admin_q.
> The reason is, that admin-connect, register reads and writes and
> admin commands cannot be guaranteed ordering while we are running
> controller resets.
>
> For example, when we reset a controller we perform:
> 1. disable the controller
> 2. teardown the admin queue
> 3. re-establish the admin queue
> 4. enable the controller
>
> In order to perform (3), we need to unquiesce the admin queue, however
> we may have some admin commands that are already pending on the
> quiesced admin_q and will immediate execute when we unquiesce it before
> we execute (4). The host must not send admin commands to the controller
> before enabling the controller.
I'm not sure there are "commands pending" on the admin_q as they should 
have been removed/rejected as part of (2). But that's not to say that 
once you do (3) that there can't be a pending scan thread that then 
releases (perhaps it did requeue) and issues a command to the admin 
queue while (3) is being established. They will get intermixed with the 
cmds to initialize the ctlr.

>
> To fix this, we have the fabric commands (admin connect and property
> get/set) use a separate fabrics_q and make sure to quiesce the admin_q
> before we disable the controller, and unquiesce it only after we enable
> the controller. This also fits the pci model where the admin commands
> and controller bar registers are accessed in different "channels".

I think this part is fine. It doesn't solve the issue of admin q cmd for 
ctlr init happening at same time a background scan is occurring. But it 
does help the contention vs the first few init cmds.

I'd feel most safe if everything that was part of initializing a 
controller (through to the set of state to LIVE) use this separate 
request q. This keeps anything in that scan thread from getting in the 
way.?? We're not too far from this with your patches. It may be the 
interaction of the two isn't so bad (if you are live enough for a 
controller Identify, are you live enough for the ns scanning ios ?), but 
my initial reaction is I'd like to separate them.? Thoughts ?

>
> This fixes the error prints from nvmet in a controller reset storm test:
> kernel: nvmet: got cmd 6 while CC.EN == 0 on qid = 0
> Which indicate that the host is sending an admin command when the
> controller is not enabled.
>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   drivers/nvme/host/core.c    |  3 ++-
>   drivers/nvme/host/fabrics.c |  8 ++++----
>   drivers/nvme/host/fc.c      | 15 ++++++++++++---
>   drivers/nvme/host/nvme.h    |  1 +
>   drivers/nvme/host/rdma.c    | 19 +++++++++++++++++--
>   drivers/nvme/host/tcp.c     | 19 +++++++++++++++++--
>   drivers/nvme/target/loop.c  | 16 +++++++++++++---
>   7 files changed, 66 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index ae30ed75dad9..ccd465220f1e 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -1623,7 +1623,8 @@ static int nvme_report_ns_ids(struct nvme_ctrl *ctrl, unsigned int nsid,
>   		ret = nvme_identify_ns_descs(ctrl, nsid, ids);
>   		if (ret)
>   			dev_warn(ctrl->device,
> -				 "%s: Identify Descriptors failed\n", __func__);
> +				 "%s: Identify Descriptors failed (%d)\n",
> +				 __func__, ret);
>   	}
>   	return ret;
>   }
> diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
> index d0d066307bb4..4801bdc7d85b 100644
> --- a/drivers/nvme/host/fabrics.c
> +++ b/drivers/nvme/host/fabrics.c
> @@ -150,7 +150,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
>   	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
>   	cmd.prop_get.offset = cpu_to_le32(off);
>   
> -	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
>   			NVME_QID_ANY, 0, 0, false);
>   
>   	if (ret >= 0)
> @@ -197,7 +197,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
>   	cmd.prop_get.attrib = 1;
>   	cmd.prop_get.offset = cpu_to_le32(off);
>   
> -	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res, NULL, 0, 0,
> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0, 0,
>   			NVME_QID_ANY, 0, 0, false);
>   
>   	if (ret >= 0)
> @@ -243,7 +243,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
>   	cmd.prop_set.offset = cpu_to_le32(off);
>   	cmd.prop_set.value = cpu_to_le64(val);
>   
> -	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, NULL, 0, 0,
> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0, 0,
>   			NVME_QID_ANY, 0, 0, false);
>   	if (unlikely(ret))
>   		dev_err(ctrl->device,
> @@ -396,7 +396,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
>   	strncpy(data->subsysnqn, ctrl->opts->subsysnqn, NVMF_NQN_SIZE);
>   	strncpy(data->hostnqn, ctrl->opts->host->nqn, NVMF_NQN_SIZE);
>   
> -	ret = __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, &res,
> +	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
>   			data, sizeof(*data), 0, NVME_QID_ANY, 1,
>   			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
>   	if (ret) {
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index c289f46f6d13..5680ec15f52c 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -2029,6 +2029,7 @@ nvme_fc_ctrl_free(struct kref *ref)
>   
>   	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>   	blk_cleanup_queue(ctrl->ctrl.admin_q);
> +	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
>   	blk_mq_free_tag_set(&ctrl->admin_tag_set);
>   
>   	kfree(ctrl->queues);
> @@ -2656,8 +2657,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	if (ret)
>   		goto out_delete_hw_queue;
>   
> -	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> -
>   	ret = nvmf_connect_admin_queue(&ctrl->ctrl);
>   	if (ret)
>   		goto out_disconnect_admin_queue;
> @@ -2678,6 +2677,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
>   	ctrl->ctrl.max_hw_sectors =
>   		(ctrl->lport->ops->max_sgl_segments - 1) << (PAGE_SHIFT - 9);
>   
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> +
>   	ret = nvme_init_identify(&ctrl->ctrl);
>   	if (ret)
>   		goto out_disconnect_admin_queue;
> @@ -3122,10 +3123,16 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   		goto out_free_queues;
>   	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
>   
> +	ctrl->ctrl.fabrics_q = blk_mq_init_queue(&ctrl->admin_tag_set);
> +	if (IS_ERR(ctrl->ctrl.fabrics_q)) {
> +		ret = PTR_ERR(ctrl->ctrl.fabrics_q);
> +		goto out_free_admin_tag_set;
> +	}
> +
>   	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
>   	if (IS_ERR(ctrl->ctrl.admin_q)) {
>   		ret = PTR_ERR(ctrl->ctrl.admin_q);
> -		goto out_free_admin_tag_set;
> +		goto out_cleanup_fabrics_q;
>   	}
>   
>   	/*
> @@ -3197,6 +3204,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
>   
>   out_cleanup_admin_q:
>   	blk_cleanup_queue(ctrl->ctrl.admin_q);
> +out_cleanup_fabrics_q:
> +	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
>   out_free_admin_tag_set:
>   	blk_mq_free_tag_set(&ctrl->admin_tag_set);
>   out_free_queues:

I think the fabrics_q had to be quiesced and unquiesed at the points 
where today's admin_q is in fc.? It's possible the controller may under 
go a reset while in the middle of creating/initializing a new controller 
(on FC, async detection of connectivity is detected, resetting the 
controller). As such, I need to be sure the fabric commands initializing 
the controller are stopped/aborted, and the admin queue will be marked 
non-live to abort any retries other attempts, until the new 
create_association is attempted.?? Quiescing also helps as, as is, we 
are looping on the admin tag set to abort/clear anything outstanding on 
the reset, with the request_q not quiesced, which is probably not a good 
thing.

otherwise looks good.

-- james


> diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
> index 8dc010ca30e5..c7736bad9c91 100644
> --- a/drivers/nvme/host/nvme.h
> +++ b/drivers/nvme/host/nvme.h
> @@ -164,6 +164,7 @@ struct nvme_ctrl {
>   	const struct nvme_ctrl_ops *ops;
>   	struct request_queue *admin_q;
>   	struct request_queue *connect_q;
> +	struct request_queue *fabrics_q;
>   	struct device *dev;
>   	int instance;
>   	int numa_node;
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index c029ef1bc510..f6007a973f70 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -757,6 +757,7 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   {
>   	if (remove) {
>   		blk_cleanup_queue(ctrl->ctrl.admin_q);
> +		blk_cleanup_queue(ctrl->ctrl.fabrics_q);
>   		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
>   	}
>   	if (ctrl->async_event_sqe.data) {
> @@ -798,10 +799,16 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   			goto out_free_async_qe;
>   		}
>   
> +		ctrl->ctrl.fabrics_q = blk_mq_init_queue(&ctrl->admin_tag_set);
> +		if (IS_ERR(ctrl->ctrl.fabrics_q)) {
> +			error = PTR_ERR(ctrl->ctrl.fabrics_q);
> +			goto out_free_tagset;
> +		}
> +
>   		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
>   		if (IS_ERR(ctrl->ctrl.admin_q)) {
>   			error = PTR_ERR(ctrl->ctrl.admin_q);
> -			goto out_free_tagset;
> +			goto out_cleanup_fabrics_q;
>   		}
>   	}
>   
> @@ -816,6 +823,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   	ctrl->ctrl.max_hw_sectors =
>   		(ctrl->max_fr_pages - 1) << (ilog2(SZ_4K) - 9);
>   
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> +
>   	error = nvme_init_identify(&ctrl->ctrl);
>   	if (error)
>   		goto out_stop_queue;
> @@ -827,6 +836,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   out_cleanup_queue:
>   	if (new)
>   		blk_cleanup_queue(ctrl->ctrl.admin_q);
> +out_cleanup_fabrics_q:
> +	if (new)
> +		blk_cleanup_queue(ctrl->ctrl.fabrics_q);
>   out_free_tagset:
>   	if (new)
>   		blk_mq_free_tag_set(ctrl->ctrl.admin_tagset);
> @@ -899,7 +911,8 @@ static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
>   	if (ctrl->ctrl.admin_tagset)
>   		blk_mq_tagset_busy_iter(ctrl->ctrl.admin_tagset,
>   			nvme_cancel_request, &ctrl->ctrl);
> -	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> +	if (remove)
> +		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>   	nvme_rdma_destroy_admin_queue(ctrl, remove);
>   }
>   
> @@ -1048,6 +1061,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
>   	nvme_rdma_teardown_io_queues(ctrl, false);
>   	nvme_start_queues(&ctrl->ctrl);
>   	nvme_rdma_teardown_admin_queue(ctrl, false);
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>   
>   	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
>   		/* state change failure is ok if we're in DELETING state */
> @@ -1858,6 +1872,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
>   	cancel_delayed_work_sync(&ctrl->reconnect_work);
>   
>   	nvme_rdma_teardown_io_queues(ctrl, shutdown);
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>   	if (shutdown)
>   		nvme_shutdown_ctrl(&ctrl->ctrl);
>   	else
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7daf39f31b08..5f5fb1dd922d 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -1691,6 +1691,7 @@ static void nvme_tcp_destroy_admin_queue(struct nvme_ctrl *ctrl, bool remove)
>   	nvme_tcp_stop_queue(ctrl, 0);
>   	if (remove) {
>   		blk_cleanup_queue(ctrl->admin_q);
> +		blk_cleanup_queue(ctrl->fabrics_q);
>   		blk_mq_free_tag_set(ctrl->admin_tagset);
>   	}
>   	nvme_tcp_free_admin_queue(ctrl);
> @@ -1711,10 +1712,16 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>   			goto out_free_queue;
>   		}
>   
> +		ctrl->fabrics_q = blk_mq_init_queue(ctrl->admin_tagset);
> +		if (IS_ERR(ctrl->fabrics_q)) {
> +			error = PTR_ERR(ctrl->fabrics_q);
> +			goto out_free_tagset;
> +		}
> +
>   		ctrl->admin_q = blk_mq_init_queue(ctrl->admin_tagset);
>   		if (IS_ERR(ctrl->admin_q)) {
>   			error = PTR_ERR(ctrl->admin_q);
> -			goto out_free_tagset;
> +			goto out_cleanup_fabrics_q;
>   		}
>   	}
>   
> @@ -1726,6 +1733,8 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>   	if (error)
>   		goto out_stop_queue;
>   
> +	blk_mq_unquiesce_queue(ctrl->admin_q);
> +
>   	error = nvme_init_identify(ctrl);
>   	if (error)
>   		goto out_stop_queue;
> @@ -1737,6 +1746,9 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
>   out_cleanup_queue:
>   	if (new)
>   		blk_cleanup_queue(ctrl->admin_q);
> +out_cleanup_fabrics_q:
> +	if (new)
> +		blk_cleanup_queue(ctrl->fabrics_q);
>   out_free_tagset:
>   	if (new)
>   		blk_mq_free_tag_set(ctrl->admin_tagset);
> @@ -1753,7 +1765,8 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
>   	if (ctrl->admin_tagset)
>   		blk_mq_tagset_busy_iter(ctrl->admin_tagset,
>   			nvme_cancel_request, ctrl);
> -	blk_mq_unquiesce_queue(ctrl->admin_q);
> +	if (remove)
> +		blk_mq_unquiesce_queue(ctrl->admin_q);
>   	nvme_tcp_destroy_admin_queue(ctrl, remove);
>   }
>   
> @@ -1878,6 +1891,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
>   	/* unquiesce to fail fast pending requests */
>   	nvme_start_queues(ctrl);
>   	nvme_tcp_teardown_admin_queue(ctrl, false);
> +	blk_mq_unquiesce_queue(ctrl->admin_q);
>   
>   	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
>   		/* state change failure is ok if we're in DELETING state */
> @@ -1894,6 +1908,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
>   	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
>   
>   	nvme_tcp_teardown_io_queues(ctrl, shutdown);
> +	blk_mq_quiesce_queue(ctrl->admin_q);
>   	if (shutdown)
>   		nvme_shutdown_ctrl(ctrl);
>   	else
> diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
> index d8078d7014eb..b78d10dba6f5 100644
> --- a/drivers/nvme/target/loop.c
> +++ b/drivers/nvme/target/loop.c
> @@ -253,6 +253,7 @@ static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
>   	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
>   	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
>   	blk_cleanup_queue(ctrl->ctrl.admin_q);
> +	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
>   	blk_mq_free_tag_set(&ctrl->admin_tag_set);
>   }
>   
> @@ -357,10 +358,16 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
>   		goto out_free_sq;
>   	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
>   
> +	ctrl->ctrl.fabrics_q = blk_mq_init_queue(&ctrl->admin_tag_set);
> +	if (IS_ERR(ctrl->ctrl.fabrics_q)) {
> +		error = PTR_ERR(ctrl->ctrl.fabrics_q);
> +		goto out_free_tagset;
> +	}
> +
>   	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
>   	if (IS_ERR(ctrl->ctrl.admin_q)) {
>   		error = PTR_ERR(ctrl->ctrl.admin_q);
> -		goto out_free_tagset;
> +		goto out_cleanup_fabrics_q;
>   	}
>   
>   	error = nvmf_connect_admin_queue(&ctrl->ctrl);
> @@ -376,6 +383,8 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
>   	ctrl->ctrl.max_hw_sectors =
>   		(NVME_LOOP_MAX_SEGMENTS - 1) << (PAGE_SHIFT - 9);
>   
> +	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
> +
>   	error = nvme_init_identify(&ctrl->ctrl);
>   	if (error)
>   		goto out_cleanup_queue;
> @@ -384,6 +393,8 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
>   
>   out_cleanup_queue:
>   	blk_cleanup_queue(ctrl->ctrl.admin_q);
> +out_cleanup_fabrics_q:
> +	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
>   out_free_tagset:
>   	blk_mq_free_tag_set(&ctrl->admin_tag_set);
>   out_free_sq:
> @@ -400,13 +411,12 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
>   		nvme_loop_destroy_io_queues(ctrl);
>   	}
>   
> +	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>   	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
>   		nvme_shutdown_ctrl(&ctrl->ctrl);
>   
> -	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
>   	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
>   				nvme_cancel_request, &ctrl->ctrl);
> -	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
>   	nvme_loop_destroy_admin_queue(ctrl);
>   }
>   
