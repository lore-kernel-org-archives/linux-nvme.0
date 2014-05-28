From: keith.busch@intel.com (Keith Busch)
Date: Tue, 27 May 2014 18:17:28 -0600 (MDT)
Subject: [RFC PATCH] NVMe: Remove IOD scatter-gather list
In-Reply-To: <80B89753B40C5141A3E2D53FE7A2A8A9943C0584@NTXBOIMBX02.micron.com>
References: <1401174326-25045-1-git-send-email-keith.busch@intel.com>
 <80B89753B40C5141A3E2D53FE7A2A8A9943C0584@NTXBOIMBX02.micron.com>
Message-ID: <alpine.LRH.2.03.1405271805000.4700@AMR>

On Tue, 27 May 2014, Sam Bradshaw (sbradshaw) wrote:
> Hi Keith,
>
> I tested on our hw and don't see any throughput or latency improvements.
> However, I'm limited to less than 50% of the hw top end performance due
> to some serialization in the io_acct code.  Would you like me to test with
> the patch I sent on 5/9 (NVMe: Adhere to request queue block accounting
> enable/disable) and io stats disabled to see if there's an improvement at
> much higher throughput levels?

Darn, maybe it doesn't make a difference overall. I only put tracing
in the driver's make_request_fn to measure the difference in driver's
submission side.
