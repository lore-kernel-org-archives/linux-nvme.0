Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1FC60A3837
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 11:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=uEpo3v0S;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xF1Nt7gp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=xz8HPCWEbQVqy3w4HlCVb5N/8mNJZ1F0FNCstNxmPd8=; b=uEpo3v0SNNMeHCMgw8K1i3QEdF
	/LT0vwcQW68yqHzgLYvWmniMOy9B43GOddr5aCdxf+hUi61VGSfiJXzG5NmJGdPowU2x2KJrN5FTD
	ReHPs9HadsdQJn2+GzgKd+Fvntbs8giD7evVJoR7Lfyy1sME9KqgeaKD+C1oy+XhoDZUvh631AzGx
	7Tp/VdQsIOJ8OyQZECatbzpc9wN92+mL4xVqtZBpjWBqUM8OIvrSAt7YALQHi61Ff1/rDoMsEZXJm
	uLLka8sO7dxSAGTutkmyTp2HObm5nOt/m23LMzB0o3NxnnTEMdYWvFhZN1Bnk308UO6cyijer+M9T
	lTOLPAyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIb5-00000002KQE-0mai;
	Mon, 26 Oct 2026 11:10:35 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLIb0-00000002KJx-3pfN
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 11:10:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793013028; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=xz8HPCWEbQVqy3w4HlCVb5N/8mNJZ1F0FNCstNxmPd8=;
	b=xF1Nt7gp0PFenTG1oxXay546qgZe1ycADetBp/RJiwbP84cEWcKiCU+rSkDnQME3hMYBCuK3Z5dQZjIxR7CvF66WvBhVYsqoWeC0/4ssAE0A89hXCyD3qq7CDDHcSBO+5sufwtL1py3DhvZqqMWtQX1jTollMwtih88vQt+rdEM=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDXPhZn_1793013027;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDXPhZn_1793013027 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 26 Oct 2026 19:10:28 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v4 0/3] nvme: introduce the service-time iopolicy
Date: Mon, 26 Oct 2026 19:10:15 +0800
Message-ID: <20261026111019.3724465-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_041031_124933_73061C1F 
X-CRM114-Status: GOOD (  14.20  )
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
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The queue-depth iopolicy counts requests, so a 128K I/O weighs the same
as a 4K one, and it cannot express that one path is simply faster than
another. This series adds a service-time iopolicy for NVMe native
multipath, adapted from dm-ps-service-time: it picks the path with the
lowest estimated service time, in_flight_bytes / relative_throughput,
so balancing follows actual bytes in flight and per-path throughput
weights.

Weights live in a per-path relative_throughput sysfs attribute (0-100,
default 1, 0 makes the path a standby). Patch 3 documents the new
attributes in the stable sysfs ABI; patch 1 carries the benchmark data
in its commit log.

This version is rebased onto the nvme-7.4 branch of
git://git.infradead.org/nvme.git.

Changes since v3:

- Rebased onto nvme-7.4, which adds the iopolicies and path_state
  attributes and the discovery-subsystem "none" handling.

- The iopolicies ABI entry now lists service-time too. nvme-7.4
  already documents the attribute (with a hardcoded list of the
  three older policies); patch 3 extends that list along with the
  iopolicy accepted values.

Changes since v2:

- in_flight_bytes no longer leaks on failover: the accounted bytes
  are now released in nvme_failover_req() before blk_steal_bios()
  clears the request data length. Before, every failover (ANA
  transition, path error, queue_rq unwind) permanently left the
  request's bytes in the counter, skewing path selection until a
  controller reset. Reproduced with an ANA transition during load on
  the NVMe-oF/TCP test setup: the counter kept 512K of phantom bytes
  after all I/O completed; with the fix it returns to zero.

- The release clamps at zero instead of a plain subtraction. A
  request requeued across a controller reset is accounted against the
  pre-reset counter but completes after nvme_mpath_init_identify()
  re-zeroed it, and the plain subtraction would wrap negative, making
  the comparator treat the path as pathologically overloaded. This
  mirrors atomic_dec_if_positive() in the queue-depth accounting.

- The comparison operates on u64 instead of size_t, so the byte
  counts and the shift guard keep their magnitude on 32-bit builds,
  where size_t would truncate the atomic64 reads.

- Added "service-time" to the accepted values of the subsystem
  iopolicy ABI entry and to the policies listed by the iopolicies
  ABI entry.

No public v3 was posted; this version folds the review feedback from
the v2 discussion and a rebase onto nvme-7.4.

On the adaptive I/O policy dependency Hannes raised during v1: that
series has become the latency I/O policy and is still under
revision. The two are complementary: the latency policy infers path
speed from observed completions, service-time takes configured
weights and byte counts.

Guixin Liu (3):
  nvme-multipath: implement service-time iopolicy
  nvme-multipath: document service-time iopolicy
  nvme: document the service-time iopolicy sysfs attributes

 Documentation/ABI/stable/sysfs-nvme          |  35 +++-
 Documentation/admin-guide/nvme-multipath.rst |  31 +++-
 drivers/nvme/host/multipath.c                | 189 ++++++++++++++++++-
 drivers/nvme/host/nvme.h                     |   6 +
 drivers/nvme/host/sysfs.c                    |   7 +-
 5 files changed, 256 insertions(+), 12 deletions(-)

v2 of this series:
https://lore.kernel.org/r/20261019075607.808947-1-kanie@linux.alibaba.com

v1 of this series:
https://lore.kernel.org/r/20260617114602.2224074-1-kanie@linux.alibaba.com

latency I/O policy v7:
https://lore.kernel.org/r/20260809100825.2014133-1-nilay@linux.ibm.com
-- 
2.43.7

