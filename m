From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Jun 2017 12:19:53 -0400
Subject: [PATCH v2 3/4] nvme-pci: factor out the cqe reading mechanics
 from __nvme_process_cq
In-Reply-To: <1497796090-14808-4-git-send-email-sagi@grimberg.me>
References: <1497796090-14808-1-git-send-email-sagi@grimberg.me>
 <1497796090-14808-4-git-send-email-sagi@grimberg.me>
Message-ID: <20170619161953.GD21765@localhost.localdomain>

On Sun, Jun 18, 2017@05:28:09PM +0300, Sagi Grimberg wrote:
> Also, maintain a consumed counter to rely on for doorbell and
> cqe_seen update instead of directly relying on the cq head and phase.
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>

Looks like this particular change failed to produce the best diff. :)

> -	nvme_ring_cq_doorbell(nvmeq);
> +		if (tag && *tag == cqe.command_id) {
> +			*tag = -1;
> +			break;

This 'break' is new. We're already holding the lock, why wouldn't we
want to reap all the completions?
