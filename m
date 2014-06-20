From: barrett.n.mayes@intel.com (Mayes, Barrett N)
Date: Fri, 20 Jun 2014 18:34:08 +0000
Subject: [PATCH] NVMe: Create module parameter for shutdown timeout.
References: <1403256174-3595-1-git-send-email-daniel.mcleran@intel.com>
 <20140620171552.GN12025@linux.intel.com> 
Message-ID: <B8DB29EA17EB2742AC3405C31A9B9EE9614C63A7@ORSMSX111.amr.corp.intel.com>

>"Minimum of one second" means "wait at least one second".  It doesn't specify an upper boundary for the maximum time to wait.
>I believe there's a proposal in flight to try and clarify this (or there will be soon).

TP011 for Runtime D3 support added bytes 91:88 to ID controller for runtime D3 entry latency and associated text for host to wait this amount of time to enter shutdown.

A value of 0 still means wait at least one second without an upper limit imposed by the spec.
