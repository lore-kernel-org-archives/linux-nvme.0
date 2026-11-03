Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2DC606A324
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 06:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=jRi3uf6+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=/XztQY7i7a6rG8P89HhOqUxJ6l5LKEKog7gThE/5jCM=; b=jRi3uf6+7lK9jcTx7fNQinQKOj
	ukPOIb7DCFff4xIUIyDYs4G7qNRbeUGZbE/v5J8RWmIaxAFwNSbmJo21cHWtktovfpMLQwy0UjiEb
	VK34kGr/MHiAmr8vhYjaJh3RWLQ4oCeMSYrq6LXteqJG46TabUnHo4p4/styojjy8048OpTCH92fU
	07PLJABnymIt5xBUsAF1NIoCLm9jw/bknrEaTk4kDQmbG+w7krt60yRq5CZjBo/fDCKGCmPaHqKGw
	mTOgJ5gWQC9lr0mDP9tohaNEojES9NPm76zg+BEROE84fNSIo8z/T5v6shtkqCGPFKF8QDLfwYEow
	Hc9V6fWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7d7-00000001BCu-0wZR;
	Tue, 03 Nov 2026 06:04:21 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO7d4-00000001BCY-1unT
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 06:04:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 072DA68BEB; Tue,  3 Nov 2026 07:04:15 +0100 (CET)
Date: Tue, 3 Nov 2026 07:04:14 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk,
	Chris Mason <mason@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Guixin Liu <kanie@linux.alibaba.com>
Subject: Re: [PATCH 09/19] nvmet: fix pc_ref use-after-free in preempt and
 abort
Message-ID: <20261103060414.GE1862@lst.de>
References: <20261029155252.2332266-1-kbusch@meta.com> <20261029155252.2332266-10-kbusch@meta.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029155252.2332266-10-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261102_220418_823485_D7231F9C 
X-CRM114-Status: GOOD (  35.25  )
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

Adding Guixin for the PR code.

On Thu, Oct 29, 2026 at 08:52:42AM -0700, Keith Busch wrote:
> From: Chris Mason <mason@kernel.org>
> 
> With reservations enabled on a namespace, the target keeps a pc_ref per
> controller, a percpu_ref counting that controller's I/O on the
> namespace. "Preempt and abort" kills the pc_refs of the preempted
> controllers and waits for the kill to be confirmed in
> nvmet_pr_set_ctrl_to_abort(), then waits for the count to drop to zero
> and resurrects them in nvmet_pr_do_abort(). Neither holds a reference
> to the pc_ref, only pr_sem. nvmet_ctrl_destroy_pr() frees the pc_refs
> under subsys->lock when the controller goes away, so a host that
> registers a key, disconnects, and sends preempt and abort with that key
> over a second connection frees a pc_ref that the abort is sleeping on:
> 
>     preempt and abort on C1            last put of C2
>     nvmet_pr_set_ctrl_to_abort()
>       percpu_ref_kill_and_confirm()
>       wait_for_completion()
>                                        nvmet_ctrl_destroy_pr()
>                                          percpu_ref_exit()
>                                          kfree(pc_ref)
>     percpu_ref_switch_to_atomic_rcu()  /* use after free */
> 
> Put the pc_refs that an abort has killed on a per-namespace list.
> nvmet_ctrl_destroy_pr() only flags a pc_ref on that list, and
> nvmet_pr_do_abort() frees flagged ones once it's done with them. The
> list and the flag are written under the xarray lock.
> 
> Fixes: 5a47c2080a73 ("nvmet: support reservation feature")
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Sagi Grimberg <sagi@grimberg.me>
> Cc: Chaitanya Kulkarni <kch@nvidia.com>
> Signed-off-by: Chris Mason <mason@kernel.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/nvme/target/nvmet.h |  5 ++
>  drivers/nvme/target/pr.c    | 92 ++++++++++++++++++++++++++-----------
>  2 files changed, 69 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
> index d7804bf91aaa8..a89b384c4bbc9 100644
> --- a/drivers/nvme/target/nvmet.h
> +++ b/drivers/nvme/target/nvmet.h
> @@ -88,6 +88,8 @@ struct nvmet_pr {
>  	 */
>  	struct semaphore	pr_sem;
>  	struct list_head	registrant_list;
> +	/* The pc_refs that a running "preempt and abort" has killed. */
> +	struct list_head	abort_list;
>  };
>  
>  struct nvmet_pr_per_ctrl_ref {
> @@ -95,6 +97,9 @@ struct nvmet_pr_per_ctrl_ref {
>  	struct completion	free_done;
>  	struct completion	confirm_done;
>  	uuid_t			hostid;
> +	/* Both are written under the lock of ns->pr_per_ctrl_refs. */
> +	struct list_head	abort_entry;
> +	bool			ctrl_gone;
>  };
>  
>  struct nvmet_ns {
> diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
> index 14eaa99f98fa3..1c0d6cac1a6b3 100644
> --- a/drivers/nvme/target/pr.c
> +++ b/drivers/nvme/target/pr.c
> @@ -468,18 +468,54 @@ static void nvmet_pr_confirm_ns_pc_ref(struct percpu_ref *ref)
>  	complete(&pc_ref->confirm_done);
>  }
>  
> +static void nvmet_pr_free_pc_ref(struct nvmet_pr_per_ctrl_ref *pc_ref)
> +{
> +	percpu_ref_exit(&pc_ref->ref);
> +	kfree(pc_ref);
> +}
> +
> +/*
> + * The controller goes away. "Preempt and abort" sleeps on the pc_refs on its
> + * list, so leave the free of such a pc_ref to nvmet_pr_do_abort().
> + */
> +static void nvmet_pr_erase_pc_ref(struct nvmet_ns *ns, unsigned long cntlid)
> +{
> +	struct nvmet_pr_per_ctrl_ref *pc_ref;
> +
> +	xa_lock(&ns->pr_per_ctrl_refs);
> +	pc_ref = __xa_erase(&ns->pr_per_ctrl_refs, cntlid);
> +	if (pc_ref && !list_empty(&pc_ref->abort_entry)) {
> +		pc_ref->ctrl_gone = true;
> +		pc_ref = NULL;
> +	}
> +	xa_unlock(&ns->pr_per_ctrl_refs);
> +
> +	if (pc_ref)
> +		nvmet_pr_free_pc_ref(pc_ref);
> +}
> +
>  static void nvmet_pr_set_ctrl_to_abort(struct nvmet_req *req, uuid_t *hostid)
>  {
>  	struct nvmet_pr_per_ctrl_ref *pc_ref;
>  	struct nvmet_ns *ns = req->ns;
>  	unsigned long idx;
>  
> +	xa_lock(&ns->pr_per_ctrl_refs);
>  	xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
> -		if (uuid_equal(&pc_ref->hostid, hostid)) {
> -			percpu_ref_kill_and_confirm(&pc_ref->ref,
> -						nvmet_pr_confirm_ns_pc_ref);
> -			wait_for_completion(&pc_ref->confirm_done);
> -		}
> +		if (uuid_equal(&pc_ref->hostid, hostid) &&
> +		    list_empty(&pc_ref->abort_entry))
> +			list_add_tail(&pc_ref->abort_entry,
> +				      &ns->pr.abort_list);
> +	}
> +	xa_unlock(&ns->pr_per_ctrl_refs);
> +
> +	list_for_each_entry(pc_ref, &ns->pr.abort_list, abort_entry) {
> +		/* Killed for another host that this command preempts. */
> +		if (percpu_ref_is_dying(&pc_ref->ref))
> +			continue;
> +		percpu_ref_kill_and_confirm(&pc_ref->ref,
> +					    nvmet_pr_confirm_ns_pc_ref);
> +		wait_for_completion(&pc_ref->confirm_done);
>  	}
>  }
>  
> @@ -618,20 +654,27 @@ static u16 nvmet_pr_preempt(struct nvmet_req *req,
>  static void nvmet_pr_do_abort(struct work_struct *w)
>  {
>  	struct nvmet_req *req = container_of(w, struct nvmet_req, r.abort_work);
> -	struct nvmet_pr_per_ctrl_ref *pc_ref;
> +	struct nvmet_pr_per_ctrl_ref *pc_ref, *tmp;
>  	struct nvmet_ns *ns = req->ns;
> -	unsigned long idx;
> +	bool ctrl_gone;
>  
>  	/*
>  	 * The target does not support abort, just wait per-controller ref to 0.
>  	 */
> -	xa_for_each(&ns->pr_per_ctrl_refs, idx, pc_ref) {
> -		if (percpu_ref_is_dying(&pc_ref->ref)) {
> -			wait_for_completion(&pc_ref->free_done);
> -			reinit_completion(&pc_ref->confirm_done);
> -			reinit_completion(&pc_ref->free_done);
> -			percpu_ref_resurrect(&pc_ref->ref);
> -		}
> +	list_for_each_entry_safe(pc_ref, tmp, &ns->pr.abort_list, abort_entry) {
> +		wait_for_completion(&pc_ref->free_done);
> +		reinit_completion(&pc_ref->confirm_done);
> +		reinit_completion(&pc_ref->free_done);
> +		percpu_ref_resurrect(&pc_ref->ref);
> +
> +		/* Off the list, the pc_ref belongs to its controller again. */
> +		xa_lock(&ns->pr_per_ctrl_refs);
> +		list_del_init(&pc_ref->abort_entry);
> +		ctrl_gone = pc_ref->ctrl_gone;
> +		xa_unlock(&ns->pr_per_ctrl_refs);
> +
> +		if (ctrl_gone)
> +			nvmet_pr_free_pc_ref(pc_ref);
>  	}
>  
>  	up(&ns->pr.pr_sem);
> @@ -1052,6 +1095,8 @@ static int nvmet_pr_alloc_and_insert_pc_ref(struct nvmet_ns *ns,
>  	init_completion(&pc_ref->free_done);
>  	init_completion(&pc_ref->confirm_done);
>  	uuid_copy(&pc_ref->hostid, hostid);
> +	INIT_LIST_HEAD(&pc_ref->abort_entry);
> +	pc_ref->ctrl_gone = false;
>  
>  	ret = xa_insert(&ns->pr_per_ctrl_refs, idx, pc_ref, GFP_KERNEL);
>  	if (ret)
> @@ -1067,7 +1112,6 @@ static int nvmet_pr_alloc_and_insert_pc_ref(struct nvmet_ns *ns,
>  int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl)
>  {
>  	struct nvmet_subsys *subsys = ctrl->subsys;
> -	struct nvmet_pr_per_ctrl_ref *pc_ref;
>  	struct nvmet_ns *ns = NULL;
>  	unsigned long idx;
>  	int ret;
> @@ -1095,19 +1139,14 @@ int nvmet_ctrl_init_pr(struct nvmet_ctrl *ctrl)
>  
>  free_per_ctrl_refs:
>  	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, ns) {
> -		if (ns->pr.enable) {
> -			pc_ref = xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
> -			if (pc_ref)
> -				percpu_ref_exit(&pc_ref->ref);
> -			kfree(pc_ref);
> -		}
> +		if (ns->pr.enable)
> +			nvmet_pr_erase_pc_ref(ns, ctrl->cntlid);
>  	}
>  	return ret;
>  }
>  
>  void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
>  {
> -	struct nvmet_pr_per_ctrl_ref *pc_ref;
>  	struct nvmet_ns *ns;
>  	unsigned long idx;
>  
> @@ -1115,12 +1154,8 @@ void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
>  	mutex_destroy(&ctrl->pr_log_mgr.lock);
>  
>  	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
> -		if (ns->pr.enable) {
> -			pc_ref = xa_erase(&ns->pr_per_ctrl_refs, ctrl->cntlid);
> -			if (pc_ref)
> -				percpu_ref_exit(&pc_ref->ref);
> -			kfree(pc_ref);
> -		}
> +		if (ns->pr.enable)
> +			nvmet_pr_erase_pc_ref(ns, ctrl->cntlid);
>  	}
>  }
>  
> @@ -1136,6 +1171,7 @@ int nvmet_pr_init_ns(struct nvmet_ns *ns)
>  	atomic_set(&ns->pr.generation, 0);
>  	sema_init(&ns->pr.pr_sem, 1);
>  	INIT_LIST_HEAD(&ns->pr.registrant_list);
> +	INIT_LIST_HEAD(&ns->pr.abort_list);
>  	ns->pr.notify_mask = 0;
>  
>  	xa_init(&ns->pr_per_ctrl_refs);
> -- 
> 2.52.0
---end quoted text---

