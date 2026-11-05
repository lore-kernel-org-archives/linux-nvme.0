Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2E5606A328
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Nov 2026 18:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=4V4zATsT;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HD43nCc8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Subject:Cc:To:From:
	Message-ID:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=FYrSOLCmu3GIzaMabGYZjJKQcXM64yf8sup8daWFGF4=; b=4V4zATsTqSjvYIg2rCmxxLJtwX
	FBBhgqsbFs/Bqp6EG1fpFwzhpaIHvy9naqj8OlL1f6kdmXHRHraWktNlH2Yy4qURjCnn5KlG9OE23
	02I12rKk8xc9Cigzi0jR0YR5bGHlRX/fFcPF9IhhlQFwk8tKfZ6AGp4DPO3PQMklHjbXIpGxxFRzr
	pPi2MOwQt0xiwZZax8/1TjkFPivaJ0oQdKp2Ly1C2cZyQ1Y2C94hhnK7BxPThBNoQLHQHXEZtRItj
	HSCxCvBAeVx1O/A94PwKKMZPNWEW7pWANutwrPTSg0xyGowQTaaIiRCix+nSb3V01fRLj0FPHZeU6
	m6dtst8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2Wb-0000000ACLI-1OPK;
	Thu, 05 Nov 2026 18:49:25 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xP2WY-0000000ACKn-3IhK
	for linux-nvme@lists.infradead.org;
	Thu, 05 Nov 2026 18:49:22 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 1D624600B4;
	Thu,  5 Nov 2026 18:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A04A41F00919;
	Thu,  5 Nov 2026 18:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793904561;
	bh=FYrSOLCmu3GIzaMabGYZjJKQcXM64yf8sup8daWFGF4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HD43nCc8dh6ojhuWc9zEF6coxYSc/8f6hTrOhWv/dK76zIVkMbIvxhpHzA0fo1DfB
	 YQElOaMCWl/q8x/bJgbfNOmkQlluYzAx1He/B23fuiL3JgpZFR1hZcJzUgHycHC2uQ
	 EpDv+LX/NDZIXjhDUkGP+wA6ZTj7fiz1k/DhaKePbfc/PbOGI+P74kljKGuIvP9y7v
	 i1pbE7c8XorwMCgzaXZD29OO0+sBZC+PU6S5JubL9rO/CiLUBBEtsBBifk0TAlWIQD
	 1OXthKJ14jA/BS8P6Kz7lIJBpX4vxEYBKvelDyTyyLYxASdkzGy/BA3L2guGPw0oG3
	 TzOM6W2ifK5EQ==
Date: Thu, 05 Nov 2026 08:49:20 -1000
Message-ID: <95403f5dce741c515718b2fc7f5dcc64@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peng Yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>, Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>, Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org, linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12] nvmet: add cgroup_id to charge namespace I/O to a cgroup
In-Reply-To: <20261104071600.470430-1-yupeng0921@gmail.com>
References: <20261104071600.470430-1-yupeng0921@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 11:16:00PM -0800, Peng Yu wrote:
> +/*
> + * A command of a namespace with a cgroup already runs from its own work
> + * item on the namespace's workqueue (see nvmet_blkcg_work()), so run the
> + * backend's work function right there; otherwise queue it on @wq.
> + */
> +static inline void nvmet_req_run_work(struct nvmet_req *req,
> +		struct workqueue_struct *wq, struct work_struct *work,
> +		work_func_t func)
> +{
> +#ifdef CONFIG_BLK_CGROUP
> +	if (req->ns->blkcg_wq) {
> +		func(work);
> +		return;
> +	}
> +#endif
> +	INIT_WORK(work, func);
> +	queue_work(wq, work);
> +}

With cgroup_id set, the file backend's Flush, DSM and Write Zeroes and
zone management now run synchronously in the command's blkcg_wq work
item and hold one of its max_active slots for the whole vfs_fsync(),
vfs_fallocate() or zone operation. This probably deserves at least a
comment. Can you add one?

From the cgroup and workqueue side,

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

--
tejun

