From: Steve.Schremmer@netapp.com (Schremmer, Steven)
Date: Fri, 4 May 2018 22:11:12 +0000
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <20180504112845.38820-6-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
Message-ID: <SN6PR06MB3984921468FB9721423BD0ED8C860@SN6PR06MB3984.namprd06.prod.outlook.com>

>  int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
>  {
> @@ -1488,6 +1489,9 @@ static int nvme_revalidate_disk(struct gendisk *disk)
>  		goto out;
>  	}
> 
> +	if (ctrl->subsys->cmic & (1 << 3))
> +		nvme_get_ana_log(ctrl, ns);
> +
If __nvme_revalidate_disk() would save the groupid from the Identify Namespace data,
then finding the ANA state in the log page could be done more quickly.

>  	__nvme_revalidate_disk(disk, id);
>  	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
>  	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
> @@ -2276,6 +2280,61 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
>  	return ret;
>  }
> 
> +static void nvme_get_ana_log(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
> +{
> +	int i, j;
> +	struct nvmf_ana_rsp_page_header *ana_log;
> +	size_t ana_log_size = 4096;
> +
> +	ana_log = kzalloc(ana_log_size, GFP_KERNEL);
> +	if (!ana_log)
> +		return;
> +
> +	if (nvme_get_log(ctrl, NVME_LOG_ANA, ana_log, ana_log_size))
> +		dev_warn(ctrl->device,
> +			 "Get ANA log error\n");
> +	for (i = 0; i < ana_log->grpid_num; i++) {
> +		struct nvmf_ana_group_descriptor *desc =
> +			&ana_log->desc[i];
> +		for (j = 0; j < desc->nsid_num; j++) {
> +			if (desc->nsid[j] == ns->head->ns_id) {
> +				ns->ana_state = desc->ana_state;
> +				ns->ana_group = desc->groupid;
Maybe jump out of the for loops here?

> @@ -3370,6 +3485,10 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
>  	case NVME_AER_NOTICE_FW_ACT_STARTING:
>  		queue_work(nvme_wq, &ctrl->fw_act_work);
>  		break;
> +	case NVME_AER_NOTICE_ANA_CHANGE:
> +		dev_info(ctrl->device, "ANA state change\n");
> +		queue_work(nvme_wq, &ctrl->ana_change_work);
> +		break;
I think eventually we'll need a way for the AER work to potentially force a call to
__nvme_find_path() to choose a better current_path based on the updated ANA states.

> @@ -56,8 +56,18 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head)
>  {
>  	struct nvme_ns *ns;
> 
> +	/* First round: select from all ANA optimized paths */
>  	list_for_each_entry_rcu(ns, &head->list, siblings) {
> -		if (ns->ctrl->state == NVME_CTRL_LIVE) {
> +		if (ns->ctrl->state == NVME_CTRL_LIVE &&
> +		    ns->ana_state == NVME_ANA_STATE_OPTIMIZED) {
> +			rcu_assign_pointer(head->current_path, ns);
> +			return ns;
> +		}
> +	}
> +	/* Second round: select from all ANA non-optimized paths */
> +	list_for_each_entry_rcu(ns, &head->list, siblings) {
> +		if (ns->ctrl->state == NVME_CTRL_LIVE &&
> +		    ns->ana_state == NVME_ANA_STATE_NONOPTIMIZED) {
>  			rcu_assign_pointer(head->current_path, ns);
>  			return ns;
>  		}
