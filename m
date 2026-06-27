Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D016C43458
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 04:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W3BlDeepFbwZ4oE1Vsnyo+V98vHfS2bZA1E4/dojlN4=; b=vTwqyXpcXJe+X+Z7Q6YAzS31Jc
	5cK6sRThOl/OZvEsSr0fbXy4ei5VjV18m/61ukgUG2ppT4lC2lgY8Nrx53E0MvKeaAL+/B8dmQ7hA
	YuVEQ8s+98LDHecAdWEKIX/UaheIfpu2NPxM++4MtNlam4J7NzP9CUOtbE/DJoxAZM2ZqhCdLurme
	/YufVdtzcvCYr3tgvuM4v27xGmuz60Bh6irKZIjvDViXbNoxKnhEfYNQ5VhvU1N4RIedD38R6M6QQ
	1ZatgiV+jxOP2S7YpDWEYl3Kfrn1fuNzEIVrEIcqA10gQgzYdGZbaoWNZoWHkg2XjBHnLG8SQfrWb
	5bu7CjRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdKTD-0000000C7uK-2CUW;
	Sat, 27 Jun 2026 04:16:43 +0000
Received: from mail-ej1-x666.google.com ([2a00:1450:4864:20::666])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdKT9-0000000C7th-2mCZ
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 04:16:41 +0000
Received: by mail-ej1-x666.google.com with SMTP id a640c23a62f3a-c07c67ad9f2so194879266b.0
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 21:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782533797; x=1783138597; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W3BlDeepFbwZ4oE1Vsnyo+V98vHfS2bZA1E4/dojlN4=;
        b=NeMyIEJrcQcNpiHXfNnlWs9BcU4jL7/Cvwqi0bzvpA8pD53eIdUHXtbLHgi1TZJVYm
         XCcWrPbcHfsMWK+9/sBYq6YYQn1RWiE3FP3YM0RsxjBLKbM6/CtHTt1DIdV14Wp0Ed2x
         WdUc8DnWgHCZ3YSbl/IURAHMD9Pj0z1114CdbdiCCb8meoYcw/Nwy29gBAlJVxxq56Yz
         UNzvr8SY1SrGaCxktu1xtXRIL6h2CWACc51BhWmwoRFM1JHZ2Z1Buzq6GV+vXxoAKGUq
         QknTSya6qFnqYkV2i0s1ojCGLtzRc5igXQeIP/iUzMR6T4/yHGvsUTKBY6pOxpbirOO7
         lmYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782533797; x=1783138597;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W3BlDeepFbwZ4oE1Vsnyo+V98vHfS2bZA1E4/dojlN4=;
        b=BSk9mjG0EP++0L0TdCTKYta+qWaZg33vLbMwJL+QDs3Panky138m5fr3o9ItK0ggZS
         Z6Vgk6cUhAeLw3JukMC1zi2gTcCRobV4NahPy0ofgNeGGUyI3LkCHMxE2kfug45TX00K
         suO3stCJ+AD8nf1Xdpj9TvNz/j5ibf2Zi0Rn6J+37bmWXVr+bBu3QZcPJp49716C97/l
         CjTzJ/IGivRck+97o9AMtEqf4mkK7GNGpm3RrKRa+Mrws0NONH0RWmh3dVlMY1vKDONL
         9SsJLLOBQ4WhoaaszjCmgcOMtGvA+IsRqsqC7uZMHpuUlhUAWiNSkz251ZQLbUmpqQvj
         soJw==
X-Gm-Message-State: AOJu0YyysgNUllqbC+l6q7ST0IC/UGv1sUrGeXdvNfGUNOfdqJU/Rg2a
	vOVjFPfJuLxSiJ+dda8DcRh4SGMZoUt+EUKKhQJ/ODwyV2Offw0bNDUJTZg188z1elXhHfYyCik
	5AfSGxfZOgb8VHFsULaVebHPHq9FAjdFKZT/2KOsA05Dk9lrpNIoL
X-Gm-Gg: AfdE7clPHJpOC/QXq1HJYUbl27X3XhniVGPaKvjy14WZNg5acKUSUjh/nv0G07B9DMd
	lAr2Ov49amMe4ai48wTsfVhEhhaUeQE02xQY7JQi1viWUVCFXaMISEfZetAZBZ+Zu45+nap8RCE
	jc2OVA94zDhIjeTfnDIKhulvHsmPNaAtxmF423gpBo+Nz95vjEssdq79/4nC5yZbUpOcZdhOBxl
	prFD/8zzvBPtbfUFnhRCYQ9belbZ5qw7Mfch8GAza0LBFSR13S2dBbySYYsh4O2EPiNteo6ruU6
	2z4IJ21MHgyLcn+/FkdatVsPc0rGR+WYWER5gXIM7Vu5fWLao4B9V9mX4KxU+UpD0WC/YkLCuxt
	7rUXjfuEU9JLBJsgGbJ8gQZtfdUs=
X-Received: by 2002:a17:907:d30c:b0:c0f:bf3b:1793 with SMTP id a640c23a62f3a-c120446a4camr569437966b.21.1782533797198;
        Fri, 26 Jun 2026 21:16:37 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id a640c23a62f3a-c1230ac0218sm13606566b.35.2026.06.26.21.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 21:16:37 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 17A9540146;
	Fri, 26 Jun 2026 22:16:35 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 11F2551219; Fri, 26 Jun 2026 22:16:35 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v4 0/2] nvme-rdma: parallelize I/O queue setup
Date: Fri, 26 Jun 2026 22:15:49 -0600
Message-ID: <20260627041551.1981256-1-sgogte@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_211639_890093_1B03A0BF 
X-CRM114-Status: GOOD (  11.51  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This patch series parallelizes nvme-rdma connection and reconnection by
setting up I/O queues in parallel instead of sequentially. Allocation and
startup of each queue are combined into a single per-queue async work
item, so per-queue connection latency overlaps across all queues. This
matters most on high-core-count hosts with many I/O queues, where serial
setup dominates connect time.

Patch 1 is a preparatory refactor: nvme_rdma_alloc_queue() takes a queue
pointer so allocation and startup can be folded into a single async
worker.

Patch 2 contains the implementation for async setup of I/O queues.

Testing on a 64-core host with 64 I/O queues shows nvme-rdma connection
time reduced from ~1.4s to 416ms.

Signed-off-by: Surabhi Gogte <sgogte@purestorage.com>
---
Changes from v3->v4:
- Fixed formatting.
- Replaced kmalloc_array with kmalloc_objs.

Changes from v2->v3:
- Split the series into two patches: extract the nvme_rdma_alloc_queue()
  refactor into a separate preparatory patch.
- Replace the atomic error flag in struct nvme_rdma_ctrl with a per-work
  nvme_rdma_setup_ctx { queue, err } struct.
- Fix formatting changes regarding line overflow indentation and nesting.

Changes from v1->v2:
- Remove separate workqueue and use the async API instead.

Previous versions:
v1: https://lore.kernel.org/all/20260529001354.1003640-1-sgogte@purestorage.com/
v2: https://lore.kernel.org/all/20260604195321.2232838-1-sgogte@purestorage.com/
v3: https://lore.kernel.org/all/20260625212722.1302344-1-sgogte@purestorage.com/

Surabhi Gogte (2):
  nvme-rdma: refactor nvme_rdma_alloc_queue() to take a queue pointer
  nvme-rdma: parallelize I/O queue allocation and startup

 drivers/nvme/host/rdma.c | 136 ++++++++++++++++++++++++---------------
 1 file changed, 83 insertions(+), 53 deletions(-)

-- 
2.54.0


