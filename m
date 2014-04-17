From: keith.busch@intel.com (Keith Busch)
Date: Thu, 17 Apr 2014 09:29:54 -0600 (MDT)
Subject: [PATCH] NVMe: Change how aborts are handled
In-Reply-To: <1397409133-18140-1-git-send-email-matthew.r.wilcox@intel.com>
References: <1397409133-18140-1-git-send-email-matthew.r.wilcox@intel.com>
Message-ID: <alpine.LRH.2.03.1404170919020.7391@AMR>

On Sun, 13 Apr 2014, Matthew Wilcox wrote:
> +static void abort_cmdid(struct nvme_queue *nvmeq, u16 cmdid)
> +{
> +	void *ctx;
> +	nvme_completion_fn fn;
> +	static struct nvme_completion cqe = {
> +		.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
> +	};
> +
> +	ctx = cancel_cmdid(nvmeq, cmdid, &fn);
> +	if (fn(nvmeq, ctx, &cqe))
> +		clear_bit(cmdid, nvmeq->cmdid_data);
> +}

I don't think you want to clear the cmdid bit here. The above internally
completes the command as failed, but the controller still technically
owns the cmdid and may still return completion status for it, so we
don't want to make this cmdid available for reuse just yet.

We also don't want to leak the cmdid forever either. The existing method
will consider the controller being failed and reset it so we can reclaim
missing cmdids. This new way doesn't appear to reset the controller
if a command is never returned. At the very least, we probably need to
delete and recreate the IO queue it's associated with if not go straight
to the full controller reset.

Since the "aborted" flag in nvme_cmd_info adds 4k per queue, maybe we
can use the lower bits of the "ctx" for this flag instead, and have the
callbacks mask it off to retrieve the true context? The lower two bits
should never be in use if I'm not mistaken.
