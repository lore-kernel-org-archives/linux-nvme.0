Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B89D9C44507
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jul 2026 02:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P20skrUm4HZS8JTk5TGJZTP7YmJdI0Mg5/mxR9z/xBU=; b=1TlkZzo7e8ObVqfGCkkw76/4s4
	nnNegrsw+iFwuY8dHAVX5kiOnxmeF99eEL7YP5Fz+I4XYxc/nEpaJtZ0qfxDNxYt0PccGSWi3zCAo
	5enrWVRNf67i6EKCO7v8hSHah0OOvpR3yFWhfbKd4kQXyK6tp50YsCpsqJQmvHfvdtDWvGohFa5rH
	QUfNaSfyikbVDLV7uNfEoIJJHRF8F5px/51/c0nnxxnxotaBBEwgHEPwpL/PmjfHyJSuMKx6DCHkm
	9/ZWkBfmTqZzm5cBp3PhrOVVWsimrL+ZX9POg3XtdwRkVR6yiMUK8zgcHfzp/7Ds8M+RNCBOW1f+H
	uKOKJ3dA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsm-000000071Pt-08pD;
	Sun, 12 Jul 2026 02:25:28 +0000
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wijsi-000000071M8-25av
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jul 2026 02:25:25 +0000
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-ca80d708489so1237759a12.1
        for <linux-nvme@lists.infradead.org>; Sat, 11 Jul 2026 19:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1783823123; x=1784427923; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P20skrUm4HZS8JTk5TGJZTP7YmJdI0Mg5/mxR9z/xBU=;
        b=OmMzqapzLey+dV1wY2V5mqEATz96t4jw4RENkYGi1f403NqF52wO7NfXlyTx4za6wq
         S7Qf8HHxja++K0g/Wh3iUHvJ8+OlFOU/iySRMllW/GIbt1ct/jYhtj833sDeYJi4Pd0X
         jbWhYTSVhli9bJt9WTB2iG18Ck0UpK2KxTVYkvcSyHsqFKDTo8jJdZ+FSHp+xxG/vuNX
         /sZvuWxTZUN6hb7kgs3J6i9qtle9aFugjrtCSqlJ/3uxL/cZSN7WUunGqCJSouUzWS2T
         R+UpRLqQMt1XV+ouBIMp3pHeacwJBzquB0yeKxMn8PVZNzacDzpo2RovMdFzICAPUoSW
         pYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783823123; x=1784427923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P20skrUm4HZS8JTk5TGJZTP7YmJdI0Mg5/mxR9z/xBU=;
        b=qyDoixUtfOLrhhNJHSS8tM7BwdVkVK8lAVALQrxEdXYl63YbBYoybeCNhB3ESwLtzE
         3mFWdFHhGEJM8+zxFaS02/wi2v3VtFGYAaNrDbQvS6x/C9TebSkUeap2sMnxwLAC2oL4
         oPW1KbHBuVjyBXOgk76yEs3FOtR+ZBzo75kqw9Owbsh11fU6mO7rH2JLowH+t88Hhgsy
         Z8DZq5JcrwjXUn3espNi1WHmakmnkWfK8p3qa5v4Go3K+UxNE8gP36PqLqgohCHPwRpT
         sj9iAsfcvJEWhcJ+YlO2hGdH6L7su7eBsXaiXuaPxQfx3WFcNhnSWQEa7xqVwnyWsnM/
         blyg==
X-Forwarded-Encrypted: i=1; AHgh+RrjHX17LsJQPeEecvpcypp2VgCZuUgHzQ3qQqF41IwM06qitgRpsjTLr36C6X4IBhgqfy/vURCGesCb@lists.infradead.org
X-Gm-Message-State: AOJu0Yy0fYK+NQtDEncG5RRLnbIMQ3L/645nBDqI35T05JNMvjHrMN+1
	udgRI/o/PxBwJDSy0yXnmw9EV56C6hN4em+T0FkkNK+IrhSM/BP/allfkKrLed17nWI=
X-Gm-Gg: AfdE7cmfBjPky0NlKP5Th07NFGJZUJPJjH0Ya6oiCW0jO4mjXY+aF0b4UtnHRsJKhk2
	c4SmRqUTiTdV6gor6wK4JVzk7fWjeRQws1kK2ZbiyzcIoztAz3xatnZHUEvLI9bXEH3JfewMmph
	d0OeAQBrZzRzG/vG032aQvcnRxuaLk7o6zrkflDy3eA+cf0VP1pPDPWmfFtc1qLf9jAoq0BRy/A
	aJSK/HmlpmfqCs9gMoc0cHOOEqFt+1+aXpSV9l7DMJFYFQyNnk+lAl176jWtyigQ0+5dm4U6tNr
	SofMTRpFCIdBC6cXfeI1VS6Ao2Uyqes2/mHX4gUNHHzjiaYDU+oPAT2hGL0nMEQTKBmco0XeeDi
	8DsP/vsvyniFK7MOph3uj9/eLvPWsGLbMdezdDIN8N2s53l0/I5LUENKCKRaJuWFg9+MzwgTHyF
	tCQdgI
X-Received: by 2002:a05:6a21:6115:b0:3bf:aa54:4cbc with SMTP id adf61e73a8af0-3c0f0b6fda4mr9262734637.26.1783823123312;
        Sat, 11 Jul 2026 19:25:23 -0700 (PDT)
Received: from ceto.lan ([2607:fb90:9c20:2264::1c31])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm60704693eec.0.2026.07.11.19.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 19:25:22 -0700 (PDT)
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
Subject: [PATCH v5 04/16] nvmet: Implement CCR logpage
Date: Sat, 11 Jul 2026 19:23:25 -0700
Message-ID: <20260712022437.3743117-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260712022437.3743117-1-mkhalfella@purestorage.com>
References: <20260712022437.3743117-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260711_192524_542495_5860AC55 
X-CRM114-Status: GOOD (  14.54  )
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
index 1b97e1bafa30..ea2566a9b83f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -220,6 +220,7 @@ static void nvmet_execute_get_supported_log_pages(struct nvmet_req *req)
 	logs->lids[NVME_LOG_FEATURES] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RMI] = cpu_to_le32(NVME_LIDS_LSUPP);
 	logs->lids[NVME_LOG_RESERVATION] = cpu_to_le32(NVME_LIDS_LSUPP);
+	logs->lids[NVME_LOG_CCR] = cpu_to_le32(NVME_LIDS_LSUPP);
 
 	status = nvmet_copy_to_sgl(req, 0, logs, sizeof(*logs));
 	kfree(logs);
@@ -606,6 +607,47 @@ static void nvmet_execute_get_log_page_features(struct nvmet_req *req)
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
+	log = kzalloc_obj(*log);
+	if (!log) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	mutex_lock(&ctrl->lock);
+	list_for_each_entry(ccr, &ctrl->ccr_list, entry) {
+		u8 flags = NVME_CCR_FLAGS_VALIDATED | NVME_CCR_FLAGS_INITIATED;
+		u8 ccr_status = ccr->ctrl ? NVME_CCR_STATUS_IN_PROGRESS :
+					NVME_CCR_STATUS_SUCCESS;
+
+		log->entries[index].icid = cpu_to_le16(ccr->icid);
+		log->entries[index].ciu = ccr->ciu;
+		log->entries[index].acid = cpu_to_le16(0xffff);
+		log->entries[index].ccrs = ccr_status;
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
@@ -639,6 +681,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_page_rmi(req);
 	case NVME_LOG_RESERVATION:
 		return nvmet_execute_get_log_page_resv(req);
+	case NVME_LOG_CCR:
+		return nvmet_execute_get_log_page_ccr(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7e6150d9494a..70dd0770e032 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1440,6 +1440,7 @@ enum {
 	NVME_LOG_ANA		= 0x0c,
 	NVME_LOG_FEATURES	= 0x12,
 	NVME_LOG_RMI		= 0x16,
+	NVME_LOG_CCR		= 0x1e,
 	NVME_LOG_FDP_CONFIGS	= 0x20,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
@@ -1466,6 +1467,34 @@ enum {
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
2.54.0


