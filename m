From: wyung@micron.com (Winson Yung (wyung))
Date: Tue, 20 May 2014 14:57:04 +0000
Subject: [RFC PATCH] NVMe: Runtime suspend
In-Reply-To: <20140519093501.GI6121@linux.intel.com>
References: <4153505278C0BF4DABE3DF3D82533FE29D0CBE@NTXBOIMBX05.micron.com>
 <alpine.LRH.2.03.1405181139190.5666@AMR>
 <4153505278C0BF4DABE3DF3D82533FE29D141C@NTXBOIMBX05.micron.com>
 <20140519093501.GI6121@linux.intel.com>
Message-ID: <4153505278C0BF4DABE3DF3D82533FE29D20EE@NTXBOIMBX05.micron.com>

Hi Matthew, so how you see the NVMe linux driver should support system (i.e. ultrabook and tablet) to achieve better battery life and thermal over temperature protection in S0? Correct me if I am wrong, I don't see current driver has such mechanism put in place beyond the conventional suspend/resume support, even with this patch.

/Winson

-----Original Message-----
From: Matthew Wilcox [mailto:willy@linux.intel.com] 
Sent: Monday, May 19, 2014 2:35 AM
To: Winson Yung (wyung)
Cc: Keith Busch; linux-nvme at lists.infradead.org
Subject: Re: [RFC PATCH] NVMe: Runtime suspend

On Mon, May 19, 2014@04:32:34AM +0000, Winson Yung (wyung) wrote:
> Agree, I think beyond 2 power states, the current implementation will 
> be difficult to use, that is why I was proposing to have a dynamic 
> power reduction model based on the idleness of IO activity, and let 
> runtime PM to request different power transition automagically. Each 
> of these NVMe power states definition are very vendor specific, so for 
> sure it will work best with vendor's own driver.

Hi Winson,

I just wanted to note that "vendor's own driver" is not really an option.
Linux distributions are very unwilling to ship different drivers for the same hardware, and OEMs and ISVs do not want to certify against multiple drivers.  This was why NVM Express was formed; to give everybody a common hardware interface and have one driver for many hardware implementations.

We've already seen a couple of hardware vendors try to ship their own Linux driver and been told "No" by their customers and the ISVs.
If there are changes you would like to the Linux driver to make your device perform better, let's discuss how we can make that happen.  While I work for Intel, I don't work for the part of Intel that makes SSDs.

> I read from NVMe spec 1.1a, it says D1 and D2 is not recommended to be 
> implemented. D0 is the active states, and device only enter D3 state 
> when system going to S3/4. So it seems making sense to have NVMe PM 
> states for either host OS (to initiate) or device (to enter 
> autonomously) with a shallower sleep state while system is still in S0.

D1/D2 are inactive states; reading & writing device registers don't work, so the only point in implementing D1/D2 is for reduced latency to return to D0.
