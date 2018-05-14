From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Mon, 14 May 2018 15:34:42 +0200
Subject: [PATCH] nvme: fix lockdep warning in nvme_mpath_clear_current_path
In-Reply-To: <20180514133105.GU26088@linux.vnet.ibm.com>
References: <20180514121312.13624-1-jthumshirn@suse.de>
 <20180514124230.GA654@infradead.org>
 <20180514133105.GU26088@linux.vnet.ibm.com>
Message-ID: <20180514133442.dyvveuxkaeithb4r@linux-x5ow.site>

On Mon, May 14, 2018@06:31:05AM -0700, Paul E. McKenney wrote:
> If you are just looking at the value of an RCU-protected pointer, then
> using rcu_access_pointer() will cause RCU to just read out the value
> and otherwise keeps its mouth shut.
> 
> If you use rcu_access_pointer() and later dereference the value without
> protection, you will of course get what you deserve, good and hard.  ;-)

Thanks Paul.

Christoph, I'll be sending the v2 probably tomorrow as I have more
lockdep fixes for nvme in the pipe and I'll send them out as a
complete series.

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
