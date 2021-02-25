Return-Path: <SRS0=GtbF=H3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EAAC433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:28 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 913A364E85
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Feb 2021 01:57:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 913A364E85
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VRT4aGiEQUbj239TlGRSR6PxOHwIKwXK+fQF6XhC9Sc=; b=P96vk+kiZw2n5TbXksRRs4lqp
	fO+ComIl7KOFkROJG7ES20D+Y3eLvMWiZpaFHpUNLgqXCtL8Vo4dDICp64d/y5dErRpmfdym+m4Lk
	AQWVguV67TiwgU7d3ASdHEfNPaxOfK1dOhT4gQB3buG5X6/ahl26afE6/9B9CpbR4e/ovy6O2tacO
	S5hOpn3AQzGsB2cX+kNvB+Xgk6D9+YSJjLrqKBCbWkz78EIRLgbvSUgmF8X/LrW+y0QwJUjd9gcAd
	Smlzc580gYYM+eLJzOcBsv8co3T6vt1Bs+q5MaECAcFrWI7pv+WXDr1BsrpbGyBouU49FxiAfNwlf
	+aKeDdQVA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lF5u3-0007kI-Oj; Thu, 25 Feb 2021 01:57:19 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lF5u0-0007jA-Dg
 for linux-nvme@lists.infradead.org; Thu, 25 Feb 2021 01:57:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1614218236; x=1645754236;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=a43Y9eCi5nwQM40zMXxa3zu63A7qTY1kgJGauMW1JPY=;
 b=GOdUAA8qlsOPNyIP5qdjkSMcOk3JpsOIZRkkm+kZxemoAck1f2xhQJX0
 n+w5ZsXsubpZwrVV5XtSYOGMXtHU2rjN+WQnwkvOX81RW33VMDyhNsupZ
 DEpXO4jCUdjnNhimRhSRfeeoHCyYnLu3eIRf+TWglUdXI7BdGNtwbLE4b
 695+Zb2Py326W3H7D79xMNOdiJtrr/XVfpR+Db6O4DpPvJxPQQgRLQh4F
 BTZ3zN5aZ5T+3p8w2dxQtGV0miX/dr19yH1fbpLB6EbZegCPhd4ekpRvX
 Sexijx0GLiHXTMm8BTeWu0yXBp/o/jhQUgT4dtOiYgELAyUEmp8Hronum A==;
IronPort-SDR: +wJXo5nCX2vbin4aT9ns3uB+hng7L/wz66gS5cd03shubTfKuyncgaSHOEmks1RfhFAszvSEA8
 VPB6WpbKenbTvB+ZDdksibwhj/lL4FOqmX61Gr8poUuaJ9EtCEVvlNirr6pzzjeFthPAnWJUzV
 vVXAhqb7dry258QR30M5bZLxipQLthxZqG+QrtJRFzTuS9rkf/ai7PIc3MlJBww+i/aTNafd7y
 Ld3/v3UJVBGRitAJO5jBw3yqK50F9yQoFJ+4x4ykhktRtqfoxKmNrHkMsDCgWumZZbBX4xS24B
 K9g=
X-IronPort-AV: E=Sophos;i="5.81,203,1610380800"; d="scan'208";a="160734323"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 25 Feb 2021 09:57:14 +0800
IronPort-SDR: T9Om9/5iyw7vmK3w7J+ZUSHxNTp7+rclRmeP01B7cKlvV2d4yaMj9eBhOo1d4D9XXKIq97Yjs4
 Ub7H5rkTiBhR2SnX5djm2fbReG0Eqtyr93dnNlU/lFHWzOc980YFPTc0xqvD99dmKpkG3XhtPf
 XwATdtvL+kiTtQnBtiYqzK3uDFlqrW+XwLGxQxQ7yanDiFB1aJ//hD/qFF8hUqxzEWf/aRwOah
 I7e8oWlDE9ufsf+95v/1Zow2FGRJixhXH5UG+wsa5PxXFIFRXamLy6Uq0u4smUdtE8D5Ti4L1Q
 N2H6HZxOueuHURBs4ejmHbZ1
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Feb 2021 17:40:29 -0800
IronPort-SDR: PbveTBDA49UBCeIxVFOFIEKxhfq+omXWVN2YBmGFYa6Gbq8lslIJk92wA9MbwDopxGtv7HNKaX
 sgxmpd+jgzUd9Sw3UweclfpawGRJ3EeGCTHsVvh/lZaAftVe37wfGOoLK9cIaUjZIMzHxuvi2V
 0u2/7bamw8ZYLFMJUuFs90oklWBg7IuJO5QI/CfhXWNdgfFbw3XJsWCkd2a6FJnP+LBpBNE1Ii
 IV4X967nHXr6rgG++ELASnDJ/7RTgC1tOYlVRtiOdrHVs2lyN25ZJbaJV4aqlqzgtzl19p32i5
 Rcc=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 24 Feb 2021 17:57:14 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V2 3/6] nvmet: remove unnecessary function parameters
Date: Wed, 24 Feb 2021 17:56:39 -0800
Message-Id: <20210225015642.29288-4-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
References: <20210225015642.29288-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210224_205716_609522_5F2309A1 
X-CRM114-Status: GOOD (  18.10  )
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

The function nvmet_ctrl_find_get() accepts subsysnqn, hostnqn, cntlid,
nvmet_req, and out pointer to nvmet_ctrl structure. The parameters
subsysnqn, hostnqn and cntlid can be derived from the caller's
struct nvmf_connect_data.

Replace these parameters with structure pointer nvmf_connect_data *d.

Also, this function returns the same error value from two places. First
on failure to find subsystem from connect data and failure to find ctrl
from cntlid connect data:- NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR.

Move this to the caller to change the return type so we can return ctrl.

Now that we can change the return type instead of taking the pointer to
pointer to the nvmet_ctrl structure remove that function parameter and
return the valid nvmet_ctrl pointer on success and NULL on failure.

Also, add and rename the goto labels for more readability with comment.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c        | 30 +++++++++++++++---------------
 drivers/nvme/target/fabrics-cmd.c | 10 +++++-----
 drivers/nvme/target/nvmet.h       |  4 ++--
 3 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index c4238c08e912..db55f3a6f140 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1179,45 +1179,45 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
 }
 
-u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
-		struct nvmet_req *req, struct nvmet_ctrl **ret)
+struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
+				       struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = NULL;
 	struct nvmet_subsys *subsys;
-	struct nvmet_ctrl *ctrl;
-	u16 status = 0;
 
-	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
+	subsys = nvmet_find_get_subsys(req->port, d->subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
-			subsysnqn);
+			d->subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
-		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		goto out;
 	}
 
 	mutex_lock(&subsys->lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
-		if (ctrl->cntlid == cntlid) {
-			if (strncmp(hostnqn, ctrl->hostnqn, NVMF_NQN_SIZE)) {
+		if (ctrl->cntlid == le16_to_cpu(d->cntlid)) {
+			if (strncmp(d->hostnqn, ctrl->hostnqn, NVMF_NQN_SIZE)) {
 				pr_warn("hostnqn mismatch.\n");
 				continue;
 			}
 			if (!kref_get_unless_zero(&ctrl->ref))
 				continue;
 
-			*ret = ctrl;
-			goto out;
+			/* ctrl found */
+			goto found;
 		}
 	}
 
+	ctrl = NULL; /* ctrl not found */
 	pr_warn("could not find controller %d for subsys %s / host %s\n",
-		cntlid, subsysnqn, hostnqn);
+		le16_to_cpu(d->cntlid), d->subsysnqn, d->hostnqn);
 	req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(cntlid);
-	status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 
-out:
+found:
 	mutex_unlock(&subsys->lock);
 	nvmet_subsys_put(subsys);
-	return status;
+out:
+	return ctrl;
 }
 
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd)
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d2289aa26645..acbb8d1c402c 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -218,7 +218,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 {
 	struct nvmf_connect_command *c = &req->cmd->connect;
 	struct nvmf_connect_data *d;
-	struct nvmet_ctrl *ctrl = NULL;
+	struct nvmet_ctrl *ctrl;
 	u16 qid = le16_to_cpu(c->qid);
 	u16 status = 0;
 
@@ -245,11 +245,11 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	status = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
-				     le16_to_cpu(d->cntlid),
-				     req, &ctrl);
-	if (status)
+	ctrl = nvmet_ctrl_find_get(d, req);
+	if (!ctrl) {
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto out;
+	}
 
 	if (unlikely(qid > ctrl->subsys->max_qid)) {
 		pr_warn("invalid queue id (%d)\n", qid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 4b84edb49f22..2938eca5378a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -428,8 +428,8 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
 u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp);
-u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
-		struct nvmet_req *req, struct nvmet_ctrl **ret);
+struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
+				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req, struct nvme_command *cmd);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
