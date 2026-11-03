Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EACF606A32F
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=R/9JVrwt
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=37OpAiwCn6erboU1eMdFL6lM3sBalxWTRU9eedva/Fk=; b=R/9JVrwtslltCVyp35egHoMGe3
	ijApkj80XXzxgRrwSe5TJdqm7KdMfFId5IPXCeCmauMYyID3O0TswOEvfD5q4n75dn30YYLygC2AK
	uk/a5dsQgCZYtFnIdIcXQhbchX1yY16dFEzmmzjeXZ0oD+hPZeU7VWJMZeom+BkTg68yJY9zSjZ6M
	Fjer85opSro0V7DkS4dsb7GCD1tVjYrXHMm5+7I4iAkM2N8UBQ3j+e3zvb+PPmP03idNy+ovz4mRS
	nmp7doa4xYS/9+g53tM9F6lY9si1oe89LUyEFd0nUZugxeN1mPwytn5eEFFKpuCuzK25iMpSg2ENl
	HWs9dIzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7oH-00000001Cha-1U0t;
	Tue, 03 Nov 2026 06:15:53 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7oC-00000001ChE-2H3H
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:15:49 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1DC5368BEB; Tue,  3 Nov 2026 07:15:45 +0100 (CET)
Date: Tue, 3 Nov 2026 07:15:44 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	Chris Mason <mason@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>
Subject: Re: [PATCH 19/19] nvmet: wait only for executing I/O in preempt
 and abort
Message-ID: <20261103061544.GM1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-20-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-20-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_221548_903564_7338D29A 
X-CRM114-Status: GOOD (  36.69  )
X-Spam-Score: -1.9 (-)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Adding Guixin for the nvmet PR code.  It would have been useful
to group things a bit more..

On Thu, Oct 29, 2026 at 08:52:52AM -0700, Keith Busch wrote:
> From: Chris Mason <mason@kernel.org>
> 
> nvmet_parse_io_cmd() takes the pc_ref for an I/O command as soon as it's
> parsed, and "preempt and abort" waits for all pc_refs of the preempted
> controllers before it releases pr_sem. But a write that still needs its
> data can't complete without the host sending it and without the
> transport context receiving it, and that same context is where Register,
> Acquire and Release sleep on pr_sem. So a host that sends a write and
> holds the data back, then preempt and abort with its own key, then
> Register on the same queue, deadlocks io_work, the abort work and the
> write with each other. Two well-behaved hosts get there by accident
> when one fences the other while it re-registers under I/O. The
> connection can't be torn down, the namespace can't be disabled, and
> with nvmet_config_sem held across that, nobody can connect.
> 
> Take the pc_ref when the transport calls ->execute(), once all the data
> is there: nvmet_parse_io_cmd() stashes the real execute method and
> installs nvmet_pr_execute_io(), which gets the reference, rechecks the
> reservation access since the host may have lost it since parse time,
> and calls through. Preempt and abort then only waits for commands that
> have started executing, which need neither the host nor the transport
> to finish. A write whose data arrives after the abort now fails with
> Reservation Conflict where it was previously executed, that's the
> input the hang needs.
> 
> Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/target/core.c  |  2 +-
>  drivers/nvme/target/nvmet.h |  4 +++-
>  drivers/nvme/target/pr.c    | 42 ++++++++++++++++++++++++++++++++++++-
>  3 files changed, 45 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
> index 1ed250cd4b56e..4f6fb7c4181ab 100644
> --- a/drivers/nvme/target/core.c
> +++ b/drivers/nvme/target/core.c
> @@ -1176,7 +1176,7 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
>  		if (ret)
>  			return ret;
>  
> -		ret = nvmet_pr_get_ns_pc_ref(req);
> +		nvmet_pr_set_execute(req);
>  	}
>  	return ret;
>  }
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index 7b429cc16d491..99b3bf5cbd3b6 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -513,6 +513,8 @@ struct nvmet_req {
>  	struct nvmet_port	*port;
>  
>  	void (*execute)(struct nvmet_req *req);
> +	/* what nvmet_pr_execute_io() calls once it has the pc_ref */
> +	void (*pr_execute)(struct nvmet_req *req);
>  	const struct nvmet_fabrics_ops *ops;
>  
>  	struct pci_dev		*p2p_dev;
> @@ -1041,7 +1043,7 @@ void nvmet_pr_exit_ns(struct nvmet_ns *ns);
>  void nvmet_execute_get_log_page_resv(struct nvmet_req *req);
>  u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask);
>  u16 nvmet_get_feat_resv_notif_mask(struct nvmet_req *req);
> -u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req);
> +void nvmet_pr_set_execute(struct nvmet_req *req);
>  static inline void nvmet_pr_put_ns_pc_ref(struct nvmet_pr_per_ctrl_ref *pc_ref)
>  {
>  	percpu_ref_put(&pc_ref->ref);
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index 1a03f74c2e14f..798f5ce9011f8 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -1060,7 +1060,7 @@ u16 nvmet_pr_check_cmd_access(struct nvmet_req *req)
>  	return status;
>  }
>  
> -u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
> +static u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
>  {
>  	struct nvmet_pr_per_ctrl_ref *pc_ref;
>  
> @@ -1072,6 +1072,46 @@ u16 nvmet_pr_get_ns_pc_ref(struct nvmet_req *req)
>  	return NVME_SC_SUCCESS;
>  }
>  
> +static void nvmet_pr_execute_io(struct nvmet_req *req)
> +{
> +	u16 status;
> +
> +	status = nvmet_pr_get_ns_pc_ref(req);
> +	if (!status) {
> +		/*
> +		 * The host can have lost its registration since the command was
> +		 * parsed. A get that succeeds after "preempt and abort" has
> +		 * resurrected the pc_ref has to see that. In percpu mode the
> +		 * get orders no later load, so this pairs with the
> +		 * smp_store_release() in __percpu_ref_switch_to_percpu(). While
> +		 * the resurrect is under way the get is a fully ordered
> +		 * atomic_long_inc_not_zero(). queue_work() in
> +		 * nvmet_execute_pr_acquire() orders the unregistration before
> +		 * the resurrect.
> +		 */
> +		smp_rmb();
> +		status = nvmet_pr_check_cmd_access(req);
> +	}
> +	if (status) {
> +		nvmet_req_complete(req, status);
> +		return;
> +	}
> +
> +	req->pr_execute(req);
> +}
> +
> +/*
> + * "Preempt and abort" waits for the commands that hold a pc_ref. Until the
> + * transport calls ->execute(), the end of a command can depend on the host,
> + * which may still have to send the data, and on the context and the resources
> + * of the transport. So a command gets its pc_ref only then.
> + */
> +void nvmet_pr_set_execute(struct nvmet_req *req)
> +{
> +	req->pr_execute = req->execute;
> +	req->execute = nvmet_pr_execute_io;
> +}
> +
>  static void nvmet_pr_ctrl_ns_all_cmds_done(struct percpu_ref *ref)
>  {
>  	struct nvmet_pr_per_ctrl_ref *pc_ref =
> -- 
> 2.52.0
---end quoted text---

