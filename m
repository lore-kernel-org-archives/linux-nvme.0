From: keith.busch@intel.com (Keith Busch)
Date: Mon, 26 May 2014 00:16:16 -0600 (MDT)
Subject: [RFC PATCH] NVMe: Runtime suspend
In-Reply-To: <4153505278C0BF4DABE3DF3D82533FE29D20EE@NTXBOIMBX05.micron.com>
References: <4153505278C0BF4DABE3DF3D82533FE29D0CBE@NTXBOIMBX05.micron.com>
 <alpine.LRH.2.03.1405181139190.5666@AMR>
 <4153505278C0BF4DABE3DF3D82533FE29D141C@NTXBOIMBX05.micron.com>
 <20140519093501.GI6121@linux.intel.com>
 <4153505278C0BF4DABE3DF3D82533FE29D20EE@NTXBOIMBX05.micron.com>
Message-ID: <alpine.LRH.2.03.1405252350070.4700@AMR>

On Tue, 20 May 2014, Winson Yung (wyung) wrote:
> Hi Matthew,
> so how you see the NVMe linux driver should support system (i.e.
> ultrabook and tablet) to achieve better battery life and thermal over
> temperature protection in S0? Correct me if I am wrong, I don't see current
> driver has such mechanism put in place beyond the conventional suspend/resume
> support, even with this patch.

This is what the RFC patch in question was proposing to address. The
only thing the patch added was supporting NVM-e low power states with a
user-defined policy, so I'm not sure what you're missing if you don't
see that mechanism in the patch. If all you are asking is to support
more than 2 power states, then we can talk about that.

Having the policy be user-defined should make it work exactly how you'd
want for a vendor's unique power states without needing a vendor specific
driver.

I don't think we want these going into lower D-states as the latency to
get out of there is probably too high for a runtime setting: we have to do
a device shutdown and full reinitilazation for D-state transitions.

I highly suspect that devices targeted to tablets and ultrabooks will
support the autonomous power state transitions feature, but lacking that,
I wanted to at least get some feedback if a driver initiated power state
transition is even desirable.

> /Winson
>
> -----Original Message-----
> From: Matthew Wilcox [mailto:willy at linux.intel.com]
> Sent: Monday, May 19, 2014 2:35 AM
> To: Winson Yung (wyung)
> Cc: Keith Busch; linux-nvme at lists.infradead.org
> Subject: Re: [RFC PATCH] NVMe: Runtime suspend
>
> On Mon, May 19, 2014@04:32:34AM +0000, Winson Yung (wyung) wrote:
>> Agree, I think beyond 2 power states, the current implementation will
>> be difficult to use, that is why I was proposing to have a dynamic
>> power reduction model based on the idleness of IO activity, and let
>> runtime PM to request different power transition automagically. Each
>> of these NVMe power states definition are very vendor specific, so for
>> sure it will work best with vendor's own driver.
>
> Hi Winson,
>
> I just wanted to note that "vendor's own driver" is not really an option.
> Linux distributions are very unwilling to ship different drivers for the same
> hardware, and OEMs and ISVs do not want to certify against multiple drivers.
> This was why NVM Express was formed; to give everybody a common hardware
> interface and have one driver for many hardware implementations.
>
> We've already seen a couple of hardware vendors try to ship their own Linux
> driver and been told "No" by their customers and the ISVs.  If there are
> changes you would like to the Linux driver to make your device perform
> better, let's discuss how we can make that happen.  While I work for Intel, I
> don't work for the part of Intel that makes SSDs.
>
>> I read from NVMe spec 1.1a, it says D1 and D2 is not recommended to be
>> implemented. D0 is the active states, and device only enter D3 state
>> when system going to S3/4. So it seems making sense to have NVMe PM
>> states for either host OS (to initiate) or device (to enter
>> autonomously) with a shallower sleep state while system is still in S0.
>
> D1/D2 are inactive states; reading & writing device registers don't work, so
> the only point in implementing D1/D2 is for reduced latency to return to D0.
