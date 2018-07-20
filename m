From: hch@lst.de (Christoph Hellwig)
Date: Fri, 20 Jul 2018 17:00:27 +0200
Subject: [PATCH 4/5] nvme-multipath: disable ANA support if parsing fails
In-Reply-To: <fda50728-d90c-2915-0ba3-7f7a3c7cd613@suse.de>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-5-hare@suse.de> <20180719144355.GA20422@lst.de>
 <fda50728-d90c-2915-0ba3-7f7a3c7cd613@suse.de>
Message-ID: <20180720150027.GA17110@lst.de>

On Thu, Jul 19, 2018@06:00:43PM +0200, Hannes Reinecke wrote:
> There are two reasons why I did this:
>
> 1. There's this statement in nvme_failover_req():
>
> 	if (!WARN_ON_ONCE(!ns->ctrl->ana_log_buf))
> 		queue_work(nvme_wq, &ns->ctrl->ana_work);
>
> (or a similar statement in nvme_handle_aen_notice())
> which really doesn't make sense if we require 'ana_log_buf' to always be 
> filled out.

We could still have a controller return the ANA status code or
send the AEN if we don't use ANA.  So I guess we do need to remove
the warnings at least.

> If we require ana_log_buf to always be set we would crash immediately 
> afterwards in nvme_read_ana_log() anyway, rendering the WARN_ON quite 
> pointless.

Well, a conditional to skip code and warn when something is not supported
is a lot better than crashing, don't you agree?

> So, from my POV, either remove the WARN_ON() (or at least replace it with a 
> BUG_ON() to clarify we've messed up) or handle the case where ana_log_buf 
> is _NOT_ set. But that involves graceful failure handling while parsing ANA 
> log pages.

As said above we probably should remove the WARN_ON, although these cases
mean we had an issue either in the driver initialization or the data
returned by the controller.

> 2. If we come across a target with invalid or incorrect ANA implementations 
> we _cannot_ connect at all (as nvme_mpath_init() will return an error, 
> causing mpath_init_identify() to fail, too).

Which seems pretty sensible.  Without that people might just keep using
the setup in this form (note that a driver bug is another possibility,
it's not always the controllers that are broken :))

> And in general I thought it was good practice to handle errors gracefully...

And I fail to see where we handle errors much more gracefully here,
the only difference seems to be that we entirely ignore ANA errors.
