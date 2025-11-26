Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62450D10372
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/6Ktrx/UQXxQ+qDpf8ETJ4IOmhLU/ttIqJExJUB/Co0=; b=diUf2U79EFHtnziWDi/Afj6rps
	TWOAyvcvUzLUupHw7guFVJZTkn9yr79FTyMGjA+W9vC1v7JtwECeiZZqHf0WF6xbPI5U6Y9ymaxBl
	//POezmaUD6UjOJndl/FFtlv7abA2g/JRz5DvPKftO4xVABe4sONapbu7e7nHv2LIkoy3ehv3QxWj
	pPsQyWFh962AtkW0Ew67Trv4gCE1PpaLIRMWqbaBIwrfg+PoAWANS+Yl7jCR43YkfsjGqt0XLg4yM
	kyEiaVGixkjVn19BpVd3ZP8plQ7Xf5MCreSx02MY4AXtVFYKwSpHBdRAKP3X01I6rQqY3GGYEFW5B
	RMycURzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO529-0000000EDOs-16HZ;
	Wed, 26 Nov 2025 02:13:29 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO525-0000000EDLV-1EoX
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:26 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-298287a26c3so71846705ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123204; x=1764728004; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/6Ktrx/UQXxQ+qDpf8ETJ4IOmhLU/ttIqJExJUB/Co0=;
        b=a3mwaSkAp/l5cvEuHnFWsdYT2T1m/Ab7FdrKzry2UILyu36+rMHPj9e+hI1uUd/rtW
         0DCLAWSyk0Hd7vMJCbeWfpebBYO6tw3wQrCcAwamfl3e6RhPEbm6G2UO3Y8UD766Y2WP
         wEr4QUwnLrUz6sDMMDi4XE555cwwd0xnKJSqZV+wnuUNyJPug9pP7uo+0DvHPLNAynBk
         HgYfHY0UlF1PcCWyDjxv5jfqq3GnLoCTLJgQo7fo4+RlfDW4h5EUw+jzMuofx6ERLDZt
         EC12AtJNabQYSW7qi9JUdgxxjZ26DbpNfiMuJQNP2kNkozl2gBXixzqka+oRGoHB+6Yz
         iMRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123204; x=1764728004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/6Ktrx/UQXxQ+qDpf8ETJ4IOmhLU/ttIqJExJUB/Co0=;
        b=VvrJoZ8yakrYf3a3xb6XVRplAEoWFPXej691fHMFtVym+SWLMA0iJfj9Lhikj12Epd
         D8wbMtvwGn3Qc6ASaV319T9rK5x53TeVsZSHSxECYXOJTV5+u/lGvkBjl71MRjM6U7lk
         tsiojBeV7Pfl2+I7y2G7EWtD8VqBhpbNHJTvQLtASxFj0o/WKt7oHcTO7bB4FxFeZrgn
         lNACp4Z42uTSdtNuJrA5r1ThmydwUru1dpHXDRAi1BcWKP5ffFUar3ibmnGNFpN7+ut8
         GbRIN2KPqREZVWKbKDVM0SfItW87Z8b8XcIDRwzHng/HsG6YPQOFt56sKxHSVmBFZ5Ma
         tnRg==
X-Forwarded-Encrypted: i=1; AJvYcCVnkcR3vamK4CcMffkfUrh1y+RiG2dsxkrNB3RtB8myJV/aCl32b2HhOfeFZP+4NM9A9b4CBbl+xhTy@lists.infradead.org
X-Gm-Message-State: AOJu0YwFEZ5rARJ5jP5M/aw3B68kkfv1gjjNzUynhkr2j4WiqHa7gRP+
	g8idQn85cWlvipAcuRu//nJxTQsO1g8OaxuRQoym5vg1ClhwHyr4TzFmVUblLD/rxF4=
X-Gm-Gg: ASbGncvzfy8a8y4C+6giPx6jztM5h+VZ3zCs8k9lq2Aa2omX2nLbBCYMy93pOXbwL96
	6MZpN/RXzphNY8XN+0th1c/zA5BBFNseafC2G++mPq8lEsW+nAPtZbjydVualEqONz/ZKblsLRl
	bmviYPNH3wL42e4R/Mv5Po+mdBQ3x8YipoHw0yt/TqwxgJ8jA0gWDVI2yyaoj6EpIa3kDQDMlFt
	aDV72S0x9VBxjlMQ4lygGBwfUrCLDR2KRqyz8oTTAguvq+yFMLJjjma01BuWOfLAzfXV3dUtkiM
	z7KtkG42pxtM60c8IQdsryCyh82FV0G9RdP4YXe0holvL614skZsHM/3gSS5LAOpNqYRThWwdfl
	ArTjGabQ0PbPI3bzRKvz7Z3aozuSQCvD9S0TVOS9REs6xHMrQQ07NaJy95hm9CRhHV6NST5K6II
	l+BR2N0rGuutq/mcoFudbrj5hXhfg1s5o/gg==
X-Google-Smtp-Source: AGHT+IGhlGJPpQ3+vlhHqQlj5aqUn4UV+qpX9NaUrwXRBSwz4d1DrNZ/KHjJ/B/28fdUcg/Ys0VOZQ==
X-Received: by 2002:a05:7022:4297:b0:11b:9386:a381 with SMTP id a92af1059eb24-11c9d871990mr13646494c88.48.1764123204091;
        Tue, 25 Nov 2025 18:13:24 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:23 -0800 (PST)
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
Subject: [RFC PATCH 03/14] nvmet: Implement CCR nvme command
Date: Tue, 25 Nov 2025 18:11:50 -0800
Message-ID: <20251126021250.2583630-4-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181325_364156_2C1381FD 
X-CRM114-Status: GOOD (  20.81  )
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
Reset) command is an nvme command the is issued to source controller by
initiator to reset impacted controller. Implement CCR command for linux
nvme target.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c | 79 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 69 ++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     | 13 ++++++
 include/linux/nvme.h            | 23 ++++++++++
 4 files changed, 184 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index aaceb697e4d2..a55ca010d34f 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -376,7 +376,9 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
 	log->acs[nvme_admin_get_features] =
 	log->acs[nvme_admin_async_event] =
 	log->acs[nvme_admin_keep_alive] =
+	log->acs[nvme_admin_cross_ctrl_reset] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
+
 }
 
 static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
@@ -1615,6 +1617,80 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ictrl, *ctrl = req->sq->ctrl;
+	struct nvme_command *cmd = req->cmd;
+	struct nvmet_ccr *ccr, *new_ccr;
+	int ccr_active, ccr_total;
+	u16 cntlid, status = 0;
+
+	cntlid = le16_to_cpu(cmd->ccr.icid);
+	if (ctrl->cntlid == cntlid) {
+		req->error_loc =
+			offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	ictrl = nvmet_ctrl_find_get_ccr(ctrl->subsys, ctrl->hostnqn,
+					cmd->ccr.ciu, cntlid,
+					le64_to_cpu(cmd->ccr.cirn));
+	if (!ictrl) {
+		/* Immediate Reset Successful */
+		nvmet_set_result(req, 1);
+		status = NVME_SC_SUCCESS;
+		goto out;
+	}
+
+	new_ccr = kmalloc(sizeof(*ccr), GFP_KERNEL);
+	if (!new_ccr) {
+		status = NVME_SC_INTERNAL;
+		goto out_put_ctrl;
+	}
+
+	ccr_total = ccr_active = 0;
+	mutex_lock(&ctrl->lock);
+	list_for_each_entry(ccr, &ctrl->ccrs, entry) {
+		if (ccr->ctrl == ictrl) {
+			status = NVME_SC_CCR_IN_PROGRESS | NVME_STATUS_DNR;
+			goto out_unlock;
+		}
+
+		ccr_total++;
+		if (ccr->ctrl)
+			ccr_active++;
+	}
+
+	if (ccr_active >= NVMF_CCR_LIMIT) {
+		status = NVME_SC_CCR_LIMIT_EXCEEDED;
+		goto out_unlock;
+	}
+	if (ccr_total >= NVMF_CCR_PER_PAGE) {
+		status = NVME_SC_CCR_LOGPAGE_FULL;
+		goto out_unlock;
+	}
+
+	new_ccr->ciu = cmd->ccr.ciu;
+	new_ccr->icid = cntlid;
+	new_ccr->ctrl = ictrl;
+	list_add_tail(&new_ccr->entry, &ctrl->ccrs);
+	mutex_unlock(&ctrl->lock);
+
+	nvmet_ctrl_fatal_error(ictrl);
+	nvmet_ctrl_put(ictrl);
+	nvmet_req_complete(req, 0);
+	return;
+
+out_unlock:
+	mutex_unlock(&ctrl->lock);
+	kfree(new_ccr);
+out_put_ctrl:
+	nvmet_ctrl_put(ictrl);
+out:
+	nvmet_req_complete(req, status);
+}
+
 u32 nvmet_admin_cmd_data_len(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -1692,6 +1768,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	case nvme_admin_keep_alive:
 		req->execute = nvmet_execute_keep_alive;
 		return 0;
+	case nvme_admin_cross_ctrl_reset:
+		req->execute = nvmet_execute_cross_ctrl_reset;
+		return 0;
 	default:
 		return nvmet_report_invalid_opcode(req);
 	}
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 409928202503..7dbe9255ff42 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -114,6 +114,20 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 	return 0;
 }
 
+void nvmet_ctrl_cleanup_ccrs(struct nvmet_ctrl *ctrl, bool all)
+{
+	struct nvmet_ccr *ccr, *tmp;
+
+	lockdep_assert_held(&ctrl->lock);
+
+	list_for_each_entry_safe(ccr, tmp, &ctrl->ccrs, entry) {
+		if (all || ccr->ctrl == NULL) {
+			list_del(&ccr->entry);
+			kfree(ccr);
+		}
+	}
+}
+
 static u32 nvmet_max_nsid(struct nvmet_subsys *subsys)
 {
 	struct nvmet_ns *cur;
@@ -1396,6 +1410,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
 		ctrl->uniquifier = ((u8)(ctrl->uniquifier + 1)) ? : 1;
 		ctrl->random = get_random_u64();
+		nvmet_ctrl_cleanup_ccrs(ctrl, false);
 	}
 	ctrl->csts = NVME_CSTS_RDY;
 
@@ -1501,6 +1516,38 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 	return ctrl;
 }
 
+struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
+					   const char *hostnqn, u8 ciu,
+					   u16 cntlid, u64 cirn)
+{
+	struct nvmet_ctrl *ctrl;
+	bool found = false;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->cntlid != cntlid)
+			continue;
+		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
+			continue;
+
+		/* Avoid racing with a controller that is becoming ready */
+		mutex_lock(&ctrl->lock);
+		if (ctrl->uniquifier == ciu && ctrl->random == cirn)
+			found = true;
+		mutex_unlock(&ctrl->lock);
+
+		if (found) {
+			if (kref_get_unless_zero(&ctrl->ref))
+				goto out;
+			break;
+		}
+	};
+	ctrl = NULL;
+out:
+	mutex_unlock(&subsys->lock);
+	return ctrl;
+}
+
 u16 nvmet_check_ctrl_status(struct nvmet_req *req)
 {
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
@@ -1626,6 +1673,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 		subsys->clear_ids = 1;
 #endif
 
+	INIT_LIST_HEAD(&ctrl->ccrs);
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
@@ -1740,12 +1788,33 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 }
 EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
 
+static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
+{
+	struct nvmet_subsys *subsys = ctrl->subsys;
+	struct nvmet_ctrl *sctrl;
+	struct nvmet_ccr *ccr;
+
+	mutex_lock(&ctrl->lock);
+	nvmet_ctrl_cleanup_ccrs(ctrl, true);
+	mutex_unlock(&ctrl->lock);
+
+	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
+		mutex_lock(&sctrl->lock);
+		list_for_each_entry(ccr, &sctrl->ccrs, entry) {
+			if (ccr->ctrl == ctrl)
+				ccr->ctrl = NULL;
+		}
+		mutex_unlock(&sctrl->lock);
+	}
+}
+
 static void nvmet_ctrl_free(struct kref *ref)
 {
 	struct nvmet_ctrl *ctrl = container_of(ref, struct nvmet_ctrl, ref);
 	struct nvmet_subsys *subsys = ctrl->subsys;
 
 	mutex_lock(&subsys->lock);
+	nvmet_ctrl_complete_pending_ccr(ctrl);
 	nvmet_ctrl_destroy_pr(ctrl);
 	nvmet_release_p2p_ns_map(ctrl);
 	list_del(&ctrl->subsys_entry);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4195c9eff1da..6c0091b8af8b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -267,6 +267,7 @@ struct nvmet_ctrl {
 	u32			kato;
 	u64			random;
 
+	struct list_head	ccrs;
 	struct nvmet_port	*port;
 
 	u32			aen_enabled;
@@ -314,6 +315,13 @@ struct nvmet_ctrl {
 	struct nvmet_pr_log_mgr pr_log_mgr;
 };
 
+struct nvmet_ccr {
+	struct nvmet_ctrl	*ctrl;
+	struct list_head	entry;
+	u16			icid;
+	u8			ciu;
+};
+
 struct nvmet_subsys {
 	enum nvme_subsys_type	type;
 
@@ -576,6 +584,7 @@ void nvmet_req_free_sgls(struct nvmet_req *req);
 void nvmet_execute_set_features(struct nvmet_req *req);
 void nvmet_execute_get_features(struct nvmet_req *req);
 void nvmet_execute_keep_alive(struct nvmet_req *req);
+void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req);
 
 u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
 u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
@@ -618,6 +627,10 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
 				       struct nvmet_req *req);
+struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
+					   const char *hostnqn, u8 ciu,
+					   u16 cntlid, u64 cirn);
+void nvmet_ctrl_cleanup_ccrs(struct nvmet_ctrl *ctrl, bool all);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req);
 ssize_t nvmet_ctrl_host_traddr(struct nvmet_ctrl *ctrl,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 5135cdc3c120..0f305b317aa3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -23,6 +23,7 @@
 
 #define NVMF_CQT_MS		0
 #define NVMF_CCR_LIMIT		4
+#define NVMF_CCR_PER_PAGE	511
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
@@ -1225,6 +1226,22 @@ struct nvme_zone_mgmt_recv_cmd {
 	__le32			cdw14[2];
 };
 
+struct nvme_cross_ctrl_reset_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__u8			rsvd10;
+	__u8			ciu;
+	__le16			icid;
+	__le32			cdw11;
+	__le64			cirn;
+	__le32			cdw14;
+	__le32			cdw15;
+};
+
 struct nvme_io_mgmt_recv_cmd {
 	__u8			opcode;
 	__u8			flags;
@@ -1323,6 +1340,7 @@ enum nvme_admin_opcode {
 	nvme_admin_virtual_mgmt		= 0x1c,
 	nvme_admin_nvme_mi_send		= 0x1d,
 	nvme_admin_nvme_mi_recv		= 0x1e,
+	nvme_admin_cross_ctrl_reset	= 0x38,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -1356,6 +1374,7 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_virtual_mgmt),	\
 		nvme_admin_opcode_name(nvme_admin_nvme_mi_send),	\
 		nvme_admin_opcode_name(nvme_admin_nvme_mi_recv),	\
+		nvme_admin_opcode_name(nvme_admin_cross_ctrl_reset),	\
 		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
 		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
 		nvme_admin_opcode_name(nvme_admin_security_send),	\
@@ -2009,6 +2028,7 @@ struct nvme_command {
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
 		struct nvme_io_mgmt_recv_cmd imr;
+		struct nvme_cross_ctrl_reset_cmd ccr;
 	};
 };
 
@@ -2173,6 +2193,9 @@ enum {
 	NVME_SC_PMR_SAN_PROHIBITED	= 0x123,
 	NVME_SC_ANA_GROUP_ID_INVALID	= 0x124,
 	NVME_SC_ANA_ATTACH_FAILED	= 0x125,
+	NVME_SC_CCR_IN_PROGRESS		= 0x13f,
+	NVME_SC_CCR_LOGPAGE_FULL	= 0x140,
+	NVME_SC_CCR_LIMIT_EXCEEDED	= 0x141,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
-- 
2.51.2


