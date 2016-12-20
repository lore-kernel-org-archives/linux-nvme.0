From: viro@ZenIV.linux.org.uk (Al Viro)
Date: Tue, 20 Dec 2016 06:50:13 +0000
Subject: [PATCH v3 2/5] lib: Add Sed-opal library
In-Reply-To: <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
References: <1482176149-2257-1-git-send-email-scott.bauer@intel.com>
 <1482176149-2257-3-git-send-email-scott.bauer@intel.com>
Message-ID: <20161220065013.GC1555@ZenIV.linux.org.uk>

On Mon, Dec 19, 2016@12:35:46PM -0700, Scott Bauer wrote:

> +int fdev_sed_ioctl(struct file *filep, unsigned int cmd,
> +		   unsigned long arg)
> +{
> +	struct sed_key key;
> +	struct sed_context *sed_ctx;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EACCES;
> +
> +	if (!filep->f_sedctx || !filep->f_sedctx->ops || !filep->f_sedctx->dev)
> +		return -ENODEV;
> +
> +	sed_ctx = filep->f_sedctx;

First of all, that's a bisect hazard.  What's more, looking through the
rest of patchset, WTF does it
	* need to be called that early in ioctl(2) handling, instead of
having ->ioctl() instance for that sucker calling it?
	* _not_ get your ->f_sedctx as an explicit argument, passed by
the caller in ->ioctl(), seeing that it's possible to calculate by
file->private_data?
	* store that thing in struct file itself, bloating it for everything
all for the sake of few drivers that might want to use that helper?
