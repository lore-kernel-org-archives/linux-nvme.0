From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Mar 2018 10:53:58 -0600
Subject: [GIT PULL] nvme fix for 4.16-rc6
In-Reply-To: <8734416c-cd14-8bfb-8e2c-6eab84e0ce5d@kernel.dk>
References: <20180316160110.GC720@localhost.localdomain>
 <e58b5357-6885-75dc-c027-9bea3cd6829d@kernel.dk>
 <20180316161655.GA13293@lst.de>
 <8734416c-cd14-8bfb-8e2c-6eab84e0ce5d@kernel.dk>
Message-ID: <20180316165357.GD720@localhost.localdomain>

On Fri, Mar 16, 2018@09:26:24AM -0700, Jens Axboe wrote:
> 
> It's not that I dislike the patch (in fact it makes the code
> easier to read), but it's pretty late for something that isn't
> a regression in this series. I can queue it up for some testing,
> but it's then -rc7 time. I guess we can see how it goes and
> push the decision until start next week.

I understand the concern on the timing. If you can queue this
for additional testing and make a final call, that would be much
appreciated. We can copy to stable during 4.17 if you consider this too
risky for 4.16.

FWIW, this patch tests well here and even correctly aligns to Intel's
intended usage, but I'm limited to a single vendor.
