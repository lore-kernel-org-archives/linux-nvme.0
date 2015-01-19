From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Jan 2015 14:33:05 +0000 (UTC)
Subject: NVMe driver status
In-Reply-To: <004b01d033df$9d6c2be0$d84483a0$@samsung.com>
References: <004b01d033df$9d6c2be0$d84483a0$@samsung.com>
Message-ID: <alpine.LNX.2.00.1501191414000.15481@localhost.lm.intel.com>

Hi Sunad,

The mainline going forward with kernel 3.19 will be blk-mq, and the
linux-nvme tree will be there as well on the next upstream merge.

I have my own repo for maintaining the bio-based version since a lot of
OS vendors are using older kernels in their minor release cycles. I can
push this out to a public repo on git.infradead.org if there's interest.

Thanks,
Keith

On Mon, 19 Jan 2015, Sunad Bhandary wrote:
> Hi Keith,
>
> Currently there are two different variants of the NVMe driver, one with the
> multi-queue implementation which is under active development and
> the one without it which is the current driver hosted in the NVMe git page.
>
> Going forward will the non-multi queue  driver also be maintained or will it
> be done away with completely ?
>
> Regards,
> Sunad
