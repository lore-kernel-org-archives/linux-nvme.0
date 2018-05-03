From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 3 May 2018 14:15:08 -0600
Subject: [PATCH] nvme/pci: Use async_schedule for initial reset work
In-Reply-To: <alpine.LRH.2.02.1805021717430.2705@file01.intranet.prod.int.rdu2.redhat.com>
References: <20180427211708.5604-1-keith.busch@intel.com>
 <CACVXFVNXmzMC9N+EabeXs4-XZLCRSOVdpd901wfojBL_s2YFRQ@mail.gmail.com>
 <20180430194533.GC5938@localhost.localdomain>
 <alpine.LRH.2.02.1805011928470.17838@file01.intranet.prod.int.rdu2.redhat.com>
 <20180502152953.GH5938@localhost.localdomain>
 <alpine.LRH.2.02.1805021717430.2705@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180503201507.GO5938@localhost.localdomain>

On Thu, May 03, 2018@10:55:09AM -0400, Mikulas Patocka wrote:
> I think there is still one more bug:
> 
> If nvme_probe is called, it schedules the asynchronous work using 
> async_schedule - now suppose that the pci system calls the "remove", 
> "shutdown" or "suspend" method - this method will race with 
> nvme_async_probe running in the async domain - that will cause 
> misbehavior.
> 
> Or - does the PCI subsystem flush the async queues before calling these 
> methods? I'm not sure, but it doesn't seem so.
> 
> I think, you need to save the cookie returned by async_schedule and wait 
> for this cookie with async_synchronize_cookie in the other methods.

I think we're fine as-is without syncing the cookie. 

The remove path should be fine since we already sync with the necessary
work queues.

The shutdown, suspend and reset paths will just cause the initial reset
work to end early, the same result as what previously would happen.
