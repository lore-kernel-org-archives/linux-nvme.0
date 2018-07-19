From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 19 Jul 2018 13:48:46 -0600
Subject: [PATCHv4 0/4] nvme timeout updates
In-Reply-To: <20180713205609.19701-1-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
Message-ID: <20180719194845.GA15114@sbauer-Z170X-UD5>

On Fri, Jul 13, 2018@02:56:05PM -0600, Keith Busch wrote:
> The majority of the v3 was either merged or no longer necessary.
> 
> Patch 1 is still the same as before.
> 
> The remaining patches 2-4 are setting up the nvme core to handle
> unfreezing queues and dispatching IO from a context that is safe to
> handle IO timeouts. The pci nvme is the only one making use of that at
> the momement, but I suspect fabrics can make something of it.
> 
> The patch retrying a failed reset on an admin init timeout has been
> dropped. If we really need to do this, I think more discussion will help
> so we are creating less arbitrary rules.
> 
> Keith Busch (4):
>   nvme: Sync request queues on reset
>   nvme: Start controller in own work queue
>   nvme: Introduce frozen controller state
>   nvme-pci: Use controller start work to dispath IO
> 
>  drivers/nvme/host/core.c | 54 ++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/nvme/host/nvme.h |  3 +++
>  drivers/nvme/host/pci.c  | 20 ++++++------------
>  3 files changed, 59 insertions(+), 18 deletions(-)
> 
> -- 
> 2.14.3

Thanks Keith!

Tested-by: Scott Bauer <scott.bauer at intel.com>
