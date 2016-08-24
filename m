From: axboe@fb.com (Jens Axboe)
Date: Wed, 24 Aug 2016 08:11:27 -0600
Subject: [PATCH] nvme: Fix nvme_get/set_features() with a NULL result
 pointer
In-Reply-To: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org>
References: <f0eca21161c9ec5f81e9591741463ec3883cb931.1472035881.git.luto@kernel.org>
Message-ID: <9f297b01-8f01-3d09-1de9-8be0d5ff007c@fb.com>

On 08/24/2016 04:52 AM, Andy Lutomirski wrote:
> nvme_set_features() callers seem to expect that passing NULL as the
> result pointer is acceptable.  Teach nvme_set_features() not to try to
> write to the NULL address.
>
> For symmetry, make the same change to nvme_get_features(), despite the
> fact that all current callers pass a valid result pointer.
>
> I assume that this bug hasn't been reported in practice because
> the callers that pass NULL are all in the SCSI translation layer
> and no one uses the relevant operations.

Thanks, applied for 4.8.


-- 
Jens Axboe
