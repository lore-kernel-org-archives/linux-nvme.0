From: hch@lst.de (Christoph Hellwig)
Date: Thu, 23 May 2019 16:07:12 +0200
Subject: [PATCH 2/2] nvme: reset request timeouts during fw activation
In-Reply-To: <20190523133428.GC14049@localhost.localdomain>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190522174812.5597-3-keith.busch@intel.com>
 <20190523101953.GA18805@ming.t460p>
 <20190523133428.GC14049@localhost.localdomain>
Message-ID: <20190523140712.GA19598@lst.de>

On Thu, May 23, 2019@07:34:29AM -0600, Keith Busch wrote:
> Doh! Didn't hit that in testing, but point taken.
>  
> > Also reset still may come during activating FW, is that a problem?
> 
> IO timeout and user initiated resets should be avoided. A state machine
> addition may be useful here.

Yep.  It almost sounds like we'd want a PAUSED state where resets just
keep returning RESET_TIMER without any other action.
