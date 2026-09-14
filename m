Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47587C88E6A
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Sep 2026 07:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zSyANMjgY1acC02moYrYonIvXnr8t8tiTx/dGGiUuuQ=; b=JDJyma0lVhVkmowQlCQw7hK/Yc
	RTJ44xVQK07FkOkBhk72v2/a7YKclQRFgAhKTyxwuj+YimFWKAc1AnfUA71iZnCHlUnju+PFyvhhb
	oP80aKVkE0klsxhVRvgjpS3W9ZkmTWh+Rkx3loVjPOSKpCsNf5L3jXYfdRqzkH4tP+32vmKuuCx9n
	MEwcCs0kbCcPrEkHdmFe/G/nEG9C+3Or+OJjWYMe4/C2VMRC7lr7k9Tt5SK6Kn4Nu+zatYWwh6W2i
	qJQ7SVjE7+pwQQZr6h/ABAfemUOukgKsjFvtq8dDnQii8fsQAYNjnCyvybHYnyTcXjH4x1JbaO8mb
	QyvQQ4pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x61RD-00000002cR5-33rd;
	Mon, 14 Sep 2026 07:49:15 +0000
Received: from esa6.hgst.iphmx.com ([216.71.154.45])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x61R9-00000002cP3-3JE9
	for linux-nvme@lists.infradead.org;
	Mon, 14 Sep 2026 07:49:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1789372151; x=1820908151;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ag2E5x+JrHlSwHLkLvFHFQIoHkplx3QQBuohhb3GGEU=;
  b=eow9dPEirRBJlHlevLAhvDayh/0gkSJKwvZMgoZyu2yVYfYMrRHd2ufs
   if90m8vBiIWvBoM9PtdvG+NDkMSCW/D9litDkuVD5jv1SBHvY1QEvLs9R
   yPjV55Qq4DY2G93geRJDoly5sonE7Lo6TDVYemCPbaem9WOhMfhQd/Tp+
   DQChKV+8Z947qV8KjdAYPRbeTXU3fXJV2r68qXZU3VBfTggJT+jt57K1O
   ZBLROr4fhJD1S47/lVhEgc3uT619wxT/GYcLxtcBULpePXtLV+VFSmBry
   f0GTey2eGC07t6mdUtL/AiiuVtGy7PE1M2skQQMvCPbv7aCbvlf9JpUM2
   w==;
X-CSE-ConnectionGUID: HePZvxu1SX+rel4dCAjyPA==
X-CSE-MsgGUID: k9Zrr08gQoObbyMpi/lw1Q==
X-IronPort-AV: E=Sophos;i="6.27,102,1786982400"; 
   d="scan'208";a="154022891"
Received: from unknown (HELO uls-op-esad3-o.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 14 Sep 2026 15:49:08 +0800
X-CSE-ConnectionGUID: JUgi0U0OTxiuCW+7cWRHWg==
X-CSE-MsgGUID: MA0w6txySFyC0x6GTuDSYw==
IronPort-SDR: 6aa7a6eb_XRoO6N8oJQHtEDL2EHNRHvgE9VAZPgcpixpQnCbwkhfwa8H
 oMSaLPhMdGHYiwzuu12x0/1DQX8dREQLDDm7uYg==
Received: from uls-op-esai1-o.wdc.com ([10.248.3.45])
  by uls-op-esad3-o.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Sep 2026 00:48:59 -0700
X-CSE-ConnectionGUID: +M1pku1VTseZuBxJBI9slA==
X-CSE-MsgGUID: 2kXrOB3VTc6ctDU8dFD7nw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.67.30])
  by uls-op-esai1-o.wdc.com with ESMTP; 14 Sep 2026 00:48:57 -0700
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@opensource.wdc.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Dumazet <edumazet@google.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH 2/2] nvme-tcp: delay nvme_tcp_reclassify_socket()
Date: Mon, 14 Sep 2026 16:48:53 +0900
Message-ID: <20260914074853.3990397-3-shinichiro.kawasaki@opensource.wdc.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
References: <20260914074853.3990397-1-shinichiro.kawasaki@opensource.wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260914_004911_884578_99FC89B1 
X-CRM114-Status: GOOD (  16.61  )
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

From: Eric Dumazet <edumazet@google.com>

Commit 841aee4d75f1 ("nvme-tcp: lockdep: annotate in-kernel sockets")
introduced nvme_tcp_reclassify_socket() to resolve a lockdep WARN by
distinguishing userspace sockets from nvme-tcp sockets. After that, TLS
encryption support was introduced to nvme-tcp and it added another lock
dependency on userspace socket handling by tlshd, which resulted in a
new lockdep WARN. This WARN was hidden by the commit 19bdb70c77d3
("nvme-tcp: lockdep: use dynamic lockdep keys per socket instance").
However, it turned out the commit 19bdb70c77d3 has a bug of lockdep key
lifetime management, and it is to be reverted by another patch in this
series. After the revert, the WARN was unveiled and observed at the
blktests test case nvme/062:

  WARNING: possible circular locking dependency detected
  7.3.0-rc2+ #455 Tainted: G        W
  ------------------------------------------------------
  tlshd/75867 is trying to acquire lock:
  ffffffff91ada5e0 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_cache_noprof+0x64/0x6d0

  but task is already holding lock:
  ffff888197808258 (sk_lock-AF_INET-NVME){+.+.}-{0:0}, at: do_tcp_setsockopt+0x499/0x26a0

  which lock already depends on the new lock.

To fix the lockdep WARN caused by the TLS encryption support, delay the
reclassification of the nvme-tcp sockets. Currently the reclassification
happens before the TLS handshake starts, which pulls in the additional
lock dependencies related to tlshd. Reclassify the sockets after the TLS
handshake instead, to cut that dependency.

Link: https://lore.kernel.org/lkml/CANn89i+wnTLC==UnXCpjsS4YxvEfhe5oK0N7fttbqr1zKyqdug@mail.gmail.com/
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
 drivers/nvme/host/tcp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 0666bb469c0a..7eec983c0ead 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1869,7 +1869,6 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 	}
 
 	sk_net_refcnt_upgrade(queue->sock->sk);
-	nvme_tcp_reclassify_socket(queue->sock);
 
 	/* Single syn retry */
 	tcp_sock_set_syncnt(queue->sock->sk, 1);
@@ -1958,6 +1957,8 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 			goto err_init_connect;
 	}
 
+	nvme_tcp_reclassify_socket(queue->sock);
+
 	ret = nvme_tcp_init_connection(queue);
 	if (ret)
 		goto err_init_connect;
-- 
2.54.0


