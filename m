Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D5606A89A
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Nov 2026 13:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=pbtPDlMn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=/nt+I/GfSYLIDlAc5SHc+b+HtXRxCdI0A5JmNuCP6hA=; b=pbtPDlMnNdFnSU1OPOVvQQRtY0
	6IDMVvlahkh9z8mLQ79TqOqrWihhK+chNEVz6ppLGeBrOI0z9Vgv57Mp/Psrpyowsrz99Dcc7zXcc
	6IHifXlIFWPgiflqeGwcN1dieGzThlZTVdw532NPhnTrXPw90EaYOgVPnar69vo9uKFGuBUDLDA0R
	5OHJB/cxjYNbFKgqenQsfhVTfCvhofPPVHiEbfS2w0nTxgcSpqhQusB7HGCxzi2qgMs2lZ9iJM9Gu
	Gg4AoRpIjeV0OwIYGKq1/xihIRQh/jU2xAenDpoVvDZLG0FP5z6YGoSsIrL9e7ck5lHbBkgW/sS8v
	Fx7DqhOQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIvP-00000005qkf-2FJ1;
	Tue, 17 Nov 2026 13:08:39 +0000
Received: from dggmsgout13.his.huawei.com ([124.71.94.104])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xTIv8-00000005qN1-0Uet
	for linux-nvme@lists.infradead.org;
	Tue, 17 Nov 2026 13:08:38 +0000
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggmsgout13.his.huawei.com (SkyGuard) with ESMTP id 4jTQ4R31Klz1rqZB
	for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 21:07:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 0FD504056B
	for <linux-nvme@lists.infradead.org>; Tue, 17 Nov 2026 21:08:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.136])
	by APP4 (Coremail) with UTF8SMTPSA id gCh0CgB3tfSfUfxqGBHaEg--.61707S4;
	Tue, 17 Nov 2026 21:08:09 +0800 (CST)
From: Hou Tao <houtao@huaweicloud.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Kanchan Joshi <joshi.k@samsung.com>,
	houtao1@huawei.com,
	xierenfeng@huawei.com
Subject: [PATCH] nvme-pci: handle the missed doorbell write due to passthrough req
Date: Tue, 17 Nov 2026 21:07:43 +0800
Message-Id: <20261117130743.2871972-1-houtao@huaweicloud.com>
X-Mailer: git-send-email 2.29.2
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgB3tfSfUfxqGBHaEg--.61707S4
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr1xZFy7uFWrZrykJw43KFg_yoW8WF4kpF
	WrWFyYkF93KF4xta4UJa17Za4Yq3WrGrWxJFWfGw1avr13KrWY9r4rK3WjvF4rXr4v93y3
	Xr45A3W7Cr15CFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyGb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7Cj
	xVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1hSdDUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261117_050822_892804_3D96B4E2 
X-CRM114-Status: GOOD (  11.15  )
X-Spam-Score: -1.9 (-)
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
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Hou Tao <houtao1@huawei.com>

Commit 1cc4cdae2a3b ("nvme-pci: fix missed admin queue sq doorbell
write") lets blk-mq invoke ->commit_rqs when nvme_queue_rq returns
failure or there are still pending requests in the dispatch list.
However, it doesn't handle the case when only passthrough reqs are
queued after the req initiated from nvme_init_ctrl_finish().
nvme_queue_rq() will return BLK_STS_OK for these passthrough reqs due to
REQ_FAILFAST_DRIVER flag, and the controller reset will fail.

Fix it by invoking nvme_commit_rqs when nvme_queue_rq() returns
BLK_STS_OK and bd->last is true.

Fixes: 1cc4cdae2a3b ("nvme-pci: fix missed admin queue sq doorbell write")
Reported-by: Xie Renfeng <xierenfeng@huawei.com>
Signed-off-by: Hou Tao <houtao1@huawei.com>
---
 drivers/nvme/host/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 18b3f1b8541c..c7f6f7989168 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1676,8 +1676,12 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (unlikely(!test_bit(NVMEQ_ENABLED, &nvmeq->flags)))
 		return BLK_STS_IOERR;
 
-	if (unlikely(!nvme_check_ready(&dev->ctrl, req, true)))
-		return nvme_fail_nonready_command(&dev->ctrl, req);
+	if (unlikely(!nvme_check_ready(&dev->ctrl, req, true))) {
+		ret = nvme_fail_nonready_command(&dev->ctrl, req);
+		if (ret == BLK_STS_OK && bd->last)
+			nvme_commit_rqs(hctx);
+		return ret;
+	}
 
 	ret = nvme_prep_rq(req);
 	if (unlikely(ret))
-- 
2.29.2


