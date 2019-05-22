From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 22 May 2019 22:20:45 +0200
Subject: [PATCH 0/2] Reset timeout for paused hardware
In-Reply-To: <20190522174812.5597-1-keith.busch@intel.com>
References: <20190522174812.5597-1-keith.busch@intel.com>
Message-ID: <721e059e-ed88-734c-fea2-3637e6d31f4c@acm.org>

On 5/22/19 7:48 PM, Keith Busch wrote:
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

Hi Keith,

Is it essential to modify the block layer to implement this behavior
change? Would it be possible to implement this behavior change by
modifying the NVMe driver only, e.g. by modifying the nvme_timeout()
function and by making that function return BLK_EH_RESET_TIMER while new
firmware is being activated?

Thanks,

Bart.
