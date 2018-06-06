From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 6 Jun 2018 08:28:11 -0600
Subject: [PATCH] block: pass failfast and driver-specific flags to flush
 requests
In-Reply-To: <20180606142140.64146-1-hare@suse.de>
References: <20180606142140.64146-1-hare@suse.de>
Message-ID: <2768f375-53cc-35db-5f6a-915735e9fd01@kernel.dk>

On 6/6/18 8:21 AM, Hannes Reinecke wrote:
> If flush requests are being sent to the device we need to inherit the
> failfast and driver-specific flags, too, otherwise I/O will fail.

Looks good to me.

-- 
Jens Axboe
