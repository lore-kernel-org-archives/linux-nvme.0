From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 1 Nov 2017 14:50:37 +0000
Subject: [PATCH v2 2/8] crypto: scompress - use sgl_alloc() and sgl_free()
In-Reply-To: <20171016224940.1332-3-bart.vanassche@wdc.com>
References: <20171016224940.1332-1-bart.vanassche@wdc.com>
 <20171016224940.1332-3-bart.vanassche@wdc.com>
Message-ID: <1509547836.2530.1.camel@wdc.com>

On Mon, 2017-10-16@15:49 -0700, Bart Van Assche wrote:
> Use the sgl_alloc() and sgl_free() functions instead of open coding
> these functions.
> 
> Signed-off-by: Bart Van Assche <bart.vanassche at wdc.com>
> Cc: Ard Biesheuvel <ard.biesheuvel at linaro.org>
> Cc: Herbert Xu <herbert at gondor.apana.org.au>

Ard and/or Herbert, can you please have a look at this patch and let us know
whether or not it looks fine to you?

Thanks,

Bart.
