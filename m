Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECFDC982EB
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XucfLuTS9otn5RCUHBJMmZsLBhJtMpUV15kULQxOZKo=; b=iz812bzWXl4roPG/u1Tuh2IXxe
	L5WxrJQbA1Y/VUfbsDDoh0KULKRVq+H3vIVVSkmEoxfvOX6JNQDCiOr8t5eWs9yL1tL9d1PldJJE3
	8CR8J4t0wksPrcuP9oybCuoFjcm5wlrCQH6IccsnCoY4kNtMdLNWuSzbpxTx39OYgkONoYR6GTUoe
	9TCcibt4a7vLbTzTYQbpaby9ZzM5gKmEsQdIY2YV0Hb8fRzvnj5Pgj7cjVFUmQ+Drx95K2fjy4JaB
	Vtdiwrrr5ZOtLcZbZ2dkmHUWor4BoO9xJJjr3dY63qGUwLOVCJl8d3rImnmXI6AXO9jGGGhnunhQ+
	FjhgNTjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MIy-00000000DlU-3o8P;
	Sun, 20 Sep 2026 18:30:24 +0000
Received: from mail-pz2-x14.google.com ([2607:f8b0:4864:3b::14])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MIw-00000000DjP-1l2y
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:23 +0000
Received: by mail-pz2-x14.google.com with SMTP id 41be03b00d2f7-cc4d2fe2056so1374526a12.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929021; x=1790533821; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XucfLuTS9otn5RCUHBJMmZsLBhJtMpUV15kULQxOZKo=;
        b=BWRICzua74iNqLkxKVPrgsas4xylK0cDW+u83fpuqMYExMGPo7+T11PntvTgc2toJV
         zBQgRThvBlknZLrED3KKrZ4d9xA4Vwdu3enjbHMHUUDLq0OUSnZiQAgF0Ue1it8kCcM+
         BH3lt/toh1vX2A3VGTdRuH+NaPSAdXJiPYOFHU67yRvxpMVyM4A6Ju+316DpPVjc4Qqh
         PrcJFez/SlxulhC1w2tJKpYSlFjxWypPUQZgWhtMWZiyJGiFtBo4hYBcPwhdMXoLW2R0
         QbIHQjw2r7sGVaPsMkJIpsuTwPLQO6PqTRi3MKY8LRjU8URZo3PJi8RKIba8Y7KayZ7z
         qn3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929021; x=1790533821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XucfLuTS9otn5RCUHBJMmZsLBhJtMpUV15kULQxOZKo=;
        b=C1iYUT+X9quuwd5TcEPGy8ovtMtHS9NUJiWR+nF9WA8uvN2lvtHcDxjbratmZf2+6s
         wYIO1IBuMjezJcZ2d3XWsPkLqbvyub6khVnChZo3o0rY3gAI8NYy2W3oyoTGga7Ys372
         GV1HwAQLfWujPIHRRJza7xzar86p3whwI/dE3L4xiH800ZOq/HSw+PG9GLXRrHRepryM
         K7o4yrJBrw1cGiKwi3bwxyZ5W9wbipxWwRJXLl3Lr9Fh5klB13G3r7pbh+V6ree5FRvk
         E43koC1vI+nMeXUSGo8HRwBEaXZLoexeX38F3U31Og2co171HD/EFaTwmgqwAAsu56NI
         9CjA==
X-Forwarded-Encrypted: i=1; AKwUvBzEhmUC9jHcToyfYtjMC9PfX5xWuidgqJ+cBkkE8OMV7GD0NEuMX8Jl0PY5TuUAUNrNIPj42/pm8B4d@lists.infradead.org
X-Gm-Message-State: AFuF++m6a5l1mtLee5ep44oAs908Wp5+rO0gG7cxb3gH/6vuQK+TOoEK
	po8KiTrb2s25hZ4AuuMGJKvZ6eqkPamcQ6cgjssJVBfDbzRAPAcphxt6oWqR9F36hMc=
X-Gm-Gg: AYBFou2Pm+xEob9NYwN2X3vHwDulNtcy/78YdmY/WOerjqzYIYIdMP2HBqw3g7IMiRX
	iCdptXQ/hm5mnTBy/Cgsnmm7OvGHGVVTeZUDdUqFuTRlAsEP6XLCIc9M0Y0jWa47Z145hfPuIDJ
	jozKRdpnanMMJIGExnYFgXCFlm8XgD/gSiJn/84sSrYl/eNELsyowyEWq+BMkyNfGcugXNCLQbN
	jUFW4HxriIXVUT/m+bPYFjg7PWiAPzDXG2TSbVxMFuCadhn12ySgy+hHpP3fV6U2K/4yUROFES3
	Yoz86qR90VjTE0zBt5pMhfEybPzNmrtI66lsu4GaA3RPFxMUpdwbqmHo1NV/HY9mRjkH0AA0rEl
	8G4uqXUhl5Htu18NL9rxq8tEJeoqsGGPi4WMxJ22EH9qy/bmxvOgvhb3T+UHl2OMmesndJ0YfZE
	KYY+ACt5HMVceLmbjfx5sLL4X2RLm7iaNY4yUWt6ZC50+zjj25WTlIOCZ0hg==
X-Received: by 2002:a05:6a21:648b:b0:3bf:b84c:2984 with SMTP id adf61e73a8af0-3dd8c37d00emr15026114637.11.1789929021398;
        Sun, 20 Sep 2026 11:30:21 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:20 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v6 04/18] nvmet: Implement CCR logpage
Date: Sun, 20 Sep 2026 11:28:02 -0700
Message-ID: <20260920182936.2317916-5-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113022_605319_56958A56 
X-CRM114-Status: GOOD (  15.52  )
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
index 21538e7c83be..a60b2f271e98 100644
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
2.55.0


