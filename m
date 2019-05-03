From: hch@lst.de (Christoph Hellwig)
Date: Fri, 3 May 2019 14:30:12 +0200
Subject: [PATCHv2 2/2] nvme: validate cntlid during controller
 initialisation
In-Reply-To: <20190503122642.59317-3-hare@suse.de>
References: <20190503122642.59317-1-hare@suse.de>
 <20190503122642.59317-3-hare@suse.de>
Message-ID: <20190503123012.GA21807@lst.de>

On Fri, May 03, 2019@02:26:42PM +0200, Hannes Reinecke wrote:
> +static bool nvme_duplicate_cntlid(struct nvme_subsystem *subsys,
> +				  struct nvme_ctrl *ctrl)
> +{
> +	struct nvme_ctrl *tmp;
> +	bool ret = false;
> +
> +	mutex_lock(&subsys->lock);
> +	list_for_each_entry(tmp, &subsys->ctrls, subsys_entry) {
> +		if (tmp == ctrl)
> +			continue;
> +		if (tmp->cntlid == ctrl->cntlid) {
> +			ret = true;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&subsys->lock);
> +	return ret;
> +}

We'll need to do the duplicate check under the same subsys->lock
critical section as adding the controller to the list, otherwise it
will be racy.
