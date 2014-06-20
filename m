From: daniel.mcleran@intel.com (Dan McLeran)
Date: Fri, 20 Jun 2014 13:42:23 -0600 (Mountain Daylight Time)
Subject: [PATCH] NVMe: Change nvme_enable_ctrl behavior and track CC
In-Reply-To: <alpine.LRH.2.03.1406201330220.4699@AMR>
References: <1403192575-9704-1-git-send-email-daniel.mcleran@intel.com>
 <20140620171327.GM12025@linux.intel.com>
 <alpine.WNT.2.00.1406201147280.22288@DMCLERAN-DESK.amr.corp.intel.com>
 <alpine.LRH.2.03.1406201330220.4699@AMR>
Message-ID: <alpine.WNT.2.00.1406201338281.22288@DMCLERAN-DESK.amr.corp.intel.com>

Hmm. You're right. I guess I thought setting EN to 0 would have cleared 
out the shutdown bits. I guess not.

On Fri, 20 Jun 2014, Keith Busch wrote:

> On Fri, 20 Jun 2014, Dan McLeran wrote:
>> nvme_probe as it is written today essentially clears out any the shutdown 
>> bits during enable. If you unload/reload the nvme module you'll see that 
>> the normal shutdown bits are set before the controller gets enabled. The 
>> nvme_remove path calls nvme_shutdown_ctrl but not nvme_disable_ctrl. Maybe 
>> the nvme_probe path should always disable the controller first before 
>> enabling to ensure we're starting clean?
>
> But we already do that. We probably want nvme_disable_ctrl to also clear
> the CC.SHN bits in addition to CC.EN, though.
>
