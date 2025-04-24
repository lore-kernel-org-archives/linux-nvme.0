Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12FA2C369AB
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Apr 2025 05:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CvHuGaeN1z91zLlmdTrVuujslUTVzgR26uOOf4mjcaI=; b=44xn+5lwFPnE1F9TlZD6q3Vntn
	8CPGaH2hiieNMKeo44hDllPEm1ipE5X0NHzThcux7zmnDXs2cgWOhUCOzpDNEc5175qGEsj9yuYQI
	TReTneLSpV5+FNYWMRQiLEjPpvLL+BGBT4b36/SOhamDanBuv3YQ/XSu1tAZD4wgbnkzqsz+cSwes
	snB80lkZotfWjisdGU3cc6GGbsvHDg0mR79S88DmNHkZGKn0MyotHssdrTY7kNQxrXwx8blEpzSTb
	m/KK+txuvtCCegBmqs/TUmP4EGgT3RGuHEsdXHyK98v60YbOWfoshX5A5P1zjA+FTrGhSlbFmlM42
	fx2CgXPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ouy-0000000CrP0-2Bju;
	Thu, 24 Apr 2025 05:14:36 +0000
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u7ouv-0000000CrNp-1veM
	for linux-nvme@lists.infradead.org;
	Thu, 24 Apr 2025 05:14:34 +0000
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-739525d4e12so472135b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 23 Apr 2025 22:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745471672; x=1746076472; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CvHuGaeN1z91zLlmdTrVuujslUTVzgR26uOOf4mjcaI=;
        b=l42vV/Q97Mdt//8f2JVOAedy/6SLAeQY7K6bYfWLksyj+j/GOSlQJeDw+ORrIZftZQ
         k81yyrFHAq7tQjTy2FeiCCxXKgXiCO8QWIXVTq+koyAvBscwedJ2KvU8RFw9DWuIeiJN
         O1xIKxPI8fAcF84hfx0DHYHeIfMyyEjwdHqJ7rzdJQ3MrEe0iFB9wk1m+QzFQSKEqDwv
         tp2Gz+D2FIYT08mPLDfrrHDNMv/0INxleq00deAfIDP3xuIuDd7ZACMT3GgpChniKyv1
         ZoQ5ZCn1Z6paY6miA64r2lDp+aGZXKsg0keYRcpWW8RGleuu6751Ck7PTfCVWCV7Yt4/
         1mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745471672; x=1746076472;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CvHuGaeN1z91zLlmdTrVuujslUTVzgR26uOOf4mjcaI=;
        b=rlOZkz0FdlKw7Wrng3z/6n0gLlCURBYmnCI/UaaYes7PtnQULxwbdJ98Dvtx02PcUG
         hIONdd5oWAirnX3alDhZfP1Df2NXMANJfmxlBb9dOKrtRi+05vRyi9hVZwF2NkinOGIy
         ajXH1BP+729o03Ijdz1PIjSD+s0BV0bNmq5Epj8jpDoXobwdoNKJQjp953OPXKUP1JDV
         GmWNvEi1KeH7hHUawpbCKPz7HKBSRp46A7ELAznqyMzgkSo73SiShmoGsjhThhb8oZUF
         3RMZCEnjbPj4lfvxG4ZcKs4foKF27edhuYTqsJURzMrwcPEbyYx5hu6A/XWrnrU4ZKJa
         0XxA==
X-Gm-Message-State: AOJu0Ywt1ObtGaI57PN6mtp/3KeeCV1midLcXoysYGvHjxy9sg6mmQ5z
	jthkTUs61NEyUv/gsNKTgqnaNCOzbF+HFRsnkWcEmAIDsCnHDooCuAN6dvLm
X-Gm-Gg: ASbGnct2XHG7/ATLPdD7pMEtghkVvxrVQjJMKDXf7rHWt3euLOcwdIcJS5w8GSU6fV6
	SV6QpK4piSx3l6TJGkLKaSv5zibvkwo77sgV+AMkwyRCO27fxJT3xk2KdVBfUnAtSOj5+IeqpmA
	8Kws0SdZOwzU5eVU3bDL3sn8k52Z11B7K6C6ad6Ve6vtNpTLy69em1poYcMH3sZo9fkWPdPg/yy
	rQEOXV2HnGmKk6UIgsVyrZmu47nGWSvyYfEuH49ZA8myEebcc0i4lT3xTSfig+q+GOu6A9Xy5ou
	aIxmZAEwJd8aief/wlUjqQ43h0Q9hgpamNqiCJitUDCLLdU=
X-Google-Smtp-Source: AGHT+IH5sRNZrCzsB46Svceumw4+RFWsIJAYHSdURsLej6ELvF4o9tLrcck6DT9QBe18Ivgi8+m85Q==
X-Received: by 2002:a17:90b:5847:b0:2ff:5e4e:861 with SMTP id 98e67ed59e1d1-309ed34bb12mr2228818a91.24.1745471672364;
        Wed, 23 Apr 2025 22:14:32 -0700 (PDT)
Received: from fedora.. ([159.196.5.243])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309ef097bdbsm324771a91.26.2025.04.23.22.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 22:14:31 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: dlemoal@kernel.org,
	alistair.francis@wdc.com,
	cassel@kernel.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH 2/5] nvmet: cq: prepare for completion queue sharing
Date: Thu, 24 Apr 2025 15:13:50 +1000
Message-ID: <20250424051352.7980-4-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250424051352.7980-2-wilfred.opensource@gmail.com>
References: <20250424051352.7980-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250423_221433_507216_DB91590D 
X-CRM114-Status: GOOD (  29.42  )
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

For the PCI transport, the NVMe specification allows submission queues to
share completion queues, however, this is not supported in the current
NVMe target implementation. This is a preparatory patch to allow for
completion queue (CQ) sharing between different submission queues (SQ).

To support queue sharing, reference counting completion queues is
required. This patch adds the refcount_t field ref to struct nvmet_cq
coupled with respective nvmet_cq_init(), nvmet_cq_get(), nvmet_cq_put(),
nvmet_cq_is_deletable() and nvmet_cq_destroy() functions.

A CQ reference count is initialized with nvmet_cq_init() when a CQ is
created. Using nvmet_cq_get(), a reference to a CQ is taken when an SQ is
created that uses the respective CQ. Similarly. when an SQ is destroyed,
the reference count to the respective CQ from the SQ being destroyed is
decremented with nvmet_cq_put(). The last reference to a CQ is dropped
on a CQ deletion using nvmet_cq_put(), which invokes nvmet_cq_destroy()
to fully cleanup after the CQ. The helper function nvmet_cq_in_use() is
used to determine if any SQs are still using the CQ pending deletion.
In which case, the CQ must not be deleted. This should protect scenarios
where a bad host may attempt to delete a CQ without first having deleted
SQ(s) using that CQ.

Additionally, this patch adds an array of struct nvmet_cq to the
nvmet_ctrl structure. This allows for the controller to keep track of CQs
as they are created and destroyed, similar to the current tracking done
for SQs. The memory for this array is freed when the controller is freed.
A struct nvmet_ctrl reference is also added to the nvmet_cq structure to
allow for CQs to be removed from the controller whilst keeping the new API
similar to the existing API for SQs.

Sample callchain with CQ refcounting for the PCI endpoint target
(pci-epf):

i.   nvmet_execute_create_cq -> nvmet_pci_epf_create_cq -> nvmet_cq_create
     -> nvmet_cq_init [cq refcount=1]

ii.  nvmet_execute_create_sq -> nvmet_pci_epf_create_sq -> nvmet_sq_create
     -> nvmet_sq_init -> nvmet_cq_get [cq refcount=2]

iii. nvmet_execute_delete_sq - > nvmet_pci_epf_delete_sq ->
     -> nvmet_sq_destroy -> nvmet_cq_put [cq refcount 1]

iv.  nvmet_execute_delete_cq -> nvmet_pci_epf_delete_cq -> nvmet_cq_put
     [cq refcount 0]

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 drivers/nvme/target/admin-cmd.c |  4 +-
 drivers/nvme/target/core.c      | 68 +++++++++++++++++++++++++--------
 drivers/nvme/target/nvmet.h     | 12 +++++-
 drivers/nvme/target/pci-epf.c   |  1 +
 4 files changed, 66 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 753166fbb133..5e3699973d56 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -96,7 +96,7 @@ static void nvmet_execute_delete_cq(struct nvmet_req *req)
 		goto complete;
 	}
 
-	status = nvmet_check_io_cqid(ctrl, cqid);
+	status = nvmet_check_io_cqid(ctrl, cqid, false);
 	if (status != NVME_SC_SUCCESS)
 		goto complete;
 
@@ -122,7 +122,7 @@ static void nvmet_execute_create_cq(struct nvmet_req *req)
 		goto complete;
 	}
 
-	status = nvmet_check_io_cqid(ctrl, cqid);
+	status = nvmet_check_io_cqid(ctrl, cqid, true);
 	if (status != NVME_SC_SUCCESS)
 		goto complete;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4c0643a72f66..a622a6b886cb 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -810,11 +810,43 @@ void nvmet_req_complete(struct nvmet_req *req, u16 status)
 }
 EXPORT_SYMBOL_GPL(nvmet_req_complete);
 
+void nvmet_cq_init(struct nvmet_cq *cq)
+{
+	refcount_set(&cq->ref, 1);
+}
+EXPORT_SYMBOL_GPL(nvmet_cq_init);
+
+bool nvmet_cq_get(struct nvmet_cq *cq)
+{
+	return refcount_inc_not_zero(&cq->ref);
+}
+EXPORT_SYMBOL_GPL(nvmet_cq_get);
+
+void nvmet_cq_put(struct nvmet_cq *cq)
+{
+	if (refcount_dec_and_test(&cq->ref))
+		nvmet_cq_destroy(cq);
+}
+EXPORT_SYMBOL_GPL(nvmet_cq_put);
+
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 		u16 qid, u16 size)
 {
 	cq->qid = qid;
 	cq->size = size;
+
+	ctrl->cqs[qid] = cq;
+}
+
+void nvmet_cq_destroy(struct nvmet_cq *cq)
+{
+	struct nvmet_ctrl *ctrl = cq->ctrl;
+
+	if (ctrl) {
+		ctrl->cqs[cq->qid] = NULL;
+		nvmet_ctrl_put(cq->ctrl);
+		cq->ctrl = NULL;
+	}
 }
 
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
@@ -834,41 +866,39 @@ static void nvmet_confirm_sq(struct percpu_ref *ref)
 	complete(&sq->confirm_done);
 }
 
-u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid)
+u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create)
 {
-	if (!ctrl->sqs)
+	if (!ctrl->cqs)
 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 
 	if (cqid > ctrl->subsys->max_qid)
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
-	/*
-	 * Note: For PCI controllers, the NVMe specifications allows multiple
-	 * SQs to share a single CQ. However, we do not support this yet, so
-	 * check that there is no SQ defined for a CQ. If one exist, then the
-	 * CQ ID is invalid for creation as well as when the CQ is being
-	 * deleted (as that would mean that the SQ was not deleted before the
-	 * CQ).
-	 */
-	if (ctrl->sqs[cqid])
+	if ((create && ctrl->cqs[cqid]) || (!create && !ctrl->cqs[cqid]))
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
 	return NVME_SC_SUCCESS;
 }
 
-u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid)
+u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create)
 {
 	if (!cqid)
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
-	return nvmet_check_cqid(ctrl, cqid);
+	return nvmet_check_cqid(ctrl, cqid, create);
 }
 
+bool nvmet_cq_in_use(struct nvmet_cq *cq)
+{
+	return refcount_read(&cq->ref) > 1;
+}
+EXPORT_SYMBOL_GPL(nvmet_cq_in_use);
+
 u16 nvmet_cq_create(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 		    u16 qid, u16 size)
 {
 	u16 status;
 
-	status = nvmet_check_cqid(ctrl, qid);
+	status = nvmet_check_cqid(ctrl, qid, true);
 	if (status != NVME_SC_SUCCESS)
 		return status;
 
@@ -1616,12 +1646,17 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (!ctrl->sqs)
 		goto out_free_changed_ns_list;
 
+	ctrl->cqs = kcalloc(subsys->max_qid + 1, sizeof(struct nvmet_cq *),
+			   GFP_KERNEL);
+	if (!ctrl->cqs)
+		goto out_free_sqs;
+
 	ret = ida_alloc_range(&cntlid_ida,
 			     subsys->cntlid_min, subsys->cntlid_max,
 			     GFP_KERNEL);
 	if (ret < 0) {
 		args->status = NVME_SC_CONNECT_CTRL_BUSY | NVME_STATUS_DNR;
-		goto out_free_sqs;
+		goto out_free_cqs;
 	}
 	ctrl->cntlid = ret;
 
@@ -1680,6 +1715,8 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	mutex_unlock(&subsys->lock);
 	nvmet_stop_keep_alive_timer(ctrl);
 	ida_free(&cntlid_ida, ctrl->cntlid);
+out_free_cqs:
+	kfree(ctrl->cqs);
 out_free_sqs:
 	kfree(ctrl->sqs);
 out_free_changed_ns_list:
@@ -1716,6 +1753,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 
 	nvmet_async_events_free(ctrl);
 	kfree(ctrl->sqs);
+	kfree(ctrl->cqs);
 	kfree(ctrl->changed_ns_list);
 	kfree(ctrl);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2f70db1284c9..c87f6fb458e8 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -141,8 +141,10 @@ static inline struct device *nvmet_ns_dev(struct nvmet_ns *ns)
 }
 
 struct nvmet_cq {
+	struct nvmet_ctrl	*ctrl;
 	u16			qid;
 	u16			size;
+	refcount_t		ref;
 };
 
 struct nvmet_sq {
@@ -247,6 +249,7 @@ struct nvmet_pr_log_mgr {
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
+	struct nvmet_cq		**cqs;
 
 	void			*drvdata;
 
@@ -571,12 +574,17 @@ void nvmet_execute_set_features(struct nvmet_req *req);
 void nvmet_execute_get_features(struct nvmet_req *req);
 void nvmet_execute_keep_alive(struct nvmet_req *req);
 
-u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid);
-u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid);
+u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
+u16 nvmet_check_io_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create);
+void nvmet_cq_init(struct nvmet_cq *cq);
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
 u16 nvmet_cq_create(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
+void nvmet_cq_destroy(struct nvmet_cq *cq);
+bool nvmet_cq_get(struct nvmet_cq *cq);
+void nvmet_cq_put(struct nvmet_cq *cq);
+bool nvmet_cq_in_use(struct nvmet_cq *cq);
 u16 nvmet_check_sqid(struct nvmet_ctrl *ctrl, u16 sqid, bool create);
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
 		u16 size);
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 7fab7f3d79b7..7dda4156d86c 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1346,6 +1346,7 @@ static u16 nvmet_pci_epf_delete_cq(struct nvmet_ctrl *tctrl, u16 cqid)
 	nvmet_pci_epf_drain_queue(cq);
 	nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
 	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
+	tctrl->cqs[cqid] = NULL;
 
 	return NVME_SC_SUCCESS;
 }
-- 
2.49.0


