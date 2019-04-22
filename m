From: joshi.k@samsung.com (kanchan)
Date: Mon, 22 Apr 2019 19:06:49 +0530
Subject: [PATCH v4 4/7] block: introduce write-hint to stream-id conversion
In-Reply-To: <6850a3ad-805f-4232-1bc7-f3249e1fba96@kernel.dk>
References: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
 <CGME20190417175358epcas1p41a0a4e349dfe0a70bdcc244161c71604@epcas1p4.samsung.com>
 <1555523406-2380-5-git-send-email-joshi.k@samsung.com>
 <6850a3ad-805f-4232-1bc7-f3249e1fba96@kernel.dk>
Message-ID: <009c01d4f910$7db6ec40$7924c4c0$@samsung.com>

> Why not just use the bio write hint? We already disallow merging of dissimilar write hints, so req->bio->bi_write_hint is known to be identical with the rest of the bio's in that chain.

Yes, that is better. Thanks for suggesting it.

-----Original Message-----
From: Jens Axboe [mailto:axboe@kernel.dk] 
Sent: Wednesday, April 17, 2019 11:28 PM
To: Kanchan Joshi <joshi.k at samsung.com>; linux-kernel at vger.kernel.org; linux-block at vger.kernel.org; linux-nvme at lists.infradead.org; linux-fsdevel at vger.kernel.org; linux-ext4 at vger.kernel.org
Cc: prakash.v at samsung.com
Subject: Re: [PATCH v4 4/7] block: introduce write-hint to stream-id conversion

On 4/17/19 11:50 AM, Kanchan Joshi wrote:
> This patch moves write-hint-to-stream-id conversion in block-layer.
> Earlier this was done by driver (nvme). Current conversion is of the 
> form "streamid = write-hint - 1", for both user and kernel streams.
> Conversion takes stream limit (maintained in request queue) into 
> account. Write-hints beyond the exposed limit turn to 0.
> A new field 'streamid' has been added in request. While 'write-hint'
> field continues to exist. It keeps original value passed from upper 
> layer, and used during merging checks.

Why not just use the bio write hint? We already disallow merging of dissimilar write hints, so req->bio->bi_write_hint is known to be identical with the rest of the bio's in that chain.

--
Jens Axboe
