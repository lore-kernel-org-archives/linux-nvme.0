Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67F9BC47258
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jan 2024 14:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zOFr89Q6CZzlTwNHOdqBfu6oHa3lor05gouMs7wn1Eg=; b=e285V21fT+eaqqMfabl96haZhs
	jleUUC5/+uAaRsSYhhM1rfjAG7vIiQKw3m9aiY29dQqQWdjqHMdZQYxYEUwjO2lMHHksCmWCG+Rts
	gPN4j9F9oimVicXJ5sPAtEWRMwrDvtrvNHEr1m8AUmDhed7POJaATXePZYd4noQCBLAsEPc95W78z
	2Q4BdLOrJy00pBsS4TJ2jhgip9m808IbGXJtdVc3LZKxLguRRmsLv4cV7WUaaKmhMCcUusr6QnfKj
	4qVURQjCbEak63pUDphuWF7FZgtTrAxthTXIJox7vK/bNEqk1TXRa1+bz0aCjDaYXOU+AQ/6H96ey
	IkIlWaaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0cw-00000000LxY-1kdU;
	Thu, 25 Jan 2024 14:22:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rT0cu-00000000Lwb-0T7A
	for linux-nvme@bombadil.infradead.org;
	Thu, 25 Jan 2024 14:22:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=zOFr89Q6CZzlTwNHOdqBfu6oHa3lor05gouMs7wn1Eg=; b=PJiGC+HQMH2aHTVUaBZmi+f259
	DmvutzZBNwglhPhthA+Jt0x8gVMA7mI1OpuJdeXUJ38S+lzV4mEXnBlRaJoSIu4tjSJ7QoRV0SQcV
	y7y/ydcLMPQW8X4+v829CNpk9jpxoenQwZaDGGwmbXorexxa2O7+E0l8nQAomasTumvTKZBfD6lyj
	mKpUXnXiXxXhuBXtW4eSWa7eZQ35Ula0CHuLeFCRsPr0sMvTefWC4XHmyv4s9NwFyQ+KOKP5jRJaR
	8mcXCbsvGkzP1W4UNm15v0tAfnd2XG1PftUk5plKFbSQa8frUNhB1zEb7dyUCXD39K9bVbHre/SAO
	3W0CwN9w==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSzTw-00000005NwQ-04CN
	for linux-nvme@lists.infradead.org;
	Thu, 25 Jan 2024 13:09:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 9F7C5CE32D8;
	Thu, 25 Jan 2024 13:09:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F68C433F1;
	Thu, 25 Jan 2024 13:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706188153;
	bh=hXtkKQhx3QXVE0EvhujX0tMzM/lnkNeb5TK4RjCKTIo=;
	h=From:To:Cc:Subject:Date:From;
	b=CXY+zau0/Hu98Q6Tst1u9qvtP5nIWEC33wSP79iowCho722ZS8yNZCJz+jaKn7KBt
	 kLzjR3oOLgYZK33X2czL00+te3Sj3tc4XlVZt0R50ULn3mpePkWk4jeZ4OPfGi1tp1
	 N4bw67q2p3p+nRWhgs5uDajCMgaWbhTv6hcAW4pQyEz2xkQgMaCtW0IUA5Dk3b+IUd
	 Pe27Pl/oOal/uvfYhgY3T+B0IROQumoFid/VJMPuio2t6pKTU5WqJA/zhIkn7pqorr
	 CNfQXUO5S/SI3rPo6zVxp+uhuSwQ0gFCn675m4DlYeyOCdWw1ZZ1N5DqibMC+nzv73
	 JL7w9M7PxGXew==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>,
	Martin George <marting@netapp.com>
Subject: [PATCH] nvme: enable retries for authentication commands
Date: Thu, 25 Jan 2024 14:09:06 +0100
Message-Id: <20240125130906.94874-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240125_130924_659331_1DD56C89 
X-CRM114-Status: GOOD (  13.65  )
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

From: Hannes Reinecke <hare@suse.de>

Authentication commands are normal NVMe commands, and as such
can return a status where NVME_SC_DNR is not set, indicating
that the command should be retried.
Rather than checking NVME_SC_DNR manually for each command completion
this patch adds a flag 'retry' to __nvme_submit_sync_cmd(), causing
the REQ_FAILFAST_DRIVER option to be cleared and the command to
be retried via the normal mechanism.

Reported-by: Martin George <marting@netapp.com>
Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/auth.c    |  2 +-
 drivers/nvme/host/core.c    | 10 ++++++----
 drivers/nvme/host/fabrics.c | 10 +++++-----
 drivers/nvme/host/nvme.h    |  2 +-
 4 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/auth.c b/drivers/nvme/host/auth.c
index 35a460cfb4bf..c3ab7c86065e 100644
--- a/drivers/nvme/host/auth.c
+++ b/drivers/nvme/host/auth.c
@@ -82,7 +82,7 @@ static int nvme_auth_submit(struct nvme_ctrl *ctrl, int qid,
 
 	ret = __nvme_submit_sync_cmd(q, &cmd, NULL, data, data_len,
 				     qid == 0 ? NVME_QID_ANY : qid,
-				     0, flags);
+				     0, flags, true);
 	if (ret > 0)
 		dev_warn(ctrl->device,
 			"qid %d auth_send failed with status %d\n", qid, ret);
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 376efb310eb2..dade4fcb88d2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1049,7 +1049,7 @@ EXPORT_SYMBOL_NS_GPL(nvme_execute_rq, NVME_TARGET_PASSTHRU);
  */
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
-		int qid, int at_head, blk_mq_req_flags_t flags)
+		int qid, int at_head, blk_mq_req_flags_t flags, bool retry)
 {
 	struct request *req;
 	int ret;
@@ -1063,6 +1063,8 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 	if (IS_ERR(req))
 		return PTR_ERR(req);
 	nvme_init_request(req, cmd);
+	if (retry)
+		req->cmd_flags &= ~REQ_FAILFAST_DRIVER;
 
 	if (buffer && bufflen) {
 		ret = blk_rq_map_kern(q, req, buffer, bufflen, GFP_KERNEL);
@@ -1083,7 +1085,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buffer, unsigned bufflen)
 {
 	return __nvme_submit_sync_cmd(q, cmd, NULL, buffer, bufflen,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
@@ -1547,7 +1549,7 @@ static int nvme_features(struct nvme_ctrl *dev, u8 op, unsigned int fid,
 	c.features.dword11 = cpu_to_le32(dword11);
 
 	ret = __nvme_submit_sync_cmd(dev->admin_q, &c, &res,
-			buffer, buflen, NVME_QID_ANY, 0, 0);
+			buffer, buflen, NVME_QID_ANY, 0, 0, false);
 	if (ret >= 0 && result)
 		*result = le32_to_cpu(res.u32);
 	return ret;
@@ -2149,7 +2151,7 @@ static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t l
 	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
-			NVME_QID_ANY, 1, 0);
+			NVME_QID_ANY, 1, 0, false);
 }
 
 static void nvme_configure_opal(struct nvme_ctrl *ctrl, bool was_suspended)
diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 8140d8166c3e..66799d59fcd1 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -180,7 +180,7 @@ int nvmf_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -226,7 +226,7 @@ int nvmf_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	cmd.prop_get.offset = cpu_to_le32(off);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 
 	if (ret >= 0)
 		*val = le64_to_cpu(res.u64);
@@ -271,7 +271,7 @@ int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
 	cmd.prop_set.value = cpu_to_le64(val);
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
-			NVME_QID_ANY, 0, 0);
+			NVME_QID_ANY, 0, 0, false);
 	if (unlikely(ret))
 		dev_err(ctrl->device,
 			"Property Set error: %d, offset %#x\n",
@@ -451,7 +451,7 @@ int nvmf_connect_admin_queue(struct nvme_ctrl *ctrl)
 
 	ret = __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, &res,
 			data, sizeof(*data), NVME_QID_ANY, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
@@ -527,7 +527,7 @@ int nvmf_connect_io_queue(struct nvme_ctrl *ctrl, u16 qid)
 
 	ret = __nvme_submit_sync_cmd(ctrl->connect_q, &cmd, &res,
 			data, sizeof(*data), qid, 1,
-			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
+			BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT, false);
 	if (ret) {
 		nvmf_log_connect_error(ctrl, ret, le32_to_cpu(res.u32),
 				       &cmd, data);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 396e6e72b6a3..743ef474d282 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -829,7 +829,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		int qid, int at_head,
-		blk_mq_req_flags_t flags);
+		blk_mq_req_flags_t flags, bool retry);
 int nvme_set_features(struct nvme_ctrl *dev, unsigned int fid,
 		      unsigned int dword11, void *buffer, size_t buflen,
 		      u32 *result);
-- 
2.35.3


