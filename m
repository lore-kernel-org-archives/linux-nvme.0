From: hare@suse.de (Hannes Reinecke)
Date: Fri, 12 Jul 2019 14:41:15 +0200
Subject: [PATCH rfc v2 03/10] nvme-cli: allow discover to address
 discovery controller by persistent name
In-Reply-To: <20190712003140.16221-4-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-4-jsmart2021@gmail.com>
Message-ID: <9cd61b4d-af8c-06ac-959f-1005ad7441d9@suse.de>

On 7/12/19 2:31 AM, James Smart wrote:
> To support discovery (connect/connect-all) to operate against a
> persistent discovery controller, let the discovery controller to
> be specified by its device node name rather than new connection
> attributes.
> 
> Example:
>   nvme connect-all ... --device=nvme5
> 
> Also centralize extraction of controller instance from the controller
> name to a common helper.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
> 
> ---
> v2:
>  Rework ctrl_instance for return value on error.
>  Validate device name is a controller name.
> ---
>  fabrics.c | 37 +++++++++++++++++++++++++++----------
>  1 file changed, 27 insertions(+), 10 deletions(-)
> 
Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
