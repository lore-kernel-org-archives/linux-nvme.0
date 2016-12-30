From: jonathan.derrick@intel.com (Jon Derrick)
Date: Fri, 30 Dec 2016 14:02:56 -0700
Subject: [PATCH v4 2/6] block: Add Sed-opal library
In-Reply-To: <1483039615-22407-3-git-send-email-scott.bauer@intel.com>
References: <1483039615-22407-1-git-send-email-scott.bauer@intel.com>
 <1483039615-22407-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20161230210255.GA4148@localhost.localdomain>

Hi Scott,

I haven't had much time with this yet, but..

[snip]
> +static int do_cmds(struct opal_dev *dev)
> +{
> +	int ret;
> +	ret = next(dev);
> +	mutex_unlock(&dev->dev_lock);
> +	return ret;
> +}
> +
> +static struct opal_dev *get_opal_dev(struct sed_context *sedc,
> +				     const opal_step *funcs)
> +{
> +	struct opal_dev *dev = sedc->dev;
> +	if (dev) {
> +		mutex_lock(&dev->dev_lock);
> +		dev->state = 0;
> +		dev->funcs = funcs;
> +		dev->tsn = 0;
> +		dev->hsn = 0;
> +		dev->error_cb = end_opal_session_error;
> +		dev->error_cb_data = dev;
> +		dev->func_data = NULL;
> +		dev->prev_data = NULL;
> +		dev->sed_ctx = sedc;
> +		dev->save_discovery = false;
> +	}
> +	return dev;
> +}
> +
> 

It's a bit nontraditional to lock and unlock in different functions, but
I see why you're doing it this way.

Can we move the mutex locking/unlocking to the callers of these
functions, such that they are both in the same function; then we can use
lockdep_assert_held(..) on the in-between?

Cheers
