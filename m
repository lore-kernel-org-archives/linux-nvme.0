Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4C1606A323
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2026 10:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=M9kaW5hX;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=LfpWBOxQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0DhlS9GoN1A/K5xM5rHfMBdr59q03ZUL1Z49b13RaPk=; b=M9kaW5hXLxNnU+
	iglHv4u7hw6V6/1g1PVMI4S2Mq0dKZlfSPRKgd93SRtMKSgKHYLDtjOAiMKPHCKdIHbC22evfM6Pc
	eJLhCZgkw/GO1IWYSx3xqK0fSrJFNUxHLVtHR7A3chThL9ikmHuBRjBp6i7mczeM7/hg8108QGdyL
	7kUJ0aDzEr7mDQDVW8lrybgJ0mIwoppRskfQ7148j02d8svJ2tk0xZUC0xTkRl9RXwMM8FazhrfXF
	TnHNqcPg7sRsk8kUCpkc1CKN2SXzzxLUg0Hojy2eZw7Cg1pMg57GwQIFWN5bIjCSAn6FOiWDAZXCs
	2BQSmhF4cknNVkaOMTKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuMV-000000021sQ-18WG;
	Mon, 16 Nov 2026 10:54:59 +0000
Received: from out30-124.freemail.mail.aliyun.com ([115.124.30.124])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xSuMR-000000021qy-0MDb
	for linux-nvme@lists.infradead.org;
	Mon, 16 Nov 2026 10:54:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794826491; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=0DhlS9GoN1A/K5xM5rHfMBdr59q03ZUL1Z49b13RaPk=;
	b=LfpWBOxQly67ukYBew1DxL6IGlNswqKvH2e0SeRIuW+xiCXvvyGY1T0qsbuTUqbhgL/CWemB7M7zu+RVymY7KEtXiwN0oJ7d5rPnmXtacXdykN6AFeow6sOKKAactb2XlD+ZXuTkIUxKAcpXpVsppzR0rYdJhKCrZ3YVAJNiy/c=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XEqpNPt_1794826489;
Received: from 30.178.85.242(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XEqpNPt_1794826489 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 16 Nov 2026 18:54:50 +0800
Message-ID: <ea29be95-49ce-4a82-b024-77898b818c48@linux.alibaba.com>
Date: Mon, 16 Nov 2026 18:54:48 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] nvme: introduce the service-time iopolicy
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Nilay Shroff <nilay@linux.ibm.com>, Daniel Wagner <dwagner@suse.de>,
 Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20261026111019.3724465-1-kanie@linux.alibaba.com>
In-Reply-To: <20261026111019.3724465-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261116_025455_814721_5B3B5F72 
X-CRM114-Status: GOOD (  25.01  )
X-Spam-Score: -17.6 (-----------------)
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
X-Spam-Status: No, score=-24.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,
  A gentle ping on this series, all comments are welcome. If you have any concerns about this feature, please let me know. Best Regards, Guixin Liu
在 2026/10/26 19:10, Guixin Liu 写道:
> The queue-depth iopolicy counts requests, so a 128K I/O weighs the same
> as a 4K one, and it cannot express that one path is simply faster than
> another. This series adds a service-time iopolicy for NVMe native
> multipath, adapted from dm-ps-service-time: it picks the path with the
> lowest estimated service time, in_flight_bytes / relative_throughput,
> so balancing follows actual bytes in flight and per-path throughput
> weights.
>
> Weights live in a per-path relative_throughput sysfs attribute (0-100,
> default 1, 0 makes the path a standby). Patch 3 documents the new
> attributes in the stable sysfs ABI; patch 1 carries the benchmark data
> in its commit log.
>
> This version is rebased onto the nvme-7.4 branch of
> git://git.infradead.org/nvme.git.
>
> Changes since v3:
>
> - Rebased onto nvme-7.4, which adds the iopolicies and path_state
>   attributes and the discovery-subsystem "none" handling.
>
> - The iopolicies ABI entry now lists service-time too. nvme-7.4
>   already documents the attribute (with a hardcoded list of the
>   three older policies); patch 3 extends that list along with the
>   iopolicy accepted values.
>
> Changes since v2:
>
> - in_flight_bytes no longer leaks on failover: the accounted bytes
>   are now released in nvme_failover_req() before blk_steal_bios()
>   clears the request data length. Before, every failover (ANA
>   transition, path error, queue_rq unwind) permanently left the
>   request's bytes in the counter, skewing path selection until a
>   controller reset. Reproduced with an ANA transition during load on
>   the NVMe-oF/TCP test setup: the counter kept 512K of phantom bytes
>   after all I/O completed; with the fix it returns to zero.
>
> - The release clamps at zero instead of a plain subtraction. A
>   request requeued across a controller reset is accounted against the
>   pre-reset counter but completes after nvme_mpath_init_identify()
>   re-zeroed it, and the plain subtraction would wrap negative, making
>   the comparator treat the path as pathologically overloaded. This
>   mirrors atomic_dec_if_positive() in the queue-depth accounting.
>
> - The comparison operates on u64 instead of size_t, so the byte
>   counts and the shift guard keep their magnitude on 32-bit builds,
>   where size_t would truncate the atomic64 reads.
>
> - Added "service-time" to the accepted values of the subsystem
>   iopolicy ABI entry and to the policies listed by the iopolicies
>   ABI entry.
>
> No public v3 was posted; this version folds the review feedback from
> the v2 discussion and a rebase onto nvme-7.4.
>
> On the adaptive I/O policy dependency Hannes raised during v1: that
> series has become the latency I/O policy and is still under
> revision. The two are complementary: the latency policy infers path
> speed from observed completions, service-time takes configured
> weights and byte counts.
>
> Guixin Liu (3):
>   nvme-multipath: implement service-time iopolicy
>   nvme-multipath: document service-time iopolicy
>   nvme: document the service-time iopolicy sysfs attributes
>
>  Documentation/ABI/stable/sysfs-nvme          |  35 +++-
>  Documentation/admin-guide/nvme-multipath.rst |  31 +++-
>  drivers/nvme/host/multipath.c                | 189 ++++++++++++++++++-
>  drivers/nvme/host/nvme.h                     |   6 +
>  drivers/nvme/host/sysfs.c                    |   7 +-
>  5 files changed, 256 insertions(+), 12 deletions(-)
>
> v2 of this series:
> https://lore.kernel.org/r/20261019075607.808947-1-kanie@linux.alibaba.com
>
> v1 of this series:
> https://lore.kernel.org/r/20260617114602.2224074-1-kanie@linux.alibaba.com
>
> latency I/O policy v7:
> https://lore.kernel.org/r/20260809100825.2014133-1-nilay@linux.ibm.com


