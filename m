Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57378D49C67
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BAKqZ559mBTag/q6sjzJcnNya5CtOd9zWOEoYKABV/Q=; b=zOTZQo+IEMKyI2j2xHu0phdPMG
	TNikA3Y2Rm9CxVwEPATOs0Jmm8POq6A0tXPl+ePKB2Y6VSvzRaUVBJGphY2CidjqQvqX6Z3twPmB4
	U3LffEISkVvPLecs+FXMMZHSv4Pe9sCeUTbxeGmV1pMChu4hBUnSBdnxnXrZ7loARbQ5GYRPZhEoK
	nSsIamCQTeYnpXTF8FkLb548d2x4XRS9hBtE7eL+SZDp6duNuWVc0Nlfo6eEU0R+ZPuxQrnL3W96b
	11NXk0ZTug+IvtviOlG/VA6vKuPh89Jw180llH+9f8a5D25PiijHITOZSfYKF+2wH+RaofTkxXOt3
	gElPR/4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6O-000000022m8-1kTm;
	Fri, 30 Jan 2026 22:36:32 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6L-000000022i8-2YRS
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:30 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-12336c0a8b6so3674825c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812589; x=1770417389; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BAKqZ559mBTag/q6sjzJcnNya5CtOd9zWOEoYKABV/Q=;
        b=Xhsv30GWpovNyVsk7w7LgFRwGfUi+ngFhPL1hs/u4YbDojGqLNziymNgWc3PtkSo32
         lT4my5EXqWCn594e7t0ADOUTE8qmB1SEFaUjdaP7G6CED0OyhgWNQ3n9gYd9HiDr1tsP
         2tC7m11UALFkEPQyjlvbHYwGxVyoKLFXYxiM5boFL6M3qfH76qAm0FlGXi6NPBV2lJ+/
         dHF/khj76AYD8sH3RiEOIC5rxEIYmGbqpobIDhVnEYWtUVO/4M01gYIhLTiqpm7hwngW
         JBFaMc/hcMAoHoCNPWXOhhoynrzRjeAEAGwubS/fteaWw06CS4Dx/Bx0KhnYUemZAd96
         0uqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812589; x=1770417389;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BAKqZ559mBTag/q6sjzJcnNya5CtOd9zWOEoYKABV/Q=;
        b=VgXd+giZinYtyfA7iDkzMbDDXiy+jm+fgCIrtJz9p5D9HWy/ikepdyQT1Ve69gm/7b
         ECEectbe6dNf0K+o96PPljSc386KNgwoae5oArYnYByStLPG2Shqjvd2AefsD4AYv2yH
         2K2XAKgcXPH6SCxRtf038CgsQpf6ZLtWsJnvjq9rAsVyT8YnxDSwETWdJcw2FvGEPcqN
         hfMn1ytNKJU/q8+qRUWLs7Ie9FYFwGLZuYw0X7/aVJb8dWNXDqdNvEzARbIi31Pl/DM0
         xNGfSn9mbNdkEluVC3EkR8RV9+YMXbQ6+DXz50eKNnOxHQRkeTai8DxsUoHvhoB4VsFG
         q0gQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8v2lsIEPgZdRsI6yFRMVWYUKxh1dGXCqUF9hqFi+egliLOaOlMSyZMz+vyk8MZ1v6H//rvdvN7+5v@lists.infradead.org
X-Gm-Message-State: AOJu0Yyj1+Yg14i1wHScLEpFJaON5M+a2Kcju2bAOMOtu1fbtLndRM2x
	uA8es6ZdWDTHeqDdFTa2dcbvriOlDG3APaNK2veTk47T25qoRsWKyFkDDKJGxG2nmj4=
X-Gm-Gg: AZuq6aI7Wy60SKcCyg3TkQhZC3kXUXFNghq7lwdBQaWwAzKue9cFX0msB5ir2AbsWnP
	/ZpwsCJCfVqAawQOCdYuxmFI8PdEga3gCHZMJXu0BkIM10k4Vd1WZZo6uIo20PnQjIMID4as85y
	E52YmBhqq1Uns2xXsNrIuguWW7giIpqDMZVLuoFTvr1ovEpRrLfgtoy8Caxb0mNshPVDFZbfS00
	8rxWRZDtD8UO3eKjWK6b+XUDBBef80hy8TS2pBTavjQe63SCZo2bI4yixwsQNU4UQm0Pk6nBfUe
	s0PSpjwysOZU9WXNNo+ALc2hLWrxy9TL/vUzqp+KAQBU+KjHM/sZVS4ntrOqGb368iuFI2UnLwJ
	KjYeiWRqx0RpAjYHZdmeoQWnkuQFqt8gmKIBvhnnQU4gno/ATEWVMzOhKDqnbbJHnLYDmTXhlmt
	bG9yoyb8QC5h/iNH7NeHYJhYHScOwJHf+h5Q==
X-Received: by 2002:a05:7022:68aa:b0:119:e569:fbb2 with SMTP id a92af1059eb24-125c1008c5cmr2553740c88.33.1769812588458;
        Fri, 30 Jan 2026 14:36:28 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:28 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 05/14] nvmet: Send an AEN on CCR completion
Date: Fri, 30 Jan 2026 14:34:09 -0800
Message-ID: <20260130223531.2478849-6-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143629_664059_1BAA6451 
X-CRM114-Status: GOOD (  14.89  )
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
 drivers/nvme/target/core.c  | 25 ++++++++++++++++++++++---
 drivers/nvme/target/nvmet.h |  3 ++-
 include/linux/nvme.h        |  3 +++
 3 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 54dd0dcfa12b..ae2fe9f90bcd 100644
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
@@ -215,13 +215,19 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
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
+
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
 {
 	u32 i;
@@ -1788,6 +1794,18 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
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
@@ -1803,6 +1821,7 @@ static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
 		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
 			if (ccr->ctrl == ctrl) {
 				ccr->ctrl = NULL;
+				nvmet_ctrl_notify_ccr(sctrl);
 				break;
 			}
 		}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 93d6ac41cf85..00528feeb3cd 100644
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
index 3e189674b69e..f6d66dadc5b1 100644
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
2.52.0


