Return-Path: <SRS0=Gy4h=HM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D2AC433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:34 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6ED064DE1
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Feb 2021 05:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6ED064DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=El0/14YMAIctklx3z1c8ubK2NQfTlTA6jR2CNg4j4+s=; b=wkcLvNiR8b/m8iTnBgYUrOkxL
	d0R/Av3ZEREKld74Qi3fc9uzYeSeBVYgSiHwyUEcKEqUgeAY/hXx5q0xk3WNUfPO69Xkxe557sbey
	7OA4I6HAmCUq7dRC+XhHaASqC8/xNdwGmZ0UDc6ac15U1JpROIltbbiJ73iuBL8C0UM8rlKEEqBsJ
	JaOzxxPvXq21gf48PL0mfviBKAVFyiuN3HZV+8Padj8r8isJBfnGsEpp6DiHiTuoVe3fsww6QtSw+
	0ZxELiHMowkWekp5ZfmQzw+Zupq0Two0L78uRD6QpZUWPo8IfUupzRFhTmZLJAHh3yGriTI1nv6Oi
	pwIZKPT+Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9iNS-0007A7-Na; Wed, 10 Feb 2021 05:49:26 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9iNN-00077E-1z
 for linux-nvme@lists.infradead.org; Wed, 10 Feb 2021 05:49:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612936161; x=1644472161;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=z+goWyHpPjZ9yh0qCMZlf70wBkJLEVSMDJ38MKwvUvI=;
 b=GGAvLaSG7KjJrh5lJ8I/jUpVoEDprQHetcO3UItxF1TmmpzPQ+T+yW/D
 rF+AYeJWIi7otGXFCufB5GO+ZcJUcunncrozwixNZqKhcWXk+7Tpdz7k0
 0WIDFq36npm3QcWK7pe1HCiMzlONJLZVt5k9rDMYMdwrFykODxrtcE8v0
 unlONdFuEd7pkRsgbYX6rGjeq4jF7q4Hnz0qy8gyDGlS1Vc1D2k3efs+E
 4gfDqBowy+mIpnsZwFX4cd0yBqsYb/2N73rRq8uZYguRMMtcOPWxwpqKc
 SygwNpxca7qaCdVdEwTUK0FA+M5fKPblJ1GNZ6J0LDAiXZXM3h+5+wL7X w==;
IronPort-SDR: nA5s/Hqw23O/LgdxliBDh48YIMTeWNpmk2f0kmilGt4NwJPnu9mt84JZW9B6NlaHdMVRrcpGZR
 QPb4bRomT8gkQzVnuasCn0jG58krsoK3UfSCPJf+RycLcEXTaEgZ1HCVxshO9lWikR1NM6PCQn
 WbL6veyDsG9NNlfTF2IIPlxOfPmTX4VG0q+JrXlvGtUc2xu+Ua33KVaXs2SrBfAgaWjopsWNfL
 TLASxtr7Z9mGagmBDXFJUcFrYR5w2uPa1w59KXd3sKq1R5RCeYTP11lbDhuUOmloi/IYMf+AOd
 QOM=
X-IronPort-AV: E=Sophos;i="5.81,167,1610380800"; d="scan'208";a="159595522"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2021 13:49:20 +0800
IronPort-SDR: yeCE13dxXFuhwPKJ8vYERyqPOS894nGGmwImJ0OqtLhwqYYTyDAEOrVUIZo4kPccJZmnch9KAv
 06tghYrhuRkGWWQNK44t7o92UBa+X/XqhOlOTILhKhMgTw81uyC38GmDw2XZt0qYXe77aSvNly
 NBCs7wehuhPR/ZA7+VBZHL50Yf1z5ZfVdgBrJqUYzk584qmQVcXzS4H+vujD14+hx8pGN1zgUx
 K3wsBgPknSWSSr0jbnq39Ft61KoeRKjolBAsd+JXNK/9CANnNlm4HWNUVyNvd+/ev2wbEgadIl
 3nhUnIQkGsJDhvTpWDDjmPZx
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2021 21:31:13 -0800
IronPort-SDR: hytD56mPyW5weGXQHgHhy1LD47bB4hh3/EXTrpkMiCb6p4v1ImwjeqWC/uXwLyH+PSrJnfzjjP
 85b43d5zH7pqZgr3jWYxy3m9IYJrNujq17L4vWH1ROspYXAk1+4SWbjaBopvFFcPPO8eOQz1fo
 d1d13lqlprYZb467WUTOclzpk7A5IDg5WdmG4O00X1wKiTDsX2QEVeI3eMzvpaeQGsQwL6xSry
 HxdrH3RX2yuejk73umjflCHeRCoNYk5C2ZVn1KIflTZLNhOUtHqaKR1NhSqIhNoJ3+6SIxlX8+
 xuU=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Feb 2021 21:49:20 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V3 10/11] nvmet: add nvmet_req_subsys() helper
Date: Tue,  9 Feb 2021 21:48:01 -0800
Message-Id: <20210210054802.34269-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
References: <20210210054802.34269-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210210_004921_317467_6BB37FA0 
X-CRM114-Status: GOOD (  15.94  )
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

Just like what we have to get the passthru ctrl from the req, add an
helper to get the subsystem associated with the nvmet_req() instead
of open coding the chain of structures.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 10 +++++-----
 drivers/nvme/target/core.c      |  2 +-
 drivers/nvme/target/nvmet.h     |  7 ++++++-
 drivers/nvme/target/passthru.c  |  4 ++--
 4 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 552da813da18..bc6a774f2124 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -683,7 +683,7 @@ static u16 nvmet_write_protect_flush_sync(struct nvmet_req *req)
 static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 {
 	u32 write_protect = le32_to_cpu(req->cmd->common.cdw11);
-	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 	u16 status;
 
 	status = nvmet_req_find_ns(req);
@@ -742,7 +742,7 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
-	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
 	u16 status = 0;
@@ -786,7 +786,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 
 static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 {
-	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 	u32 result;
 
 	result = nvmet_req_find_ns(req);
@@ -816,7 +816,7 @@ void nvmet_get_feat_async_event(struct nvmet_req *req)
 
 void nvmet_execute_get_features(struct nvmet_req *req)
 {
-	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
@@ -923,7 +923,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
 	if (nvme_is_fabrics(cmd))
 		return nvmet_parse_fabrics_cmd(req);
-	if (req->sq->ctrl->subsys->type == NVME_NQN_DISC)
+	if (nvmet_req_subsys(req)->type == NVME_NQN_DISC)
 		return nvmet_parse_discovery_cmd(req);
 
 	ret = nvmet_check_ctrl_status(req, cmd);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 95b58d4b1af2..32221f98f1cc 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -421,7 +421,7 @@ u16 nvmet_req_find_ns(struct nvmet_req *req)
 {
 	u32 nsid = le32_to_cpu(req->cmd->common.nsid);
 
-	req->ns = xa_load(&req->sq->ctrl->subsys->namespaces, nsid);
+	req->ns = xa_load(&nvmet_req_subsys(req)->namespaces, nsid);
 	if (unlikely(!req->ns)) {
 		req->error_loc = offsetof(struct nvme_common_command, nsid);
 		return NVME_SC_INVALID_NS | NVME_SC_DNR;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6b5f1b60cf50..50535563e8c5 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -551,6 +551,11 @@ static inline u32 nvmet_dsm_len(struct nvmet_req *req)
 		sizeof(struct nvme_dsm_range);
 }
 
+static inline struct nvmet_subsys *nvmet_req_subsys(struct nvmet_req *req)
+{
+	return req->sq->ctrl->subsys;
+}
+
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 void nvmet_passthru_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys);
@@ -585,7 +590,7 @@ static inline struct nvme_ctrl *nvmet_passthru_ctrl(struct nvmet_subsys *subsys)
 static inline struct nvme_ctrl *
 nvmet_req_passthru_ctrl(struct nvmet_req *req)
 {
-	return nvmet_passthru_ctrl(req->sq->ctrl->subsys);
+	return nvmet_passthru_ctrl(nvmet_req_subsys(req));
 }
 
 u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 3b22f4a868f4..f50c7b2bf21c 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -239,9 +239,9 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		}
 
 		q = ns->queue;
-		timeout = req->sq->ctrl->subsys->io_timeout;
+		timeout = nvmet_req_subsys(req)->io_timeout;
 	} else {
-		timeout = req->sq->ctrl->subsys->admin_timeout;
+		timeout = nvmet_req_subsys(req)->admin_timeout;
 	}
 
 	rq = nvme_alloc_request(q, req->cmd, 0);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
