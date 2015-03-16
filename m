From: keith.busch@intel.com (Keith Busch)
Date: Mon, 16 Mar 2015 17:27:11 +0000 (UTC)
Subject: [PATCH] NVMe: increase depth of admin queue
In-Reply-To: <20150306195613.GA20453@kernel.dk>
References: <20150306195613.GA20453@kernel.dk>
Message-ID: <alpine.LNX.2.00.1503161722420.32385@localhost.lm.intel.com>

On Fri, 6 Mar 2015, Jens Axboe wrote:
> Usually the admin queue depth of 64 is plenty, but for some use cases we
> really need it larger. Examples are use cases like MAT, where you have
> to touch all of NAND for init/format like purposes. In those cases, we
> see a good 2x increase with an increased queue depth.
>
> Signed-off-by: Jens Axboe <axboe at fb.com>

Sounds good to me. If we encounter a case where changing this again is
desirable, we might want to take Jay's suggestion to make it a module
param.

Acked-by: Keith Busch <keith.busch at intel.com>
