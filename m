Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C45606A31D
	for <linux-nvme@archiver.kernel.org>; Wed, 21 Oct 2026 21:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=IbBqSCCp;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IoR+o3ND
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9xFDwKa9QE4RkXSn8pB3Ype9/9E+5MMs7HrH2FQlI88=; b=IbBqSCCp0BDuBrOpEpUQiYep2s
	6yee/tbuGlxbJhpVtsBuY2xaR1biQsffbcDSJ8uZtloCFFU1w78EVEchmXmgwBGlm+X/7ltZgcNss
	Kgh2bcd0PdhMZT8/Z5G3r4Pry6LOzjK9KorkG44JfgHtUOkZnGX/sFq06xIu1jN7O+HZ/d5lt1LCm
	Sj+Sjb0ZS5PR29xV/JyidguiOT02UVZDyz7Xgp/jWqEoD+HKLMzAnL2vaRUIMTASvzYzjlHFd1K+q
	qBC3hgeK4BX1ODPQvCs+m7PwGWzGlKWy8SUasRibQSsSFOKBD1bJaFA4gXL4DYeAxBCBELN8D/Xkm
	J/JfZblA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdQt-0000000Ct05-1yLy;
	Wed, 21 Oct 2026 21:01:11 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJdQs-0000000CszN-42EK
	for linux-nvme@lists.infradead.org;
	Wed, 21 Oct 2026 21:01:11 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 43BF1602D3;
	Wed, 21 Oct 2026 21:01:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629C51F000C1;
	Wed, 21 Oct 2026 21:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792616470;
	bh=9xFDwKa9QE4RkXSn8pB3Ype9/9E+5MMs7HrH2FQlI88=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IoR+o3NDBCbVzx84h6KUCMBpq9z9MmhjRp+GwGzx1iOzdg041DTSdBwRmG8vwROCR
	 y8+hHxzBHJddtwOQOETh3Pv/ickuZbLpyg2VoCjaroTQJcTJkv8xVBmmhvZ4MJTF5O
	 53Q0I1CAENdcAVZbdxuB+MzJccXA8v938TRmBLXtBs5pjtfmN0JM/WF9GbsGMXpLih
	 Yji9iEOGTpsPPGHJJrIN60SuZ9Ifgm6lq3Lv7KYuwo6/tFHmoB7VB2k0ENa8b9xv9q
	 gjMYrF1RCEyY5ltlVzur4riJCoalnifF3QketRB7dkJZuWsvg8MrPyQRBQqQ67366i
	 BcV4K1YukWElQ==
Date: Wed, 21 Oct 2026 15:01:08 -0600
From: Keith Busch <kbusch@kernel.org>
To: Daniel Wagner <dwagner@suse.de>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Ming Lei <ming.lei@redhat.com>,
	Surabhi Gogte <sgogte@purestorage.com>,
	Hannes Reinecke <hare@kernel.org>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Maurizio Lombardi <mlombard@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Daniel Wagner <wagi@kernel.org>
Subject: Re: [PATCH 0/5] nvme-fabrics: fix connects with isolated CPUs and
 queue mapping bugs
Message-ID: <atkoFMy-_dmOG5ED@kbusch-mbp>
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
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

On Wed, Oct 14, 2026 at 09:46:38AM +0200, Daniel Wagner wrote:
> Connecting a fabrics controller fails when all CPUs of a hardware
> context are isolated with isolcpus=domain or an isolated cpuset
> partition. Since commit a46c27026da1 ("blk-mq: don't schedule block
> kworker on isolated CPUs") the CPU mask of such a hardware context is
> empty and blk_mq_alloc_request_hctx() fails the Connect command with
> -EXDEV. Patch 2 lets passthrough requests use the software context of a
> housekeeping CPU instead.
> 
> Patches 3-5 fix the fabrics queue mapping:
> 
>   - Stale io_queues[] entries after a reconnect with fewer queues crash
>     blk_mq_map_swqueue().
>   - A queue type can get more queues than online CPUs, so connecting
>     fails with -EXDEV.
>   - Without queues left for polling, the queue claims poll support and
>     polled I/O ends up on a non-poll queue.
> 
> Patch 1 fixes a regression in nvme-7.4 found while testing: since commit
> 61b0ed3be81b ("nvme-tcp: parallelize I/O queue allocation and startup")
> nvme_tcp_init_request takes a mutex before it is initialized, which
> disables lock debugging on the first connect.

It seems the nvme patches (1, 3-5) can be applied independently of the
blk-mq patch, so I staged those in nvme-7.4.

