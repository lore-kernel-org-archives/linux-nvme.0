From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 28 Jun 2019 00:16:34 -0700
Subject: [PATCH] nvme-fc: fix module unloads while lports still pending
In-Reply-To: <20190625160604.3905-1-jsmart2021@gmail.com>
References: <20190625160604.3905-1-jsmart2021@gmail.com>
Message-ID: <20190628071634.GA16108@infradead.org>

On Tue, Jun 25, 2019@09:06:04AM -0700, James Smart wrote:
> Current code allows the module to be unloaded even if there are
> pending data structures, such as localports and controllers on
> the localports, that have yet to hit their reference counting
> to remove them.
> 
> Fix by taking a reference out on the module upon the first localport
> registered, and which is cleared when the last localport is removed.

This looks broken.  Module unload needs to take everything down
properly, and if needed wait on reference counts to be dropped.  We
don't do that by incrementing the refcount in the module, as that
actually prevents removals.

> +	if (list_empty(&nvme_fc_lport_list) && !try_module_get(THIS_MODULE)) {
> +		spin_unlock_irqrestore(&nvme_fc_lock, flags);
> +		ret = -ENODEV;
> +		goto out_dev_put;
> +	}

And try_module_get(THIS_MODULE) is a classic anti-pattern.  If you know
you already have a reference you must use __module_get().  If you don't
know if there is another held reference using try_module_get on
THIS_MODULE also is unsafe - there is a reason why we always call it
from another module, usually on a struct module in an ops vector.
