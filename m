From: keith.busch@intel.com (Keith Busch)
Date: Wed, 16 Nov 2016 19:35:24 -0500
Subject: [PATCH v1 2/7] lib: Add Sed-opal library
In-Reply-To: <1479338252-8777-3-git-send-email-scott.bauer@intel.com>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
 <1479338252-8777-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20161117003524.GG10050@localhost.localdomain>

On Wed, Nov 16, 2016@04:17:27PM -0700, Scott Bauer wrote:
> +int opal_unlock_from_suspend(struct opal_suspend_unlk *data)
> +{
> +	const char *diskname = data->name;
> +	struct opal_dev *iter, *dev = NULL;
> +	struct opal_completion *completion;
> +	void *func_data[3] = { NULL };
> +
> +	spin_lock(&list_spinlock);
> +	list_for_each_entry(iter, &opal_list, node) {
> +		if (strncmp(iter->disk_name, diskname, DISK_NAME_LEN)) {
> +			pr_err("iterdisk was %s and diskname is %s\n",
> +			       iter->disk_name, diskname);
> +			continue;
> +		}
> +		if (atomic_add_unless(&iter->in_use, 1, 1)) {
> +			dev = iter;
> +			dev->func_data = func_data;
> +			dev->resume_from_suspend = true;
> +			dev->resume_data = data;
> +			dev->final_cb = unlock_suspend_final;
> +			dev->final_cb_data = dev;
> +			dev->error_cb = end_opal_session_error;
> +			dev->error_cb_data = dev;
> +			dev->state = 0;
> +			if (dev->lkul.authority.SUM)
> +				dev->funcs = ulk_funcs_SUM;
> +			else
> +				dev->funcs = _unlock_funcs;
> +			dev->TSN = 0;
> +			dev->HSN = 0;
> +			dev->func_data[2] = &dev->lkul;
> +			dev->func_data[1] = &dev->lkul.authority;
> +			completion = dev->completion;
> +			next(0, dev);
> +			wait_for_cmd_completion(completion);

Waiting while holding a spinlock will get a scheduling error.

> +		}
> +	}
> +	spin_unlock(&list_spinlock);
