Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77982C44509
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XL1bNu+U9GqDErYJpXpnJDbFEHkKBxgfcViduksku88=; b=1jCb9bLiwFISyzAK07QWpdESiW
	KFmJslly1mrKfFXgt7SXReqZWzLjzIL2kfZqhf2jYRTCByKcAy3FjuEuvNnVeaHx50LQQP761SxP/
	UYE2FaZ4msXAL4qsnoYHLB7NcTEertmsX0xoI0T3HiqoyHWpMCU1B8dYPmW7JtEsGAeljnciXRNII
	b/qW1Uy2XDROEA/oHEZgW91bMrQsHmNewMHKXbh9fbRDbG0dXdHWlD2RyE1y7Z6Lxkw6GRSAyvqng
	sCq1Ol5v+JQFIACGHluvEIqBPOLERuK7kkRrbuXqwU0+LphOgoaDIxVa9rik411KHn12zcqKcWQsc
	gMXmFPyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsm-000000071QR-0itH;
	Sun, 12 Jul 2026 02:25:28 +0000
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsk-000000071O5-0oKT
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:27 +0000
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-848882fdb18so1157337b3a.0
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823125; x=1784427925; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XL1bNu+U9GqDErYJpXpnJDbFEHkKBxgfcViduksku88=;
        b=GkDL2UN0kO9BOZ+UkblBhJiFjOV+0E8mp7vRWdJrUlii9KnR5hdyUzCzrnBjx2iUuK
         ZuAwscMOiFYp2KnGOWr81yiC97Xn4Uv81c0vwEqB5JymUIy65cGWXx/0DxwdejKIU2sb
         bcUBPasZPyO9Rlk1iCdvz4h87p+7QKh+hNovKg0BNQecrhlIR+3jgMJMDG90+g26Yn2C
         dgyv2+7vL5mPh8XfZsonDm8cdFxWpNFZfIEckOG11RKZlh8vw1iirPj8j+DfEHtY1PGP
         myEy42a0z7IwWJHV21ymhbCSMAL6XWm0BbrfLID9wLnPMmI603vIhTyFfrsRXvLyerWT
         R0og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823125; x=1784427925;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XL1bNu+U9GqDErYJpXpnJDbFEHkKBxgfcViduksku88=;
        b=dIuk3Ohf9d9xz9rGrJ3+EOB7ifjD+zU/4wk9lX8GWylB8AisNPmQbZrl46ZNDP/0s2
         7f2btxtc1E5P8Pm3smJmpDD/yyomNCendJyMBcnNHNcmuxPhmSAacFHA6vqVb+nlMVIT
         o6H754GIYWN5Q7lUWmOBSRHKevucvNBhhBlmGLG1bSa3sUpV7ceVieZc0HLicfK3DwlB
         K4CbS8GvdFY6xUaw967mzHYFQzEEvE+b8K43I/+4krE7CpBJaJBePrkCAawhgR9bluor
         lBkmQxr0CbUrkD7L8XpN1/kuot6oAN0+8PaBSUBe3HpTwJCudtL4HnW45sPX5/tFqeqS
         gzvQ==
X-Forwarded-Encrypted: i=1; AHgh+RpNB/Ho5wMcQFmQd/38lGPdOhMvoKGLOqNwa+xONt825yE2dZxK/8nyO1HO3M7+rP10Gg43ZCzXx2wa@lists.infradead.org
X-Gm-Message-State: AOJu0YyU2fNObs/XDVGGEd1WkTs0NvtAw1BlPAuT/uOBbBInutctqCVG
	HGyBoCdDlo64ZmvKg4QCla34ZUUGGNB96HsaI+sk/ZRsAXKZ/URRMKg+SbZVZF9LPtc=
X-Gm-Gg: AfdE7clXPGJWGMNrvUd6Yg07e5adSLY5YiXgzbXeGCwPf+Gi2NSqAYOUL9hMKKgOYg3
	4SNENutPLmEvLk6xsl7YhnY6ixIE32n/P5cxi0vbHSc+GseMJpw4JdxHfrdDy7x3VAW4B3dwRGB
	9AVdBX1JLDynAJsKDqEB3IHqCdnMwM+TgAkzgr8wgZK7+kDHpcLZ0gk0dX4qbqKXOImhnoIUGTe
	FuK1F/3AJFUyEdGN618PR0av7IIs3hCp7oG1NRrXw95gwRMoYSVWVO6s5PPsz6GZ/euTsLGRoG7
	UcD3BoJuYM98W9zBaGk1g2ufxmPSiPLFsPiS9wCnQfajBImubc1pseI0thhA3YzE/4zwiv9ABFD
	2QTT1TtV9spJg8PbkvujKR0l706DFQXzCgm9ZG3ZB9/qOPoYm1Ga78BHBBN0VCNdNgTtmEwvLdf
	OSrlZL
X-Received: by 2002:a05:6a20:72a5:b0:3c0:9c19:65bb with SMTP id adf61e73a8af0-3c110a6e389mr5138000637.67.1783823125107;
        Sat, 11 Jul 2026 19:25:25 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:24 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Cc: Aaron Dailey <adailey@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v5 05/16] nvmet: Send an AEN on CCR completion
Date: Sat, 11 Jul 2026 19:23:26 -0700
Message-ID: <20260712022437.3743117-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192526_340243_F7A0520F 
X-CRM114-Status: GOOD (  16.00  )
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

When an impacted controller that is the target of pending CCRs is torn
down, send an AEN to each source controller that issued a CCR against
it. The notification points to the CCR log page that the source
controller can read to check which CCR operation completed.

Split nvmet_add_async_event() into a locked helper so the AEN can be
queued while ctrl->lock is already held.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/core.c  | 25 ++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h |  3 ++-
 include/linux/nvme.h        |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5b4312227222..9b16b15f5093 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -205,7 +205,7 @@ static void nvmet_async_event_work(struct work_struct *work)
 	nvmet_async_events_process(ctrl);
 }
 
-void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
 	struct nvmet_async_event *aen;
@@ -218,13 +218,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	aen->event_info = event_info;
 	aen->log_page = log_page;
 
-	mutex_lock(&ctrl->lock);
 	list_add_tail(&aen->entry, &ctrl->async_events);
-	mutex_unlock(&ctrl->lock);
 
 	queue_work(nvmet_aen_wq, &ctrl->async_event_work);
 }
 
+void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+		u8 event_info, u8 log_page)
+{
+	mutex_lock(&ctrl->lock);
+	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
+	mutex_unlock(&ctrl->lock);
+}
+
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
 {
 	u32 i;
@@ -1796,6 +1802,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 }
 EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
 
+static void nvmet_ctrl_notify_ccr(struct nvmet_ctrl *ctrl)
+{
+	lockdep_assert_held(&ctrl->lock);
+
+	if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_CCR_COMPLETE))
+		return;
+
+	nvmet_add_async_event_locked(ctrl, NVME_AER_NOTICE,
+				     NVME_AER_NOTICE_CCR_COMPLETED,
+				     NVME_LOG_CCR);
+}
+
 static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 {
 	struct nvmet_subsys *subsys = ctrl->subsys;
@@ -1819,6 +1837,7 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
 			if (ccr->ctrl == ctrl) {
 				ccr->ctrl = NULL;
+				nvmet_ctrl_notify_ccr(sctrl);
 				break;
 			}
 		}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index de088986cb4b..da80377c3795 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -44,7 +44,8 @@
  * Supported optional AENs:
  */
 #define NVMET_AEN_CFG_OPTIONAL \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE)
+	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE | \
+	 NVME_AEN_CFG_CCR_COMPLETE)
 #define NVMET_DISC_AEN_CFG_OPTIONAL \
 	(NVME_AEN_CFG_DISC_CHANGE)
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 70dd0770e032..3757d11ffea3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -871,12 +871,14 @@ enum {
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 	NVME_AER_NOTICE_ANA		= 0x03,
 	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
+	NVME_AER_NOTICE_CCR_COMPLETED	= 0xf4,
 };
 
 enum {
 	NVME_AEN_BIT_NS_ATTR		= 8,
 	NVME_AEN_BIT_FW_ACT		= 9,
 	NVME_AEN_BIT_ANA_CHANGE		= 11,
+	NVME_AEN_BIT_CCR_COMPLETE	= 20,
 	NVME_AEN_BIT_DISC_CHANGE	= 31,
 };
 
@@ -884,6 +886,7 @@ enum {
 	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
 	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
 	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
+	NVME_AEN_CFG_CCR_COMPLETE	= 1 << NVME_AEN_BIT_CCR_COMPLETE,
 	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
 };
 
-- 
2.54.0


