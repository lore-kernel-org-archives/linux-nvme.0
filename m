From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 May 2017 08:24:44 +0200
Subject: [PATCH 03/10] nvme_fc: replace ioabort msleep loop with completion
In-Reply-To: <20170513190309.25417-4-jsmart2021@gmail.com>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-4-jsmart2021@gmail.com>
Message-ID: <8b796b2b-dd46-b9c0-caeb-571e53b3655a@suse.de>

On 05/13/2017 09:03 PM, James Smart wrote:
> Per the recommendation by Sagi on:
> http://lists.infradead.org/pipermail/linux-nvme/2017-April/009261.html
> 
> Wait for io aborts to complete wait converted from msleep look to
> using a struct completion.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> ---
> this is version 2 of the patch:
> removed unneeded inner braces
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
