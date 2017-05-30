From: hare@suse.de (Hannes Reinecke)
Date: Tue, 30 May 2017 10:31:19 +0200
Subject: [PATCH 7/7] nvme: provide UUID value to userspace
In-Reply-To: <e850e7d9548348ae46c82230a7077c89073e80f3.1496131397.git.jthumshirn@suse.de>
References: <cover.1496131397.git.jthumshirn@suse.de>
 <e850e7d9548348ae46c82230a7077c89073e80f3.1496131397.git.jthumshirn@suse.de>
Message-ID: <0dda446e-342d-49f2-8dfe-e778cfb0bc40@suse.de>

On 05/30/2017 10:08 AM, Johannes Thumshirn wrote:
> Now that we have a way for getting the UUID from a target, provide it
> to userspace as well.
> 
> Unfortunately there is already a sysfs attribute called UUID which is
> a misnomer as it holds the NGUID value. So instead of creating yet
> another wrong name, create a new 'nguid' sysfs attribute for the
> NGUID. For the UUID attribute add a check wheter the namespace has a
> UUID assigned to it and return this or return the NGUID to maintain
> backwards compatibility. This should give userspace a chance to catch
> up.
> 
> Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
>  drivers/nvme/host/core.c | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
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
