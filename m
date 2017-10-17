From: hare@suse.de (Hannes Reinecke)
Date: Tue, 17 Oct 2017 08:07:20 +0200
Subject: [PATCH v2 2/8] crypto: scompress - use sgl_alloc() and sgl_free()
In-Reply-To: <20171016224940.1332-3-bart.vanassche@wdc.com>
References: <20171016224940.1332-1-bart.vanassche@wdc.com>
 <20171016224940.1332-3-bart.vanassche@wdc.com>
Message-ID: <9e6d6115-8118-4e8d-aacb-849598becd19@suse.de>

On 10/17/2017 12:49 AM, Bart Van Assche wrote:
> Use the sgl_alloc() and sgl_free() functions instead of open coding
> these functions.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at wdc.com>
> Cc: Ard Biesheuvel <ard.biesheuvel at linaro.org>
> Cc: Herbert Xu <herbert at gondor.apana.org.au>
> ---
>  crypto/Kconfig     |  1 +
>  crypto/scompress.c | 51 ++-------------------------------------------------
>  2 files changed, 3 insertions(+), 49 deletions(-)
> Reviewed-by: Hannes Reinecke <hare at suse.com>

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
