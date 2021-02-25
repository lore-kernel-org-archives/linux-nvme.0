Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5439EC433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B666F64E85
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B666F64E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G5tWRmSrvbzFX2sBZJr6MlWKBIYBoadGbR0smVOno7o=; b=Hk6vho92mdC2fD8g4NWp4QL5S
	Vx7h4ZopzLiIz+z3q3y2kAt3EBtxaAMFd51Vious12QzgRd4UWIxzm4qZweFi1Ohw+QbeiI6Baajb
	DOLtiMk4DILFJLkn9HZWfnjIElpyUoUEmCusdxqkhQEcZaNf0nyPkp3/QyDVuD+Qr19dJmuuAYXU9
	/3ldfWeTxdk2uNIl59ItSMJb3YsYRR1Iy9xHokf8+oGaOs9O2CPLD9RvipB7irL7mzd0SaPZX2yNG
	3IfzCrSC6Jty84S0el/hBKNM6M6heV2UGcwAMBRn/FjHZ3s7/69KeeLBIwTfgnCEc1u+RnF+KXS33
	J0qexriEw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF5uD-0007mQ-PE; Thu, 25 Feb 2021 01:57:29 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF5u9-0007l6-Rl
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 01:57:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614218245; x=1645754245;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sJ0qVUvGgQe4HWOjJKBV6gxsrk0pmnYoeEJNiJFR9SI=;
 b=BaCx6eUDIGFPbnwpf18blu+/pP0KbnccrlsSRG8X4sIj9FE/hJVxbjDv
 oFtrwIyncDakWBD//IIWukjt875VXlaNUuiIzX5/lefkDXolmaD2vTatv
 Ndf85nDONHQHHoSP/cCFL5clhhoG0ebAb1VGy7MICqEADepjlfE3oqW3i
 Kku5S7MQ2UERTboZTPeTyNJMSilMnHVqgDTYJgyMsPUNsH/ioYEJUQEpp
 rjaTeytyWTLqU/qbIiJ2bXQjYeDJu7JbqySy8RPrRbLszKYy6FfpiAAQK
 Vd5ad1Y7eEFSohYtvGf5QqsNHsy/1gMuCUopfUWJ+m6qI/cBtsLWOPvXG w==;
IronPort-SDR: 16P+MfPNb5pZxMMEYtzcENK33BkhkyUjTMW9aIQNBcoU5DMiWeH0QaN5pkOxlFpU+z6y0IKRqd
 pocU0hDCP5DOS5jXvsiKz55RZQI8IU7zX2lxFOZuN2H9QMi+n9k/EF5cXjDRRaNy6g1d5yYqb5
 caV2uHOiPeJW4YzRv2CrkwXceVP2BRq7fbFW7N68Iu5VbnA9rzJDBU5NkjUXAbnNhL8qwVRUg8
 cIzxyiKl0enBwKARuBuYZVrFJgZlAQf4BtXJSwXWBRAKrI0h99qqEWdWTFUoWBuXZtNj8/PMG4
 lHo=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="271299742"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 09:57:23 +0800
IronPort-SDR: W5lqvkqSw8iKK+P3ui4I+WAF3EtFgpVZVJPbdbInVxpzUgpu67wZuYZdim3Ywy3tSoejizTq52
 4JtW0hf6jVsIcmQUTYN94SEeV4flbg37Y+9l5xW9NMpmOTAQksZrJU+eabZr9xr1PJ0zpnkg2n
 h5xKJEuL1DyYhpr7XmzcS33yrbR5fW0bWcT9qCfbvl4En5dZABDmBObbsN0o+BCAiDZRVTd5Kp
 6eoAt7hNVcrZ+HDKm0OlPwX/ZDygVp+skmqm3Wvb8l1M3506j7fFIpx3Od2KMLSejk6TXEqLCz
 PDWH8yu8nWYKgSR+2gGTm8hc
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 17:38:46 -0800
IronPort-SDR: M5HJRCuxJVIADp6oufF34i4Hcb1JvkTYohQd5UnDjeVlod9+q2oZ+Mcn1AMpnxST5vwGguYBCL
 3COiIXrrOKsKnV0P7fl0QImKhG21BTCTziigDRE/74qtlglCb1goE5rx+d4R7P4QT30fdKHFGG
 F5Iq2dEpvyHZ1IeKtIB+sZn3ODpmRZKPxUH41IN2xX6utg9TxQk1gpSXbdre14PHXAxxQosiw4
 cNJb8EjodqQV68ieCcJ3978GNjMK1M9ZYIfN3KQVZCbvHb82Q7a/Z0jf2Ca93facCKJEWialna
 +Jo=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 17:57:23 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 4/6] nvmet: remove unnecessary function parameter
Date: Wed, 24 Feb 2021 17:56:40 -0800
Message-Id: <20210225015642.29288-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_205726_194522_91BF7B53 
X-CRM114-Status: GOOD (  13.13  )
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

In nvmet_check_ctrl_status() cmd can be derived from nvmet_req. Remove
the local variable cmd in the nvmet_check_ctrl_status() and function
parameter cmd for nvmet_check_ctrl_status(). Derive the cmd value from
req parameter in the nvmet_check_ctrl_status().

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 drivers/nvme/target/core.c      | 9 ++++-----
 drivers/nvme/target/nvmet.h     | 2 +-
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index fe6b8aa90b53..16a3e434f52e 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -940,7 +940,7 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 	if (nvmet_req_subsys(req)->type == NVME_NQN_DISC)
 		return nvmet_parse_discovery_cmd(req);
 
-	ret = nvmet_check_ctrl_status(req, cmd);
+	ret = nvmet_check_ctrl_status(req);
 	if (unlikely(ret))
 		return ret;
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index db55f3a6f140..4dce09000b3a 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -864,10 +864,9 @@ static inline u16 nvmet_io_cmd_check_access(struct nvmet_req *req)
 
 static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 {
-	struct nvme_command *cmd = req->cmd;
 	u16 ret;
 
-	ret = nvmet_check_ctrl_status(req, cmd);
+	ret = nvmet_check_ctrl_status(req);
 	if (unlikely(ret))
 		return ret;
 
@@ -1220,17 +1219,17 @@ struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
 	return ctrl;
 }
 
-u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
+u16 nvmet_check_ctrl_status(struct nvmet_req *req)
 {
 	if (unlikely(!(req->sq->ctrl->cc & NVME_CC_ENABLE))) {
 		pr_err("got cmd %d while CC.EN == 0 on qid = %d\n",
-		       cmd->common.opcode, req->sq->qid);
+		       req->cmd->common.opcode, req->sq->qid);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 
 	if (unlikely(!(req->sq->ctrl->csts & NVME_CSTS_RDY))) {
 		pr_err("got cmd %d while CSTS.RDY == 0 on qid = %d\n",
-		       cmd->common.opcode, req->sq->qid);
+		       req->cmd->common.opcode, req->sq->qid);
 		return NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 	}
 	return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2938eca5378a..9a445fab3547 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -431,7 +431,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
 				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
-u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
+u16 nvmet_check_ctrl_status(struct nvmet_req *req);
 
 struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		enum nvme_subsys_type type);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
