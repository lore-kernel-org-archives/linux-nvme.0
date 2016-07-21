From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 21 Jul 2016 09:36:49 -0700
Subject: [PATCH] nvme: initialize variable before logical OR'ing it
In-Reply-To: <df46db7b-557c-5662-8d0a-22a691f54a0c@kernel.dk>
References: <1464882685-4531-1-git-send-email-james.p.freyensee@intel.com>
 <1468956683.21104.2.camel@linux.intel.com>
 <df46db7b-557c-5662-8d0a-22a691f54a0c@kernel.dk>
Message-ID: <1469119009.18464.6.camel@linux.intel.com>

On Wed, 2016-07-20@21:27 -0600, Jens Axboe wrote:
> 
> On 07/19/2016 01:31 PM, J Freyensee wrote:
> > On Thu, 2016-06-02@08:51 -0700, Jay Freyensee wrote:
> > 
> > Jens,
> > 
> > I believe this patch fix got missed?  Or is there a problem with
> > this
> > patch?
> 
> No problem, just got missed. Added, thanks.

Thanks Jens!

> 
