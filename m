From: hare@suse.de (Hannes Reinecke)
Date: Fri, 20 Oct 2017 08:05:00 +0200
Subject: [PATCH v3 4/5] nvme_fc: check connectivity before initiating
 reconnects
In-Reply-To: <20171017233248.6769-5-jsmart2021@gmail.com>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
 <20171017233248.6769-5-jsmart2021@gmail.com>
Message-ID: <2f0c685c-1a9d-7adf-0177-0cdee58a3a8b@suse.de>

On 10/18/2017 01:32 AM, James Smart wrote:
> check remoteport connectivity before initiating reconnects
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> ---
> v3:
>   removed inline with lock around 1 line read of state.
>   replaced calls with explicit checks of read state
> ---
>  drivers/nvme/host/fc.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
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
