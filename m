From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 19 Jun 2017 13:12:54 +0300
Subject: [PATCH 6/6] nvme: track shared namespaces in a siblings list
In-Reply-To: <20170619095754.4602-7-hch@lst.de>
References: <20170619095754.4602-1-hch@lst.de>
 <20170619095754.4602-7-hch@lst.de>
Message-ID: <b42db191-1298-c879-a1de-1e39724edc9c@grimberg.me>



On 19/06/17 12:57, Christoph Hellwig wrote:
> Verify that our IDs match for shared namespaces in a subystem, and link
> them up in a headless queue so that we can find siblings easily.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/core.c | 99 ++++++++++++++++++++++++++++++++++++++++++++++++
>   drivers/nvme/host/nvme.h |  1 +
>   2 files changed, 100 insertions(+)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index d88cd6a4a549..8a44d68a3f98 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -2261,6 +2261,100 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
>   	return ret;
>   }
>   
> +/*
> + * Check if the two nvme_ns structures refer to the same namespace.
> + *
> + * Returns 1 if they refer to the same namespace, 0 if not, or a negative
> + * errno value on error.
> + */
> +static int nvme_ns_compare_ids(struct nvme_ns *ns, struct nvme_id_ns *id,
> +		struct nvme_ns *cur)
> +{
> +	bool is_shared = id->nmic & (1 << 0);
> +	bool have_id = false;
> +
> +	if (!uuid_is_null(&ns->uuid)) {
> +		have_id = true;
> +		if (!uuid_equal(&ns->uuid, &cur->uuid))
> +			return 0;
> +	}
> +	if (memchr_inv(ns->nguid, 0, sizeof(ns->nguid))) {
> +		have_id = true;
> +		if (memcmp(&ns->nguid, &cur->nguid, sizeof(ns->nguid)))
> +			return 0;
> +	}
> +	if (memchr_inv(ns->eui, 0, sizeof(ns->eui))) {
> +		have_id = true;
> +		if (memcmp(&ns->eui, &cur->eui, sizeof(ns->eui)))
> +			return 0;
> +	}
> +
> +	/*
> +	 * Note that the unique identifiers are only a "should" condition in
> +	 * the specification.  But we require them for multipath operations
> +	 * due to safety concerns.
> +	 */
> +	if (!have_id && is_shared) {
> +		dev_err(ns->ctrl->device,
> +			"shared namespace %u without unique ID.\n",
> +			ns->ns_id);
> +		return -EINVAL;
> +	}
> +
> +	if (have_id && !is_shared) {
> +		dev_err(ns->ctrl->device,
> +			"private namespace %u with duplicate ID.\n",
> +			ns->ns_id);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * As of NVMe 1.3 (Section 6.1) this is only strictly required if namespace
> +	 * management is supported, but sort of implied for shared namespaces
> +	 * by omitting the defintion.  We'll need an ECN for this language
> +	 * eventually.
> +	 */
> +	if (is_shared && ns->ns_id != cur->ns_id) {
> +		dev_err(ns->ctrl->device,
> +			"non-matching nsids (%u vs %u) for shared namespaces\n",
> +			ns->ns_id, cur->ns_id);
> +		return -EINVAL;
> +	}
> +
> +	return 1;
> +}
> +
> +static int nvme_ns_find_siblings(struct nvme_ns *ns, struct nvme_id_ns *id)
> +{
> +	struct nvme_subsystem *subsys = ns->ctrl->subsys;
> +	struct nvme_ctrl *ctrl;
> +	struct nvme_ns *cur;
> +	int err = 0, ret;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
> +		if (ctrl == ns->ctrl)
> +			continue;
> +
> +		mutex_lock(&ctrl->namespaces_mutex);
> +		list_for_each_entry(cur, &ctrl->namespaces, list) {
> +			ret = nvme_ns_compare_ids(ns, id, cur);
> +			if (ret < 0) {
> +				err = ret;
> +				break;
> +			}
> +			if (ret > 0)

			} else if (ret > 0) {
				list_add(&ns->siblings, &cur->siblings);
			}

> +				list_add(&ns->siblings, &cur->siblings);
> +		}
> +		mutex_unlock(&ctrl->namespaces_mutex);
> +
> +		if (err)
> +			break;
> +	}
> +	mutex_unlock(&subsys->lock);
> +	return err;
> +}
> +

General question, Would it make sense to invoke this search from the
block layer as part of adding a new disk (a new block_device operation)?
And should the sibling association maybe move up to struct block_device?
(we could cache nvme_id_ns in nvme_ns for that to happen)?
