Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9B64EF99FD
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ujn7W+4lPH9KY9lfQwvZKjDUpNnsTIoIT7dQKW4fPmw=; b=oA2QB6mStb8kbBJW68Hq/iduC9
	Zpn3CEZKZyMue6IKnpYEi3Qkna79cz7QM7UvWeSFQraGLQi8AlFgd+zyP//w1SBs0XTLXKtx3p8fH
	H3fOZggTMS1pdA+eHbwwoj+4wv2d80tifWnHGm0OiNzy2fwonRjo34SPesIzCJjn20chfG4B9+VQQ
	kFpD6jCHOWOBgV6rsW1sx143bkgA+3yhrD742IQ906rBJrK1a/6RolnYJajeFaiLjLNtCYCNXiqIS
	1l0KhkzKyUq4jN7VUHE6tnh0TUgmtpuSxIqTfyV9GfWbnejR8lkaEBIph8Boj9It8Np6O07xvMia6
	o6oueSdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Ge-00000004Eyv-2yTv;
	Sat, 14 Feb 2026 04:28:28 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Ga-00000004Eve-33rQ
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:26 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-1248d27f293so3710730c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043304; x=1771648104; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ujn7W+4lPH9KY9lfQwvZKjDUpNnsTIoIT7dQKW4fPmw=;
        b=eRKtjcSRWnzOdMU0DtbukKnnIDVTCzoZm8ws5kaz523LwFxoY+tXTEUqQ1xlinI54B
         Vz/QsJ6wYFl3vf71sZym8YAw1s4nh+qE5F69BfnioJnoOIWnzFV/ceNNtJNGEuDoT6Hh
         nVCxpebtDOG5tmXmBzR7ZE1R080Fhe6BROFHIeeHv6S3YzUw0vyNCLu9UJH6HAecila2
         Ey3AOz4T2kCLS6hWp78ICZ6Wb09ARjj/Bq9mmFcnLvSAMRXafPj/PKIxuvInt44/RAoC
         EOdFKLzdrJCX5WIOEaWsh+B4P7y8cbOMeoPbxol12pcRBrH5Jjm3xTtSn3N0xZFEVJ0J
         YnRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043304; x=1771648104;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ujn7W+4lPH9KY9lfQwvZKjDUpNnsTIoIT7dQKW4fPmw=;
        b=cHEv9Cg31LyVacnzq3WbZhgQWmCaWdlHHj6nsV72DDHh7X59ha84rLEUEDyHV4iBCj
         HGj7C4+Exwx1xQVAnknTV1PlGET/2dfsbwUg+ttWWiRmsjT4Rpz/lJrFgzQMRrFgTD6v
         XN5EEQ/Fu8csfCTA0kgs/rkZhC9haFRB2UezuZHBSCXHuxWnaH2eDCjgafDdo5Y+KanE
         A1A5gp15Dn4teWNX+uDoePLtR8Bq1JzOCQCqthdzjsNCMRN48v8g6zsIBj7/+3rETuLn
         T51Z9YdPSlvTImpsUW9+4FaXUzfZhVVgCSq5PLeIBT77XKO2KBmaxDy5JbhbvxHc/ifi
         /k0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxW1NiOl284gc+Kfrp/LmKiUa8m5C2EfOLm0fJdUbyeETCu2ZfVdbrpx+lk58gms2Obw7j6llWVvGE@lists.infradead.org
X-Gm-Message-State: AOJu0YxTqi0Sv2U3cZt/C8c4Tdqw7I785wGfDquyRTWu5OOTf0cj8mrN
	SGK7gLRL/DcxxWF+kfOZRx3Q9EQf4OIHc+Aq0wQ+UGC7aoa7d26htF05oGw6aCIpj7U=
X-Gm-Gg: AZuq6aLUAubhkvZrnkojCzffoBcUHBI64yyJcwTpGB2yucYU+bdFhSqhwTI01Ib650K
	pZb4L4NdYvwkEyKfhS1Tg3MmvcVVFqaFWkRViUUyQkSSCbjfgPKA7Ak3bzcfTPsmifkNCvnQT8P
	K/p46oYOkqrEgQpogXyusYoW+lhqQI7Q4veuVq83WVG6Y2qWJ/1OSLsChRRqSs6ZFUu8xbfSbiD
	MMn1aCbWGs9CQFIdKPz770aQh/N1SU+8I9atD+pEZBV7MQBWbrXKVX94Fwd7iq9Mi9LJJaI19S3
	7cEBjYbs3BeYugInW0SREy/kOzovr1v/HzRYZ3Bt1SgdniKnbfNdiohggbeULoc/dBKZdv0kHfK
	Vg3/3mKbcEqP86lToTj6C9K42p18SZl5lVmKqfL0qkQxlEsRZiVj9/lVaD/0/OvU6G0gKqinET3
	XDzB83UCRkHrKqjekrtOz2Nt7toiyNxiIIV21y4LE5jlpRwg==
X-Received: by 2002:a05:7022:4384:b0:119:e56b:c752 with SMTP id a92af1059eb24-1273ae6989cmr1603645c88.23.1771043303588;
        Fri, 13 Feb 2026 20:28:23 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:23 -0800 (PST)
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
Subject: [PATCH v3 03/21] nvmet: Implement CCR nvme command
Date: Fri, 13 Feb 2026 20:25:04 -0800
Message-ID: <20260214042753.4073668-4-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202824_776890_0CE42075 
X-CRM114-Status: GOOD (  19.99  )
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
Reset) command is an nvme command issued to source controller by
initiator to reset impacted controller. Implement CCR command for linux
nvme target.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/target/admin-cmd.c | 74 ++++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 76 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     | 13 ++++++
 include/linux/nvme.h            | 23 ++++++++++
 4 files changed, 186 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 368e36362ac5..65ed772babb8 100644
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
@@ -1614,6 +1616,75 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
+void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ictrl, *sctrl = req->sq->ctrl;
+	struct nvme_command *cmd = req->cmd;
+	struct nvmet_ccr *ccr, *new_ccr;
+	int ccr_active, ccr_total;
+	u16 cntlid, status = NVME_SC_SUCCESS;
+
+	cntlid = le16_to_cpu(cmd->ccr.icid);
+	if (sctrl->cntlid == cntlid) {
+		req->error_loc =
+			offsetof(struct nvme_cross_ctrl_reset_cmd, icid);
+		status = NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
+		goto out;
+	}
+
+	/* Find and get impacted controller */
+	ictrl = nvmet_ctrl_find_get_ccr(sctrl->subsys, sctrl->hostnqn,
+					cmd->ccr.ciu, cntlid,
+					le64_to_cpu(cmd->ccr.cirn));
+	if (!ictrl) {
+		/* Immediate Reset Successful */
+		nvmet_set_result(req, 1);
+		status = NVME_SC_SUCCESS;
+		goto out;
+	}
+
+	ccr_total = ccr_active = 0;
+	mutex_lock(&sctrl->lock);
+	list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
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
+	new_ccr = kmalloc(sizeof(*new_ccr), GFP_KERNEL);
+	if (!new_ccr) {
+		status = NVME_SC_INTERNAL;
+		goto out_unlock;
+	}
+
+	new_ccr->ciu = cmd->ccr.ciu;
+	new_ccr->icid = cntlid;
+	new_ccr->ctrl = ictrl;
+	list_add_tail(&new_ccr->entry, &sctrl->ccr_list);
+
+out_unlock:
+	mutex_unlock(&sctrl->lock);
+	if (status == NVME_SC_SUCCESS)
+		nvmet_ctrl_fatal_error(ictrl);
+	nvmet_ctrl_put(ictrl);
+out:
+	nvmet_req_complete(req, status);
+}
+
 u32 nvmet_admin_cmd_data_len(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -1691,6 +1762,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
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
index e5f413405604..38f71e1a1b8e 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -115,6 +115,20 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
 	return 0;
 }
 
+void nvmet_ctrl_cleanup_ccrs(struct nvmet_ctrl *ctrl, bool all)
+{
+	struct nvmet_ccr *ccr, *tmp;
+
+	lockdep_assert_held(&ctrl->lock);
+
+	list_for_each_entry_safe(ccr, tmp, &ctrl->ccr_list, entry) {
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
@@ -1397,6 +1411,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
 		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
 		ctrl->cirn = get_random_u64();
+		nvmet_ctrl_cleanup_ccrs(ctrl, false);
 	}
 	ctrl->csts = NVME_CSTS_RDY;
 
@@ -1502,6 +1517,35 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 	return ctrl;
 }
 
+struct nvmet_ctrl *nvmet_ctrl_find_get_ccr(struct nvmet_subsys *subsys,
+					   const char *hostnqn, u8 ciu,
+					   u16 cntlid, u64 cirn)
+{
+	struct nvmet_ctrl *ctrl, *ictrl = NULL;
+	bool found = false;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->cntlid != cntlid)
+			continue;
+
+		/* Avoid racing with a controller that is becoming ready */
+		mutex_lock(&ctrl->lock);
+		if (ctrl->ciu == ciu && ctrl->cirn == cirn)
+			found = true;
+		mutex_unlock(&ctrl->lock);
+
+		if (found) {
+			if (kref_get_unless_zero(&ctrl->ref))
+				ictrl = ctrl;
+			break;
+		}
+	};
+	mutex_unlock(&subsys->lock);
+
+	return ictrl;
+}
+
 u16 nvmet_check_ctrl_status(struct nvmet_req *req)
 {
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
@@ -1627,6 +1671,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 		subsys->clear_ids = 1;
 #endif
 
+	INIT_LIST_HEAD(&ctrl->ccr_list);
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
@@ -1740,12 +1785,43 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 }
 EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
 
+static void nvmet_ctrl_complete_pending_ccr(struct nvmet_ctrl *ctrl)
+{
+	struct nvmet_subsys *subsys = ctrl->subsys;
+	struct nvmet_ctrl *sctrl;
+	struct nvmet_ccr *ccr;
+
+	lockdep_assert_held(&subsys->lock);
+
+	/* Cleanup all CCRs issued by ctrl as source controller */
+	mutex_lock(&ctrl->lock);
+	nvmet_ctrl_cleanup_ccrs(ctrl, true);
+	mutex_unlock(&ctrl->lock);
+
+	/*
+	 * Find all CCRs targeting ctrl as impacted controller and
+	 * set ccr->ctrl to NULL. This tells the source controller
+	 * that CCR completed successfully.
+	 */
+	list_for_each_entry(sctrl, &subsys->ctrls, subsys_entry) {
+		mutex_lock(&sctrl->lock);
+		list_for_each_entry(ccr, &sctrl->ccr_list, entry) {
+			if (ccr->ctrl == ctrl) {
+				ccr->ctrl = NULL;
+				break;
+			}
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
index a36daa5d3a57..b06d905c08c8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -268,6 +268,7 @@ struct nvmet_ctrl {
 	u32			kato;
 	u64			cirn;
 
+	struct list_head	ccr_list;
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
index 7746b6d30349..d9b421dc1ef3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -22,6 +22,7 @@
 #define NVMF_TSAS_SIZE		256
 
 #define NVMF_CCR_LIMIT		4
+#define NVMF_CCR_PER_PAGE	511
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
@@ -1222,6 +1223,22 @@ struct nvme_zone_mgmt_recv_cmd {
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
@@ -1320,6 +1337,7 @@ enum nvme_admin_opcode {
 	nvme_admin_virtual_mgmt		= 0x1c,
 	nvme_admin_nvme_mi_send		= 0x1d,
 	nvme_admin_nvme_mi_recv		= 0x1e,
+	nvme_admin_cross_ctrl_reset	= 0x38,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -1353,6 +1371,7 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_virtual_mgmt),	\
 		nvme_admin_opcode_name(nvme_admin_nvme_mi_send),	\
 		nvme_admin_opcode_name(nvme_admin_nvme_mi_recv),	\
+		nvme_admin_opcode_name(nvme_admin_cross_ctrl_reset),	\
 		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
 		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
 		nvme_admin_opcode_name(nvme_admin_security_send),	\
@@ -2006,6 +2025,7 @@ struct nvme_command {
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
 		struct nvme_io_mgmt_recv_cmd imr;
+		struct nvme_cross_ctrl_reset_cmd ccr;
 	};
 };
 
@@ -2170,6 +2190,9 @@ enum {
 	NVME_SC_PMR_SAN_PROHIBITED	= 0x123,
 	NVME_SC_ANA_GROUP_ID_INVALID	= 0x124,
 	NVME_SC_ANA_ATTACH_FAILED	= 0x125,
+	NVME_SC_CCR_IN_PROGRESS		= 0x13f,
+	NVME_SC_CCR_LOGPAGE_FULL	= 0x140,
+	NVME_SC_CCR_LIMIT_EXCEEDED	= 0x141,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
-- 
2.52.0


