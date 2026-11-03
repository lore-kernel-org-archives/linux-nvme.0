Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FE1606A32E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2026 08:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=FPfinpK4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=9WvENImLqxCgY1amf4low1ga5uTuzK/2834N4b/cV4Q=; b=FPfinpK4VorqCnBG+5irD/RhtN
	eUABwEBkehYNJGSFl1poVJ5tAbvzh8Fcbu5fjbUh7NxoXgIVCGqEeS3CkfqCLo/hXBn0b62k/Gmo1
	Gz7sOVzlkk3nyrqNZEIsLDuC1QuhXdXi4r7z61T2svBk83BukfUi/gFGsGpkIDJ2iyetVaMpq+swY
	J9g4BcUhPb0Lbr7wYHJWaTWx0TrUpnYAOMo0apQsQqmBxCs21GuypzDr7VlZIsCyxfdt0vXC1dLEU
	dKEHpQOYxSWtCzcg7H7v4iXUatTlTx4+EGjRenEx7D96GlN4dMFjc7dh7Lj/9wNgGeg3+h6z39737
	MctYIT7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9f0-00000001Vfg-1Fxk;
	Tue, 03 Nov 2026 08:14:26 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xO9ew-00000001Vez-3WnU
	for linux-nvme@lists.infradead.org;
	Tue, 03 Nov 2026 08:14:24 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8187468BEB; Tue,  3 Nov 2026 09:14:18 +0100 (CET)
Date: Tue, 3 Nov 2026 09:14:18 +0100
From: Christoph Hellwig <hch@lst.de>
To: Qiliang Yuan <odys.yuan@gmail.com>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, rcu@vger.kernel.org
Subject: Re: [PATCH] nvme: wait for SRCU readers before splicing the
 namespace list
Message-ID: <20261103081418.GB4301@lst.de>
References: <20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-bug-nvme-remove-ns-srcu-v1-1-e239087d63ac@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261103_001423_188652_F912A2A4 
X-CRM114-Status: GOOD (  31.17  )
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

On Tue, Nov 03, 2026 at 01:30:35AM -0500, Qiliang Yuan wrote:
> Readers walk ctrl->namespaces under ctrl->srcu, and some of them sleep
> there, e.g. nvme_wait_freeze() waiting for I/O to drain.
> 
> nvme_remove_namespaces() moves the list onto its on-stack ns_list with
> list_splice_init_rcu(), which only waits for RCU readers before
> relinking the entries. A reader still on the last namespace then follows
> its next pointer to ns_list instead of ctrl->namespaces and treats the
> stack as a namespace. Deleting a controller while a Format NVM
> passthrough waits for a delayed read on the last namespace gives:
> 
>   BUG: KASAN: stack-out-of-bounds in nvme_wait_freeze+0x102/0x120
>   Read of size 8 at addr ff110001d2f3fc38 by task nvme/4413
>   Call Trace:
>    nvme_wait_freeze
>    nvme_passthru_start
>    nvme_submit_user_cmd
>    nvme_user_cmd
>    nvme_dev_ioctl
>   BUG: unable to handle page fault for address: ffffffff8af04850
> 
> Open-code the splice and wait for SRCU readers instead. This also takes
> the RCU grace period out of every controller deletion:

This feels like a design issue with list_splice_init_rcu or rather
using list_splice_init_rcu with SRCU.  Do we need to encapsulate
and verify this logic in a list_splice_init_srcu so that other
potential users won't get it wrong again?

> 
>   64 tcp controllers, 1 namespace each   before        after
>   nvme disconnect-all (ms)               3543 / 3474   3221 / 3146
>   nvme_remove_namespaces() avg (ms)      39.6 / 38.9   34.4 / 33.7
> 
> Fixes: be647e2c76b2 ("nvme: use srcu for iterating namespace list")
> Cc: stable@vger.kernel.org
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
> ---
>  drivers/nvme/host/core.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index a7a4d09644c13..8f032b3edde9a 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -4754,10 +4754,25 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
>  	/* this is a no-op when called from the controller reset handler */
>  	nvme_change_ctrl_state(ctrl, NVME_CTRL_DELETING_NOIO);
>  
> +	/*
> +	 * Readers walk the list under ctrl->srcu, so hide the namespaces from
> +	 * new readers and wait for the current ones before moving them over.
> +	 * list_splice_init_rcu() can't be used as it only waits for RCU
> +	 * readers.
> +	 */
>  	mutex_lock(&ctrl->namespaces_lock);
> -	list_splice_init_rcu(&ctrl->namespaces, &ns_list, synchronize_rcu);
> +	if (!list_empty(&ctrl->namespaces)) {
> +		struct list_head *first = ctrl->namespaces.next;
> +		struct list_head *last = ctrl->namespaces.prev;
> +
> +		INIT_LIST_HEAD_RCU(&ctrl->namespaces);
> +		synchronize_srcu(&ctrl->srcu);
> +		ns_list.next = first;
> +		ns_list.prev = last;
> +		first->prev = &ns_list;
> +		last->next = &ns_list;
> +	}
>  	mutex_unlock(&ctrl->namespaces_lock);
> -	synchronize_srcu(&ctrl->srcu);
>  
>  	list_for_each_entry_safe(ns, next, &ns_list, list)
>  		nvme_ns_remove(ns);
> 
> ---
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
> change-id: 20261102-bug-nvme-remove-ns-srcu-93d8a75a9b1b
> 
> Best regards,
> -- 
> Qiliang Yuan <odys.yuan@gmail.com>
---end quoted text---

