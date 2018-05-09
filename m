From: emilne@redhat.com (Ewan D. Milne)
Date: Wed, 09 May 2018 14:49:40 -0400
Subject: [PATCH 5/5] nvme: ANA base support
In-Reply-To: <20180504112845.38820-6-hare@suse.de>
References: <20180504112845.38820-1-hare@suse.de>
 <20180504112845.38820-6-hare@suse.de>
Message-ID: <1525891780.30724.271.camel@localhost.localdomain>

On Fri, 2018-05-04@13:28 +0200, Hannes Reinecke wrote:
> Add ANA support to the nvme host. If ANA is supported the state
> and the group id are displayed in new sysfs attributes 'ana_state' and
> 'ana_group'.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>  drivers/nvme/host/core.c      | 123 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/multipath.c |  12 ++++-
>  drivers/nvme/host/nvme.h      |   3 ++
>  3 files changed, 136 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
...
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

If nvme_get_log() above returns an error you don't want to use the data
in the ana_log buffer in the following section of code:

> +	for (i = 0; i < ana_log->grpid_num; i++) {
> +		struct nvmf_ana_group_descriptor *desc =
> +			&ana_log->desc[i];
> +		for (j = 0; j < desc->nsid_num; j++) {
> +			if (desc->nsid[j] == ns->head->ns_id) {
> +				ns->ana_state = desc->ana_state;
> +				ns->ana_group = desc->groupid;
> +			}
> +		}
> +	}
> +	kfree(ana_log);
> +}
> +
