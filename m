From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Jun 2014 13:36:31 -0600 (MDT)
Subject: [PATCH] NVMe: Change nvme_enable_ctrl behavior and track CC
In-Reply-To: <alpine.WNT.2.00.1406201147280.22288@DMCLERAN-DESK.amr.corp.intel.com>
References: <1403192575-9704-1-git-send-email-daniel.mcleran@intel.com>
 <20140620171327.GM12025@linux.intel.com>
 <alpine.WNT.2.00.1406201147280.22288@DMCLERAN-DESK.amr.corp.intel.com>
Message-ID: <alpine.LRH.2.03.1406201330220.4699@AMR>

On Fri, 20 Jun 2014, Dan McLeran wrote:
> nvme_probe as it is written today essentially clears out any the shutdown 
> bits during enable. If you unload/reload the nvme module you'll see that the 
> normal shutdown bits are set before the controller gets enabled. The 
> nvme_remove path calls nvme_shutdown_ctrl but not nvme_disable_ctrl. Maybe 
> the nvme_probe path should always disable the controller first before 
> enabling to ensure we're starting clean?

But we already do that. We probably want nvme_disable_ctrl to also clear
the CC.SHN bits in addition to CC.EN, though.
