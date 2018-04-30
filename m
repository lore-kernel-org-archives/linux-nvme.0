From: keith.busch@linux.intel.com (Keith Busch)
Date: Mon, 30 Apr 2018 13:45:33 -0600
Subject: [PATCH] nvme/pci: Use async_schedule for initial reset work
In-Reply-To: <CACVXFVNXmzMC9N+EabeXs4-XZLCRSOVdpd901wfojBL_s2YFRQ@mail.gmail.com>
References: <20180427211708.5604-1-keith.busch@intel.com>
 <CACVXFVNXmzMC9N+EabeXs4-XZLCRSOVdpd901wfojBL_s2YFRQ@mail.gmail.com>
Message-ID: <20180430194533.GC5938@localhost.localdomain>

On Sat, Apr 28, 2018@05:11:18PM +0800, Ming Lei wrote:
> Looks fine,
> 
> Reviewed-by: Ming Lei <ming.lei at redhat.com>

Thanks, Ming.

Mikulas, would you be able to test this and confirm it works for you?
This appears successful in my testing, but want to hear from the source
if possible.

Thanks,
Keith
