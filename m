From: hare@suse.de (Hannes Reinecke)
Date: Tue, 10 May 2016 15:16:45 +0200
Subject: [PATCH] NVMe: Only release requested regions
In-Reply-To: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
References: <1462886068-14605-1-git-send-email-jthumshirn@suse.de>
Message-ID: <5731DF3D.4000306@suse.de>

On 05/10/2016 03:14 PM, Johannes Thumshirn wrote:
> The NVMe driver only requests the PCIe device's memory regions but releases
> all possible regions (including eventual I/O regions). This leads to a stale
> warning entry in dmesg about freeing non existent resources.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/pci.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
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
