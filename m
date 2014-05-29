From: keith.busch@intel.com (Keith Busch)
Date: Thu, 29 May 2014 00:40:25 -0600 (MDT)
Subject: [PATCH] NVMe: Add support to receive NVMe asynchronous events
In-Reply-To: <53864890.5070609@micron.com>
References: <53839E67.1010006@micron.com>
 <20140526235156.GS6121@linux.intel.com>
 <alpine.LRH.2.03.1405261834070.4700@AMR> <53864890.5070609@micron.com>
Message-ID: <alpine.LRH.2.03.1405290035130.4995@AMR>

On Wed, 28 May 2014, Winson Yung (wyung) wrote:
> I had a look of the patch, it looks it does what I was trying to enable, 
> except it misses the portion that enables it by calling set feature cmd. Is 
> it something we can consider now? Also, for these critical warnings that 
> exposed by the async events, can we also put them in the kernel log as well 
> when they enabled?

I thought we agreed it's best to let the user space do the set features
so it gets to decide what events it wants to see.

I don't have a strong opinion on how to present events to the user. Maybe
just print them to the kernel log and be done with it.
