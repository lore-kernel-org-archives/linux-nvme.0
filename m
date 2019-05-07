From: hare@suse.de (Hannes Reinecke)
Date: Tue, 7 May 2019 09:08:03 +0200
Subject: [PATCH nvme-cli rfc 1/5] fabrics: ignore arguments that pass in
 "none"
In-Reply-To: <20190504000456.3888-2-jsmart2021@gmail.com>
References: <20190504000456.3888-1-jsmart2021@gmail.com>
 <20190504000456.3888-2-jsmart2021@gmail.com>
Message-ID: <7269d1a0-f93c-6026-b7b8-76cbebe6174f@suse.de>

On 5/4/19 2:04 AM, James Smart wrote:
> As we want to support discovery uevents over different
> transports, we want to allow the kernel to provide missing
> information in the form of none and have nvme-cli properly
> ignore it.
> 
> One example is the host_traddr. If it is not set (which means
> that the default route determined the host address) we will
> want to do the same for newly discovered controllers.
> 
> So allow users to pass 'none' arguments as well.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> Signed-off-by: James Smart <jsmart2021 at gmail.com>
> ---
> Patch originated from Sagi in an RFC
> Fixed typo in Sagi's patch on cfg.hostid
> ---
>   fabrics.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
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
