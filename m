Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D884E60A3823
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=cSYXXv8P;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=ImPfsOi/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CG9o4q0/p9eK6cHIz1jRq27t81avh0MFxut6HWEORa4=; b=cSYXXv8PU34niY
	XdYzbo0lrq/cKEBlTtKyyVv3E+k5V6eQzolSwsshcaUAAsnsw2/CF84+YebyjvznUrEM17VcKcL2/
	CvpnBSUe+A8GsTTm31F/zG3bj/Qo8Ny5lh/gQFluzZ+PHbZ5QoAn3OW474PA5XzFhxweGSvGvCD1S
	QjZoGAnTlj5WYkIJTIf1NQ1KJWntIfSA5I4zkb3m4IQglCafvBojOs+aouYqEaSS6cjALPwCUvA7z
	CKBykNFafJv45F2KBJbLzOkL7kBoRohl5xcEr4glKUvoghRkM+3kIb/xVBttFGqvEh7iTXe/pJQwC
	sa6qr6hM8Nt26+XTTAQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45X-0000000F9sz-1LN6;
	Sat, 14 Nov 2026 03:05:59 +0000
Received: from mail-dl1-x1232.google.com ([2607:f8b0:4864:20::1232])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45Q-0000000F9hv-2PD5
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:05:54 +0000
Received: by mail-dl1-x1232.google.com with SMTP id a92af1059eb24-15dd124bbe7so979341c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:05:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625551; x=1795230351; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CG9o4q0/p9eK6cHIz1jRq27t81avh0MFxut6HWEORa4=;
        b=ImPfsOi/p8b+R9l+Jx7gUm9IhPjaHqvL6ttosIpjf3SBaZgKsmKRLhib+7tE6qY2J/
         Fsni1iW+9cqNwuXH2z9CmLjPNfjiNhEG5FB88ZEev5mwBVlIJiT339A4D+ikjXgOiT1i
         YefbTRujbZSsQ6dJda2uYfd8yCVYO8dS2sWC4WZGR/L7GGkIaIdxYCINlXnnXqgiDTu9
         wdaTyVSAWvglsLHj4VjtJ6zbtt9GBJ4gytr4wYPwiWd0hz6urmCFPbEnkvSy31+JX1lE
         S2Pkrzu9ejU7MTZLMHRSIGIliIB+Um/ixw4gqNmWPu2mXEpgI4zQJC9Orba4+y8Qe4uP
         yOLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625551; x=1795230351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CG9o4q0/p9eK6cHIz1jRq27t81avh0MFxut6HWEORa4=;
        b=yE2ZXbCR2Aqy/zsKUlfUTTSapX2hi/qP/L2ZqDOR31CXFn2eahXT4te6Mdr4J/G1ja
         Mn6dLP9oLW138MpzymchyQJXUzPTkZAf5YGiMaZBfsSVgxZhuBLjrxJCnOhXZ9zxKvKv
         4JpD7kZHTjQAJVu37FQcFxoFkpzYhTIrPPgng2g49+TPCHvNnh7zNUZBbRD1D4mGynKl
         IqhTzifpwn7TV024ulvmz5GUMI+8YeiQlNVuRXlPjAxUMCS2pgRCbI3CEE+RU+TKVMm4
         lqeSZErYjTWr+HWOwqIHfyCs0YLASRKBuNAe+vuDYsZjD5jW1r+njuJlLcka6792lkFA
         Xd7Q==
X-Forwarded-Encrypted: i=1; AL+hErG9invrRfjCq7NQMYnJDUT2BJYIhaQ8AHqqA8cX+FHFcGMgMWp/mhB3CgzshwKrlihiSLQ8skes7L97@lists.infradead.org
X-Gm-Message-State: APuU4Z9qcn38U/cbR18xdS6P/StuCKZLUCKpzP3clrjneTKMvpp9B9mO
	aEQ8wcCk5OeDRtOE77j5bh8jspVJ5cOWcBdqwiz/yI9+Oszf/gRbMVqNbo+/RO7EKUM=
X-Gm-Gg: AYBFou2BOzYyAwctq9ZI89WgcuDnOqivtvRCocG192j/76wDSVMbxJw8lAdHT2uS2qp
	lIqyAkrNCBwkIvPtC7iYLGbqxKUKQiRUlcUwbHM8iVhbpBt5gvs3J5WvJso1aVrrWHTg7H64X+h
	o3p7IHBwR7edczIG1Q5ojeW/o6p/v4e2o063jelwgIy2hch9NBLU0wXP7PlgwGYpYyXEdqhI/bh
	P4iCEkBTUr/hQ/nRHgcXc8XeVPu9UGtLyOZxMdn0xbJzu28VRg67RzsqwngvVeEXQE7zow+C7zZ
	Y+CLTJZyqycF83xn2BGjMDDuWHBk8Sk5pM6vnbX71xJLIxPEcLcl3bZ0K77GnibJgl8/U8kALAY
	ErMXZNiC258ZaKHISsOImToT/tM0Ox5lrl6hb2Rw7pH8gOmqRhXoagK2ctpO4gIjerMbtSy9qbV
	H7F5yabNpoGVEFGAa0fRtYVbmPYTbsRqhepyGOjHgxtdUQTVLKxLkW411RUQKw2QdHxgikTpNKX
	A9XE2DM91iyy5E+OW2jzDsIPH65Wg5M+fNUpWvl+TTftZWrDUCOuq6so7aMwA23ePSohFDm+15P
	9tZ9oz3yz6sP6iJek98UMXByZleK0xbIdN5IAS5wNk0RhpNevuU/Sw==
X-Received: by 2002:a05:7022:f519:b0:167:d73a:e994 with SMTP id a92af1059eb24-1b50317545bmr4203966c88.24.1794625551135;
        Fri, 13 Nov 2026 19:05:51 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:05:50 -0800 (PST)
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
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v7 03/17] nvmet: Implement CCR nvme command
Date: Fri, 13 Nov 2026 19:04:17 -0800
Message-ID: <20261114030454.2836543-4-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190552_633612_15781ABD 
X-CRM114-Status: GOOD (  21.29  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Defined by TP8028 Rapid Path Failure Recovery, CCR (Cross-Controller
Reset) command is an nvme command issued to source controller by
initiator to reset impacted controller. Implement CCR command for linux
nvme target.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 76 ++++++++++++++++++++++++++++++
 drivers/nvme/target/core.c      | 83 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h     | 13 ++++++
 include/linux/nvme.h            | 23 +++++++++
 4 files changed, 195 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5710ae53eb83..3df9db454db9 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -378,6 +378,7 @@ static void nvmet_get_cmd_effects_admin(struct nvmet_ctrl *ctrl,
 	log->acs[nvme_admin_get_features] =
 	log->acs[nvme_admin_async_event] =
 	log->acs[nvme_admin_keep_alive] =
+	log->acs[nvme_admin_cross_ctrl_reset] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 }
 
@@ -1629,6 +1630,78 @@ void nvmet_execute_keep_alive(struct nvmet_req *req)
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
+	if (!nvmet_check_transfer_len(req, 0))
+		return;
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
+	new_ccr = kmalloc_obj(*new_ccr, GFP_KERNEL);
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
@@ -1706,6 +1779,9 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
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
index 9c9ad4d9b292..86018e0fb158 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -117,6 +117,20 @@ u16 nvmet_zero_sgl(struct nvmet_req *req, off_t off, size_t len)
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
@@ -1432,6 +1446,7 @@ static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
 	if (!nvmet_is_disc_subsys(ctrl->subsys)) {
 		ctrl->ciu = ((u8)(ctrl->ciu + 1)) ? : 1;
 		ctrl->cirn = get_random_u64() ? : 1;
+		nvmet_ctrl_cleanup_ccrs(ctrl, false);
 	}
 	ctrl->csts = NVME_CSTS_RDY;
 
@@ -1537,6 +1552,42 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
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
+		if (strncmp(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE))
+			continue;
+
+		/*
+		 * Enabling the controller regenerates ciu and cirn under
+		 * ctrl->lock. Hold the lock so that a controller becoming
+		 * ready concurrently is matched against either the old or
+		 * the new instance, never a mix of both.
+		 */
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
+	}
+	mutex_unlock(&subsys->lock);
+
+	return ictrl;
+}
+
 u16 nvmet_check_ctrl_status(struct nvmet_req *req)
 {
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
@@ -1676,6 +1727,7 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	}
 #endif
 
+	INIT_LIST_HEAD(&ctrl->ccr_list);
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
 	INIT_LIST_HEAD(&ctrl->async_events);
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
@@ -1791,12 +1843,43 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
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
index fba4d320f907..5b8d87454772 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -279,6 +279,7 @@ struct nvmet_ctrl {
 	u64			cirn;
 	bool			tbkas;
 
+	struct list_head	ccr_list;
 	struct nvmet_port	*port;
 
 	u32			aen_enabled;
@@ -338,6 +339,13 @@ struct nvmet_passthru {
 	unsigned int		clear_ids;
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
 
@@ -601,6 +609,7 @@ void nvmet_req_free_sgls(struct nvmet_req *req);
 void nvmet_execute_set_features(struct nvmet_req *req);
 void nvmet_execute_get_features(struct nvmet_req *req);
 void nvmet_execute_keep_alive(struct nvmet_req *req);
+void nvmet_execute_cross_ctrl_reset(struct nvmet_req *req);
 
 u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
 u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
@@ -643,6 +652,10 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args);
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
index a3c1b1713b4f..d31c9648af43 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -22,6 +22,7 @@
 #define NVMF_TSAS_SIZE		256
 
 #define NVMF_CCR_LIMIT		4
+#define NVMF_CCR_PER_PAGE	511
 
 #define NVME_DISC_SUBSYS_NAME	"nqn.2014-08.org.nvmexpress.discovery"
 
@@ -1233,6 +1234,22 @@ struct nvme_zone_mgmt_recv_cmd {
 	__le32			cdw14[2];
 };
 
+struct nvme_cross_ctrl_reset_cmd {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__le64			rsvd2[2];
+	union nvme_data_ptr	dptr;
+	__le16			icid;
+	__u8			ciu;
+	__u8			rsvd10;
+	__le32			cdw11;
+	__le64			cirn;
+	__le32			cdw14;
+	__le32			cdw15;
+};
+
 struct nvme_io_mgmt_recv_cmd {
 	__u8			opcode;
 	__u8			flags;
@@ -1331,6 +1348,7 @@ enum nvme_admin_opcode {
 	nvme_admin_virtual_mgmt		= 0x1c,
 	nvme_admin_nvme_mi_send		= 0x1d,
 	nvme_admin_nvme_mi_recv		= 0x1e,
+	nvme_admin_cross_ctrl_reset	= 0x38,
 	nvme_admin_dbbuf		= 0x7C,
 	nvme_admin_format_nvm		= 0x80,
 	nvme_admin_security_send	= 0x81,
@@ -1364,6 +1382,7 @@ enum nvme_admin_opcode {
 		nvme_admin_opcode_name(nvme_admin_virtual_mgmt),	\
 		nvme_admin_opcode_name(nvme_admin_nvme_mi_send),	\
 		nvme_admin_opcode_name(nvme_admin_nvme_mi_recv),	\
+		nvme_admin_opcode_name(nvme_admin_cross_ctrl_reset),	\
 		nvme_admin_opcode_name(nvme_admin_dbbuf),		\
 		nvme_admin_opcode_name(nvme_admin_format_nvm),		\
 		nvme_admin_opcode_name(nvme_admin_security_send),	\
@@ -2022,6 +2041,7 @@ struct nvme_command {
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
 		struct nvme_io_mgmt_recv_cmd imr;
+		struct nvme_cross_ctrl_reset_cmd ccr;
 	};
 };
 
@@ -2186,6 +2206,9 @@ enum {
 	NVME_SC_PMR_SAN_PROHIBITED	= 0x123,
 	NVME_SC_ANA_GROUP_ID_INVALID	= 0x124,
 	NVME_SC_ANA_ATTACH_FAILED	= 0x125,
+	NVME_SC_CCR_IN_PROGRESS		= 0x13f,
+	NVME_SC_CCR_LOGPAGE_FULL	= 0x140,
+	NVME_SC_CCR_LIMIT_EXCEEDED	= 0x141,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
-- 
2.56.0


