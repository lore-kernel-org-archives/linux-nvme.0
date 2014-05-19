From: wyung@micron.com (Winson Yung (wyung))
Date: Mon, 19 May 2014 04:32:34 +0000
Subject: [RFC PATCH] NVMe: Runtime suspend
In-Reply-To: <alpine.LRH.2.03.1405181139190.5666@AMR>
References: <4153505278C0BF4DABE3DF3D82533FE29D0CBE@NTXBOIMBX05.micron.com>
 <alpine.LRH.2.03.1405181139190.5666@AMR>
Message-ID: <4153505278C0BF4DABE3DF3D82533FE29D141C@NTXBOIMBX05.micron.com>

See my comment inline below

On 5/18/2014 11:00 AM, Keith Busch wrote:> On Sun, 18 May 2014, Winson Yung (wyung) wrote:
>> * How is the current NVMe power states defined by a storage device
>> exposed/used in the kernel? I looked at the driver/block/nvme-scsi.c, and
>> only can see that they were mapped to supporting scsi START STOP UNIT cmd
>> inside nvme_trans_power_state(). So is it accurate to say that no (power
>> management) code in linux kernel take advantage of these NVMe power 
>> states?
> 
> Yes, that's true that we're not making use of power states in the core
> driver. You can only test this out on your device with IOCTLs, either
> passthrough or the SG_IO you mentioned.
> 
>> * I think your patch is a good idea, but you should consider to extend it
>> such that it uses runtime power management to create a dynamic power
>> reduction model based on the idleness of IO activity. For example, if the
>> storage drive supports 3 NVMe power states (0, 1, 2), we can let
>> nvme_runtime_suspend() to determine which NVMe power states to use 
>> among 0, 1
>> or 2 based on the IO activity.
> 
> That's kind of the idea, but I was only letting the user choose a policy
> for idle time until runtime suspending, and which power state to go
> to. It would take more driver work to allow a policy with more than 2
> power states, but maybe we should support more like how the autonomous
> power transitions feature allows.
> 

Agree, I think beyond 2 power states, the current implementation will be difficult to use, that is why I was proposing to have a dynamic power reduction model based on the idleness of IO activity, and let runtime PM to request different power transition automagically. Each of these NVMe power states definition are very vendor specific, so for sure it will work best with vendor's own driver.

I read from NVMe spec 1.1a, it says D1 and D2 is not recommended to be implemented. D0 is the active states, and device only enter D3 state when system going to S3/4. So it seems making sense to have NVMe PM states for either host OS (to initiate) or device (to enter autonomously) with a shallower sleep state while system is still in S0. 

What will happen if host try to initiate entering one of these NVMe PM states while device firmware is also trying to do the same? Is autonomous power transition defined by NVMe implies device firmware can transition device (if capable) to a different NVMe PM state by itself? Should the host OS use set feature cmd to disable autonomous power transition feature in this case?

>> This way creates a more scalable solution that gives better balance 
>> between
>> power saving and performance (i.e. exit latency) in the middle of D0 
>> and D3.
> 
> I'm not sure we want to take let the device go to D3 at runtime
> suspend. D3 would require we reinitialize the device and add more
> overhead in going from idle to resume. Maybe it's acceptable, but I was
> assuming not.
> 
>> * As for your observation of the potential issue, I think if a device 
>> is in
>> suspended mode, driver should allowed to post a command to IO queue as 
>> long
>> as the device can be awaken. Of course, the service of the command 
>> will be
>> queued and delay serviced only after runtime resume is completed.
> 
> I actually did get some clarification on this. The spec defines that a
> device in a non-operational power automatically transistions to the last
> operational power state that it was in when an IO submission occurs. This
> was in the autonomous power state section, but I'm told this applies to
> the device even when not using autonomous power states.
