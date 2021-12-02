Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BDC5C433F5
	for <linux-nvme@archiver.kernel.org>; Thu,  2 Dec 2021 03:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IoAOzQu199jitCRpPWpeDUIrsMhEQLhTqV1OeHiWJ3k=; b=3W1JwsdA/dT814BjQySx0n2gdx
	iovVpQTKRUnmVwoUWeawqk640zZl9aeRU+mTGZBk6nwp3eXilRKA/7CQaiWayvnKpHXZOra5nb4N3
	leJkBSZebUW9z3gm5cjIT0ShGBoV/7RD3SBV8/UY5CTrokekxbJP3Di+9FbHzIlJSxlbo3CvVzX87
	IUkDBt4rb/8VxLXByu3cjfFEeBt1H5ozVr6SeG7AYQkUsuTQ0c9tBz3Quct4Bvt6DKUicu9X58B3q
	BT0Qwd5/Z+jyxmhgfsm3MrXdIJme5AIcvtQ7CRfED8akcyk7XQRH7Uw/T41eEiZMd98X86z+4Po6t
	dMT03UjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mscNG-00AfD3-PF; Thu, 02 Dec 2021 03:03:06 +0000
Received: from smtpbg511.qq.com ([203.205.250.109])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mscNB-00Af9U-Ef
 for linux-nvme@lists.infradead.org; Thu, 02 Dec 2021 03:03:06 +0000
X-QQ-mid: bizesmtp36t1638414159t1g4ankc
Received: from localhost.localdomain (unknown [113.200.76.118])
 by esmtp6.qq.com (ESMTP) with 
 id ; Thu, 02 Dec 2021 11:02:32 +0800 (CST)
X-QQ-SSF: 01400000002000B0D000B00A0000000
X-QQ-FEAT: Jd++W0FxedHXR/8SxplsRCSONu04WlhnpdS3bDtQlCiQefp9Bb9KcJBcezXMY
 GvtzunS+MkiTlnT+7IN1ZqXG0HERGqzXFyZuFOETy7P0Nw+a5tfdgQBI1RHT3i1ZJKKrvOu
 xPM/PL6EKzvITjDmuuh4tFQIIy2u6t2LBk69Qlob22YW5Q9j5WgETWk81F+8KV+i03PHUnT
 mEg67kcTTqfPYcX6v9Imic8bNAf73IWz20yMk5UOTn21BLGPoFSVINpp9DVbL4f6ppVOOIg
 bojn9Ek9UDtRYRPdzacnIf3JrZBLfwQRpf7tSh9BPV5hCr6sWakgJc+CjXsLySm32G6vxSy
 H/ddiHs1AScaBbtfXlfoK33QrYcXPZ9xTCETUDS
X-QQ-GoodBg: 2
From: caojun <caojun@uniontech.com>
To: axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 caojun <caojun@uniontech.com>
Subject: [PATCH] add Intel 760p/Pro 7600p nvme disk
Date: Thu,  2 Dec 2021 11:02:30 +0800
Message-Id: <20211202030230.17507-1-caojun@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign2
X-QQ-Bgrelay: 1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211201_190301_813120_B5BBDBBE 
X-CRM114-Status: GOOD (  11.89  )
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

Signed-off-by: caojun <caojun@uniontech.com>
---
 drivers/nvme/host/core.c | 16 +++++++++-------
 drivers/nvme/host/nvme.h |  5 +++++
 drivers/nvme/host/pci.c  |  2 ++
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e64310f22..8e0dbfb6a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2155,14 +2155,16 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 	size_t nqnlen;
 	int off;
 
-	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
-	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strncpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
-		return;
-	}
+	if(!(ctrl->quirks & NVME_QUIRK_IGNORE_DEV_SUBNQN)) {
+		nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
+		if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
+			strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
+			return;
+		}
 
-	if (ctrl->vs >= NVME_VS(1, 2, 1))
-		dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+		if (ctrl->vs >= NVME_VS(1, 2, 1))
+			dev_warn(ctrl->device, "missing or invalid SUBNQN field.\n");
+	}
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 276975506..5f5a91518 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -90,6 +90,11 @@ enum nvme_quirks {
 	 * Set MEDIUM priority on SQ creation
 	 */
 	NVME_QUIRK_MEDIUM_PRIO_SQ		= (1 << 7),
+
+	/*
+	 * Ignore device provided subnqn.
+	 */
+	NVME_QUIRK_IGNORE_DEV_SUBNQN		= (1 << 8),
 };
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d7cf3202c..fcac05528 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2713,6 +2713,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0xf1a5),	/* Intel 600P/P3100 */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_MEDIUM_PRIO_SQ },
+	{ PCI_VDEVICE(INTEL, 0xf1a6),	/* Intel 760p/Pro 7600p */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-- 
2.20.1




