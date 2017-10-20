From: hare@suse.de (Hannes Reinecke)
Date: Fri, 20 Oct 2017 08:00:08 +0200
Subject: [PATCH v3 2/5] nvme_fc: change ctlr state assignments during
 reset/reconnect
In-Reply-To: <20171017233248.6769-3-jsmart2021@gmail.com>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
 <20171017233248.6769-3-jsmart2021@gmail.com>
Message-ID: <06d12d08-990f-26fa-fe73-127dbe4a7f4e@suse.de>

On 10/18/2017 01:32 AM, James Smart wrote:
> Clean up some of the controller state checks and add the
> RESETTING->RECONNECTING state transition.
> 
> Specifically:
> - the movement of the RESETTING state change and schedule of
>   reset_work to core doesn't work wiht nvme_fc_error_recovery
>   setting state to RECONNECTING before attempting to reset.
>   Remove the state change as the reset request does it.
> - In the rare cases where an error occurs right as we're
>   transitioning to LIVE, defer the controller start actions.
> - In error handling on teardown of associations while
>   performing initial controller creation - avoid quiesce
>   calls on the admin_q. They are unneeded.
> - Add the RESETTING->RECONNECTING transition in the reset
>   handler.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 
> ---
> v3: no change. incorporated Reviewed-by's
> ---
>  drivers/nvme/host/fc.c | 28 +++++++++++++---------------
>  1 file changed, 13 insertions(+), 15 deletions(-)
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
