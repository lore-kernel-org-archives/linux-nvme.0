Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47FE5D10376
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8XbXxl9w54eoJ5bw9vwLfDrvdJe4OVmNRP09snH5Q98=; b=zjJMBWt+roeNCauR4mJN3rqw3I
	Zt5WvkYB0U7SRiUcmC9Q04ItgBU91Rj8rYvdqlGMQOTrhrLfTM+2dkllcspv4EUhpHBQ6PB6CXmJj
	dfdIPFNdR7F7LH55UCXJHxvUTlO7rQewRM2gIBnRQS4z0EUZ+ju6c5Hk76yUYXqsrxEYThC2xWKr8
	aGPWE9COAzHm513mGKAmvNSAV5ZkW9175//mzuBmal/h5OS7rFSDIkUhxgPgaEnVxtoHQyFahDBhq
	DOEcMvyPrGrdarU7Kl/fAwEPKSwz7b1WsjIc8YN+y1rusiIl7/mtMNbkMq0ZfDKu/p/RCwzvVQ9wv
	QQe8pryA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52C-0000000EDRR-2RJL;
	Wed, 26 Nov 2025 02:13:32 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO527-0000000EDMR-01Mb
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:28 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so7463322b3a.2
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123206; x=1764728006; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8XbXxl9w54eoJ5bw9vwLfDrvdJe4OVmNRP09snH5Q98=;
        b=Qnxdyo8xh7f3LtQCzNVAnKHpPJiS5KbYMzkZvM6CgpJPNCHT6wP2jL9GxHnvtW51HO
         VmKRhq/AeYbQLdq9KhbiRm2cKEoZqAoGgeTSexneZGRrP8J3cXngMmpEN/cT6sjBahXu
         yjmHu44vdSPshX+WopDpkXG9pAT77f6y19oC3Tv5fdZK29hWzEsV1T5OR+M3UsDumHNM
         cdLZ8/XcmAnjd2Usxbnq376WB50tLnZ4va80NArALRv3pqj0aDaLCeGYlYI4DlH25y3l
         fZ1pwaZULPY1GdC/FYfH5++uGpAfW20UlGrmrj7CTvoXHi6Q4Sw/GD2gT/pM/exXYUbe
         iRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123206; x=1764728006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8XbXxl9w54eoJ5bw9vwLfDrvdJe4OVmNRP09snH5Q98=;
        b=U0vl2RjAUFPmIO/3W6xBuW7vKUL+tDaz6p0311Tl2ZBhjGskAUsPF5wKPRjR9caF7D
         0ckQl30JR3Iy3FQS8uudFSMAdwGIdHVWQC0c0O0G7TXpao1nczW3RCDXZ9EwfK6JWHUT
         QcG/xFjP+S+kedhKU2GDpbp9jA7H7+Jeo5dtV6zSXYor2UPaaV9sxRa4BfB/AvcJ6nHb
         tWPMlf+VqNxm9dNGRVEsiWieFOAtoX3ss1GpIRMZddZP1RTqTr3GwHWgAye5fenmybtW
         LqGobh8Red1+AUr6rhjaV4NlDOjoCJnm8AORkku62zDkYlLjFW9bJY8YIShCogKG2Yzp
         9ecQ==
X-Forwarded-Encrypted: i=1; AJvYcCWWyBmzRlW4tJhDF1Qj2w5AKORjgg02nzNn2S5P1bYdO+rTNVJKLqAhqpZiGfR51ertq1ARh2q1ernw@lists.infradead.org
X-Gm-Message-State: AOJu0Yx3A3wG9XRlYmShDTepSbAoOo5C/IVtsQc0P9/m7ca1Ix12IpaT
	zzdtAdAVulW/H4wntfcHrclur+zVq11L7I61x1o/FoZ2jG1qWK1FSpZ1BwJmw5AT7r4=
X-Gm-Gg: ASbGncsM5H6Z+i3BrX53wLXsqmmM+W8iw8OSVppmsh1N+ZI8f4piamXwIiUcS8TH2bh
	r9fBBqghYbC16Z/rXlIY/cYRcNh0AFiPvSODxaeeamxGHviQViVVZ35xBCJXLjxA/hfEkM03vIK
	IncZLUuc3xEPJi1APYR5JE7XGhK9DDMw5Gwd3eV4zVnoPvzlVN+J8r5OJb553WAQu0PrZ8Yd1jj
	qYB0DdJ1D0PrGLyt0jZDeV/23tGGHBri2Cj+mwE0ASVa3soyb627kbur0nWkMlcI1U3NFpsXmDZ
	SIETk76xnoeKFIN7C/yViTTnnETI8BAOndOVJm9Kf0hGns4Ogo2dCoFIRoDDliVu/zLDD5wgcOT
	aNWkkDf4noBt3OYZDXEBFvUNGP8GKGkT/Pd4LSRYn1uc9paskhHd/RCOTEE9/qjcSbNevRWs9Ar
	Z6HPAM4rP4mE4A4c5oBYwJQheA19Fq3Be721PnUCFVNk41
X-Google-Smtp-Source: AGHT+IHwR/uNyy4XREluHWJ5+ovrWb65gDmMgcIcohHXB6flzaenya5awGJFYvmrd36ufdEuxYrdaA==
X-Received: by 2002:a05:7022:671f:b0:11a:436c:2d56 with SMTP id a92af1059eb24-11c9d7090ffmr11613972c88.2.1764123205776;
        Tue, 25 Nov 2025 18:13:25 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:25 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 05/14] nvmet: Send an AEN on CCR completion
Date: Tue, 25 Nov 2025 18:11:52 -0800
Message-ID: <20251126021250.2583630-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181327_053582_2351C95F 
X-CRM114-Status: GOOD (  15.80  )
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

Send an AEN to initiator when impacted controller exists. The
notification points to CCR log page that initiator can read to check
which CCR operation completed.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/core.c  | 27 +++++++++++++++++++++++----
 drivers/nvme/target/nvmet.h |  3 ++-
 include/linux/nvme.h        |  3 +++
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7dbe9255ff42..60173833c3eb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -202,7 +202,7 @@ static void nvmet_async_event_work(struct work_struct *work)
 	nvmet_async_events_process(ctrl);
 }
 
-void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+static void nvmet_add_async_event_locked(struct nvmet_ctrl *ctrl, u8 event_type,
 		u8 event_info, u8 log_page)
 {
 	struct nvmet_async_event *aen;
@@ -215,12 +215,17 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	aen->event_info = event_info;
 	aen->log_page = log_page;
 
-	mutex_lock(&ctrl->lock);
 	list_add_tail(&aen->entry, &ctrl->async_events);
-	mutex_unlock(&ctrl->lock);
 
 	queue_work(nvmet_wq, &ctrl->async_event_work);
 }
+void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
+		u8 event_info, u8 log_page)
+{
+	mutex_lock(&ctrl->lock);
+	nvmet_add_async_event_locked(ctrl, event_type, event_info, log_page);
+	mutex_unlock(&ctrl->lock);
+}
 
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
 {
@@ -1788,6 +1793,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
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
@@ -1801,8 +1818,10 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
 		mutex_lock(&sctrl->lock);
 		list_for_each_entry(ccr, &sctrl->ccrs, entry) {
-			if (ccr->ctrl == ctrl)
+			if (ccr->ctrl == ctrl) {
+				nvmet_ctrl_notify_ccr(sctrl);
 				ccr->ctrl = NULL;
+			}
 		}
 		mutex_unlock(&sctrl->lock);
 	}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c0091b8af8b..7ebcef13be2b 100644
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
index d51883122d65..a145417dccd3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -863,12 +863,14 @@ enum {
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
 
@@ -876,6 +878,7 @@ enum {
 	NVME_AEN_CFG_NS_ATTR		= 1 << NVME_AEN_BIT_NS_ATTR,
 	NVME_AEN_CFG_FW_ACT		= 1 << NVME_AEN_BIT_FW_ACT,
 	NVME_AEN_CFG_ANA_CHANGE		= 1 << NVME_AEN_BIT_ANA_CHANGE,
+	NVME_AEN_CFG_CCR_COMPLETE	= 1 << NVME_AEN_BIT_CCR_COMPLETE,
 	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
 };
 
-- 
2.51.2


