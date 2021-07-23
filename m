Return-Path: <SRS0=kg3i=MP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE79BC4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 03:58:30 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD68660F49
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jul 2021 03:58:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AD68660F49
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=AeCbxOzmfvos4Af0xHBIqnCyrCIMr6nh+FxquXGfYEs=; b=wMH0g0+fEUwKNB
	7B3uuF1FfbulXcT53cku4AmT0XCyPcmJIA7Qc7Q9b97RhzdFr/2MtknAIpMsSa3BVgbUM75M2LsJz
	nA/MNMSYvGNriqi8tldP4uxLRnP++8rW6Bae9Ad9lr6oLLHOioy2SkjdVp+ZjTIlh3oLQUrVN67B+
	H4rj6DuMbSOb4SG7AzkjuIDj9zCBgmICw1rIcnxxhi8t9nzYaLkwNw1U1Fh/Ymufz6W3ZV8/nM8nr
	+Xxeb8EC9fy6z2wedzfrQByHX0S4rGnofB18zpAy3XHXWuzIIfpCDiztjgjh13azMyWdvt95gkuiL
	BHqsXiKSML5w1uX1fNbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m6mJc-003Cl9-Ch; Fri, 23 Jul 2021 03:57:36 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m6mJY-003Cjb-MQ
 for linux-nvme@lists.infradead.org; Fri, 23 Jul 2021 03:57:34 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E32B60E9C;
 Fri, 23 Jul 2021 03:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627012652;
 bh=fHoJD2nmeHTB7HukJvxAs42kgkhwb5agKiJFkm9nR1s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=E8nFfw3wHdcyeZFo+N6PbdV5EcuEnydYAMHPEkBNgV3DU/EFf9sVnYv/BTF3uCthV
 9+PCWKuQjoHv6whnLHGV1huMwq12wLUcZHdbuc9wk2LydTyDlmpWgBAfAPhRFMk6Up
 aTmNXg8bnVyN1fS+jD6t6TXG4CEwhPM+o0D/i3rc2dq7gnJK68FrL0t+LN/mTWL+JJ
 4vB1PSOgzW5zKKtFehZjOxxmA0KFGlssXEDw4cfq20u7SA2o2CatP9c254TGg7jgmY
 jsDaHS1iQ/fdEl5TsoUQ/iTs1UgXXVVvkPaCG+23q4UYrmUmu1wQn0+gGajcfKzI9u
 9EPdQtioFAqMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Casey Chen <cachen@purestorage.com>,
 Yuanyuan Zhong <yzhong@purestorage.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.13 08/19] nvme-pci: fix multiple races in
 nvme_setup_io_queues
Date: Thu, 22 Jul 2021 23:57:09 -0400
Message-Id: <20210723035721.531372-8-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210723035721.531372-1-sashal@kernel.org>
References: <20210723035721.531372-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210722_205732_824329_362AB253 
X-CRM114-Status: GOOD (  21.59  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Casey Chen <cachen@purestorage.com>

[ Upstream commit e4b9852a0f4afe40604afb442e3af4452722050a ]

Below two paths could overlap each other if we power off a drive quickly
after powering it on. There are multiple races in nvme_setup_io_queues()
because of shutdown_lock missing and improper use of NVMEQ_ENABLED bit.

nvme_reset_work()                                nvme_remove()
  nvme_setup_io_queues()                           nvme_dev_disable()
  ...                                              ...
A1  clear NVMEQ_ENABLED bit for admin queue          lock
    retry:                                       B1  nvme_suspend_io_queues()
A2    pci_free_irq() admin queue                 B2  nvme_suspend_queue() admin queue
A3    pci_free_irq_vectors()                         nvme_pci_disable()
A4    nvme_setup_irqs();                         B3    pci_free_irq_vectors()
      ...                                            unlock
A5    queue_request_irq() for admin queue
      set NVMEQ_ENABLED bit
      ...
      nvme_create_io_queues()
A6      result = queue_request_irq();
        set NVMEQ_ENABLED bit
      ...
      fail to allocate enough IO queues:
A7      nvme_suspend_io_queues()
        goto retry

If B3 runs in between A1 and A2, it will crash if irqaction haven't
been freed by A2. B2 is supposed to free admin queue IRQ but it simply
can't fulfill the job as A1 has cleared NVMEQ_ENABLED bit.

Fix: combine A1 A2 so IRQ get freed as soon as the NVMEQ_ENABLED bit
gets cleared.

After solved #1, A2 could race with B3 if A2 is freeing IRQ while B3
is checking irqaction. A3 also could race with B2 if B2 is freeing
IRQ while A3 is checking irqaction.

Fix: A2 and A3 take lock for mutual exclusion.

A3 could race with B3 since they could run free_msi_irqs() in parallel.

Fix: A3 takes lock for mutual exclusion.

A4 could fail to allocate all needed IRQ vectors if A3 and A4 are
interrupted by B3.

Fix: A4 takes lock for mutual exclusion.

If A5/A6 happened after B2/B1, B3 will crash since irqaction is not NULL.
They are just allocated by A5/A6.

Fix: Lock queue_request_irq() and setting of NVMEQ_ENABLED bit.

A7 could get chance to pci_free_irq() for certain IO queue while B3 is
checking irqaction.

Fix: A7 takes lock.

nvme_dev->online_queues need to be protected by shutdown_lock. Since it
is not atomic, both paths could modify it using its own copy.

Co-developed-by: Yuanyuan Zhong <yzhong@purestorage.com>
Signed-off-by: Casey Chen <cachen@purestorage.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 66 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 58 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 42ad75ff1348..1e704c63f1e2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1562,6 +1562,28 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	wmb(); /* ensure the first interrupt sees the initialization */
 }
 
+/*
+ * Try getting shutdown_lock while setting up IO queues.
+ */
+static int nvme_setup_io_queues_trylock(struct nvme_dev *dev)
+{
+	/*
+	 * Give up if the lock is being held by nvme_dev_disable.
+	 */
+	if (!mutex_trylock(&dev->shutdown_lock))
+		return -ENODEV;
+
+	/*
+	 * Controller is in wrong state, fail early.
+	 */
+	if (dev->ctrl.state != NVME_CTRL_CONNECTING) {
+		mutex_unlock(&dev->shutdown_lock);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 {
 	struct nvme_dev *dev = nvmeq->dev;
@@ -1590,8 +1612,11 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 		goto release_cq;
 
 	nvmeq->cq_vector = vector;
-	nvme_init_queue(nvmeq, qid);
 
+	result = nvme_setup_io_queues_trylock(dev);
+	if (result)
+		return result;
+	nvme_init_queue(nvmeq, qid);
 	if (!polled) {
 		result = queue_request_irq(nvmeq);
 		if (result < 0)
@@ -1599,10 +1624,12 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid, bool polled)
 	}
 
 	set_bit(NVMEQ_ENABLED, &nvmeq->flags);
+	mutex_unlock(&dev->shutdown_lock);
 	return result;
 
 release_sq:
 	dev->online_queues--;
+	mutex_unlock(&dev->shutdown_lock);
 	adapter_delete_sq(dev, qid);
 release_cq:
 	adapter_delete_cq(dev, qid);
@@ -2176,7 +2203,18 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (nr_io_queues == 0)
 		return 0;
 
-	clear_bit(NVMEQ_ENABLED, &adminq->flags);
+	/*
+	 * Free IRQ resources as soon as NVMEQ_ENABLED bit transitions
+	 * from set to unset. If there is a window to it is truely freed,
+	 * pci_free_irq_vectors() jumping into this window will crash.
+	 * And take lock to avoid racing with pci_free_irq_vectors() in
+	 * nvme_dev_disable() path.
+	 */
+	result = nvme_setup_io_queues_trylock(dev);
+	if (result)
+		return result;
+	if (test_and_clear_bit(NVMEQ_ENABLED, &adminq->flags))
+		pci_free_irq(pdev, 0, adminq);
 
 	if (dev->cmb_use_sqes) {
 		result = nvme_cmb_qdepth(dev, nr_io_queues,
@@ -2192,14 +2230,17 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		result = nvme_remap_bar(dev, size);
 		if (!result)
 			break;
-		if (!--nr_io_queues)
-			return -ENOMEM;
+		if (!--nr_io_queues) {
+			result = -ENOMEM;
+			goto out_unlock;
+		}
 	} while (1);
 	adminq->q_db = dev->dbs;
 
  retry:
 	/* Deregister the admin queue's interrupt */
-	pci_free_irq(pdev, 0, adminq);
+	if (test_and_clear_bit(NVMEQ_ENABLED, &adminq->flags))
+		pci_free_irq(pdev, 0, adminq);
 
 	/*
 	 * If we enable msix early due to not intx, disable it again before
@@ -2208,8 +2249,10 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	pci_free_irq_vectors(pdev);
 
 	result = nvme_setup_irqs(dev, nr_io_queues);
-	if (result <= 0)
-		return -EIO;
+	if (result <= 0) {
+		result = -EIO;
+		goto out_unlock;
+	}
 
 	dev->num_vecs = result;
 	result = max(result - 1, 1);
@@ -2223,8 +2266,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	 */
 	result = queue_request_irq(adminq);
 	if (result)
-		return result;
+		goto out_unlock;
 	set_bit(NVMEQ_ENABLED, &adminq->flags);
+	mutex_unlock(&dev->shutdown_lock);
 
 	result = nvme_create_io_queues(dev);
 	if (result || dev->online_queues < 2)
@@ -2233,6 +2277,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	if (dev->online_queues - 1 < dev->max_qid) {
 		nr_io_queues = dev->online_queues - 1;
 		nvme_disable_io_queues(dev);
+		result = nvme_setup_io_queues_trylock(dev);
+		if (result)
+			return result;
 		nvme_suspend_io_queues(dev);
 		goto retry;
 	}
@@ -2241,6 +2288,9 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 					dev->io_queues[HCTX_TYPE_READ],
 					dev->io_queues[HCTX_TYPE_POLL]);
 	return 0;
+out_unlock:
+	mutex_unlock(&dev->shutdown_lock);
+	return result;
 }
 
 static void nvme_del_queue_end(struct request *req, blk_status_t error)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
