Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA1B606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 01:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=Un9jivXK;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LX2ypuCH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=W3lroRbnqIXSNHCrTJQtlhuCGTKiM9QEtQ4RkVSjLYE=; b=Un9jivXK8me2yoiWRkStdTkAEo
	ygizchAHV55GsDhI9klDc199lKaiaZBkxIWq8qwKBNzelS+57WwiGT/ZeD9ilxK9oTxr/561VQp7D
	7a38is7OF/+xNizchIYVaMM+W+JzCrIbfbfgF0tDP+OF3IlKZPITCHSqp7DbNDaPMnEYovwoENnDk
	aC+pg2uBDOZ1n88BamrCpsRCrNYk1P7J8C72nCCES3pe9tb2YRBhYPfcUDO34w8K1jyO31Imir/mw
	PjGmpwBOn5hzyVuxNi0YFPIFbB5wEZdm6h8x7uLgYnEc0c37tGwdvKhdvhpabvUWN33+MurLU9u+h
	zY3kN31Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLslt-000000063Lu-03iJ;
	Wed, 28 Oct 2026 01:48:09 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLslr-000000063Ln-2gsC
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 01:48:07 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 21AFE4373B;
	Wed, 28 Oct 2026 01:48:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71331F01825;
	Wed, 28 Oct 2026 01:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793152087;
	bh=W3lroRbnqIXSNHCrTJQtlhuCGTKiM9QEtQ4RkVSjLYE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LX2ypuCHqV2uGMH8qOVhqcBnhXQaDfo8s4cpETl26rPtNIMdjFgLkSEng0ur4gevd
	 qys/fBtgxedOw9n4flTdHsGtShbLOj1FcLR6OaLZis5jXAvKAUyMYLJW2KD4rAUy1f
	 MNhUOaC/039WMqpS1xhvjrgRwkz8+vHngpy9Pu1f0CF3r7pLIY8pgn5eSAsH61Rz2Z
	 T4HTBJuuO0e31+Eaz6JzwxEBMzpm99efAj0I0HagcQ0CXEad2w6cS314P0HL80qIWg
	 uR8Yt/Ig0WC5ZpBEXHp/uEExzQ2QGBVIM5u1ErGJtYRS4M9mr/uMfk0ygSMeBCOr61
	 eShVkUOQKCahQ==
Date: Tue, 27 Oct 2026 19:48:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
Cc: linux-nvme@lists.infradead.org, axboe@kernel.dk, hch@lst.de,
	sagi@grimberg.me, hare@kernel.org, sgogte@purestorage.com,
	wagi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-tcp: fix NULL queue->ctrl dereference on reconnect
Message-ID: <auFUVXscufZffXyK@kbusch-mbp>
References: <20261028002654.1077190-1-christian.aurichzm@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028002654.1077190-1-christian.aurichzm@gmail.com>
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 09:26:54PM -0300, Christian Aurich Zanettini Martins wrote:
> +static void nvme_tcp_init_queue(struct nvme_tcp_ctrl *ctrl, int qid)
> +{
> +	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
> +
> +	queue->ctrl = ctrl;
> +	mutex_init(&queue->pf_cache_lock);
> +	queue->hdr_digest = ctrl->ctrl.opts->hdr_digest;
> +	queue->data_digest = ctrl->ctrl.opts->data_digest;

It's a good start, but if we're introducing an init helper, let's take
it all the way! The queue_lock at least is something Guixin has in a
conflicting patch here:

https://lore.kernel.org/linux-nvme/20261027123950.3122316-1-kanie@linux.alibaba.com/

Other fields including io_work and send_mutex look safe to move here too.

