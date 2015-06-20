From: axboe@fb.com (Jens Axboe)
Date: Sat, 20 Jun 2015 10:33:22 -0600
Subject: [PATCH] block: nvme-scsi: Catch kcalloc failure
In-Reply-To: <1434788954.21528.3.camel@ingics.com>
References: <1434788954.21528.3.camel@ingics.com>
Message-ID: <558595D2.1040607@fb.com>

On 06/20/2015 02:29 AM, Axel Lin wrote:
> res variable was initialized to -ENOMEM, but it's override by
> nvme_trans_copy_from_user(). So current code returns 0 if kcalloc fails.
> Fix it to return proper error code.

Looks good to me, applied for 4.2.

-- 
Jens Axboe
