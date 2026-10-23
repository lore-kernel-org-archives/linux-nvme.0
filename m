Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD9E606A31A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2026 07:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=OVtHvc8y;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=MJAFn9V5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=IUhG/JOZJ4aL/RRCs76fyoJSK8gQ/X0cYpn80zqNotk=; b=OVtHvc8ygYtnQbxAzAO1ISy0PR
	H7NBOgZ+lBL2KAHuzxxxb80MZ8+QoYJBRSMy57Op0jWz68m1wfeOAROiuD18e7tUitFkFaHHLPM3m
	uwPdL90ZUE32zeGJCjlhMdI82PILFcNgOr694Bmf3bQh/dQhr3UDFv7x7AN74vXVL7pX1xk02VBOj
	8wN2/pj2ZW0g2z40aJvEsMgYDn63x6WnKPmBwrj8wZbvAtOZD7RSBbFqlJR4TFt9bzzacbMMwh9G/
	3EujF/nP4feOKFLuk7JR14BCDd01CKzdGieKAM5RFqfxxJP62vbko5Bc7tpRmdfN3O9fJfNjNgCnR
	WlpHU9JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9J0-0000000FhWJ-0ieb;
	Fri, 23 Oct 2026 07:03:10 +0000
Received: from out30-118.freemail.mail.aliyun.com ([115.124.30.118])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xK9In-0000000FhKg-0o6l
	for linux-nvme@lists.infradead.org;
	Fri, 23 Oct 2026 07:03:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1792738970; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IUhG/JOZJ4aL/RRCs76fyoJSK8gQ/X0cYpn80zqNotk=;
	b=MJAFn9V5YKcBQK+TNPBDDzmXRS01ALBS2MmtDYlXB3xQFHgQFw/AkmDZHRIUaauvHMqY6jBMEorn2b4qJNmFj2Y3VYx4fcSIyVVCBxMAlcvUSE4qKOeLecsldJk0RDN9QBTNa25V8HgXy6HyMgRWgGwYWXMUwk6PPV+t1dUbToA=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDLGtrG_1792738969;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDLGtrG_1792738969 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 23 Oct 2026 15:02:50 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 0/3] nvme: introduce the service-time iopolicy
Date: Fri, 23 Oct 2026 15:02:38 +0800
Message-ID: <20261023070243.2495522-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261023_000257_940251_4E9FF11A 
X-CRM114-Status: GOOD (  12.91  )
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
X-Spam-Status: No, score=-21.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=4.0.1
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

Changes since v2 [1]:

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
  iopolicy ABI entry.

On the adaptive I/O policy dependency Hannes raised during v1: that
series has become the latency I/O policy [2] and is still under
revision, so this version stays on plain master. The two are
complementary: the latency policy infers path speed from observed
completions, service-time takes configured weights and byte counts.
I can rebase once the latency series lands.

Guixin Liu (3):
  nvme-multipath: implement service-time iopolicy
  nvme-multipath: document service-time iopolicy
  nvme: document the service-time iopolicy sysfs attributes

 Documentation/ABI/stable/sysfs-nvme          |  28 ++-
 Documentation/admin-guide/nvme-multipath.rst |  31 +++-
 drivers/nvme/host/multipath.c                | 189 ++++++++++++++++++-
 drivers/nvme/host/nvme.h                     |   6 +
 drivers/nvme/host/sysfs.c                    |   5 +-
 5 files changed, 251 insertions(+), 8 deletions(-)

v2 of this series:
https://lore.kernel.org/r/20261019075607.808947-1-kanie@linux.alibaba.com

v1 of this series:
https://lore.kernel.org/r/20260617114602.2224074-1-kanie@linux.alibaba.com

latency I/O policy v7:
https://lore.kernel.org/r/20260809100825.2014133-1-nilay@linux.ibm.com
-- 
2.43.7

