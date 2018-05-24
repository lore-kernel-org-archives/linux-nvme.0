From: keith.busch@linux.intel.com (Keith Busch)
Date: Thu, 24 May 2018 07:38:59 -0600
Subject: [PATCH 2/2] nvme-pci: don't send delete cq command when allocate
 sq return -EINTR
In-Reply-To: <1527155494-1891-2-git-send-email-jianchao.w.wang@oracle.com>
References: <1527155494-1891-1-git-send-email-jianchao.w.wang@oracle.com>
 <1527155494-1891-2-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <20180524133859.GH11037@localhost.localdomain>

On Thu, May 24, 2018@05:51:34PM +0800, Jianchao Wang wrote:
>  	result = adapter_alloc_sq(dev, qid, nvmeq);
> -	if (result < 0)
> +	/*
> +	 * If return -EINTR, it means the allocate sq command times out and is completed
> +	 * with NVME_REQ_CANCELLED. At the time, the controller has been disabled
> +	 * and admin request queue has been quiesced. So don't try to send delete cq
> +	 * command any more.
> +	 */
> +	if (result == -EINTR)
> +		goto out;
> +	else if (result < 0)
>  		goto release_cq;

Since you're touching this part anyway, you'd really only want to goto
the release_cq if result is > 0.
