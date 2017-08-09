From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 9 Aug 2017 13:23:47 -0600
Subject: [PATCH] nvme: fix directive command numd calculation
In-Reply-To: <1502303189-11939-1-git-send-email-kwan.huen@ssi.samsung.com>
References: <CGME20170809182322epcas2p177ff5f42184c24dcab4a73a9c640916b@epcas2p1.samsung.com>
 <1502303189-11939-1-git-send-email-kwan.huen@ssi.samsung.com>
Message-ID: <6cfd6f4a-ead7-2e60-398e-748dd1b62b3c@kernel.dk>

On 08/09/2017 12:26 PM, kwan.huen@ssi.samsung.com wrote:
> From: "Kwan (Hingkwan) Huen-SSI" <kwan.huen at samsung.com>
> 
> The numd field of directive receive command takes number of dwords to 
> transfer. This fix has the correct calculation for numd.

Oops, that's my bad.

Reviewed-by: Jens Axboe <axboe at kernel.dk>

-- 
Jens Axboe
