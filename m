From: sbradshaw@micron.com (Sam Bradshaw (sbradshaw))
Date: Tue, 27 May 2014 18:03:08 +0000
Subject: [RFC PATCH] NVMe: Remove IOD scatter-gather list
In-Reply-To: <1401174326-25045-1-git-send-email-keith.busch@intel.com>
References: <1401174326-25045-1-git-send-email-keith.busch@intel.com>
Message-ID: <80B89753B40C5141A3E2D53FE7A2A8A9943C0584@NTXBOIMBX02.micron.com>



> -----Original Message-----
> From: Keith Busch [mailto:keith.busch at intel.com]
> Sent: Tuesday, May 27, 2014 12:05 AM
> To: linux-nvme at lists.infradead.org; willy at linux.intel.com; Sam Bradshaw
> (sbradshaw)
> Cc: Keith Busch
> Subject: [RFC PATCH] NVMe: Remove IOD scatter-gather list
> 
> I've seen a lot of patches recently on the mailing list about improving
> driver side latencies and I want in on the action. :)
> 
> This patch proposes to remove the scatter gather list and create prp
> lists directly from the bio's io vector. This way we don't have to walk
> it twice, and we don't have to allocate prp lists from DMA pools when
> we can point to them inline with the IOD and map them from there.
> 
> I am breaking a few things here, notably REQ_DISCARD and the IOCTL
> passthroughs, but I'm just trying to gauge if this is actually as good
> a win as I hope before spending too much time on it.
> 
> I don't have my normal test machine available to me from my remote
> location right now, so stuck using slower hardware than I normally use
> for these kinds of tests.
> 
> On 4k transfer, I measure submission side latency reduced by ~25ns.
> On 128k transfer, same latency was reduced by ~110ns.
> 
> I've not been able to test at higher transfers than this. I'm not even
> sure if this will not crash a system if we have to chain two prp lists
> since I couldn't test that either. Maybe it will break bio splits too,
> I'm not sure, it's just prototype code right now.
> 
> Would anyone be willing to give this a try on some of their faster h/w?

Hi Keith,

I tested on our hw and don't see any throughput or latency improvements.
However, I'm limited to less than 50% of the hw top end performance due
to some serialization in the io_acct code.  Would you like me to test with
the patch I sent on 5/9 (NVMe: Adhere to request queue block accounting 
enable/disable) and io stats disabled to see if there's an improvement at 
much higher throughput levels?

-Sam
