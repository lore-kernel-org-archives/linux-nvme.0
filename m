From: hare@suse.de (Hannes Reinecke)
Date: Mon, 15 May 2017 08:41:09 +0200
Subject: [PATCH 07/10] nvmet_fc: Add queue create and delete callbacks in
 LLDD api
In-Reply-To: <20170513190309.25417-8-jsmart2021@gmail.com>
References: <20170513190309.25417-1-jsmart2021@gmail.com>
 <20170513190309.25417-8-jsmart2021@gmail.com>
Message-ID: <e479d2d9-4a72-89d4-2dd0-f8520cd1e20d@suse.de>

On 05/13/2017 09:03 PM, James Smart wrote:
> To facilitate LLDD resource management on nvme queue creation and
> deletion, add optional callbacks queue_create and queue_delete.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
> ---
> this is version 3 of the patch:
> v2: require queue_delete if queue_create entrypoint present
> v3: recut on nvme-4.12
> 
>  drivers/nvme/target/fc.c       | 19 ++++++++++++++++++-
>  include/linux/nvme-fc-driver.h | 18 ++++++++++++++++++
>  2 files changed, 36 insertions(+), 1 deletion(-)
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
