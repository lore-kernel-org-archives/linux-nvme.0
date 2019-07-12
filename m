From: hare@suse.de (Hannes Reinecke)
Date: Fri, 12 Jul 2019 16:10:37 +0200
Subject: [PATCH rfc v2 08/10] nvme-cli: Expand --device argument processing
In-Reply-To: <20190712003140.16221-9-jsmart2021@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-9-jsmart2021@gmail.com>
Message-ID: <6699bf8a-b78e-ed9f-e579-e4f96440b5f9@suse.de>

On 7/12/19 2:31 AM, James Smart wrote:
> The connect-all --device argument was used to specify a specific device
> to be used as the discovery controller. The device is typically a
> long-lived discovery controller that posted a discovery event.
> No attempt was made to ensure the device is who it is supposed to be
> before using it.
> 
> Revised the code to use the other arguments in the connect-all request
> to validate that the device is the entity that was expected. If the
> device doesn't match, the cli will look for an existing matching device
> in the system (should be a discovery controller due to nqn) with the
> same connect parameters and use it.  If one is not found on the system,
> a new discovery controller will be created for the connect-all request.
> 
> The revision uses new routines to parse the connect arguments given
> in the argstr parameter. As a couple of new fieldnames are needed, the
> parse routine constants were expanded for them.
> 
> The revision uses the new routines to match the specified device vs
> it's attributes as well as the search routine that looks for a device
> with the connect arguments.
> 
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> CC: Sagi Grimberg <sagi at grimberg.me>
> CC: Hannes Reinecke <hare at suse.com>
> ---
>  fabrics.c | 38 ++++++++++++++++++++++++++++++++++++++
>  nvme.c    |  2 ++
>  nvme.h    |  2 ++
>  3 files changed, 42 insertions(+)
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
