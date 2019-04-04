From: hch@lst.de (Christoph Hellwig)
Date: Thu, 4 Apr 2019 07:26:16 +0200
Subject: [PATCH 2/2] nvme: validate cntlid during controller initialisation
In-Reply-To: <20190403224158.58106-3-hare@suse.de>
References: <20190403224158.58106-1-hare@suse.de>
 <20190403224158.58106-3-hare@suse.de>
Message-ID: <20190404052616.GA7497@lst.de>

> +	ret = 0;
> +	mutex_lock(&ctrl->subsys->lock);
> +	list_for_each_entry(tmp, &ctrl->subsys->ctrls, subsys_entry) {
> +		if (tmp->cntlid == ctrl->cntlid) {
> +			dev_err(ctrl->device, "Duplicate cntlid %u, rejecting\n",
> +				ctrl->cntlid);
> +			ret = -EINVAL;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&ctrl->subsys->lock);

Please split the validation loop ino a separate helper.  Also I think
the check should go into nvme_init_subsystem, under the same critical
section as actualy adding the controller to the controller list to
avoid a small race window.
