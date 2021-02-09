Return-Path: <SRS0=1rws=HL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45ABAC433E6
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAA8064EA4
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Feb 2021 04:09:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA8064EA4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=GbjshXmDHcOmXl1mZE44XFMsGXhbUMQijSHFsX+cUMg=; b=uw1MRs09TUMnVJXNqaNTpiGlc
	q2q8oiNes7KlRWn7Lz2ukiUhn7y+ftTnP52yU4M/LHUDUbufSpIZWDoDbjPz1/VLj4+gJgsmoR/n5
	GhwBXrUEDQbscuwHU/w92o5s5S03PMl5EV9OKFLzVvDxwa1d1es716Duzm7CI5XR1vv6qzLqflkZb
	LYDvwni6okvGIZxHjddlnZZRno4WU5WSHEtzxiqtzBKDWHzd4h3Gfm3Z6BBFcJR1CYp1i8sz94HHV
	QNO9OFdCqyMawwHuI/lKM8Mp2LVAOK3fk+jH+hofl1+0zxQah1bNIhVYONZdf7LuE4nssmGzLk9f6
	IXgf/zBDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l9KL2-00035z-EF; Tue, 09 Feb 2021 04:09:20 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l9KKl-0002yo-HG
 for linux-nvme@lists.infradead.org; Tue, 09 Feb 2021 04:09:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1612843743; x=1644379743;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=hqjKH0b3GaMIuk77BXo948xHjOvl6jHVXAT3s+VpoRY=;
 b=oleEA3EPF4mOSRzkJahhLxI6geNtqg4lGrJI1mi4TrZkOOA+6e5RPZi0
 22QKwcD6X6nG05gEBdordLDuk5YpTPy5xBRd2S8q+NQ24bR8eNIzdYinL
 QlezO1QFNy30ayGuNht8ytOHPrxjVfRGMKRorsZDoql/wKZBRTVsSqz7C
 Osh8ao7CRuAifXMWFnbGnIaYArGbQSQR5OiSQvyscgBMq/zEPBjYXLd9q
 11+Z/ajyIibKt7B4+GWLqsFThU7MAWgTDFnykVIYLA8PHbU5DYX4IItxz
 3rGbyypraLcJDBY32CbvxexG/xaSKaD4b9ghmmAOZe12fDtUEOkihE/20 A==;
IronPort-SDR: LYqp9iC3lSQV97UclotdQqrh71nqEF/coY0hGBp4qbiw0RUSTUKs/d9BelOrqXvM5OOQdsbl1w
 9NYPVPosVT5QhbnNFJv+jOm4Ob2pNkxbC+eY9QobulVSAv/9ZlwWQ8xw+3yAxz7n2AR4VJjTrY
 Gz3bf6PCAhU8w/vySUS2lD980W7yRDlzDJTM+myP5U12H+J2LvTpbkzSO4ls4MI9z3/bZJG9IH
 gryy945yN02t5hgblVlMjTpBbyFgXKCeVNzsdX5oMPur+BgsmnXBOffrcuUjdJTmZ/8CT7GowT
 qwE=
X-IronPort-AV: E=Sophos;i="5.81,164,1610380800"; d="scan'208";a="269970527"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 09 Feb 2021 12:09:02 +0800
IronPort-SDR: LsRsV9oUui5yJWirPeLPmbFKtM7OyT2bIB3iIPYLiSHvCuc+sdc/63m/P5cxX1vI6MwAKmJIIb
 bicCaYQaQpOz3/iqO8EclRz1s4mKrTznYfmmd2dsx3njBR9k3mQ8HLt08js7GH8AwcPPd9wYYk
 LYSgFyazWtt1806V3bL2rx130RdCOEwaNkobkwSZTfXZjzrAbyBmqf+kQ6LlyRu06ryhBRoy5a
 8UAaOvvBkB7RD0YtHO+tgCGRDyJkUdigYkiohdr+5m/AMv/U19x8yggvVWlMTAEpYNd7iWhN0q
 FY9wuxXNgNrvguLQwBdB3KK6
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Feb 2021 19:50:56 -0800
IronPort-SDR: eHHC5TpF0ZZ5IIABNvmP6hPNK05upl6XGWukibn3x1Hmhjf79Vqcmxcy+wPayPeL27YKm+Jl53
 vi6LICI5nRn+/iDW2YmEK8flDAv8rFthPG6NI789opkVy72OyfhLrGc3cZB3IXugFy6LjcOtkb
 WS8zOKy7HSI+r2XuzwFAPjft7XRD9xFO5K27Thg3Dx7dAj96ddfiPUskpFbMPlot2CI4SNU0mD
 xrZmw1x+OJGcoLavI1LmzdcsDQTRw2esTm8TeMA7V12CZ/1P7l4YYv4sFMxtIvO5S2023C340E
 btE=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 08 Feb 2021 20:09:03 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 10/11] nvmet: add nvmet_req_subsys() helper
Date: Mon,  8 Feb 2021 20:08:42 -0800
Message-Id: <20210209040843.45572-11-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
References: <20210209040843.45572-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210208_230903_773710_D9C3720A 
X-CRM114-Status: GOOD (  16.10  )
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
index d551571b538c..8f8382021c31 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -690,7 +690,7 @@ static u16 nvmet_write_protect_flush_sync(struct nvmet_req *req)
 static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 {
 	u32 write_protect = le32_to_cpu(req->cmd->common.cdw11);
-	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 	u16 status;
 
 	status = nvmet_req_find_ns(req);
@@ -750,7 +750,7 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
-	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
 	u16 status = 0;
@@ -794,7 +794,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 
 static u16 nvmet_get_feat_write_protect(struct nvmet_req *req)
 {
-	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 	u32 result;
 
 	result = nvmet_req_find_ns(req);
@@ -824,7 +824,7 @@ void nvmet_get_feat_async_event(struct nvmet_req *req)
 
 void nvmet_execute_get_features(struct nvmet_req *req)
 {
-	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
@@ -931,7 +931,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 
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
