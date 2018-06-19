From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Tue, 19 Jun 2018 09:56:22 -0700
Subject: [PATCH 5/7] nvme-rdma: don't override opts->queue_size
In-Reply-To: <20180619123415.25077-6-sagi@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
 <20180619123415.25077-6-sagi@grimberg.me>
Message-ID: <d0b79dfb-72ab-2356-8633-3ad42b3f04dc@intel.com>

On 06/19/2018 05:34 AM, Sagi Grimberg wrote:
> That is user argument, and theoretically controller limits can
> change over time (over reconnects/resets). Instead, use sqsize
> controller attribute to check queue depth boundaries and use it
> to the tagset allocation.
[...]
>  	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
> -		/* warn if sqsize is lower than queue_size */
> +		/*
> +		 * warn if sqsize is lower than queue_size actual calmping
> +		 * will be by using sqsize for the tagset allocation later.
> +		 */

This comment is a bit hard to follow; I think it's meant to say
"clamping", and it could probably use a semicolon or period before "actual".

Thanks,
-- Daniel
