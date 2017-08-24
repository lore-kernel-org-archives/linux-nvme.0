From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 24 Aug 2017 02:02:22 -0700
Subject: [PATCH v2] nvme: Honor RTD3 Entry Latency for shutdowns
In-Reply-To: <20170823223258.6695-1-martin.petersen@oracle.com>
References: <20170817174224.tkgrkl4hp2yjgkag@sbauer-Z170X-UD5>
 <20170823223258.6695-1-martin.petersen@oracle.com>
Message-ID: <20170824090222.GA2543@infradead.org>

On Wed, Aug 23, 2017@06:32:58PM -0400, Martin K. Petersen wrote:
> If an NVMe v1.2+ compliant controller reports RTD3 Entry Latency larger
> than shutdown_timeout, up to a maximum of 60 seconds, use that value to
> set the shutdown timer. Otherwise fall back to the module parameter
> which defaults to 5 seconds.

This generally looks fine, but NVMe allows TPs and thus new fields
to be implemented even against older spec versions, so we should avoid
version tests wherever possible.

> +	if (ctrl->vs >= NVME_VS(1, 2, 0)) {
> +		u32 transition_time = le32_to_cpu(id->rtd3e);

So instead of the version check here I'd check for a non-zero
RTD3E field instead.
