From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 20 Jun 2014 13:15:52 -0400
Subject: [PATCH] NVMe: Create module parameter for shutdown timeout.
In-Reply-To: <1403256174-3595-1-git-send-email-daniel.mcleran@intel.com>
References: <1403256174-3595-1-git-send-email-daniel.mcleran@intel.com>
Message-ID: <20140620171552.GN12025@linux.intel.com>

On Fri, Jun 20, 2014@03:22:54AM -0600, Dan McLeran wrote:
> The current implementation hard-codes shutdown timeout to 2 seconds. Some devices take
> longer than this to successfully complete a normal shutdown. This patch creates a module
> parameter for shutdown timeout and sets the default to 5 seconds.

Those devices are broken.  From the spec:

"It is recommended that the host wait a minimum of one second for the
shutdown operations to complete."

We're being generous and allowing them two seconds.  Whoever's device
this is should fix it.
