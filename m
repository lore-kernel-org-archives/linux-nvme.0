From: keith.busch@intel.com (Keith Busch)
Date: Fri, 25 Aug 2017 15:56:05 -0400
Subject: [PATCH v3] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170825022641.1424-1-martin.petersen@oracle.com>
References: <20170824090222.GA2543@infradead.org>
 <20170825022641.1424-1-martin.petersen@oracle.com>
Message-ID: <20170825195605.GC1207@localhost.localdomain>

On Thu, Aug 24, 2017@10:26:41PM -0400, Martin K. Petersen wrote:
> +	transition_time = le32_to_cpu(id->rtd3e);
> +	if (transition_time) {
> +		do_div(transition_time, 1000000); /* us -> s */
> +		clamp(transition_time, shutdown_timeout, 60); /* max 60s */
> +		ctrl->shutdown_timeout = transition_time;

My first experience with the kernel's 'clamp', so I had to look up that
macro. The above does not appear to fit the usage since 'clamp' returns
a value rather than directly clamp the parameter; I think it should be:

	transition_time = clamp(transition_time, shutdown_timeout, 60);
