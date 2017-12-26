From: keith.busch@intel.com (Keith Busch)
Date: Tue, 26 Dec 2017 13:51:10 -0700
Subject: [for-4.16 PATCH 0/5] block, nvme, dm: allow DM multipath to use
 NVMe's error handler
In-Reply-To: <20171219210546.65928-1-snitzer@redhat.com>
References: <20171219210546.65928-1-snitzer@redhat.com>
Message-ID: <20171226205109.GB13188@localhost.localdomain>

On Tue, Dec 19, 2017@04:05:41PM -0500, Mike Snitzer wrote:
> These patches enable DM multipath to work well on NVMe over Fabrics
> devices.  Currently that implies CONFIG_NVME_MULTIPATH is _not_ set.
> 
> But follow-on work will be to make it so that native NVMe multipath
> and DM multipath can be made to co-exist (e.g. blacklisting certain
> NVMe devices from being consumed by native NVMe multipath?)

Hi Mike,

I've reviewed the series and I support with the goal. I'm not a big fan,
though, of having yet-another-field to set in bio and req on each IO.

Unless I'm missing something, I think we can make this simpler if you add
the new 'failover_req_fn' as an attribute of the struct request_queue
instead of threading it through bio and request. Native nvme multipath
can set the field directly in the nvme driver, and dm-mpath can set it
in each path when not using the nvme mpath. What do you think?
