Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA8FBEDF17F
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CZrFuOxPh30GDseArs+7imxFHdxAweEbIg0R0txG24E=; b=mg1Fh7E459mBl3/TN9cNMZPHPo
	LhFpmj9uK+qHSZ/kSQzdcMLY69ctpHth+gH3X8zXZJ4EZZSRzly9DerQF4ebDc3KJO7VJTiGNOMr8
	6mvM41r93qYuRe4Rife25jM2hkDy+5ARVTWKrVtj45QrG0G8R0xJAbD9F1jQ8m0YzOJQg1w3bNOCw
	qWILLLFXnLWI7+4WbPOPoGKzJEU3MylyAYAv1RO9/DSTBTauRu2+RG66kISWu9j+lCHTYJjPVeLQH
	ZiYq9+tBy5TrU13IR+4qM26lkmnW8WQZ0TG1PaSfFyeiqyVJsGS5ctONeyBOIBqOkGjB4i/NdlMiq
	KMvN7ogg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gf-00000004Ezs-0HBe;
	Sat, 14 Feb 2026 04:28:29 +0000
Received: from mail-dl1-x1231.google.com ([2607:f8b0:4864:20::1231])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gb-00000004Ew6-1OvY
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:26 +0000
Received: by mail-dl1-x1231.google.com with SMTP id a92af1059eb24-1248d27f2b9so2229445c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043305; x=1771648105; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZrFuOxPh30GDseArs+7imxFHdxAweEbIg0R0txG24E=;
        b=VUt8Y/ddEZ8FlFqpQ0nLa7z5SIM2zAmmw8U3KMkrvf7CoKxSBDlT1FYBJmzIRfPf5p
         J6y2ilfk/9/edrfZ0b7Uwl5DVqiSfMSF43COvF50ewozzhN874HKwPScp+kozdsrRVa5
         kITqjWt9Y1JeHzmydcRx2LE+A91PXFSBBwdWl+h9LgYor6UH0Lluc47zWCJrndUHMSV6
         q30pwYx84ihid6vHLYfqSlv+/9NFI9b3ZglwtqAxR/1O6m/bqBc1uD0ypT3PQtwBbY/u
         Y0fQ4sPqVW/2KcL+NKTD28qmZuZ8g/k9iBF1cTBilyFbjDC9NzGZOO8QkF6rnw9WaVSN
         8Yhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043305; x=1771648105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CZrFuOxPh30GDseArs+7imxFHdxAweEbIg0R0txG24E=;
        b=QHG/rzxmqosww4gj0HVPgJUaG9zqms2554bIgoUDGbMBKBRg6oYJi3wetR2xjkhDZF
         7FUlB45I/tT7DdHSKxmFHaEBh7l97Gy0km9Y8bSVAw2Uk7ZhNs4yYziZgIbO+5oPoQaz
         8u6Iy5SZG0bHZ5yWYbE0putIDp8HrtZSgSZcfAfeHmZt/tiF3EdVhbwcQc3f4MZEElaD
         DSb2ZZSBnbXOQ1bMW0ysU0a+NlxUGnVfG7kKVkhPg4DAwHl2BUXRn/qmvGShMnq6FrQL
         5cHTAHVTop+j5YoZXcofsai3AXDjmrpxa09//GlTpuiGp9wmUFK5PMmKYoJcnVUAR8LQ
         wB0w==
X-Forwarded-Encrypted: i=1; AJvYcCWF5clOzLysrVs7WAmeQlbMZA2tL2fkHnaYIbLARP1hL7qSWNG5JTk06nZoU0z94fHssKvm+WOh6dHM@lists.infradead.org
X-Gm-Message-State: AOJu0YyUh3HUwBf3bFQZWB2Ey5pkLDAGDmTvdWRc5me6//g18HqNvAL6
	Mna4qui1/ncQ43bKpazIGohSU4cT+elLyCmqldLYu9ExzDrp+hD4/DWJegHl61tJez8=
X-Gm-Gg: AZuq6aLlUeYxH9qHB0jPHZ39M7KjgDRfEOzNj1oxLOLmm20b5wvPcMB4vAjxFJ0tniu
	DUb80jU+JNHkLlTSxeKXlE/y0/9wQ66dpqVdKqBmUxOzHZh/4cBTtid+gkHUnRWSXszNdCCto+U
	XVZv+SKak2hrjWIfrDq7dnWDTaGeUFGmAdKh7OtHHWuY6FxXca+REqUP7b7eIIjpedp07i2wjHr
	WZ8eRR37Qj1AhUJKA4PgGgd1Y0erNvb/DWaSydLF5cirzwVL1L5HxGtKodksmY09v3OADW1TzDC
	w7l2jORBAQG+Brn5VwGlWkJr1EVvhE5e9D3KXj02MxBTT4Uh/ufcXKnTKT3636AxC+7IwV6z9k0
	Uo4hWtSFUKRhOlJBWYl6d7NgfTEfcVtn3QiPQf7KQCfuwgVzWwSvdS+pqgR/Nw00vC1bl0hmJju
	r2yeoZjDhvBAeJuipPLNx05N9WvkT5kali6eOy2wAqQokHsg==
X-Received: by 2002:a05:7022:929:b0:11d:f44d:1863 with SMTP id a92af1059eb24-127397a2455mr2164149c88.11.1771043304472;
        Fri, 13 Feb 2026 20:28:24 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:24 -0800 (PST)
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
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v3 04/21] nvmet: Implement CCR logpage
Date: Fri, 13 Feb 2026 20:25:05 -0800
Message-ID: <20260214042753.4073668-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202825_461465_550618EA 
X-CRM114-Status: GOOD (  14.14  )
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

Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
Reset) log page contains an entry for each CCR request submitted to
source controller. Implement CCR logpage for nvme linux target.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 44 +++++++++++++++++++++++++++++++++
 include/linux/nvme.h            | 29 ++++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 65ed772babb8..925a81979278 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -220,6 +220,7 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_FEATURES] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RMI] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_CCR] = cpu_to_le32(NVME_LIDS_LSUPP);
 
 	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
@@ -608,6 +609,47 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+static void nvmet_execute_get_log_page_ccr(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_ccr *ccr;
+	struct nvme_ccr_log *log;
+	int index = 0;
+	u16 status;
+
+	log = kzalloc(sizeof(*log), GFP_KERNEL);
+	if (!log) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	mutex_lock(&ctrl->lock);
+	list_for_each_entry(ccr, &ctrl->ccr_list, entry) {
+		u8 flags = NVME_CCR_FLAGS_VALIDATED | NVME_CCR_FLAGS_INITIATED;
+		u8 status = ccr->ctrl ? NVME_CCR_STATUS_IN_PROGRESS :
+					NVME_CCR_STATUS_SUCCESS;
+
+		log->entries[index].icid = cpu_to_le16(ccr->icid);
+		log->entries[index].ciu = ccr->ciu;
+		log->entries[index].acid = cpu_to_le16(0xffff);
+		log->entries[index].ccrs = status;
+		log->entries[index].ccrf = flags;
+		index++;
+	}
+
+	/* Cleanup completed CCRs if requested */
+	if (req->cmd->get_log_page.lsp & 0x1)
+		nvmet_ctrl_cleanup_ccrs(ctrl, false);
+	mutex_unlock(&ctrl->lock);
+
+	log->ne = cpu_to_le16(index);
+	nvmet_clear_aen_bit(req, NVME_AEN_BIT_CCR_COMPLETE);
+	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	kfree(log);
+out:
+	nvmet_req_complete(req, status);
+}
+
 static void nvmet_execute_get_log_page(struct nvmet_req *req)
 {
 	if (!nvmet_check_transfer_len(req, nvmet_get_log_page_len(req->cmd)))
@@ -641,6 +683,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_page_rmi(req);
 	case NVME_LOG_RESERVATION:
 		return nvmet_execute_get_log_page_resv(req);
+	case NVME_LOG_CCR:
+		return nvmet_execute_get_log_page_ccr(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index d9b421dc1ef3..9b6d93270c59 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1432,6 +1432,7 @@ enum {
 	NVME_LOG_FDP_CONFIGS	= 0x20,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
+	NVME_LOG_CCR		= 0x1E,
 	NVME_FWACT_REPL		= (0 << 3),
 	NVME_FWACT_REPL_ACTV	= (1 << 3),
 	NVME_FWACT_ACTV		= (2 << 3),
@@ -1455,6 +1456,34 @@ enum {
 	NVME_FIS_CSCPE	= 1 << 21,
 };
 
+/* NVMe Cross-Controller Reset Status */
+enum {
+	NVME_CCR_STATUS_IN_PROGRESS,
+	NVME_CCR_STATUS_SUCCESS,
+	NVME_CCR_STATUS_FAILED,
+};
+
+/* NVMe Cross-Controller Reset Flags */
+enum {
+	NVME_CCR_FLAGS_VALIDATED	= 0x01,
+	NVME_CCR_FLAGS_INITIATED	= 0x02,
+};
+
+struct nvme_ccr_log_entry {
+	__le16			icid;
+	__u8			ciu;
+	__u8			rsvd3;
+	__le16			acid;
+	__u8			ccrs;
+	__u8			ccrf;
+};
+
+struct nvme_ccr_log {
+	__le16				ne;
+	__u8				rsvd2[6];
+	struct nvme_ccr_log_entry	entries[NVMF_CCR_PER_PAGE];
+};
+
 /* NVMe Namespace Write Protect State */
 enum {
 	NVME_NS_NO_WRITE_PROTECT = 0,
-- 
2.52.0


