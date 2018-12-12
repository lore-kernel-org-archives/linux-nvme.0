From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 12 Dec 2018 09:08:22 -0700
Subject: [PATCH] nvme: provide fallback for discard alloc failure
In-Reply-To: <eea978e4-2c63-26d7-dbb6-8023c58675d4@kernel.dk>
References: <eea978e4-2c63-26d7-dbb6-8023c58675d4@kernel.dk>
Message-ID: <0256153d-6572-ecf0-d690-64dbfe419d32@kernel.dk>

On 12/12/18 9:04 AM, Jens Axboe wrote:
> When boxes are run near (or to) OOM, we have a problem with the discard
> page allocation in sd. If we fail allocating the special page, we return
                     ^^

nvme, of course, a bit too much reuse in the patch description.

-- 
Jens Axboe
