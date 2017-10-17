From: hare@suse.de (Hannes Reinecke)
Date: Tue, 17 Oct 2017 08:06:42 +0200
Subject: [PATCH v2 1/8] lib/scatterlist: Introduce sgl_alloc() and
 sgl_free()
In-Reply-To: <20171016224940.1332-2-bart.vanassche@wdc.com>
References: <20171016224940.1332-1-bart.vanassche@wdc.com>
 <20171016224940.1332-2-bart.vanassche@wdc.com>
Message-ID: <b7975651-7f1e-9a61-f752-78eb8763dece@suse.de>

On 10/17/2017 12:49 AM, Bart Van Assche wrote:
> Many kernel drivers contain code that allocates and frees both a
> scatterlist and the pages that populate that scatterlist.
> Introduce functions in lib/scatterlist.c that perform these tasks
> instead of duplicating this functionality in multiple drivers.
> Only include these functions in the build if CONFIG_SGL_ALLOC=y
> to avoid that the kernel size increases if this functionality is
> not used.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at wdc.com>
> ---
>  include/linux/scatterlist.h |  10 +++++
>  lib/Kconfig                 |   4 ++
>  lib/scatterlist.c           | 105 ++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 119 insertions(+)
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
