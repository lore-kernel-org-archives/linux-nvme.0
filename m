From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 14:06:12 +0200
Subject: [PATCH 1/4] nvmet: make ANATT configurable
In-Reply-To: <20180607073556.39050-2-hare@suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-2-hare@suse.de>
Message-ID: <20180607120612.GA11938@lst.de>

Needs a description.  Especially to explain why you want it
per-port.  In the end the transition timeout is something determined
by the failover backend, which in no way maps to a port.  In fact
it doesn't map to anything, which is why I would suggest to just
make it global.  This still won't cover the case of using different
backed storage types with different failover characteristics, but
at least it ?sn't too confusing.

> +	ret = kstrtou8(page, 0, &ana_tt);
> +	if (ret || ana_tt == 0)
> +		return -EINVAL;

Please propagate the actual error returned by kstrtou8.

> +
> +	if (port->enabled) {
> +		pr_err("Cannot modify ANA transition timeout while enabled\n");
> +		return -EACCES;
> +	}
> +	down_write(&nvmet_config_sem);
> +	port->anatt = ana_tt;
> +	up_write(&nvmet_config_sem);

The enabled check needs to be under nvmet_config_sem to be race free.
