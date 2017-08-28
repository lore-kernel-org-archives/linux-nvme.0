From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 28 Aug 2017 09:00:20 +0300
Subject: [PATCH] Add support for reservations to NVMeoF target
In-Reply-To: <1503497088-12775-1-git-send-email-omri@excelero.com>
References: <1503497088-12775-1-git-send-email-omri@excelero.com>
Message-ID: <d787b603-ce2c-c130-d5f9-5178f1e55997@grimberg.me>

Hi Omri,

First, please follow the format of patch submission as described
in: Documentation/process/submitting-patches.rst

Second, I would love to see a generic reservations lib so nvmet
and LIO can share the same abstraction (with proper callouts
in place). But I don't think its a gating issue.
Adding Mike to the thread.

Third, persistent reservations should survive power loss, which
means they need to be logged in a file at least.

As for the implementation itself, any reason to choose a rw_lock
instead of a rcu protection scheme? Up until now we got the
IO path to be lock free and I'm not very enthusiast starting now.

> diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
> index a53bb66..9695af7 100644
> --- a/drivers/nvme/target/admin-cmd.c
> +++ b/drivers/nvme/target/admin-cmd.c
> @@ -156,6 +156,30 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
>   		 * still claim to fully implement this mandatory log page.
>   		 */
>   		break;
> +	case NVME_LOG_RESERVATION:
> +		if (data_len < 16) {
> +			status = NVME_SC_INTERNAL;
> +			goto err;
> +		}
> +		mutex_lock(&req->sq->ctrl->lock);
> +		req->sq->ctrl->rsrv_log_async_sent = false;
> +		if (!list_empty(&req->sq->ctrl->rsrv_log)) {
> +			struct nvmet_rsrv_log *p;
> +
> +			list_for_each_entry(p, &req->sq->ctrl->rsrv_log, link) {
> +				if (++((u8 *)buf)[9] == 255)
> +					break;
> +			}
> +			p = list_first_entry(&req->sq->ctrl->rsrv_log,
> +					     struct nvmet_rsrv_log, link);
> +			++req->sq->ctrl->rsrv_log_counter;
> +			*(__le64 *)buf =
> +				cpu_to_le64(&req->sq->ctrl->rsrv_log_counter);
> +			((u8 *)buf)[8] = p->log_type;
> +			*(__le32 *)(buf+12) = cpu_to_le32(p->nsid);

I suggest that buf should be casted to a generic reservation log page
event (defined in include/linux/nvme.h) instead of this buffer 
manipulation. And please move the handling to a dedicated routine.

> +		}
> +		mutex_unlock(&req->sq->ctrl->lock);
> +		break;
>   	default:
>   		BUG();
>   	}
> @@ -461,6 +485,15 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
>   		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
>   		nvmet_set_result(req, req->sq->ctrl->kato);
>   		break;
> +	case NVME_FEAT_HOST_ID:
> +		status = nvmet_copy_from_sgl(req, 0, &req->sq->ctrl->host_id,
> +						8);
> +		break;

Can you split the host_id part to a dedicated patch?

> +void add_reservation_log_page(struct nvmet_ctrl *ctrl,
> +		struct nvmet_ns *ns, int type)
> +{
> +	struct nvmet_rsrv_log *p;
> +
> +	if (ctrl->rsrv_mask & (1 << type))
> +		return;
> +	p = kzalloc(sizeof(*p), GFP_KERNEL);
> +	if (p == NULL)
> +		return;
> +	p->nsid = ns->nsid;
> +	p->log_type = type;
> +	mutex_lock(&ctrl->lock);
> +	list_add_tail(&p->link, &ctrl->rsrv_log);
> +	mutex_unlock(&ctrl->lock);
> +	if (!ctrl->rsrv_log_async_sent) {
> +		ctrl->rsrv_log_async_sent = true;
> +		nvmet_add_async_event(ctrl, 6, 0, NVME_LOG_RESERVATION);
> +	}
> +}

It would be good if you directly fill a reservation log page structure
itself here.

> +
>   int nvmet_register_transport(struct nvmet_fabrics_ops *ops)
>   {
>   	int ret = 0;
> @@ -377,6 +398,8 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
>   
>   	INIT_LIST_HEAD(&ns->dev_link);
>   	init_completion(&ns->disable_done);
> +	INIT_LIST_HEAD(&ns->rsrv_list);
> +	rwlock_init(&ns->rsrv_lock);
>   
>   	ns->nsid = nsid;
>   	ns->subsys = subsys;
> @@ -846,6 +869,7 @@ static void nvmet_ctrl_free(struct kref *ref)
>   	nvmet_stop_keep_alive_timer(ctrl);
>   
>   	mutex_lock(&subsys->lock);
> +	nvmet_rsrv_remove_ctrl(ctrl);
>   	list_del(&ctrl->subsys_entry);
>   	mutex_unlock(&subsys->lock);
>   
> diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
> index 3b4d47a..4eb4182 100644
> --- a/drivers/nvme/target/io-cmd.c
> +++ b/drivers/nvme/target/io-cmd.c
> @@ -16,6 +16,8 @@
>   #include <linux/module.h>
>   #include "nvmet.h"
>   
> +#define IEKEY	0x8	/* Ignore Existing Key */
> +
>   static void nvmet_bio_done(struct bio *bio)
>   {
>   	struct nvmet_req *req = bio->bi_private;
> @@ -40,6 +42,57 @@ static void nvmet_inline_bio_init(struct nvmet_req *req)
>   	bio_init(bio, req->inline_bvec, NVMET_MAX_INLINE_BIOVEC);
>   }
>   
> +static inline bool nvmet_ctrl_same_host(struct nvmet_ctrl *ctrl1,
> +					struct nvmet_ctrl *ctrl2)
> +{
> +	if (ctrl1 == NULL || ctrl2 == NULL)
> +		return false;
> +	if (ctrl1 == ctrl2)
> +		return true;
> +	if (ctrl1->host_id != 0 && ctrl1->host_id == ctrl2->host_id)
> +		return true;
> +	return false;
> +}
> +
> +static struct nvmet_rsrv *nvmet_find_reservation(struct nvmet_req *req)
> +{
> +	struct nvmet_rsrv *p;
> +
> +	list_for_each_entry(p, &req->ns->rsrv_list, link) {
> +		if (nvmet_ctrl_same_host(p->ctrl, req->sq->ctrl))
> +			return p;
> +	}
> +	return NULL;
> +}
> +
> +static bool nvmet_check_reservation(struct nvmet_req *req)
> +{
> +	bool success = true;
> +
> +	read_lock(&req->ns->rsrv_lock);
> +	switch (req->ns->rsrv_type) {
> +	case PR_WRITE_EXCLUSIVE:
> +		if (req->cmd->rw.opcode == nvme_cmd_read)
> +			goto out;
> +	case PR_EXCLUSIVE_ACCESS:
> +		success = nvmet_ctrl_same_host(req->ns->rsrv_ctrl,
> +						req->sq->ctrl);
> +		goto out;
> +	case PR_WRITE_EXCLUSIVE_REG_ONLY:
> +	case PR_WRITE_EXCLUSIVE_ALL_REGS:
> +		if (req->cmd->rw.opcode == nvme_cmd_read)
> +			goto out;
> +	case PR_EXCLUSIVE_ACCESS_REG_ONLY:
> +	case PR_EXCLUSIVE_ACCESS_ALL_REGS:
> +		success = (nvmet_find_reservation(req) != NULL);
> +	default:
> +		goto out;
> +	}
> +out:
> +	read_unlock(&req->ns->rsrv_lock);
> +	return success;
> +}
> +
>   static void nvmet_execute_rw(struct nvmet_req *req)
>   {
>   	int sg_cnt = req->sg_cnt;
> @@ -196,6 +249,296 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
>   	}
>   }
>   
> +static void nvmet_execute_resv_register(struct nvmet_req *req)
> +{
> +	struct nvmet_rsrv *p;
> +	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
> +	u16 status = NVME_SC_SUCCESS;
> +	struct { u64 crkey, nrkey; } keys;
> +
> +	write_lock(&req->ns->rsrv_lock);
> +	status = nvmet_copy_from_sgl(req, 0, &keys, sizeof(keys));
> +	if (status)
> +		goto out;
> +	p = nvmet_find_reservation(req);

> +	switch (cdw10 & 0x7) {

You should add a macro to extract the reservation action
directly from nvme_command.

> +	case 0:	/* Register */

I think that meaningful enumeration is better then comments.

> +		if (p == NULL) {
> +			p = kzalloc(sizeof(*p), GFP_KERNEL);

Allocation under write_lock?

> +
> +static void nvmet_execute_resv_report(struct nvmet_req *req)
> +{
> +	union {
> +		struct {
> +			__le32	gen;
> +			u8	rtype;
> +			__le16	regctls;
> +			u16	rsvd2;
> +			u8	ptpls;
> +			u8	rsvd14[14];
> +		} __packed hdr;
> +		struct {
> +			__le16	cntlid;
> +			u8	rcsts;
> +			u8	rsvd5[5];
> +			__le64	hostid;
> +			__le64	rkey;
> +		} __packed cntrl;

These are generic nvme structures, so they should live in
nvme protocol header.
