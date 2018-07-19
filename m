From: hare@suse.de (Hannes Reinecke)
Date: Thu, 19 Jul 2018 18:00:43 +0200
Subject: [PATCH 4/5] nvme-multipath: disable ANA support if parsing fails
In-Reply-To: <20180719144355.GA20422@lst.de>
References: <20180716105837.101125-1-hare@suse.de>
 <20180716105837.101125-5-hare@suse.de> <20180719144355.GA20422@lst.de>
Message-ID: <fda50728-d90c-2915-0ba3-7f7a3c7cd613@suse.de>

On 07/19/2018 04:43 PM, Christoph Hellwig wrote:
> On Mon, Jul 16, 2018@12:58:36PM +0200, Hannes Reinecke wrote:
>> If we cannot parse the ANA log page we should just disable ANA
>> support altogether, otherwise we fail to connect to the controller
>> and we have no way of figuring out what went wrong.
>> And we should kill the WARN_ON() statements as we now have a valid
>> recovery strategy.
> 
> I don't like this.  There is a lot magic now where we need to
> check if we have a buffer independent of wheter the controller
> supports ANA to start with.
> 
> If we really have a that buggy controller we'll need to quirk it.
> 
Well, I've came across this will testing ANA support on the target.

There are two reasons why I did this:

1. There's this statement in nvme_failover_req():

	if (!WARN_ON_ONCE(!ns->ctrl->ana_log_buf))
		queue_work(nvme_wq, &ns->ctrl->ana_work);

(or a similar statement in nvme_handle_aen_notice())
which really doesn't make sense if we require 'ana_log_buf' to always be 
filled out.
If we require ana_log_buf to always be set we would crash immediately 
afterwards in nvme_read_ana_log() anyway, rendering the WARN_ON quite 
pointless.
So, from my POV, either remove the WARN_ON() (or at least replace it 
with a BUG_ON() to clarify we've messed up) or handle the case where 
ana_log_buf is _NOT_ set. But that involves graceful failure handling 
while parsing ANA log pages.

2. If we come across a target with invalid or incorrect ANA 
implementations we _cannot_ connect at all (as nvme_mpath_init() will 
return an error, causing mpath_init_identify() to fail, too).
Which means we don't have _any_ way of figuring out what went wrong.
So I've opted to handle error gracefully and disabling ANA support for 
those targets (which is perfectly legit methinks), allowing us to 
inspect the log page via nvme-cli and figure out what went wrong.

And in general I thought it was good practice to handle errors gracefully...

Cheers,

Hannes
