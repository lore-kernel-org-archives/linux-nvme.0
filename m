From: daniel.verkamp@intel.com (Verkamp, Daniel)
Date: Tue, 29 May 2018 16:59:05 +0000
Subject: [PATCH 08/14] nvmet: implement the changed namespaces log
In-Reply-To: <20180526102735.31404-9-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
 <20180526102735.31404-9-hch@lst.de>
Message-ID: <A5F28D4A728A7E41839CDC5C3B5A01E8B74D2527@FMSMSX103.amr.corp.intel.com>

 [...]

> +static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, u32 nsid)
> +{
> +	mutex_lock(&ctrl->lock);
> +	if (ctrl->nr_changed_ns < NVME_MAX_CHANGED_NAMESPACES) {
> +		ctrl->changed_ns_list[ctrl->nr_changed_ns++] =
> +			cpu_to_le32(nsid);
> +	} else if (ctrl->nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES) {
> +		ctrl->changed_ns_list[0] = cpu_to_le32(0xffffffff);
> +	}

Unless I'm missing it happening somewhere else, the list-full case that sets element 0 to 0xffffffff should also explicitly zero out the rest of the list to satisfy the "remainder of the list shall be zero-filled" wording in the spec, since the other changed_ns_list entries will be filled with non-zero NSIDs when we get here.

-- Daniel
