From: hare@suse.de (Hannes Reinecke)
Date: Tue, 7 May 2019 09:13:44 +0200
Subject: [PATCH nvme-cli rfc 3/5] fabrics: allow discover to address
 discovery controller by persistent name
In-Reply-To: <20190504000456.3888-4-jsmart2021@gmail.com>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-4-jsmart2021@gmail.com>
Message-ID: <28e1e9a8-671d-e3ff-6111-7561e0f56fa9@suse.de>

On 5/4/19 2:04 AM, James Smart wrote:
> To support discovery (connect/connect-all) to operate against a
> persistent discovery controller, let the discovery controller to
> be specified by its device node name rather than new connection
> attributes.
> 
> Also centralize extraction of controller instance from the controller
> name to a common helper.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
> Patch originated from Sagi in an RFC
> fix merge issue
> fix contoller->controller
> add cfg.device check for "none"
> ---
>   fabrics.c | 35 +++++++++++++++++++++++++----------
>   1 file changed, 25 insertions(+), 10 deletions(-)
> 
Actually, I would rather scan existing controllers, and use the first 
one that matches the arguments.
With the current design we would have different calling sequences, 
depending on whether it's the first call (which create the controller), 
or any subsequent call.
If we were looking up the existing controller from the arguments we 
could be using the same commandline throughout.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N?rnberg)
