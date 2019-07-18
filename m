From: tj@kernel.org (Tejun Heo)
Date: Thu, 18 Jul 2019 06:59:16 -0700
Subject: [PATCH v3 1/5] block: add weighted round robin for blkcgroup
In-Reply-To: <1333161d2c64dbe93f9dcd0814ffaf6d00216d58.1561385989.git.zhangweiping@didiglobal.com>
References: <cover.1561385989.git.zhangweiping@didiglobal.com>
 <1333161d2c64dbe93f9dcd0814ffaf6d00216d58.1561385989.git.zhangweiping@didiglobal.com>
Message-ID: <20190718135916.GC696309@devbig004.ftw2.facebook.com>

Hello, Weiping.

On Mon, Jun 24, 2019@10:28:51PM +0800, Weiping Zhang wrote:
> +static const char *blk_wrr_name[BLK_WRR_COUNT] = {
> +	[BLK_WRR_NONE]		= "none",
> +	[BLK_WRR_LOW]		= "low",
> +	[BLK_WRR_MEDIUM]	= "medium",
> +	[BLK_WRR_HIGH]		= "high",
> +	[BLK_WRR_URGENT]	= "urgent",
> +};

cgroup controllers must be fully hierarchical which the proposed
implementation isn't.  While it can be made hierarchical, there's only
so much one can do if there are only five priority levels.

Can you please take a look at the following?

  http://lkml.kernel.org/r/20190710205128.1316483-1-tj at kernel.org

In comparison, I'm having a bit of hard time seeing the benefits of
this approach.  In addition to the finite level limitation, the actual
WRR behavior would be device dependent and what each level means is
likely to fluctuate depending on the workload and device model.

I wonder whether WRR is something more valuable to help internal queue
management rather than being exposed to userspace directly.

Thanks.

-- 
tejun
