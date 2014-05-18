From: keith.busch@intel.com (Keith Busch)
Date: Sun, 18 May 2014 12:00:49 -0600 (MDT)
Subject: [RFC PATCH] NVMe: Runtime suspend
In-Reply-To: <4153505278C0BF4DABE3DF3D82533FE29D0CBE@NTXBOIMBX05.micron.com>
References: <4153505278C0BF4DABE3DF3D82533FE29D0CBE@NTXBOIMBX05.micron.com>
Message-ID: <alpine.LRH.2.03.1405181139190.5666@AMR>

On Sun, 18 May 2014, Winson Yung (wyung) wrote:
> * How is the current NVMe power states defined by a storage device
> exposed/used in the kernel? I looked at the driver/block/nvme-scsi.c, and
> only can see that they were mapped to supporting scsi START STOP UNIT cmd
> inside nvme_trans_power_state(). So is it accurate to say that no (power
> management) code in linux kernel take advantage of these NVMe power states?

Yes, that's true that we're not making use of power states in the core
driver. You can only test this out on your device with IOCTLs, either
passthrough or the SG_IO you mentioned.

> * I think your patch is a good idea, but you should consider to extend it
> such that it uses runtime power management to create a dynamic power
> reduction model based on the idleness of IO activity. For example, if the
> storage drive supports 3 NVMe power states (0, 1, 2), we can let
> nvme_runtime_suspend() to determine which NVMe power states to use among 0, 1
> or 2 based on the IO activity.

That's kind of the idea, but I was only letting the user choose a policy
for idle time until runtime suspending, and which power state to go
to. It would take more driver work to allow a policy with more than 2
power states, but maybe we should support more like how the autonomous
power transitions feature allows.

> This way creates a more scalable solution that gives better balance between
> power saving and performance (i.e. exit latency) in the middle of D0 and D3.

I'm not sure we want to take let the device go to D3 at runtime
suspend. D3 would require we reinitialize the device and add more
overhead in going from idle to resume. Maybe it's acceptable, but I was
assuming not.

> * As for your observation of the potential issue, I think if a device is in
> suspended mode, driver should allowed to post a command to IO queue as long
> as the device can be awaken. Of course, the service of the command will be
> queued and delay serviced only after runtime resume is completed.

I actually did get some clarification on this. The spec defines that a
device in a non-operational power automatically transistions to the last
operational power state that it was in when an IO submission occurs. This
was in the autonomous power state section, but I'm told this applies to
the device even when not using autonomous power states.
