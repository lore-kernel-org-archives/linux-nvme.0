From: hare@suse.de (Hannes Reinecke)
Date: Thu, 7 Jun 2018 14:42:49 +0200
Subject: [PATCH 1/4] nvmet: make ANATT configurable
In-Reply-To: <20180607120612.GA11938@lst.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-2-hare@suse.de>
 <20180607120612.GA11938@lst.de>
Message-ID: <20180607144249.0401c466@pentland.suse.de>

On Thu, 7 Jun 2018 14:06:12 +0200
Christoph Hellwig <hch@lst.de> wrote:

> Needs a description.  Especially to explain why you want it
> per-port.  In the end the transition timeout is something determined
> by the failover backend, which in no way maps to a port.  In fact
> it doesn't map to anything, which is why I would suggest to just
> make it global.  This still won't cover the case of using different
> backed storage types with different failover characteristics, but
> at least it ?sn't too confusing.
> 
Well, I just moved it to the position where the state change actually
happend, and figured it'll give us the most flexibility.

> > +	ret = kstrtou8(page, 0, &ana_tt);
> > +	if (ret || ana_tt == 0)
> > +		return -EINVAL;  
> 
> Please propagate the actual error returned by kstrtou8.
> 
Okay.

> > +
> > +	if (port->enabled) {
> > +		pr_err("Cannot modify ANA transition timeout while
> > enabled\n");
> > +		return -EACCES;
> > +	}
> > +	down_write(&nvmet_config_sem);
> > +	port->anatt = ana_tt;
> > +	up_write(&nvmet_config_sem);  
> 
> The enabled check needs to be under nvmet_config_sem to be race free.
> 

Okay, will be doing so.

Cheers,

Hannes
