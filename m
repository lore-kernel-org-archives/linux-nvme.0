Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F108ECDE00B
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2026 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u6g8GnQBUk2ne5BaPEaScB3+h0qp9XYYdT6ZfiBb2l4=; b=UP6cF8ch/96jA0D407lDeVm2tM
	zUxiEcP6RnLlqKf0OOtpGf+MgKKBF5i1Is/HCZhKmcwOMt5Pr8zuLOoXW6P+uK/cLK4vy0qj+L9P2
	MOeps9M7bHC1DFfXTyuu57bMHax1w7Wv/tnFQTi1hIegWtQnDj3kHO6WyTPURtk2pI9//c1XJtmYB
	WUZvMf5lDG5w5jPg9khBns0tokbXGIaqhO9CP0R11qnatUz/u9YyLq+Ao2vTs9AEbRKaSQUirkgt+
	g1k1kNPol2YWYDp69l8EEq2/NNLyr9iMjJLMr7unIBfs7xQFwCKdEq3DEDwSypShu37k2eS8ErDkF
	mZhHKcQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcrbl-00000009s5R-1id5;
	Thu, 25 Jun 2026 21:27:37 +0000
Received: from mail-oo1-xc66.google.com ([2607:f8b0:4864:20::c66])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcrbi-00000009s4y-3buV
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jun 2026 21:27:36 +0000
Received: by mail-oo1-xc66.google.com with SMTP id 006d021491bc7-69de16f5f79so164220eaf.0
        for <linux-nvme@lists.infradead.org>; Thu, 25 Jun 2026 14:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782422853; x=1783027653; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=u6g8GnQBUk2ne5BaPEaScB3+h0qp9XYYdT6ZfiBb2l4=;
        b=baPmm9AqI4Bek2dBOFc2BaFwnWGqtUjUuszkm3gcaLd0TYBvcaVo5+aiaMzp7CstxU
         XkqdkfJVS85qfJUOEv/KzXmq7rxYCKAMv+IxiHXig0QRyqNm5tVCaw5DbHLtbcMFbPLp
         68E34VGaDxvsPu0RXJJGEcOnE675pzHVULENDZjvdgFPe6BtdM5SXIPux6TYmoKOkzEm
         rPJJCnHJwsD/SNePwYovDikbVT0o+nZam4scuIJzNY4pQ+W5XTq1q4im7rCGen+Thypf
         olVcXDzBxKoVEaba99226FfbJpKNvkgRVQ+pfI9u2hv9iUE7IhZVdl8yzzYaqA91ZHCm
         zOHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782422853; x=1783027653;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6g8GnQBUk2ne5BaPEaScB3+h0qp9XYYdT6ZfiBb2l4=;
        b=IalDb1dFkCIvs7Kcmr7d8gknnm65X6AVHVZ25w4hzTyOcOAnLNvMTmHtVCQ7a8NdvN
         7iiomLOiu5nGwpDVjcHvzYypnoixZCiUYmkdQLBzVWgIN8rif1TOiQW9lhens0sjfIup
         AG0A9Cw+tR2VDbF2PJd25/ixBKmmt8JlK0hJB9WqGmxgLRMAddvrYdS9X0MyVQQbMp4G
         R8KynX6VtxWGGM8huEL/3Sg0TSkRtdLNJYJUKNpL0p5kPdcDaRd0SWnGixPY5u1jMbDU
         mfVFkGJSp+L4+JfJBQeN7x6KG5kAo7YYIJHN8sgaMXM4gqPuFLytN9feF+bnNOYkggVT
         3afQ==
X-Gm-Message-State: AOJu0YyS/D1z5YlrCRiD5H+xOj9I+hWr5FoWpt/8xLLmRnGlcFvQ5e0t
	AgegJhabNbOo37SqozRnnyBSXoWg3A17d7N+g9Kh0Rc5DGwGm18TeB7550zNVRfXZzFB5T/qsbF
	rAGPoq5EG7SymWUAFDq7ofFVLY7Ey4LrEsPLQ
X-Gm-Gg: AfdE7cml88kPDlvi+iJ63bH8n0IiVCBk9IRN+rIXfcfsuxCtT4oDvN0ZbUMOjyBaObu
	G/GpkRbpehP4WFsNZEjecguPSTTgiK5eQtmdcYlvL7RR26EdaXtx/B3LKZV3NnIeifZf9WTqMHB
	YR2xcXtd1uS+m8S/Uyy/a5901bysDXlOjLJfYZ5QvohLKKI6h2lY5YnHU7bZzvvZp0WVuXt66xV
	rAgMwIK+yx6aj3VDl4Dv1Md7ZyQM4KWpiJPMyCkPrHOR2GuBjtyKWuLYzSExRXlE1RnLyTSceLc
	5J27VwuPzt50+idv10zSnugf6QvF11/6rbd0K+3954swiicRcqdb7ppPjOD5YU0xvOntsTeX6NB
	GCbamh1YFGwBpTRGyjHJJdSKfoM0k4oKejOthYxebGQ==
X-Received: by 2002:a05:6820:1b14:b0:69d:f7bf:c53f with SMTP id 006d021491bc7-6a13524882bmr3311653eaf.39.1782422853559;
        Thu, 25 Jun 2026 14:27:33 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4472f162514sm1474497fac.12.2026.06.25.14.27.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 14:27:33 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-sgogte.dev.purestorage.com (bond0.slc5-n22m24-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:429])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 171DA401FD;
	Thu, 25 Jun 2026 15:27:33 -0600 (MDT)
Received: by dev-sgogte.dev.purestorage.com (Postfix, from userid 1557734945)
	id 1352051222; Thu, 25 Jun 2026 15:27:33 -0600 (MDT)
From: Surabhi Gogte <sgogte@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mkhalfella@purestorage.com,
	randyj@purestorage.com,
	adailey@purestorage.com,
	Surabhi Gogte <sgogte@purestorage.com>
Subject: [PATCH v3 0/2] nvme-rdma: parallelize I/O queue setup
Date: Thu, 25 Jun 2026 15:27:20 -0600
Message-ID: <20260625212722.1302344-1-sgogte@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260625_142734_908373_B27A25B4 
X-CRM114-Status: GOOD (  11.99  )
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

Surabhi Gogte (2):
  nvme-rdma: refactor nvme_rdma_alloc_queue() to take a queue pointer
  nvme-rdma: parallelize I/O queue allocation and startup

 drivers/nvme/host/rdma.c | 135 ++++++++++++++++++++++++---------------
 1 file changed, 82 insertions(+), 53 deletions(-)

--
2.54.0


