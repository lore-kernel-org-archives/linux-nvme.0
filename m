From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 20 Dec 2013 13:47:10 -0500
Subject: [PATCH] NVMe: Use error handling on failed sync commands
In-Reply-To: <1387563249-27871-1-git-send-email-keith.busch@intel.com>
References: <1387563249-27871-1-git-send-email-keith.busch@intel.com>
Message-ID: <20131220184710.GB4945@linux.intel.com>

On Fri, Dec 20, 2013@11:14:09AM -0700, Keith Busch wrote:
> Sync commands schedule an internal timeout to cancel rather than using
> the nvme timeout handler kthread. We should still try to recover so
> moving the check for cancelled commands after the error handling.

>  		if (timeout && !time_after(now, info[cmdid].timeout))
>  			continue;
> -		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
> -			continue;
>  		if (timeout && nvmeq->dev->initialized) {
>  			nvme_abort_cmd(cmdid, nvmeq);
>  			continue;
>  		}
> +		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
> +			continue;
>  		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n", cmdid,
>  								nvmeq->qid);
>  		ctx = cancel_cmdid(nvmeq, cmdid, &fn);

I'm confused by this patch.  Won't it cause us to send abort commands
repeatedly for commands IDs that have already been cancelled, but haven't
yet been completed as cancelled?
