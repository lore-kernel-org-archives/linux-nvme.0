From: hch@lst.de (Christoph Hellwig)
Date: Fri, 16 Nov 2018 09:12:41 +0100
Subject: [PATCHv3 0/3] nvme: NUMA locality for fabrics
In-Reply-To: <20181102095641.28504-1-hare@suse.de>
References: <20181102095641.28504-1-hare@suse.de>
Message-ID: <20181116081241.GA14072@lst.de>

Before we get into all the other craziness on the list, can I get
a respin of this one that is actually useful first?

On Fri, Nov 02, 2018@10:56:38AM +0100, Hannes Reinecke wrote:
> Hi all,
> 
> here's a patchset to leverage NUMA locality information for fabric controllers.
> This is the second attempt for doing so; after discussion with hch we came
> to the conclusion that the attempt in the initial submission with a manual
> configuration would only lead to more confusion and suboptimal configuration.
> 
> So here's now a version with an automatic NUMA balancing, where we attempt
> to split the number submitting CPUs/cores evenly across the available
> controller.
> 
> With this patchset I'm seeing a performance increase from
> 262k IOPS to 344k IOPS, measured against a NetApp AF700.
> 
> As usual, comments and reviews are welcome.
> 
> Changes to v2:
> - use 'numa_node' instead of 'node_id' (suggested by Sagi)
> - rediff patches for better readability
> 
> Hannes Reinecke (3):
>   nvme: NUMA locality information for fabrics
>   nvme-multipath: Select paths based on NUMA locality
>   nvme-multipath: automatic NUMA path balancing
> 
>  drivers/nvme/host/core.c      |  36 ++++++++++++-
>  drivers/nvme/host/fc.c        |   5 +-
>  drivers/nvme/host/multipath.c | 119 +++++++++++++++++++++++++++++++++++++++++-
>  drivers/nvme/host/nvme.h      |   3 ++
>  drivers/nvme/host/rdma.c      |   6 ++-
>  5 files changed, 161 insertions(+), 8 deletions(-)
> 
> -- 
> 2.16.4
---end quoted text---
