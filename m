Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A33BC98302
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 02:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=H//0L15NF9Hg36hxkG5YrT92KjkouCTlUR4u5ZBrdks=; b=xmwKfmJE7grCKDN9+yRy1Egu+E
	59dgXxwcBauTs7x+LJOnw9eGjdIA1D5kkmtCPDPSqJ64nq2Q2JnOEPqcIvrafLkeTZ7pTtRd3wIKd
	JH2rgR1rr33729pcfOhiMH0HIy8Vqul2uuT1XaF4MjIJMXTzQ9q0GeTmR931iLNzJApG85xySbolp
	htSKS2PAK55ocIPts+mW0JDLS6LPRQlahe69hKamf2p9XeghL7QKyuZLGZ7pi09tKaPfQV7u4WMaO
	XVrSo8RGMERH4Jimr2R4iRsg7ozpA+V1tfNHcJbNRjodPl/G2nh9WM1GKyCdAM+6A6biC4oNkbxit
	BSZLWv5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9CeJ-00000006vaj-2Zd9;
	Wed, 23 Sep 2026 02:23:55 +0000
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net ([162.243.161.220])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9CeF-00000006va8-0BGY;
	Wed, 23 Sep 2026 02:23:53 +0000
Received: from zju.edu.cn (unknown [10.98.66.117])
	by mtasvr (Coremail) with SMTP id _____wB3migtOLNq4vsvAQ--.4161S3;
	Wed, 23 Sep 2026 10:23:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.98.66.117])
	by mail-app4 (Coremail) with SMTP id zi_KCgAH7DQtOLNqzObNAw--.61111S2;
	Wed, 23 Sep 2026 10:23:41 +0800 (CST)
From: Fan Wu <fanwu01@zju.edu.cn>
To: Sven Peter <sven@kernel.org>,
	Janne Grunau <j@jannau.net>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Neal Gompa <neal@gompa.dev>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	Song Li <songl@zju.edu.cn>
Subject: [PATCH] nvme: apple: don't unbind the driver on reset failure
Date: Wed, 23 Sep 2026 02:22:46 +0000
Message-Id: <20260923022246.396036-1-fanwu01@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: zi_KCgAH7DQtOLNqzObNAw--.61111S2
X-CM-SenderInfo: qrstjiaswqq6lmxovvfxof0/
X-CM-DELIVERINFO: =?B?o5En3QXKKxbFmtjJiESix3B1w3vZ3A9ovKVTomAyoQazvoRs/NHSP8GI2EvgeEEW7R
	sfnXz+g1OQfMo27QHy5TwQyZx14AC2V9q43cqIiEB7VCKWQgzTF47xQDkI8NAgYzF2bFu/
	H+AHJg4+1EcSoEokfq2p9E6mavGmQbzmcFsnzP86
X-Coremail-Antispam: 1Uk129KBj93XoWxZF18CFWxCry8tw43JFWftFc_yoW5Wr1kpF
	4rWasI9rZrWr1Dtr1UJr4DuF98uw1fJryUJryIgw4rur1FqryrZ3s8KFyY9FW5Ar9Yva13
	ZFWrJw15CF1kJFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6x
	kI12xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v2
	6r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2
	Ij64vIr41lF7xvr2IYc2Ij64vIr40E4x8a64kEw24lFIxGxcIEc7CjxVA2Y2ka0xkIwI1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7gAwDUUUU
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_192351_212744_FA0F6ECB 
X-CRM114-Status: UNSURE (   9.90  )
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

When apple_nvme_reset_work() fails it queues anv->remove_work, whose
callback apple_nvme_remove_dead_ctrl_work() unbinds the driver through
device_release_driver(). The work is embedded in the devm-allocated
apple_nvme, but apple_nvme_remove() only flushes ctrl.reset_work, so an
external unbind while the work is pending frees anv through
devres_release_all() before the callback runs, and it operates on freed
memory.

Fix this by not unbinding from a work item at all, mirroring commit
c7c16c5b1967 ("nvme-pci: don't unbind the driver on reset failure"):
on reset failure, disable the controller, mark the namespaces dead and
leave the controller in the dead state instead of queueing the deferred
unbind. The device stays bound and can be recovered by unbinding and
rebinding the driver. apple_nvme_disable() is now passed shutdown=true,
as in the final disable in apple_nvme_remove(), so entered requests are
completed.

Draining the work from apple_nvme_remove() is not an option: that path
holds the device lock the callback blocks on, so waiting would deadlock.

This issue was found by an in-house static analysis tool.

Fixes: 5bd2927aceba ("nvme-apple: Add initial Apple SoC NVMe driver")
Cc: stable@vger.kernel.org
Co-developed-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Song Li <songl@zju.edu.cn>
Signed-off-by: Fan Wu <fanwu01@zju.edu.cn>
---
 drivers/nvme/host/apple.c | 2 insertions(+), 15 deletions(-)

--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -193,7 +193,6 @@
 	mempool_t *iod_mempool;
 
 	struct nvme_ctrl ctrl;
-	struct work_struct remove_work;
 
 	struct apple_nvme_queue adminq;
 	struct apple_nvme_queue ioq;
@@ -1224,20 +1223,9 @@
 out:
 	dev_warn(anv->ctrl.device, "Reset failure status: %d\n", ret);
 	nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_DELETING);
-	nvme_get_ctrl(&anv->ctrl);
-	apple_nvme_disable(anv, false);
+	apple_nvme_disable(anv, true);
 	nvme_mark_namespaces_dead(&anv->ctrl);
-	if (!queue_work(nvme_wq, &anv->remove_work))
-		nvme_put_ctrl(&anv->ctrl);
-}
-
-static void apple_nvme_remove_dead_ctrl_work(struct work_struct *work)
-{
-	struct apple_nvme *anv =
-		container_of(work, struct apple_nvme, remove_work);
-
-	nvme_put_ctrl(&anv->ctrl);
-	device_release_driver(anv->dev);
+	nvme_change_ctrl_state(&anv->ctrl, NVME_CTRL_DEAD);
 }
 
 static int apple_nvme_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
@@ -1531,7 +1519,6 @@
 	}
 
 	INIT_WORK(&anv->ctrl.reset_work, apple_nvme_reset_work);
-	INIT_WORK(&anv->remove_work, apple_nvme_remove_dead_ctrl_work);
 	spin_lock_init(&anv->lock);
 
 	ret = apple_nvme_queue_alloc(anv, &anv->adminq);
-- 
2.39.5


