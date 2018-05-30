From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Wed, 30 May 2018 10:33:49 -0700
Subject: [PATCH 06/12] nvmet: implement the changed namespaces log
In-Reply-To: <20180530164600.26856-7-hch@lst.de>
References: <20180530164600.26856-1-hch@lst.de>
 <20180530164600.26856-7-hch@lst.de>
Message-ID: <0c4cc53d-1c28-0bf5-d454-df6c9ef9335b@intel.com>

On 05/30/2018 09:45 AM, Christoph Hellwig wrote:
> Just keep a per-controller buffer of changed namespaces and copy it out
> in the get log page implementation.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
[...]
> +static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
> +{
> +	mutex_lock(&ctrl->lock);
> +	if (ctrl->nr_changed_ns < NVME_MAX_CHANGED_NAMESPACES) {

Minor nitpick here: if ctrlr->nr_changed_ns is exactly
NVME_MAX_CHANGED_NAMESPACES and the new nsid is already in the list,
this will skip down to the 0xffffffff case below, even though it could
have just left the list as-is.

I don't know if this is a problem in practice; reporting 0xffffffff is
probably always safe, since the host will presumably treat that as
"rescan everything".

> +		u32 i;
> +
> +		for (i = 0; i < ctrl->nr_changed_ns; i++)
> +			if (ctrl->changed_ns_list[i] == nsid)
> +				goto out_unlock;
> +		ctrl->changed_ns_list[ctrl->nr_changed_ns++] = nsid;
> +	} else if (ctrl->nr_changed_ns == NVME_MAX_CHANGED_NAMESPACES) {
> +		ctrl->changed_ns_list[0] = cpu_to_le32(0xffffffff);
> +		ctrl->nr_changed_ns = U32_MAX;
> +	}
> +out_unlock:
> +	mutex_unlock(&ctrl->lock);
> +}

Thanks,
-- Daniel
