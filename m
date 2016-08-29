From: keith.busch@intel.com (Keith Busch)
Date: Mon, 29 Aug 2016 12:45:40 -0400
Subject: [PATCH 3/3] nvme: Enable autonomous power state transitions
In-Reply-To: <88cc7972617eec58a81877d933604e0f0e342e43.1472462539.git.luto@kernel.org>
References: <cover.1472462539.git.luto@kernel.org>
 <88cc7972617eec58a81877d933604e0f0e342e43.1472462539.git.luto@kernel.org>
Message-ID: <20160829164540.GE19986@localhost.localdomain>

On Mon, Aug 29, 2016@02:25:46AM -0700, Andy Lutomirski wrote:
> +	/*
> +	 * By default, allow up to 25ms of APST-induced latency.  This will
> +	 * have no effect on non-APST supporting controllers (i.e. any
> +	 * controller with APSTA == 0).
> +	 */
> +	ctrl->apst_max_latency_ns = 25000000;

Any objection to making this a module parameter? 25ms default sounds
reasonable, but I would still like the option to not ever initialize
APST on a capable device.
