Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61799D6E2A4
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Nov 2024 10:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XftiLEbSkAxfWv6CEZMioYXkmt8BWkrgDvdvMO8qR+g=; b=y3w5H126NdVWUN7pdHF0SJp3dC
	CIe/svGDs1TtP3Cz0vBjE0Wbc7JPt6zrknINKoxsnzaJZ61C/Yqizba/xkpmEI40dFTq1DcYJE+CL
	hGVPX7P4Ws4fj4zQo8tRK9ebTtXLWb4l7YtR5P/YwzR35rPeOH6i/HFd3PqvGw8bD3MQmOV33QUQx
	8Dt+joMHuwbwKSscpqDjcNs3x8gThluAg97g+3JOSR04dik9H3y1zLPqL3JjGxWFHhWpW+JaYiuYz
	29s5Vl0D+uJwanBPYp2yjsro1V3RlBBTUjrWg7dEksBktsZcx0YmXBLpI7ISSqtM5UYyPC6j9iJ8A
	XFuKr1iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tE4N2-0000000HMDt-0bnS;
	Thu, 21 Nov 2024 10:25:08 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tE4Mz-0000000HMBk-1eAj
	for linux-nvme@lists.infradead.org;
	Thu, 21 Nov 2024 10:25:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732184700; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XftiLEbSkAxfWv6CEZMioYXkmt8BWkrgDvdvMO8qR+g=;
	b=Qsi4T2nwphG+9U4c3o0YtGH9Rl97//GLheTtxrLD2tMHBa6O7f6Jx77devXSXHLKoTo/P137GZfOqwbKontwI0/d+q2taOD/JWKbvQt8/Axd/pndZjIVMBDGR887KkxGDxJ8q4Wd4LZDelsFYblYjCzrYmjZ6MJJS/btkgE2LVo=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0WJwjaX0_1732184694 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 21 Nov 2024 18:24:59 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: handle rw's limited retry flag
Date: Thu, 21 Nov 2024 18:24:54 +0800
Message-ID: <20241121102454.122247-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241121_022505_908467_321FE94C 
X-CRM114-Status: UNSURE (   8.02  )
X-CRM114-Notice: Please train this message.
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

When the nvme target receive an rw command with limited retry flag,
handle it in block backend by setting the REQ_FAILFAST_DEV flag to
bio.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0bda83d0fc3e..6380b60fd490 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -272,6 +272,9 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		iter_flags = SG_MITER_FROM_SG;
 	}
 
+	if (req->cmd->rw.control & NVME_RW_LR)
+		opf |= REQ_FAILFAST_DEV;
+
 	if (is_pci_p2pdma_page(sg_page(req->sg)))
 		opf |= REQ_NOMERGE;
 
-- 
2.43.0


