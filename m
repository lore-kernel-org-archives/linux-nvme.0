From: ming.lei@redhat.com (Ming Lei)
Date: Thu, 23 May 2019 11:29:26 +0800
Subject: [PATCH 0/2] Reset timeout for paused hardware
In-Reply-To: <20190522174812.5597-1-keith.busch@intel.com>
References: <20190522174812.5597-1-keith.busch@intel.com>
Message-ID: <20190523032925.GA10601@ming.t460p>

On Wed, May 22, 2019@11:48:10AM -0600, Keith Busch wrote:
> Hardware may temporarily stop processing commands that have
> been dispatched to it while activating new firmware. Some target
> implementation's paused state time exceeds the default request expiry,
> so any request dispatched before the driver could quiesce for the
> hardware's paused state will time out, and handling this may interrupt
> the firmware activation.
> 
> This two-part series provides a way for drivers to reset dispatched
> requests' timeout deadline, then uses this new mechanism from the nvme
> driver's fw activation work.

Just wondering why not freeze IO queues before updating FW?


Thanks,
Ming
