Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F76D606A321
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 20:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=A0otIt7H;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oPSfs0y/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:In-Reply-To:
	Subject:Cc:To:From:Message-ID:Date:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=bzWNPK46eAIw1eDkMclbdycEdK5XtHh8k+peej1q8aI=; b=A0otIt7HrzkgedsIIZNF5ZQxYp
	Z6yb81AuVmKFciqS6pH78sf7s1r2Gj9D4SNOU9U7vtC1Glrf4BhWhmrZUuBWBH71om9K8KoeCa+d/
	rEY8badyV2bhXS/CJqToofh9g7hGYb3j7EHtsfbNeH9/3rbQ0O8rY8lFTWh7BMOiBR0dH3EyFjwWS
	k6zdEB8JiPxZArxExqf9Rrvzwwf5bVzhuF+Nk1tp4UiwF47h8VJCdNFEBXQEWTrMDzx4heGyjDbMk
	xngeLUDc/8ygfx5Z7AJ+FoFh6e8h/ec9h0nwZlQRLlTxzdilk/8n+xCkoiTwAUv74giIrYKPoML86
	pnWTuNZw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKLqT-0000000GvV3-2wmO;
	Fri, 23 Oct 2026 20:26:33 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xKLqS-0000000GvUt-22YE
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 20:26:32 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D428D40B40;
	Fri, 23 Oct 2026 20:26:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1181F01825;
	Fri, 23 Oct 2026 20:26:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792787191;
	bh=bzWNPK46eAIw1eDkMclbdycEdK5XtHh8k+peej1q8aI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=oPSfs0y/pqeNRUF77SVKj1Sa3k165FWzvtmwoGmp+VRfhKIDCXtXmYN+wG3XRxZat
	 /bWrDmgGc9Q1j6lp4AP7NC7x4og4mEK0+3Achlp8ThpPNzQvO1uJm7uJMRZhYmTfhR
	 uSwQI11tilgqgSZefXrydseTCbiIBPLF5cxL/QsDFVqtuLf/Kwg6gPxcUOUPrf1RQT
	 THGEyDWxkuRqBO/mJOXFqDoi1wNXcGaWONv8g2x/XE9pN59BfR9qH50fsTfMeLYfB9
	 S46IOMgr//zSopeugI5LhCt/DZ7wRG0WAsjN0Jjp7S380RzTFrwrxPnL60F5rIzMi+
	 5v0MOMW44ixnQ==
Date: Fri, 23 Oct 2026 10:26:30 -1000
Message-ID: <aee729fd53ef9c7c084a443216cfeb39@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Peng Yu <yupeng0921@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch <kbusch@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>, cgroups@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9] nvmet: add cgroup_id to charge namespace I/O to a cgroup
In-Reply-To: <20261023043423.176002-1-yupeng0921@gmail.com>
References: <20261023043423.176002-1-yupeng0921@gmail.com>
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
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Hello, Peng.

On Thu, Oct 22, 2026 at 09:34:23PM -0700, Peng Yu wrote:
> +	/*
> +	 * The I/O commands of a namespace with a cgroup, except Reservation
> +	 * commands, are executed from ->blkcg_work on ->blkcg_wq, so the
> +	 * cgroup's throttling doesn't put a transport context to sleep.
> +	 */
> +	struct workqueue_struct	*blkcg_wq;
> +	struct llist_head	blkcg_reqs;
> +	struct work_struct	blkcg_work;

All commands of the namespace go through the single blkcg_work, so they
execute one at a time on one worker. Can't each command embed its own
work item and be queued on blkcg_wq instead? For an unbound workqueue,
max_active applies to the whole system, so blkcg_wq's max_active can
just be set to the number of CPUs. That would be simpler and might
remove the performance degradation too.

Thanks.

--
tejun

