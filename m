From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 05 Nov 2014 13:41:11 -0700
Subject: [patch -next] NVMe: blk_mq_alloc_request() returns error pointers
In-Reply-To: <20141105203909.GB26314@mwanda>
References: <20141105203909.GB26314@mwanda>
Message-ID: <545A8B67.7060809@kernel.dk>

On 11/05/2014 01:39 PM, Dan Carpenter wrote:
> We recently converted this to blk_mq but the error checks have to be
> updated to check for IS_ERR() instead of NULL.

Ah good catch, thanks Dan.

-- 
Jens Axboe
