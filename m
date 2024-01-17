Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A8B0C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 08:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xpJ0/3E4Zex69k1CnI9dtrl2gdZtN5rxsUHBvkO5P0c=; b=vzxSOWRDg6ooS6hnUbZcf+Gko9
	EwjZnwSIux+8mk46UxtgDjJx7mEp+5kk7KH9u3u2Z9NTSCZkmbR0vJIlL42JcgUC4Jh8vy7V8eb6D
	OoeN0w/AI3dasKRC9ZdkiQNjmEe3mKggepm0MNGrSQoA7qKuCd9Uvx5QryFYvMm6WtwwSZ2ZanJ7g
	/wQpE8O0aiILJGAc0NiOD0tp1x4zJnEGrgumiB6o6MKxxSX9HgdNO/T9+joN9i3NrER4hcVpLAhz5
	U+jZzCm5UwXnGRsjAzeSiM+nbjg54Qv/BpG0YI7c3Qu1QzrEd+sSj6XpQ3aXFSSJ8UU9RJSWk63my
	G3ANAdyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ15K-00EpTC-0k;
	Wed, 17 Jan 2024 08:15:42 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ15E-00EpQz-1U
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 08:15:38 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-om2-b_1705479328;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-om2-b_1705479328)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 16:15:33 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH V2 2/2] nvmet: unify aer type enum
Date: Wed, 17 Jan 2024 16:15:12 +0800
Message-ID: <20240117081512.89635-3-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117081512.89635-1-kanie@linux.alibaba.com>
References: <20240117081512.89635-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_001536_657954_361ACB79 
X-CRM114-Status: UNSURE (   9.06  )
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
index 67a8c9fd1956..f957cfb7052f 100644
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


