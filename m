From: keith.busch@intel.com (Keith Busch)
Date: Fri, 15 May 2015 21:59:48 +0000 (UTC)
Subject: [PATCH] NVMe: Automatic namespace rescan
In-Reply-To: <alpine.LNX.2.00.1505151440220.15930@localhost.lm.intel.com>
References: <1431633707-9265-1-git-send-email-keith.busch@intel.com>
 <20150515143746.GA2729@linux.intel.com>
 <alpine.LNX.2.00.1505151440220.15930@localhost.lm.intel.com>
Message-ID: <alpine.LNX.2.00.1505152152180.15930@localhost.lm.intel.com>

On Fri, 15 May 2015, Keith Busch wrote:
> On Fri, 15 May 2015, Matthew Wilcox wrote:
>> Pondering if it's worth keeping the list sorted so we can break out early
>> if the namespace isn't in the list?
>
> The list is actually already sorted since this doesn't allow gaps in
> NSIDs. If a namespace is not attached, the driver creates a 0 capacity
> block device for it and appends it to the list, so it's always in
> ascending order.
>
> Is this a bad idea? Let's say a controller supports 128 namespaces,
> but only NSID 128 is attached, we'd see 127 zero capacity /dev/nvme#n#
> block devs.

Decided we don't want a bunch of zero capacity drives if there are gaps
in attached NSIDs. There could be millions after all. But it's not so
simple since the nvmeq's hctx points to hctx from a single namespace's
request_queue, and that's not right. I'll take a stab at decoupling that
next week. In the mean time, this patch is dead.
