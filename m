From: keith.busch@intel.com (Keith Busch)
Date: Tue, 26 Apr 2016 15:39:22 +0000
Subject: [PATCH v2 0/2] nvme_ns_remove() deadlock fix
In-Reply-To: <1461619219-18144-1-git-send-email-mlin@kernel.org>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
Message-ID: <20160426153922.GD21270@localhost.localdomain>

On Mon, Apr 25, 2016@02:20:17PM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> Hi Sunad,
> 
> I don't have device that can do namespace attribute change.
> Could you help to verify these 2 patches fix the ns remove deadlock?
> 
> Thanks.
> 
> v2:
>   - switch to RCU freeing the namespace
> 
> Ming Lin (2):
>   nvme: switch to RCU freeing the namespace
>   nvme: fix nvme_ns_remove() deadlock
> 
>  drivers/nvme/host/core.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)

This looks good, and successfully tested on a namespace management capable
controller. These tests will be run more often from now on. Thanks for
the patches.

Reviewed-by: Keith Busch <keith.busch at intel.com>
