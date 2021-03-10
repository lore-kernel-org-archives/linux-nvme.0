Return-Path: <SRS0=Sfb4=II=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BE58C433DB
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 01:17:18 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B997165000
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Mar 2021 01:17:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B997165000
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xIczaKIWHKftvmBwHokCLkmFbO2WesKA+loz5v8Bwic=; b=NzkH2C8BRXjhR2e0klo+AsbL9A
	JLFOyy9IRHxcn6bhchYq6yIkAzsbbdM5WeLWquM9wW/ZOy9GBMbOllwpDBZp/zvtgaFHaI8+YbPV6
	toNe2h9kPeF+wPlKqy2bRZ73yTOh8/kxWxlQ76ooT1FzMAQP6spMkvklOtxAa34xvDyePKQDOteCN
	fMgdq/XFmljCC44NVrKYseU0W/IZawFJ9OQDJjRPkFlq9X7mjwK+WmPtVE+xxFrDc9LxuKn9//4Pt
	s1bCDyts+4VfhIAd18N8gK6UIrg0DTGJN9oEEi2RGoosz8SG/hrhHc3UTFgcNTMCeW5Hli/UUXJWo
	mzLuQkww==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lJnTJ-005jpE-F8; Wed, 10 Mar 2021 01:17:09 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lJnSp-005jn5-Q2
 for linux-nvme@lists.infradead.org; Wed, 10 Mar 2021 01:17:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1615339004; x=1646875004;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MqY8bHAAjQXzmzR78PZz43K6Q8ZRnc3OFIEVZ0APd70=;
 b=or72agJ1tRNcLmSW5Yr5+Wo8iNXuJRmFfopwhZ8p8QraSrslmhv8QU7b
 2qKXU5ILq4YehqaEv7D5sRmCa+6n1B/WL5qt8n7yowAd8veRL9SSEIwqE
 8L69zK+RGEu+iRw8X4wWwyXuC1DJ7G5YMKqQ5wD9nchmKaU3MAx1EGBBB
 CRRk9M9E/MxIQ2JWsUoyNGo6UTF2HO+tJ+QbjdW85lbcSgL4EOAv1XY2f
 60dLkkTy/R9nAgbaqNgTJT4xhVSnMZha/aLQAVU9+sBo4KXhjrbItZOe8
 bFVi2e72etQKGMuHVts5xQBQpPccN+72VAKoiwi8vW16Yo0ZDmEC9WxVi Q==;
IronPort-SDR: YGdA/DZfdSXelyimhfDDwRXyDcHmXI2WcRhAkT9WQWXJTsUM753qCI1M+iE8lUSMQkt8Vy/Nc5
 4ft8pj0Z3QPD++iE/UA/i9iKlxay99Zr/DR1tcqS1J+u/XJzQL1/DzoGlPoHCgJMyy5PVp3KUI
 CJMeGFxa8REu/+KgfXCXpDW6RNq5cuVnvQhHqxwhT6kTj4oC56fABj8RorYMMm9xlusFwUgp0+
 l8g2H+ZZsWQNQme4nqPYZvWUGp3bDEBiriPc3YPcbC7yU+EoQ2R0lGGtJMSZKRx17WDwpEvG28
 gko=
X-IronPort-AV: E=Sophos;i="5.81,236,1610380800"; d="scan'208";a="266109261"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 10 Mar 2021 09:16:37 +0800
IronPort-SDR: Skh4kNslffKhWUVW+qvHK8qlKNBfVa9KUDjpVGbm9UwTtg2+nR2hms/vENSMR8+JBjLnbXuoyM
 N1Em8CEHcbyj50rphFF1izkkf6fv4QWstUxtZMcIPlpeX53UVxm0JwcKrS8tTLgxZip0C6D/gp
 t0/xA8QL9RITh0kZnulUi/wOcx1O0f+RzG9xri8YVL/15lkZLMHjW5i9vYSWVrJ2k3LRjHalTl
 8w8E4uJPGkD+ndYEhAdEE+XK2qrkny6jYxCRLlJocf3zmE5stf28sfUX6j0qBBtxXLY3SetGt4
 NmN1Ms2V0HYjqb8TSH+ISbc4
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Mar 2021 16:57:32 -0800
IronPort-SDR: QPyqmV66IicJNEkP5S0Jb0MdYY6JzccFW4Y4qIWeqsOmQ//Owk6OrAlKpUs+EonnkKiuG0G5YS
 i0SXfDiXNaNJ6zZqYKTxW9XVZW49ft3jcf2OMpM49QtfqemkFKpk2BBe3m3tP6UIpvuUzIJhcV
 zUU+SYWRijsJCwSXYLOVWP/mhwBVRgI8zTeA19CzTKXZ3eJLKuw8x6+MJXNa17dfR0fz6gM+6M
 68BGcnX9xyExc+XX4qTM5YhBZsmDv1xzGjMgarYn4bo17c7ukOIk/bTecDQloWc+G+U4iOrfzM
 0xM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 09 Mar 2021 17:16:35 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH] nvmet: remove unnecessary ctrl parameter
Date: Tue,  9 Mar 2021 17:16:32 -0800
Message-Id: <20210310011632.38818-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210310_011705_825474_C76FE172 
X-CRM114-Status: GOOD (  16.69  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_ctrl_find_get() accepts out pointer to nvmet_ctrl
structure. This function returns the same error value from two places
that is :- NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR.

Move this to the caller so we can change the return type to nvmet_ctrl.

Now that we can changed the return type, instead of taking out pointer
to the nvmet_ctrl structure remove that function parameter and return
the valid nvmet_ctrl pointer on success and NULL on failure.

Also, add and rename the goto labels for more readability with comments.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c        | 21 +++++++++++----------
 drivers/nvme/target/fabrics-cmd.c | 11 ++++++-----
 drivers/nvme/target/nvmet.h       |  5 +++--
 3 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 2f0213b4a6df..adbede9ab7f3 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1178,19 +1178,19 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
 }
 
-u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
-		struct nvmet_req *req, struct nvmet_ctrl **ret)
+struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
+				       const char *hostnqn, u16 cntlid,
+				       struct nvmet_req *req)
 {
+	struct nvmet_ctrl *ctrl = NULL;
 	struct nvmet_subsys *subsys;
-	struct nvmet_ctrl *ctrl;
-	u16 status = 0;
 
 	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
 			subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
-		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+		goto out;
 	}
 
 	mutex_lock(&subsys->lock);
@@ -1203,20 +1203,21 @@ u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
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
 		cntlid, subsysnqn, hostnqn);
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
 
 u16 nvmet_check_ctrl_status(struct nvmet_req *req)
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d2289aa26645..1420a8e3e0b1 100644
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
 
@@ -245,11 +245,12 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	status = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
-				     le16_to_cpu(d->cntlid),
-				     req, &ctrl);
-	if (status)
+	ctrl = nvmet_ctrl_find_get(d->subsysnqn, d->hostnqn,
+				   le16_to_cpu(d->cntlid), req);
+	if (!ctrl) {
+		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto out;
+	}
 
 	if (unlikely(qid > ctrl->subsys->max_qid)) {
 		pr_warn("invalid queue id (%d)\n", qid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 824d06e2779b..24e261bf153a 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -428,8 +428,9 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
 u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp);
-u16 nvmet_ctrl_find_get(const char *subsysnqn, const char *hostnqn, u16 cntlid,
-		struct nvmet_req *req, struct nvmet_ctrl **ret);
+struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
+				       const char *hostnqn, u16 cntlid,
+				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
 u16 nvmet_check_ctrl_status(struct nvmet_req *req);
 
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
