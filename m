From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Jan 2016 20:13:08 +0000
Subject: [PATCH 0/3] NVMe: Introduce CMB allocation scheme
In-Reply-To: <1451497679-1195-1-git-send-email-jonathan.derrick@intel.com>
References: <1451497679-1195-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <20160106201308.GB21311@localhost.localdomain>

On Wed, Dec 30, 2015@10:47:56AM -0700, Jon Derrick wrote:
> Applies to Jens' for-4.5/nvme
> 
> This patchset changes the CMB allocation scheme. Instead of reserving
> the entire range for SQes and automatically placing the SQes in the CMB,
> this set creates sysfs knobs to manage it. This allows partial usage of
> the CMB for SQes, so that the remainder can be mmapped or used for other
> NVMe-defined CMB usages.

Thanks, Jon.

In general, I like the control and visibility this provides. With this,
I think we're on the verge of warranting a new drivers/nvme/host/sysfs.c
file to keep all the nvme sysfs management in one place.

I don't think anyone is in a rush to see this in the 4.5 merge window,
so I'll load this on a CMB capable machine and provide a more thorough
review in the next week or so.

> Jon Derrick (3):
>   NVMe: Introduce sysfs entries for submission queues in CMB
>   NVMe: Generate resource tree for CMB
>   NVMe: Create CMB resource sysfs file
> 
>  drivers/nvme/host/core.c | 161 ++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h |  21 +++++
>  drivers/nvme/host/pci.c  | 212 ++++++++++++++++++++++++++++++-----------------
>  3 files changed, 313 insertions(+), 81 deletions(-)
> 
> -- 
> 2.1.4
> 
