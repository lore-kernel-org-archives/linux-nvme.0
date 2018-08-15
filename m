From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 15 Aug 2018 15:21:44 -0600
Subject: [PATCH V4 1/9] nvme-core: add new interfaces to access nvme-ctrl
In-Reply-To: <20180815195854.15449-2-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
 <20180815195854.15449-2-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815212144.GA5299@localhost.localdomain>

On Wed, Aug 15, 2018@03:58:46PM -0400, Chaitanya Kulkarni wrote:
> +int nvme_get_ctrl_by_path(char *path, struct nvme_ctrl **ctrl)
> +{
> +	int ret = -ENODEV;
> +	char *cdev = strrchr(path, '/');
> +	struct nvme_ctrl *ictrl = NULL;
> +	struct nvme_subsystem *isubsys = NULL;
> +
> +	if (!cdev) {
> +		*ctrl = NULL;
> +		return ret;
> +	}
> +	cdev++;
> +
> +	mutex_lock(&nvme_subsystems_lock);
> +	list_for_each_entry(isubsys, &nvme_subsystems, entry) {
> +		if (!nvme_get_subsystem(isubsys)) {
> +			pr_info("failed to get the subsystem for ctrl %s\n",
> +					path);
> +			goto out;
> +		}
> +		mutex_unlock(&nvme_subsystems_lock);
> +
> +		list_for_each_entry(ictrl, &isubsys->ctrls, subsys_entry) {
> +			spin_lock(&ictrl->lock);
> +			nvme_get_ctrl(ictrl);
> +			if (strcmp(cdev, kobject_name(&ictrl->device->kobj))
> +					== 0) {
> +				*ctrl = ictrl;
> +				if (try_module_get(ictrl->ops->module)) {
> +					spin_unlock(&ictrl->lock);
> +					mutex_lock(&nvme_subsystems_lock);
> +					ret = 0;
> +					goto out;
> +				}
> +			}
> +			nvme_put_ctrl(ictrl);
> +			spin_unlock(&ictrl->lock);
> +		}
> +		mutex_lock(&nvme_subsystems_lock);
> +		nvme_put_subsystem(isubsys);
> +	}
> +out:
> +	mutex_unlock(&nvme_subsystems_lock);
> +	return ret;
> +}

Some difficult to follow locking and reference counting here.

The 'nvme_get_subsystem' is a kref_get_unless_zero, so if the subsystem
happens to be at the final 'put' during this iteration, why bail out
instead of going to the next subsystem? Seems like a 'continue' is the
right thing to do there.

The end part of the loop is even more confusing. If the nvme_put_subsystem
happens to be the final 'put', it will deadlock because the
nvme_destroy_subsystem will want to take the same lock you're already
holding. It looks like getting rid of the reference counting on the
subsystem, and hold nvme_subsystems_lock for the entire loop gets the
desired result.

And while iterating the inner loop subsys_entry, it looks like you
need to hold isubsys->lock. And if you're holding that lock, you won't
need a reference on nvme_ctrl until you find the controller you're
searching for.

Finally I cant even tell why ictrl->lock is being taken. That will only
prevent a state transition, which doesn't seem to matter here.
