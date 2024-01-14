Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65DA8C47077
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jan 2024 09:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zFBDPpq9gN+4LKmtyvL0nY6BDkm5fi/gruFXRDYxPKc=; b=nw082b7Lj58Spa/YqcV0JAnSt8
	YfI3ytTUMoLcaJkfcjDmgcZgPqVD67cufnxrvcCNI3RTzPsNh3SiUS3gb3lOWCuOtoowG96m+32M9
	9fbchPWNSHndZBrWQNO9Lu7mTBt6vek3sFH4oopoRnZ9q3+Mw01DGIABrEVNdsA9OosHsVWs7Jyh7
	1Vp2z/XyfhQ14AucRRY3/eBjgS5PTYWlDSTZ9xf9gBe3UZHLWEZ77AbBJFdZH49LP2+KX0H1RD1rD
	UcZa4hnmDe5yaZPHEaoPSES1HQ+Rs9msgonw4No1euOceBx2Z2jjFIDM/B9KRam7U76T22q2GrvAv
	VkpRHx4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rOwiQ-006NJ7-0P;
	Sun, 14 Jan 2024 09:23:38 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rOwiM-006NHz-18
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jan 2024 09:23:36 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R811e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-XgL.k_1705224205;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-XgL.k_1705224205)
          by smtp.aliyun-inc.com;
          Sun, 14 Jan 2024 17:23:30 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: hch@lst.de,
	sagi@grimberg.me,
	kch@nvidia.com,
	chaitanyak@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/3] nvmet: unify aer type enum
Date: Sun, 14 Jan 2024 17:23:13 +0800
Message-ID: <20240114092314.63694-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240114092314.63694-1-kanie@linux.alibaba.com>
References: <20240114092314.63694-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240114_012334_547605_043FDDD3 
X-CRM114-Status: UNSURE (   8.93  )
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

The host and target use two definition of aer type, unify
them into a single one.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/core.c      | 4 ++--
 drivers/nvme/target/discovery.c | 2 +-
 include/linux/nvme.h            | 6 ------
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a5019881d60b..12088160ce23 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -248,7 +248,7 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
 		nvmet_add_to_changed_ns_log(ctrl, cpu_to_le32(nsid));
 		if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_NS_ATTR))
 			continue;
-		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+		nvmet_add_async_event(ctrl, NVME_AER_NOTICE,
 				NVME_AER_NOTICE_NS_CHANGED,
 				NVME_LOG_CHANGED_NS);
 	}
@@ -265,7 +265,7 @@ void nvmet_send_ana_event(struct nvmet_subsys *subsys,
 			continue;
 		if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_ANA_CHANGE))
 			continue;
-		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+		nvmet_add_async_event(ctrl, NVME_AER_NOTICE,
 				NVME_AER_NOTICE_ANA, NVME_LOG_ANA);
 	}
 	mutex_unlock(&subsys->lock);
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 668d257fa986..68e82ccc0e4e 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -21,7 +21,7 @@ static void __nvmet_disc_changed(struct nvmet_port *port,
 	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_DISC_CHANGE))
 		return;
 
-	nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+	nvmet_add_async_event(ctrl, NVME_AER_NOTICE,
 			      NVME_AER_NOTICE_DISC_CHANGED, NVME_LOG_DISC);
 }
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bb5f56ebae50..226f5d48d135 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -865,12 +865,6 @@ struct nvme_reservation_status_ext {
 	struct nvme_registered_ctrl_ext regctl_eds[];
 };
 
-enum nvme_async_event_type {
-	NVME_AER_TYPE_ERROR	= 0,
-	NVME_AER_TYPE_SMART	= 1,
-	NVME_AER_TYPE_NOTICE	= 2,
-};
-
 /* I/O commands */
 
 enum nvme_opcode {
-- 
2.43.0


