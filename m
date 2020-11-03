Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59B19C388F2
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 01:29:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF122222B
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 01:29:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="hEv7+AmX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3u1iTaZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF122222B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=I76nMM4Vz1FDwSY/hrL5WUisn+STsHXQLjkg4kuGA20=; b=hEv7+AmXxheb2/9m+N/akile2
	AS5FJ5eWJSoFZOOOQOD1NFgZnTRGQ0sQ5wRiUv5A1nX51pCjW6PXdQW/aWDpys7vXRuAWL3G0MnT0
	DDpz50oiFGK/02ls5WiLL6flNflPXx3MzkTasGO8tGuOfqWAZp71aAxmWok3mKmFCZEtFZnvTJbk7
	VHzPb1hiX3tD57lrPLccmVvKQUzxAWkQjN5q16dBm1qi7X0ykiqcXC6wCy29IZVZNEo1dSiYaWvMW
	6whMd77+vzkhoZvKQpQCBOZnsvtpYiEHmnky6tQ8ZPWPrbsNIVcMUhTNsoI/SQD4lSeLp5GbXbadQ
	vmaBeZ2TQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZl8D-0001YH-Ha; Tue, 03 Nov 2020 01:29:05 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZkzx-0005bg-46
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 01:20:36 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C37D222453;
 Tue,  3 Nov 2020 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1604366430;
 bh=aA8e9Bb/bGjP79dUDBE23SvgQ+7Zz95nL9u23Kqa3X8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=u3u1iTaZWYhCa4Pe6krjwzGcMwZqCFT5zeXISX5NUrpyGGXSHIaCX/wYIo4Usz1G1
 b1ucW8uuaSIJ20PQxPEputQ7Rf/kGeQ9XNOcJC2ONfrVZkGSlIINKVGkL1so6KE92R
 O/hGN9Rymq0YrRECd6NuCBNJptCU8BTD3ovDpCkg=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 17/24] nvme-rdma: handle unexpected nvme
 completion data length
Date: Mon,  2 Nov 2020 20:20:00 -0500
Message-Id: <20201103012007.183429-17-sashal@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201103012007.183429-1-sashal@kernel.org>
References: <20201103012007.183429-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201102_202034_729749_79A64D22 
X-CRM114-Status: GOOD (  15.36  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Sagi Grimberg <sagi@grimberg.me>, zhenwei pi <pizhenwei@bytedance.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: zhenwei pi <pizhenwei@bytedance.com>

[ Upstream commit 25c1ca6ecaba3b751d3f7ff92d5cddff3b05f8d0 ]

Receiving a zero length message leads to the following warnings because
the CQE is processed twice:

refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 0 at lib/refcount.c:28

RIP: 0010:refcount_warn_saturate+0xd9/0xe0
Call Trace:
 <IRQ>
 nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
 __ib_process_cq+0x76/0x150 [ib_core]
 ...

Sanity check the received data length, to avoids this.

Thanks to Chao Leng & Sagi for suggestions.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index abe4fe496d05c..cb5aecb018901 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1520,6 +1520,14 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
+	/* sanity checking for received data length */
+	if (unlikely(wc->byte_len < len)) {
+		dev_err(queue->ctrl->ctrl.device,
+			"Unexpected nvme completion length(%d)\n", wc->byte_len);
+		nvme_rdma_error_recovery(queue->ctrl);
+		return;
+	}
+
 	ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
 	/*
 	 * AEN requests are special as they don't time out and can
-- 
2.27.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
