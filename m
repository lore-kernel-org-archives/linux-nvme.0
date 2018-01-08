From: hare@suse.com (Hannes Reinecke)
Date: Mon, 8 Jan 2018 09:57:13 +0100
Subject: [PATCH 2/5] nvme/multipath: Consult blk_status_t for failover
In-Reply-To: <20180104224623.8944-3-keith.busch@intel.com>
References: <20180104224623.8944-1-keith.busch@intel.com>
 <20180104224623.8944-3-keith.busch@intel.com>
Message-ID: <1fbfce0c-2666-95c8-34e8-e0c1dd5f58af@suse.com>

On 01/04/2018 11:46 PM, Keith Busch wrote:
> This removes nvme multipath's specific status decoding to see if failover
> is needed, using the generic blk_status_t that was translated earlier. This
> abstraction from the raw NVMe status means nvme status decoding exists
> in just one place.
> 
> Signed-off-by: Keith Busch <keith.busch at intel.com>
> ---
>  drivers/nvme/host/core.c      |  9 +++++----
>  drivers/nvme/host/multipath.c | 44 ++++++++-----------------------------------
>  drivers/nvme/host/nvme.h      |  4 ++--
>  3 files changed, 15 insertions(+), 42 deletions(-)
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		               zSeries & Storage
hare at suse.com			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
