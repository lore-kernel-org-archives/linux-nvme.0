From: hare@suse.de (Hannes Reinecke)
Date: Tue, 12 Jun 2018 10:45:44 +0200
Subject: [PATCH 06/10] nvme: add ANA support
In-Reply-To: <20180611141139.30462-7-hch@lst.de>
References: <20180611141139.30462-1-hch@lst.de>
 <20180611141139.30462-7-hch@lst.de>
Message-ID: <20180612104544.4fd45421@pentland.suse.de>

Hi Christoph,

after reviewing your patch (and my comment) I do agree that using a
per-controller timer will work if we are only worried about terminating
the timer eventually. So I retract my issues.

But during testing I found this:

On Mon, 11 Jun 2018 16:11:35 +0200
Christoph Hellwig <hch@lst.de> wrote:
[ .. ]
> +
> +static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
> +		struct nvme_ana_group_desc *desc, void *data)
> +{
> +	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
> +	unsigned *nr_change_groups = data;
> +	struct nvme_ns *ns;
> +
> +	dev_info(ctrl->device, "ANA group %d: %s.\n",
> +			le32_to_cpu(desc->grpid),
> +			nvme_ana_state_names[desc->state]);
> +
> +	if (!nr_nsids)
> +		return 0;
> +
This will cause any 'change' state during runtime never to be evaluated
as we're setting the RGO bit, and consequently 'nnsids' is zero:

[  326.612670] nvme nvme1: ANATT timeout, resetting controller.
[  326.613761] nvme nvme1: Cancel ANATT timer
[  326.637365] nvme nvme1: ANA group 1: optimized.
[  326.637369] nvme nvme1: ANA group 2: change.
[  326.637372] nvme nvme1: ANA group 3: optimized.
[  326.637374] nvme nvme1: Stop ANATT timer
[  326.637938] nvme nvme1: creating 1 I/O queues.

better to use a label here to skip namespace evaluation.

> +	down_write(&ctrl->namespaces_rwsem);
> +	list_for_each_entry(ns, &ctrl->namespaces, list) {
> +		if (ns->head->ns_id != le32_to_cpu(desc->nsids[n]))
> +			continue;
> +		nvme_update_ns_ana_state(desc, ns);
> +		if (++n == nr_nsids)
> +			break;
> +	}
> +	up_write(&ctrl->namespaces_rwsem);
> +	WARN_ON_ONCE(n < nr_nsids);
> +

And jump to here:

> +	if (desc->state == NVME_ANA_CHANGE)
> +		(*nr_change_groups)++;
> +	return 0;
> +}
> +

With that we're tracking 'change' states correctly.

Cheers,

Hannes
