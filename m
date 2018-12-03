From: keith.busch@intel.com (Keith Busch)
Date: Mon, 3 Dec 2018 11:22:29 -0700
Subject: [PATCH 10/13] nvme-mpath: remove I/O polling support
In-Reply-To: <20181202164628.1116-11-hch@lst.de>
References: <20181202164628.1116-1-hch@lst.de>
 <20181202164628.1116-11-hch@lst.de>
Message-ID: <20181203182229.GG14775@localhost.localdomain>

On Sun, Dec 02, 2018@08:46:25AM -0800, Christoph Hellwig wrote:
> The ->poll_fn has been stale for a while, as a lot of places check for mq
> ops.  But there is no real point in it anyway, as we don't even use
> the multipath code for subsystems without multiple ports, which is usually
> what we do high performance I/O to.  If it really becomes an issue we
> should rework the nvme code to also skip the multipath code for any
> private namespace, even if that could mean some trouble when rescanning.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>

This was a bit flawed anyway since the head's current path could change,
and you end up polling the wrong request_queue. Not really harmful other
than some wasted CPU cycles, but might be worth thinking about if we
want to bring mpath polling back.

Reviewed-by: Keith Busch <keith.busch at intel.com>
