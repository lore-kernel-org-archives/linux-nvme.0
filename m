From: hare@suse.de (Hannes Reinecke)
Date: Thu, 13 Dec 2018 10:15:08 +0100
Subject: [PATCH 2/4] nvme: create slaves/holder entries for multipath
 devices
In-Reply-To: <20181206164812.30925-3-cascardo@canonical.com>
References: <20181206164812.30925-1-cascardo@canonical.com>
 <20181206164812.30925-3-cascardo@canonical.com>
Message-ID: <b1a12b3b-fddc-56df-baed-c09151031266@suse.de>

On 12/6/18 5:48 PM, Thadeu Lima de Souza Cascardo wrote:
> From: Christoph Hellwig <hch at lst.de>
> 
> This allows tools like distro installers easily track the relationship.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> [cascardo: only add disk when there is ns->head]
> Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo at canonical.com>
> ---
>   drivers/nvme/host/core.c      |  5 +++--
>   drivers/nvme/host/multipath.c | 13 +++++++++++--
>   drivers/nvme/host/nvme.h      | 12 ++++++++----
>   3 files changed, 22 insertions(+), 8 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
