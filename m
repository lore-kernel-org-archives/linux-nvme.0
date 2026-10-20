Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E83606A31E
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Oct 2026 14:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=eYE2lsB3;
	dkim=pass (2048-bit key, unprotected) header.d=arkamax.eu header.i=@arkamax.eu header.a=rsa-sha256 header.s=mail1 header.b=MqFRxE28
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:References:To:
	From:Subject:Cc:Message-Id:Date:Content-Type:Content-Transfer-Encoding:
	Mime-Version:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=u4XaG/IADUsHmeeyIIicJPIkyXDiTtIuQOXLloWOdXI=; b=eYE2lsB3gpE9hKV0E5xVLrVzTV
	+AkYhCkGmb0+qP6JAHV6HztfPZbmEZSeQfeUGTmefOzdvMJhZVoR77+alKwplmZ2b1yZ9RaNgcT8J
	i0sk7HdNGmmcktTbI0uB9A5VkWzoNrAxF+t5qD07o8wjt7NskyiH07+aoZIRiKFTWENW3h2ooeYK5
	2/oq6thEyHSrSW0Sprkp6czWFNOlGPRlL3Y44CxWIhxPnXal3XLjlYc1P7KmlcotQWbErsMJlDb1w
	hP8pVQpiN1NTf4RNZ2tT7idgRTOzbnV/lqDUKjFpxPpabg3RrW5OBpGhMo64wv8d8k4Ne5/SGfChO
	mAwQKFBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJAUF-00000009sdi-3o83;
	Tue, 20 Oct 2026 14:06:43 +0000
Received: from 128-116-240-228.dyn.eolo.it ([128.116.240.228] helo=arkamax.eu)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xJAUC-00000009sd8-2e2N
	for linux-nvme@lists.infradead.org;
	Tue, 20 Oct 2026 14:06:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; s=mail1; bh=NKfybp1z4fYKmU
	Jxu+F5lJKRKChEkxpkgysjOttxVcA=; h=in-reply-to:references:to:from:
	subject:cc:date; d=arkamax.eu; b=MqFRxE28BwpPrwcnDCbylbRnEk3900ANI5XFC
	MW8XEJ4JKMo8Y0MjsRKLPouE+wE7JTCRPMZ3ro7NHYn4mxL8mCdzHi3dLEJMA95Ag2v6NG
	kzDI4tfPRqGkq8CbvGo86Bn+I6sUvE7SY8EGzsEs1TyLOHJhgm/frrxs1I+T7GfviaZc77
	m8nyt7izPKeQqthp9B0V6VIiTuyHftHinwBBKMlKzNR/B2MjySlFelMwQ7eVyReRWzezsy
	6i4hAyW1RDcnXV7MA2yw14f3SJ+uFTsxoLLdJCnKrDVPmZoKyEuCb4EFFiJS9KaH7fZ52m
	l1XEAOa8mlEBPyItKD20H5lLg==
Received: from localhost (128-116-240-228.dyn.eolo.it [128.116.240.228])
	by arkamax.eu (OpenSMTPD) with ESMTPSA id da627210 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 20 Oct 2026 16:06:33 +0200 (CEST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 16:06:33 +0200
Message-Id: <DM9Q25N4G8WV.38ALK3OHBOGJA@arkamax.eu>
Cc: "Ming Lei" <ming.lei@redhat.com>, "Surabhi Gogte"
 <sgogte@purestorage.com>, "Hannes Reinecke" <hare@kernel.org>, "Nilay
 Shroff" <nilay@linux.ibm.com>, "Frederic Weisbecker" <frederic@kernel.org>,
 "Aaron Tomlin" <atomlin@atomlin.com>, "Maurizio Lombardi"
 <mlombard@redhat.com>, "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>,
 <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>, "Daniel Wagner" <wagi@kernel.org>
Subject: Re: [PATCH 0/5] nvme-fabrics: fix connects with isolated CPUs and
 queue mapping bugs
From: "Maurizio Lombardi" <mlombard@arkamax.eu>
To: "Daniel Wagner" <dwagner@suse.de>, "Keith Busch" <kbusch@kernel.org>,
 "Jens Axboe" <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>, "Sagi
 Grimberg" <sagi@grimberg.me>
X-Mailer: aerc 0.22.0
References: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
In-Reply-To: <20261014-nvme-fabrics-isolcpu-v1-0-355156be27b2@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261020_070641_302652_3CDA9743 
X-CRM114-Status: GOOD (  26.09  )
X-Spam-Score: -1.1 (-)
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
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed Oct 14, 2026 at 9:46 AM CEST, Daniel Wagner wrote:
> Connecting a fabrics controller fails when all CPUs of a hardware
> context are isolated with isolcpus=3Ddomain or an isolated cpuset
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
>
> I found the fabrics queue setup problems while working on the isolcpus
> series for the block layer, which Aaron Tomlin has since taken over and
> which has not been merged yet. Maurizio Lombardi reported customer bugs
> with isolcpus and nvme fabrics. This series doesn't depend on the block
> layer work.
>
> The bugs fixed by patches 3-5 predate commit a249d3066de6
> ("nvme-fabrics: add queue setup helpers"), which moved the tcp and rdma
> code into fabrics.c, so kernels before v6.5 need manual backports.
>
> Testing, QEMU with 8 CPUs, nvme-tcp and nvme-loop against nvmet:
>
>   - isolcpus=3Dmanaged_irq,domain,2-3: without the series, connecting
>     with nr_io_queues=3D8, with and without nr_write_queues=3D8
>     nr_poll_queues=3D8, fails on I/O queue 2, whose hardware context only
>     has CPU 3. With the series connect and I/O work.
>   - New blktests, posted separately:
>       nvme/070  connect with an isolated CPU             -> patch 2
>       nvme/071  more write and poll queues than CPUs     -> patch 4
>       nvme/072  no queues left for polling               -> patch 5
>       nvme/073  reconnect with fewer queues              -> patches 3, 5
>     Without the series all fail, nvme/073 crashes the kernel. With the
>     series all pass.
>   - blktests block and nvme (loop, tcp): no regressions.
>
> Reconnecting after all CPUs of a hardware context went offline still
> fails, with and without this series: blk-mq marks the hardware context
> inactive, but tcp, rdma and loop connect the I/O queues before updating
> the CPU mapping. I'll fix this separately, together with moving the
> fabrics reconnect sequence into common code.
>
> Signed-off-by: Daniel Wagner <wagi@kernel.org>
> ---
> Daniel Wagner (5):
>       nvme-tcp: initialize pf_cache_lock when allocating the controller
>       blk-mq: use a housekeeping CPU for passthrough requests on isolated=
 hctxs
>       nvme-fabrics: reset io_queues before computing the queue mapping
>       nvme-fabrics: limit each queue type to the number of online CPUs
>       nvme-fabrics: clear the poll map if no poll queues are mapped
>
>  block/blk-mq.c              | 37 +++++++++++++++++++++++++++++++++++--
>  drivers/nvme/host/fabrics.c | 30 ++++++++++++++++++++++++------
>  drivers/nvme/host/tcp.c     | 13 +++++++++----
>  3 files changed, 68 insertions(+), 12 deletions(-)
> ---
> base-commit: 31b8a6af19b73e6167c4b655cd5e86681bac1c41
> change-id: 20261013-nvme-fabrics-isolcpu-5b4948362f88
>
> Best regards,
> -- =20
> Daniel Wagner <wagi@kernel.org>

Thank you very much for this

I tested nvme/tcp with and without isolcpus and it works for me

Tested-by: Maurizio Lombardi <mlombard@redhat.com>

