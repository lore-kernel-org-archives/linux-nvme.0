From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 11 Oct 2017 14:54:47 +0300
Subject: [PATCH 3/9] block: provide a direct_make_request helper
In-Reply-To: <20170925134031.10548-4-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-4-hch@lst.de>
Message-ID: <eb2f78e6-042f-f39b-39e7-322c9a831dd2@grimberg.me>


> +/**
> + * direct_make_request - hand a buffer directly to its device driver for I/O
> + * @bio:  The bio describing the location in memory and on the device.
> + *
> + * This function behaves like generic_make_request(), but does not protect
> + * against recursion.  Must only be used if the called driver is known
> + * to not re-issue this bio or a split to itself.
> + */

Can you explain a bit on the comment? What happens if nvme attempts
to failover a split if the original IO didn't comply to the
virt_boundary?

Would that cause any problems?
