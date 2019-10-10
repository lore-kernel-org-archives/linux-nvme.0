Return-Path: <SRS0=Uo3O=YD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E833EC4360C
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:57:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEF51214E0
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Oct 2019 16:57:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="cjKLNF9f";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1yMZI1V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF51214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EX/owtAaHpsXGDVlo469Eh6wWNwwjQiMZ+t3pb5sFZI=; b=cjKLNF9fyt40Py
	JjgpdRhs8xavwxDWwmK8tdHOuxYyEyogxM6CWMsf+38X0eREb/41iGiC+ANexqQu6VDBmBPIUaSar
	nWMz7pRuTcKoBETPKVbvJXwO4ji35w65QSy7HHiJkO9GA5LMFauTeMfjSA4p5hCi0h6UkdZ74FhvA
	DurYYzhQBREieoL9yeQBFs2uZbvgmjwrg3palQVP0JZgWlf8kFMdw5bDSBlnFsBgAinfV8jmp4p2z
	bmHA0+Hd09qQoZ6mWPmZSV0HOlo/MMU9QgbvMs+LG9EPfQY3dilOuzHT7BPGDDJOYJqnNG0z8DzBi
	jRcohQkIDvnaPVe9Stgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iIbl5-0008Cz-GC; Thu, 10 Oct 2019 16:57:47 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iIbl0-00088K-P5
 for linux-nvme@lists.infradead.org; Thu, 10 Oct 2019 16:57:44 +0000
Received: from washi1.fujisawa.hgst.com (unknown [199.255.47.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 5589A218AC;
 Thu, 10 Oct 2019 16:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570726662;
 bh=EOHZNc6gHYNoQOR7NOwbzGCfVUx1RzLP43J4E2zRVDA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Y1yMZI1Vy3tomw8AVLjvEXfBx5qXmv/o7ut1VfQyJYbhi6TEkaQe14CfbUubKBzam
 J2XH5XmWHRpNPUL0+SPsgX4WOXMkmffgvAKBmBqDeGZZpFW7+h94mfyokXMlgeR9rL
 WlvJHlUShTHujfFcVwksunkrIm8l5Fs/Dxcq4rfw=
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCHv4 1/5] nvme-pci: Free tagset if no IO queues
Date: Fri, 11 Oct 2019 01:57:32 +0900
Message-Id: <20191010165736.12081-2-kbusch@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191010165736.12081-1-kbusch@kernel.org>
References: <20191010165736.12081-1-kbusch@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191010_095742_834695_A730815F 
X-CRM114-Status: GOOD (  12.78  )
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
Cc: Keith Busch <kbusch@kernel.org>, Judy Brock <judy.brock@samsung.com>,
 Edmund Nadolski <edmund.nadolski@intel.com>,
 James Smart <james.smart@broadcom.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

If a controller becomes degraded after a reset, we will not be able to
perform any IO. We currently teardown previously created request
queues and namespaces, but we had kept the unusable tagset. Free
it after all queues using it have been released.

Reviewed-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/nvme/host/pci.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bb88681f4dc3..fe24a02aa213 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2490,14 +2490,20 @@ static void nvme_release_prp_pools(struct nvme_dev *dev)
 	dma_pool_destroy(dev->prp_small_pool);
 }
 
+static void nvme_free_tagset(struct nvme_dev *dev)
+{
+	if (dev->tagset.tags)
+		blk_mq_free_tag_set(&dev->tagset);
+	dev->ctrl.tagset = NULL;
+}
+
 static void nvme_pci_free_ctrl(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
 
 	nvme_dbbuf_dma_free(dev);
 	put_device(dev->dev);
-	if (dev->tagset.tags)
-		blk_mq_free_tag_set(&dev->tagset);
+	nvme_free_tagset(dev);
 	if (dev->ctrl.admin_q)
 		blk_put_queue(dev->ctrl.admin_q);
 	kfree(dev->queues);
@@ -2616,6 +2622,7 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
+		nvme_free_tagset(dev);
 	} else {
 		nvme_start_queues(&dev->ctrl);
 		nvme_wait_freeze(&dev->ctrl);
-- 
2.21.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
