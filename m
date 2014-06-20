From: barrett.n.mayes@intel.com (Mayes, Barrett N)
Date: Fri, 20 Jun 2014 17:26:33 +0000
Subject: [PATCH] NVMe: Create module parameter for shutdown timeout.
In-Reply-To: <20140620171552.GN12025@linux.intel.com>
References: <1403256174-3595-1-git-send-email-daniel.mcleran@intel.com>
 <20140620171552.GN12025@linux.intel.com>
Message-ID: <B8DB29EA17EB2742AC3405C31A9B9EE9614C5D27@ORSMSX111.amr.corp.intel.com>

>Those devices are broken.  From the spec:
>"It is recommended that the host wait a minimum of one second for the shutdown operations to complete."
>We're being generous and allowing them two seconds.  Whoever's device this is should fix it.

"Minimum of one second" means "wait at least one second".  It doesn't specify an upper boundary for the maximum time to wait.  I believe there's a proposal in flight to try and clarify this (or there will be soon).

Start stop unit on the SCSI side was more generous with timing, as was standby immediate for ATA.  1 sec. for shutdown, especially to be power fail safe following device acknowledgement is unnecessarily aggressive.
