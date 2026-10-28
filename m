Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CABF606A31E
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Oct 2026 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=YmuyFLqH;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BckGkJUA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=wGEp7crgi9gEiQBBRqNxXFkvR/He+V+yDg2RZ4aMmgs=; b=YmuyFLqHh2FkHv8kfEvD4CJ4kW
	sXjAcdMWYyyT2Ih1d+NTcahd78HnMxO/79nMraTrEPq0fp8bVilPFZXM1V1Ua72EFQ10msNzamBQE
	a96rLkl3XQLt6jXIQxsA93I59NnRoQK+L5r9cm+HNsWeKSIcyRJuQGmeLIlH0QfC43buwMdpaeg/0
	6pNZUMmH0k+cgOK+VHqYxcpXGDnPsm/0syb9J03DxrPGSUihM1imh1GN1vXrLrPTJvb3E5HYgBzmJ
	9zkL8VYfu4+3QZdeLJBb1gNQULiGs73wkz7KdTqHajZbmXPfYU7JCAQ6J93v4p1KUDdmgr9XFsxf6
	0Wo+v65Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5jO-00000007QJe-48hL;
	Wed, 28 Oct 2026 15:38:26 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xM5jO-00000007QJD-0gGb
	for linux-nvme@lists.infradead.org;
	Wed, 28 Oct 2026 15:38:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 766B941A50;
	Wed, 28 Oct 2026 15:38:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BE21F01828;
	Wed, 28 Oct 2026 15:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793201905;
	bh=wGEp7crgi9gEiQBBRqNxXFkvR/He+V+yDg2RZ4aMmgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BckGkJUAhF+VitOuIUrDWRW9K6iT06ssiVgwiU/B2Vau5ygihl7dEh0o47HSOJkrr
	 0sxyXeK492MnM8abIudvLdpv6ea3drF3LDBM1Vq1YzoRq3/a274alYXMtq3tQJ5CB3
	 ZAOeqKcFc7qODzDxO6Y8Ad/AIu7d2L3oG2I7oClyCKybxuoxNnrQu0zZbXraS5tw6F
	 SoEDyYLk5DMw99bxaAEWLbT3VGo4ri+/ggfalNd0LRvqVte9w7se4JBxpPLCz4/4hO
	 gSCfDYN37HVf9Ea/s7Z2ftOp7oqm0oDGsucGQ0bLsxyO5vLIUWoDHIl979lmYGnjom
	 P+bc3+bxgOU1g==
Date: Wed, 28 Oct 2026 09:38:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v4] nvme-tcp: Validate the queue state under the queue
 lock in the address attribute
Message-ID: <auIW70TjZVDjIX5R@kbusch-mbp>
References: <20261028020904.4188671-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261028020904.4188671-1-kanie@linux.alibaba.com>
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

On Wed, Oct 28, 2026 at 10:09:04AM +0800, Guixin Liu wrote:
> Reading the "address" sysfs attribute calls kernel_getsockname() on the
> admin queue socket, which can race with the queue teardown during
> connection error recovery: a reader can observe NVME_TCP_Q_LIVE set,
> then block on the queue lock while nvme_tcp_free_queue() releases the
> socket and clears queue->sock without holding the lock.  Once the
> reader acquires the lock it dereferences the NULL socket pointer.
> 
> Commit 76d54bf20cdc ("nvme-tcp: don't access released socket during
> error recovery") had the queue liveness check inside the lock.
> Commit 782373ba2766 ("nvme: tcp: avoid race between queue_lock lock
> and destroy") moved it back out because the lock itself is destroyed
> in nvme_tcp_free_queue(), so a reader arriving late trips
> mutex_destroy().

Thanks, applied to nvme-7.4.

