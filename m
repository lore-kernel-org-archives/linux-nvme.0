From: kbusch@kernel.org (Keith Busch)
Date: Wed, 22 May 2019 14:28:05 -0600
Subject: [PATCH 0/2] Reset timeout for paused hardware
In-Reply-To: <721e059e-ed88-734c-fea2-3637e6d31f4c@acm.org>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <721e059e-ed88-734c-fea2-3637e6d31f4c@acm.org>
Message-ID: <20190522202805.GA5781@localhost.localdomain>

On Wed, May 22, 2019@10:20:45PM +0200, Bart Van Assche wrote:
> On 5/22/19 7:48 PM, Keith Busch wrote:
> > Hardware may temporarily stop processing commands that have
> > been dispatched to it while activating new firmware. Some target
> > implementation's paused state time exceeds the default request expiry,
> > so any request dispatched before the driver could quiesce for the
> > hardware's paused state will time out, and handling this may interrupt
> > the firmware activation.
> > 
> > This two-part series provides a way for drivers to reset dispatched
> > requests' timeout deadline, then uses this new mechanism from the nvme
> > driver's fw activation work.
> 
> Hi Keith,
> 
> Is it essential to modify the block layer to implement this behavior
> change? Would it be possible to implement this behavior change by
> modifying the NVMe driver only, e.g. by modifying the nvme_timeout()
> function and by making that function return BLK_EH_RESET_TIMER while new
> firmware is being activated?

Good question.

We can't just do this from nvme_timeout(), though. That introduces races
between timeout_work and fw_act_work if that fw work clears the
condition that timeout needs to observe to return RESET_TIMER.

Even if we avoid that race, the rq->deadline needs to be adjusted to
the current time after the h/w unpause because the time accumulated while
h/w halted itself should not be counted against the request.
