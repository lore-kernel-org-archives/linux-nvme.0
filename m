From: hare@suse.de (Hannes Reinecke)
Date: Tue, 7 May 2019 09:14:22 +0200
Subject: [PATCH nvme-cli rfc 4/5] fabrics: add --quiet option
In-Reply-To: <20190504000456.3888-5-jsmart2021@gmail.com>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-5-jsmart2021@gmail.com>
Message-ID: <539ef8c5-65a9-3228-a500-fd6c57f725fa@suse.de>

On 5/4/19 2:04 AM, James Smart wrote:
> From: Sagi Grimberg <sagi at grimberg.me>
> 
> Now we are going to have discovery log change events, so
> instead of trying to figure out which NVM subsystem ports
> are already connected, we let the driver do that and
> only suppress the failure messages.
> 
> This option will be used by the discovery log change corresponding
> udev rule.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>   fabrics.c | 14 +++++++++++---
>   1 file changed, 11 insertions(+), 3 deletions(-)
> 
Signed-off-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
