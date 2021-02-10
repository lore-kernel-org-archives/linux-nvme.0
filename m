Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E536AC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7599764DE1
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:48:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7599764DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=B1Gqjt8OdONMrVrvHcgcTKhzD48GQR2tewnNQQaynvs=; b=vzpehP+lDUIUGEGiB+vyKa4vi
	ph9BYhfFpym0f0mlt2oTcFRvdSeCOLJqU77ZcnEt1inVFuMoask+QRKdtM6BzgDVMjOzuCiZlSAOn
	h1Doa0TS8Rj76TQ0NUSWYdiOVJPKmxdZ4vROb4tLp1h+Rjsk144iR3baa8JW+NoOzQbh3khqzfhis
	9Z77LNEhBFIMcbOvJSjqswe+m5osLkv7NQqHSUo1NqMlnQlUm2qeCLKveP7xbCxC9t4xr2QMcohYG
	evhS36Kc4SvE/oSU/wUfdmtwhNfsk7Ruip7PRNfG0TyyYL5kx/WrVbZjF20FScjof1uvDC735tOqp
	CvEmhm9RA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iMd-0006qa-9f; Wed, 10 Feb 2021 05:48:35 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iMa-0006pN-VY
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:48:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936113; x=1644472113;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=y7P0LGTqQeRF4kjTSzN8914iE/PrAFTuHX8NttiXPMA=;
 b=Ud8uL6ZBkO2HYAHniEgoZY6ow+D8xZ5UEiz9ljFHvc7HGjD/KnXBnhoR
 vR5RGerXuaKa0tmnrR6Nhctp5s7zSagTQXaYoffMTCwO/dcvQysMCurit
 t2QHuf2GPDRO36OtxkDYanUbYmWVLWcKwmLeGi6ESyXeHFL+hwMmyA7T+
 WRqxIZ3SURxh7Zp10vDMl/lTpcX7MCYZTc4JsZFae0u4JNvqtybTw//Qj
 rlCScnX4IfCLCjRac/CNG0AwZfIQ2P7yMGIWgJrhZpqC7y0DohLAemCKo
 5d0LZyDcGJOqh4VvZNLerTaEhacYVvMl8ACx9mgZ7iIxocrP6LJ1M3t4h g==;
IronPort-SDR: iqClHdi1Kt+3AnZdmE/gAGgmBSt4AyM2nFqTcp6Oj8tXK0yob26AvQGCchsZFlYYbx5AMRHi2q
 EMUoPKIJbO3q6+B46qREa1LQdHQnW34rHY6J1/o8zSUcBGRK46CimoltdbPAJ0S8gbwKYUUF6B
 KbXGRcWj+rmo+dHT73nFtCuPGGwZAAeDskxnJDh3Uk29UnvX57ypSKh3fkLJWIzzIiPbrQzc7o
 iW7CaV0z/uJj4pzpLr3cxMcccwBxJiClOlMXsGKtgiv9etTkXKMmwMgGLdPLuTkEHev93EtPCP
 1f8=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="159609238"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:48:31 +0800
IronPort-SDR: ObDcbjv8UeBbS7XlaXbG90aKRW3gPhwQEYCWJow3LRD13Uh5OXCAwph9drFka1NNF1DgYKIw6N
 KUOAUljGY1IRdYc8X929YmskHFfBMARL52cbjM8xdDDMZw3L1gfPFnZHSWzwA3d68bd/+/D4+E
 tMMD/03qs3+VA+ftfqAmRtLwRVacaSRSwKEZz3ufWGSss3UXzb8UMlXG1n5UvnRReeGbCFKbeY
 2rJkjFZkVDqffqDjP3hzJTnJAL14QySCJgs+/OgRgR4VC0EgTxc9+uX4Yud/AAu/XnAqnI+v9f
 fEuXK5AqmPP3TRHRsUrOD2Fl
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:32:14 -0800
IronPort-SDR: 4YhWZ615IQRgM44lxIeHWJfJ7/rRS1Hw2c989lNXlM5HAuQHjjsrghEA+rM+PhbqpoeA0VoiQj
 Mx1P6gAQP/bVhEciX2vGxrTUhijL1i0vP9XYgopj+ibDlfEOQQupN7AlbVpjNom9Ibcc8UMD8p
 cutI1QVVM2iz6G8Oim5Gd39p5UR6EkVgHAn3E4PiiWvy0AF2ZTQSEN6pDQZDhO3zOyZ52ua+Ol
 yVtVT1dpThAE7yNtEeFaZPqnC9jxRHnczd/dXKPIbPa3Yu9LR2ClEbKouOk7QgqOEhMI5YMvM0
 HE4=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:48:31 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 03/11] nvmet: make nvmet_find_namespace() req based
Date: Tue,  9 Feb 2021 21:47:54 -0800
Message-Id: <20210210054802.34269-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004833_186335_FEEB21FF 
X-CRM114-Status: GOOD (  18.50  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The six callers of nvmet_find_namespace() duplicate the error log page
update and status setting code for each call on failure.

All callers are nvmet requests based functions, so we can pass req
to the nvmet_find_namesapce() & derive ctrl from req, that'll allow us
to update the error log page in nvmet_find_namespace(). Now that we
pass the request we can also get rid of the local variable in
nvmet_find_namespace() and use the req->ns and return the error code.

Replace the ctrl parameter with nvmet_req for nvmet_find_namespace(),
centralize the error log page update for non allocated namesapces, and
return uniform error for non-allocated namespace.

The nvmet_find_namespace() takes nsid parameter which is from NVMe
commands structures such as get_log_page, identify, rw and common. All
these commands have same offset for the nsid field.

Derive nsid from req->cmd->common.nsid) & remove the extra parameter
from the nvmet_find_namespace().

Lastly now we associate the ns to the req parameter that we pass to the
nvmet_find_namespace(), rename the nvmet_find_namespace() to
nvmet_req_find_ns() i.e. :-

Old:-
struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl,
				      __le32 nsid)
New :-
u16 nvmet_req_find_ns(struct nvmet_req *req);

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 46 +++++++++++++--------------------
 drivers/nvme/target/core.c      | 24 +++++++++--------
 drivers/nvme/target/nvmet.h     |  2 +-
 3 files changed, 32 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e938064254a5..f32533480e66 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -75,15 +75,11 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
 	u64 host_reads, host_writes, data_units_read, data_units_written;
+	u16 status;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl,
-				       req->cmd->get_log_page.nsid);
-	if (!req->ns) {
-		pr_err("Could not find namespace id : %d\n",
-				le32_to_cpu(req->cmd->get_log_page.nsid));
-		req->error_loc = offsetof(struct nvme_rw_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
+	status = nvmet_req_find_ns(req);
+	if (status)
+		return status;
 
 	/* we don't have the right data for file backed ns */
 	if (!req->ns->bdev)
@@ -468,7 +464,7 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ns *id;
-	u16 status = 0;
+	u16 status;
 
 	if (le32_to_cpu(req->cmd->identify.nsid) == NVME_NSID_ALL) {
 		req->error_loc = offsetof(struct nvme_identify, nsid);
@@ -483,8 +479,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	}
 
 	/* return an all zeroed buffer if we can't find an active namespace */
-	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!req->ns) {
+	status = nvmet_req_find_ns(req);
+	if (status) {
 		status = 0;
 		goto done;
 	}
@@ -604,15 +600,12 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
-	u16 status = 0;
 	off_t off = 0;
+	u16 status;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!req->ns) {
-		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	status = nvmet_req_find_ns(req);
+	if (status)
 		goto out;
-	}
 
 	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
@@ -692,13 +685,11 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 {
 	u32 write_protect = le32_to_cpu(req->cmd->common.cdw11);
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
-	u16 status = NVME_SC_FEATURE_NOT_CHANGEABLE;
+	u16 status;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->rw.nsid);
-	if (unlikely(!req->ns)) {
-		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return status = NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
+	status = nvmet_req_find_ns(req);
+	if (status)
+		return status;
 
 	mutex_lock(&subsys->lock);
 	switch (write_protect) {
@@ -799,11 +790,10 @@ static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u32 result;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->common.nsid);
-	if (!req->ns)  {
-		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
+	result = nvmet_req_find_ns(req);
+	if (result)
+		return result;
+
 	mutex_lock(&subsys->lock);
 	if (req->ns->readonly == true)
 		result = NVME_NS_WRITE_PROTECT;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8ce4d59cc9e7..95b58d4b1af2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -417,15 +417,18 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
 
-struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid)
+u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
-	struct nvmet_ns *ns;
+	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
 
-	ns = xa_load(&ctrl->subsys->namespaces, le32_to_cpu(nsid));
-	if (ns)
-		percpu_ref_get(&ns->ref);
+	req->ns = xa_load(&req->sq->ctrl->subsys->namespaces, nsid);
+	if (unlikely(!req->ns)) {
+		req->error_loc = offsetof(struct nvme_common_command, nsid);
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+	}
 
-	return ns;
+	percpu_ref_get(&req->ns->ref);
+	return NVME_SC_SUCCESS;
 }
 
 static void nvmet_destroy_namespace(struct percpu_ref *ref)
@@ -862,11 +865,10 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvmet_req_passthru_ctrl(req))
 		return nvmet_parse_passthru_io_cmd(req);
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
-	if (unlikely(!req->ns)) {
-		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
+	ret = nvmet_req_find_ns(req);
+	if (unlikely(ret))
+		return ret;
+
 	ret = nvmet_check_ana_state(req->port, req->ns);
 	if (unlikely(ret)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8776dd1a0490..954b3d8451f5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -443,7 +443,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
 void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys);
 
-struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid);
+u16 nvmet_req_find_ns(struct nvmet_req *req);
 void nvmet_put_namespace(struct nvmet_ns *ns);
 int nvmet_ns_enable(struct nvmet_ns *ns);
 void nvmet_ns_disable(struct nvmet_ns *ns);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
