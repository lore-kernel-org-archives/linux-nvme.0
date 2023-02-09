Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94907C05027
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Feb 2023 14:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CuhavpOL3sTRXZ6wmI9DJemw29iB9/d6+v5eiuBK8MY=; b=JTmefSXuA1DNR6gIB3kP18zIol
	Q1lYCArTfQi9eFkHvO3XLqPRcSandpnhw3Gx1QB7FDSf3hDFFhysCTTj7JmulWBNtOSqwDzaDigFc
	uavUgHy2arlpqvQOTNfI5ns3WUTVW2blYXo5WU7wyx35EkuB4DC4F+RSa3h8RHjG4zo1PaLxD8+Mo
	8y6Kda0+G+eJWR7d5d61eoejGMjxzRi7g9gMT7SJTSjwTvlxmOL8nhvZZStq2NOGq4ZToqB+fs64x
	/0tYoQbn5c2wxgXEz8Atwbb0fNeSfLmWV/ZGE8p8SZZduOD1ljWUPDJFzex4qJJVHcogIvRTJscm4
	AQNEE6wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84Y-0020pC-9H; Thu, 09 Feb 2023 14:38:50 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ84F-0020ex-9S
	for linux-nvme@lists.infradead.org; Thu, 09 Feb 2023 14:38:34 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id C7A4D375D0;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1675953509; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuhavpOL3sTRXZ6wmI9DJemw29iB9/d6+v5eiuBK8MY=;
	b=DE9DAaHuRkbMFpiaaPMSTSpkC5UjCCGNCzomAYrGwilEH/W34HUuPg73WSsfYQBqZG5JxU
	F1AqiUW3H90yXUB0sKJesHmKMVBNCGVDygcZAdieEyTJ1CpUSQLvewY33WJRC96OkYBVCz
	t6B23J54T23f2QtJZk3ZAZsZO87yWKU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1675953509;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuhavpOL3sTRXZ6wmI9DJemw29iB9/d6+v5eiuBK8MY=;
	b=D6Jg1y1rRDSB3qIj68EBhoaY+QYJqdcfezD1p8LkTi4arHMECMaG8DQivfkaaJBg0ccAKz
	fyk1pddzP84XM4BQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B102A2C146;
	Thu,  9 Feb 2023 14:38:29 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id A397251BD13E; Thu,  9 Feb 2023 15:38:29 +0100 (CET)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 4/5] nvme: open-code __nvme_submit_sync_cmd()
Date: Thu,  9 Feb 2023 15:38:19 +0100
Message-Id: <20230209143820.118097-5-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230209143820.118097-1-hare@suse.de>
References: <20230209143820.118097-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_063831_525027_EF7AA3D3 
X-CRM114-Status: GOOD (  18.58  )
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

The argument list for __nvme_submit_sync_cmd() really got overloaded
trying to abstract away the various use-cases. Plus it's a really
simple function now, so open-code it in the callers and drop this function.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c    | 22 ++++++++++----
 drivers/nvme/host/core.c    | 42 ++++++++++++++-------------
 drivers/nvme/host/fabrics.c | 58 +++++++++++++++++++++++--------------
 drivers/nvme/host/nvme.h    |  2 --
 4 files changed, 74 insertions(+), 50 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 05d02ab229f7..ef5dcd885b0c 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -81,13 +81,23 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, NULL, data, data_len, 0);
-	if (ret > 0)
-		dev_warn(ctrl->device,
-			"qid %d auth_send failed with status %d\n", qid, ret);
-	else if (ret < 0)
+	ret = blk_rq_map_kern(req->q, req, data, data_len, GFP_KERNEL);
+	if (ret) {
 		dev_err(ctrl->device,
-			"qid %d auth_send failed with error %d\n", qid, ret);
+			"qid %d auth_submit failed to map, error %d\n",
+			qid, ret);
+	} else {
+		ret = nvme_execute_rq(req, NULL, false);
+		if (ret > 0)
+			dev_warn(ctrl->device,
+				 "qid %d auth_submit failed with status %d\n",
+				 qid, ret);
+		else if (ret < 0)
+			dev_err(ctrl->device,
+				"qid %d auth_submit failed with error %d\n",
+				qid, ret);
+	}
+	blk_mq_free_request(req);
 	return ret;
 }
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 11faebe87764..160261a76f27 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1021,7 +1021,7 @@ int nvme_execute_rq(struct request *rq, union nvme_result *result,
 	}
 	return blk_status_to_errno(status);
 }
-EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
+EXPORT_SYMBOL_GPL(nvme_execute_rq);
 
 struct request *nvme_alloc_request(struct request_queue *q,
 				   struct nvme_command *cmd, int qid,
@@ -1045,32 +1045,22 @@ EXPORT_SYMBOL_GPL(nvme_alloc_request);
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
  * if the result is positive, it's an NVM Express status code
  */
-int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
-			   void *buffer, unsigned bufflen, int at_head)
-{
-	int ret;
-
-	ret = blk_rq_map_kern(req->q, req, buffer, bufflen, GFP_KERNEL);
-	if (ret)
-		goto out;
-
-	ret = nvme_execute_rq(req, result, at_head);
- out:
-	blk_mq_free_request(req);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(__nvme_submit_sync_cmd);
-
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	struct request *req;
+	int ret;
 
 	req = nvme_alloc_request(q, cmd, NVME_QID_ANY, 0);
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	return __nvme_submit_sync_cmd(req, NULL, buffer, bufflen, 0);
+	ret = blk_rq_map_kern(req->q, req, buffer, bufflen, GFP_KERNEL);
+	if (!ret)
+		ret = nvme_execute_rq(req, NULL, false);
+
+	blk_mq_free_request(req);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1500,7 +1490,13 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, &res, buffer, buflen, 0);
+	ret = blk_rq_map_kern(req->q, req, buffer, buflen, GFP_KERNEL);
+	if (ret)
+		goto out;
+
+	ret = nvme_execute_rq(req, &res, false);
+ out:
+	blk_mq_free_request(req);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2223,6 +2219,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	struct nvme_ctrl *ctrl = data;
 	struct nvme_command cmd = { };
 	struct request *req;
+	int ret;
 
 	if (send)
 		cmd.common.opcode = nvme_admin_security_send;
@@ -2236,7 +2233,12 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	return __nvme_submit_sync_cmd(req, NULL, buffer, len, 1);
+	ret = blk_rq_map_kern(req->q, req, buffer, len, GFP_KERNEL);
+	if (!ret)
+		ret = nvme_execute_rq(req, NULL, true);
+
+	blk_mq_free_request(req);
+	return ret;
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 914784b611a2..49299fcdcf68 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -121,6 +121,31 @@ int nvmf_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 }
 EXPORT_SYMBOL_GPL(nvmf_get_address);
 
+/**
+ * nvmf_submit_fabrics_cmd() - Submit NVMe Fabrics command
+ * @ctrl:	Host NVMe controller instance
+ * @cmd:	NVMe command to submit
+ * @res:	NVMe result to be returned (may be NULL)
+ */
+static int nvmf_submit_fabrics_cmd(struct nvme_ctrl *ctrl,
+				   struct nvme_command *cmd,
+				   union nvme_result *res)
+{
+	struct request *req;
+	int ret;
+
+	req = nvme_alloc_request(ctrl->fabrics_q, cmd, NVME_QID_ANY, 0);
+	if (IS_ERR(req))
+		return PTR_ERR(req);
+
+	ret = blk_rq_map_kern(req->q, req, NULL, 0, GFP_KERNEL);
+	if (!ret)
+		ret = nvme_execute_rq(req, res, false);
+
+	blk_mq_free_request(req);
+	return ret;
+}
+
 /**
  * nvmf_reg_read32() -  NVMe Fabrics "Property Get" API function.
  * @ctrl:	Host NVMe controller instance maintaining the admin
@@ -144,7 +169,6 @@ EXPORT_SYMBOL_GPL(nvmf_get_address);
  */
 int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
-	struct request *req;
 	struct nvme_command cmd = { };
 	union nvme_result res;
 	int ret;
@@ -153,12 +177,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.fctype = nvme_fabrics_type_property_get;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	req = nvme_alloc_request(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	ret = __nvme_submit_sync_cmd(req, &res, NULL, 0, 0);
-
+	ret = nvmf_submit_fabrics_cmd(ctrl, &cmd, &res);
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
 	if (unlikely(ret != 0))
@@ -193,7 +212,6 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read32);
  */
 int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 {
-	struct request *req;
 	struct nvme_command cmd = { };
 	union nvme_result res;
 	int ret;
@@ -203,12 +221,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.attrib = 1;
 	cmd.prop_get.offset = cpu_to_le32(off);
 
-	req = nvme_alloc_request(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	ret = __nvme_submit_sync_cmd(req, &res, NULL, 0, 0);
-
+	ret = nvmf_submit_fabrics_cmd(ctrl, &cmd, &res);
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
 	if (unlikely(ret != 0))
@@ -242,7 +255,6 @@ EXPORT_SYMBOL_GPL(nvmf_reg_read64);
  */
 int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 {
-	struct request *req;
 	struct nvme_command cmd = { };
 	int ret;
 
@@ -252,11 +264,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.offset = cpu_to_le32(off);
 	cmd.prop_set.value = cpu_to_le64(val);
 
-	req = nvme_alloc_request(ctrl->fabrics_q, &cmd, NVME_QID_ANY, 0);
-	if (IS_ERR(req))
-		return PTR_ERR(req);
-
-	ret = __nvme_submit_sync_cmd(req, NULL, NULL, 0, 0);
+	ret = nvmf_submit_fabrics_cmd(ctrl, &cmd, NULL);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -417,7 +425,10 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, &res, data, sizeof(*data), 1);
+	ret = blk_rq_map_kern(req->q, req, data, sizeof(*data), GFP_KERNEL);
+	if (!ret)
+		ret = nvme_execute_rq(req, &res, true);
+	blk_mq_free_request(req);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -507,7 +518,10 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 
-	ret = __nvme_submit_sync_cmd(req, &res, data, sizeof(*data), 1);
+	ret = blk_rq_map_kern(req->q, req, data, sizeof(*data), GFP_KERNEL);
+	if (!ret)
+		ret = nvme_execute_rq(req, &res, true);
+	blk_mq_free_request(req);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a63650b00d1a..8f02d981644c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -815,8 +815,6 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, int qid, blk_mq_req_flags_t flags);
-int __nvme_submit_sync_cmd(struct request *req, union nvme_result *result,
-		void *buffer, unsigned bufflen, int at_head);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.35.3


