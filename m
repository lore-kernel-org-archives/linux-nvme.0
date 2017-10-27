From: james.smart@broadcom.com (James Smart)
Date: Fri, 27 Oct 2017 10:47:16 -0700
Subject: [PATCH] nvme-fc: Zero out SGL before submitting AEN
In-Reply-To: <1509088577-7342-1-git-send-email-hare@suse.de>
References: <1509088577-7342-1-git-send-email-hare@suse.de>
Message-ID: <c1e37e1d-e5d4-c939-9569-36999c0fdaed@broadcom.com>

On 10/27/2017 12:16 AM, Hannes Reinecke wrote:
> nvme_fc_start_fc_op() will be updating the SGL entries of the
> sqe, so we need to zero those before resubmitting a received
> AEN. Otherwise we trigger the WARN_ON() in nvme_fc_start_fc_op().
>
> Signed-off-by: Hannes Reinecke <hare at suse.com>
> ---
>
This patch is unnecessary. It was completely resolved by the following 
patch which has been committed:

nvme-fc: use transport-specific sgl format
http://lists.infradead.org/pipermail/linux-nvme/2017-September/012723.html

-- james
