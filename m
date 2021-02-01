Return-Path: <SRS0=DeHG=HD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616DFC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 155C864E15
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Feb 2021 05:42:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 155C864E15
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Ik4jaZKwjHRGLsKBeAWPEa4eSnHE9GKkLBUq40e8cLQ=; b=B9g7ltKLKbltz9QV6woPkJHOZ
	E0QDbKUsn1hhy/5DnYrLXKzEDp2J7gwXDu0QPoRKdSIY83kGH/BQ6KrYwssY2DIucCaOawlIiQETW
	ZznIDsroWQEofZSeO10eP7X9F5XebMqDn/njcIRDr3OoRSeaS8iECJgViEoQdBhge6KhzXAN7RH2d
	wcl9pzz0KJ4IGCGSHjKsrBmiTcyBL10ILdeDyBQutIClzEPHqPDK9EyECnUG2IrJwnl/waSQuNhat
	eFnXLCO/zkfdlcyZnFTgNU/Iy75auK66TqIbU9IoRPSQyUBc1XLnJ4xp2pIvneHht3KjW4Ei+KkkW
	Jc4o4g+DQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l6RyU-0004rj-UC; Mon, 01 Feb 2021 05:42:10 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l6RyT-0004qt-Cg
 for linux-nvme@lists.infradead.org; Mon, 01 Feb 2021 05:42:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612158129; x=1643694129;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=x52iLDFKZMzD+Hsog53PkWI1S5LY+CCpa46kVO1GC4c=;
 b=RA8Tf0HbWN2GTBmgNmqxqPR4V41DLPWwnOzBf5s77FT/H4s2fXxILfpY
 6kBAxgmmf0+1hx3n/ktLGouLy+dMXNtzg6w+9oZoht+to0WS1OtsZR5oY
 znnsRwowzIbfcEyHKO0mVxf+T/uswi0vSkKL11ZwATWGZkD22Ll2OPpja
 pCzCVBezaRKnSAApatTSb/d8tUtsPnUKcOoSf8TKeioSAUsVleH0f4kH0
 E06RHmLiwTvSc1mAkSp9GJeSTmDCIv8iANECopV0OtuZPp6KTuHSELdfG
 6+W//VxWUmzulMPq2Ulid+0AOENOQcYQBcg/vj7BgQFJp5L8isPZQRf6I A==;
IronPort-SDR: ta0uksUj7/fh1ayhu2uXlL0vLCtmbHfMcP7n6PSujlqhc3ggSNujrL5qs2R0RrxwKktPIzsvh4
 FAjWsp6mckq3mNlVfCRjrGlB0SYPjISHggK3JOzZ9Pt6IcNn2l3tIHvYOlKdf8Z1TYtCa8joG0
 uljChS9MmRTDr2+NBYQZ9ZmPZZNJ4LyuI7WAqP3xD/Z1dV4Nhifh0kCZks3NcB9G51mvBRLXx/
 RXzmy55QmICSEUDIFHbzOTSUg+gDvsfORSPaDjkC47tf775+QsLwk0eqsOLvjmJj4KWpEFdrwl
 4dU=
X-IronPort-AV: E=Sophos;i="5.79,391,1602518400"; d="scan'208";a="163231159"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 01 Feb 2021 13:42:07 +0800
IronPort-SDR: P8t+YdhJ0FPKvQk/zcWTaINyRM9ovRHnp0f970+W832zoC5F/QV7HCUWNRPuMHg+nA4XnI3m/p
 6yMX5+exLJOtcL5cHyvbF2IlvbvBwRCYFH+Veix4zK7AlO1/QxO+x77rEpL4pigfxJdI8xG2vt
 Z0HMj9B/rqrvH9GX/JSipu9EiPsP8G6XuS7B/RKNOMCZyIM2zZVfRrRgqUN8zu3vKxpqnvBEI+
 2ZUPsfldDKY/UJfRea5nnhacyxiQZ97SHOZuey2EunEsBZypUFl89T57NagSpox4Y0FKToSwNM
 Sz7UbWLQHi/u4fYCxBIdP3AK
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2021 21:24:18 -0800
IronPort-SDR: 6eIbymg0NWHEptjls0zVbWRqwXKv+VEz/b5JDEZ/rkytYtfYPYUixFMFzJOUMDL04rURsQpo6d
 3Cu2yGZee331xi2nhrpFCQF3BLEBQkv3Qh8cVe4CvhnnYjB6MGFy4sD9oJ/TfM4wH20IMqWLd/
 ljDsOtXkRO4AjXyJ0v2s7QM0XR8t8CrbE8BFZx/e5UcbB/hqOhVOS+QdttzL5njAx167mDBqLf
 Azl5cMnI1uVB4JcF6monppOh+NURGkjoMu7piSJMNWtcnUUU330rdO6AiOUYbVDENEPL7Ryx0m
 sdQ=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 31 Jan 2021 21:42:09 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 03/10] nvmet: set error in nvmet_find_namespace()
Date: Sun, 31 Jan 2021 21:41:31 -0800
Message-Id: <20210201054138.34324-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
References: <20210201054138.34324-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210201_004209_594585_853E8BA7 
X-CRM114-Status: GOOD (  18.81  )
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
update and status setting code for each call.

All callers are nvmet requests based functions and so we can pass req
to the nvmet_find_namesapce() & derive ctrl from req, that'll allow us
to update the error log page in nvmet_find_namespace(). Now that we
pass the request we can also get rid of the local variable in
nvmet_find_namespace() and use the req->ns and return the error code.

Replace the ctrl parameter with nvmet_req for nvmet_find_namespace(),
centralize the error log page update for non allocated namesapces, and
return uniform error for non-allocated namespace.

With this change now we have ten less lines and most importantly we
get rid of the inconsistent behaviour for different commands when ns is
not allocated.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 45 +++++++++++++--------------------
 drivers/nvme/target/core.c      | 23 ++++++++---------
 drivers/nvme/target/nvmet.h     |  2 +-
 3 files changed, 30 insertions(+), 40 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ee3121b447fe..fbb5fe18f2d4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -75,14 +75,13 @@ static u16 nvmet_get_smart_log_nsid(struct nvmet_req *req,
 		struct nvme_smart_log *slog)
 {
 	u64 host_reads, host_writes, data_units_read, data_units_written;
+	u16 status;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl,
-				       req->cmd->get_log_page.nsid);
-	if (!req->ns) {
+	status = nvmet_find_namespace(req, req->cmd->get_log_page.nsid);
+	if (status) {
 		pr_err("Could not find namespace id : %d\n",
 				le32_to_cpu(req->cmd->get_log_page.nsid));
-		req->error_loc = offsetof(struct nvme_rw_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+		return status;
 	}
 
 	/* we don't have the right data for file backed ns */
@@ -476,9 +475,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		goto out;
 	}
 
-	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!req->ns) {
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	status = nvmet_find_namespace(req, req->cmd->identify.nsid);
+	if (status) {
 		/*
 		 * According to spec : If the specified namespace is
 		 * an unallocated NSID then the controller returns a zero filled
@@ -610,15 +608,12 @@ static u16 nvmet_copy_ns_identifier(struct nvmet_req *req, u8 type, u8 len,
 
 static void nvmet_execute_identify_desclist(struct nvmet_req *req)
 {
-	u16 status = 0;
+	u16 status;
 	off_t off = 0;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!req->ns) {
-		req->error_loc = offsetof(struct nvme_identify, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	status = nvmet_find_namespace(req, req->cmd->identify.nsid);
+	if (status)
 		goto out;
-	}
 
 	if (memchr_inv(&req->ns->uuid, 0, sizeof(req->ns->uuid))) {
 		status = nvmet_copy_ns_identifier(req, NVME_NIDT_UUID,
@@ -698,14 +693,11 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 {
 	u32 write_protect = le32_to_cpu(req->cmd->common.cdw11);
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
-	u16 status = NVME_SC_FEATURE_NOT_CHANGEABLE;
+	u16 status;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->rw.nsid);
-	if (unlikely(!req->ns)) {
-		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	status = nvmet_find_namespace(req, req->cmd->rw.nsid);
+	if (unlikely(status))
 		return status;
-	}
 
 	mutex_lock(&subsys->lock);
 	switch (write_protect) {
@@ -717,9 +709,9 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 		break;
 	case NVME_NS_NO_WRITE_PROTECT:
 		req->ns->readonly = false;
-		status = 0;
 		break;
 	default:
+		status = NVME_SC_FEATURE_NOT_CHANGEABLE;
 		break;
 	}
 
@@ -804,13 +796,12 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
-	u32 result;
+	u16 result;
+
+	result = nvmet_find_namespace(req, req->cmd->common.nsid);
+	if (result)
+		return result;
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->common.nsid);
-	if (!req->ns)  {
-		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
 	mutex_lock(&subsys->lock);
 	if (req->ns->readonly == true)
 		result = NVME_NS_WRITE_PROTECT;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 8ce4d59cc9e7..6ebcbc637265 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -417,15 +417,16 @@ void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	cancel_delayed_work_sync(&ctrl->ka_work);
 }
 
-struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid)
+u16 nvmet_find_namespace(struct nvmet_req *req, __le32 id)
 {
-	struct nvmet_ns *ns;
-
-	ns = xa_load(&ctrl->subsys->namespaces, le32_to_cpu(nsid));
-	if (ns)
-		percpu_ref_get(&ns->ref);
+	req->ns = xa_load(&req->sq->ctrl->subsys->namespaces, le32_to_cpu(id));
+	if (unlikely(!req->ns)) {
+		req->error_loc = offsetof(struct nvme_common_command, nsid);
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+	}
 
-	return ns;
+	percpu_ref_get(&req->ns->ref);
+	return NVME_SC_SUCCESS;
 }
 
 static void nvmet_destroy_namespace(struct percpu_ref *ref)
@@ -862,11 +863,9 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	if (nvmet_req_passthru_ctrl(req))
 		return nvmet_parse_passthru_io_cmd(req);
 
-	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
-	if (unlikely(!req->ns)) {
-		req->error_loc = offsetof(struct nvme_common_command, nsid);
-		return NVME_SC_INVALID_NS | NVME_SC_DNR;
-	}
+	ret = nvmet_find_namespace(req, cmd->rw.nsid);
+	if (unlikely(ret))
+		return ret;
 	ret = nvmet_check_ana_state(req->port, req->ns);
 	if (unlikely(ret)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 8776dd1a0490..80811fccb431 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -443,7 +443,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 void nvmet_subsys_put(struct nvmet_subsys *subsys);
 void nvmet_subsys_del_ctrls(struct nvmet_subsys *subsys);
 
-struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid);
+u16 nvmet_find_namespace(struct nvmet_req *req, __le32 id);
 void nvmet_put_namespace(struct nvmet_ns *ns);
 int nvmet_ns_enable(struct nvmet_ns *ns);
 void nvmet_ns_disable(struct nvmet_ns *ns);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
