From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 23 May 2014 10:55:34 -0400
Subject: [PATCH] NVMe: Remove superfluous cqe_seen
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A9943A7ADC@NTXBOIMBX02.micron.com>
References: <537CED01.6040106@micron.com>
 <20140521231706.GP6121@linux.intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A9943A7ADC@NTXBOIMBX02.micron.com>
Message-ID: <20140523145534.GQ6121@linux.intel.com>

On Thu, May 22, 2014@12:10:19AM +0000, Sam Bradshaw (sbradshaw) wrote:
> Performance problem, though not very easily measured.  At very high iops
> rates, most if not all cqe's are processed via nvme_process_cq() in 
> make_request(), leaving nvme_irq() with no work to do.  Nevertheless, it
> always writes cqe_seen, which invalidates a very hot cacheline.  This
> is somewhat exacerbated when IO submissions originate on a remote node
> relative to the cpu handling the irq.
> 
> Perhaps a simpler patch where cqe_seen is only written if set? 

Sure, we could do that, although in the scenario you're talking about,
cqe_seen would almost always get written.  I think your workload would
perhaps benefit from tuning the interrupt coalescing settings.
