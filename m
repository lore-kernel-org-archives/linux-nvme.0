From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Sep 2015 17:39:47 +0000 (UTC)
Subject: [PATCH 04/10] blk-mq: kill undead requests during CPU hotplug
 notify
In-Reply-To: <1443380518-6829-5-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
 <1443380518-6829-5-git-send-email-hch@lst.de>
Message-ID: <alpine.LNX.2.00.1509281709460.23840@localhost.lm.intel.com>

On Sun, 27 Sep 2015, Christoph Hellwig wrote:
> REQ_NO_TIMEOUT requests can linger out basically forever, so we need
> to kill them before waiting for all requests to complete in the
> hotplug CPU notification.  Note that we really should be doing an
> abort here, but that will require much more invasive changes to allow
> certain preemptable requests to be started while the queue has already
> been frozen.  As this new code isn't any worse than the early request
> freeing done currently by the nvme driver I'd like to get it in for now
> and sort the full hornet's nest later.

The command is still owned by the device and breaks if the controller
happens to complete the command after a cpu hot event. This was 'ok'
when the driver provided special completion handling.

We'd have to reset the controller to reliably recover the command,
but that's a bit heavy handed.
