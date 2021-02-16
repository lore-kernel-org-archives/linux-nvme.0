Return-Path: <SRS0=dBpD=HS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23938C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:32:13 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC3FF64D99
	for <linux-nvme@archiver.kernel.org>; Tue, 16 Feb 2021 21:32:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC3FF64D99
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=cbNIofCYMw5rPBkd2+hA/YMRcPo2QE5n5lerETERW0s=; b=p8mS852VNB16+qlnfBqdvDoic
	Ni+T4wslmW5X4rGDp0UNvMLdhmxfk4roF6Yxra/AuzCwT7ElNta1S1Jv0VZ3zbWw7bP7XW3HWbrvW
	kN1Ob6EWw4YZKahOhCW6kBbbCozMLyWfbzm+UPOjtS0AtZkErkhHH0Zgl8LUTXBks8BQoe5EUV2AJ
	5Gl4Ey0Q5MYK5NpHjasQYv0cYds4sMzVPgUzD4Z/yPdF4L+T/2MFX5DN2BAeL2odmjJRByepc6T4V
	ij3UJHq5fnNcqM0A4317DsiUxK/CTo8QGrJdTMSWeWGKo2KUHl5dW7bjib8tNN4Rd1UyLU1/4YeCu
	Q0MLHcZ4w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lC7x4-0005fb-GC; Tue, 16 Feb 2021 21:32:10 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lC7x2-0005ec-5z
 for linux-nvme@lists.infradead.org; Tue, 16 Feb 2021 21:32:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1613512140; x=1645048140;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=S9O1Kx1zINTttKrIdMarteqyr8R2Pf4fBbQTtdaXYMU=;
 b=W9YpROez0oMUB4QmOlJCJ6kNAPlofwmO7Y6JRUhj/PHRNk0qr9EyBRg8
 8tW/22FaIeiTBATXGB8LR0UbTZPxukofk6Swg3w+r4uIJ1xOh6UkNI8bD
 q5IO9ZWNNhRqlLJdvJ8xvpUqXYTwdATPDKGk0HDvLaI6iU1utYNCme9K6
 ibWGE/HgcewktmrirrvGwicNfCMdPPZj2+E48R3YI70ecQeTIHgm6Htn9
 WhBB19QFL4Y8hxnmwTVkBWDv7eW4MNp41h7s++gSuSPSY7JXIQ0YNKNOD
 Jfp9lkP7r+h6jjWOfJF4Hll2xYJF+3aSu/Xno3tqQEzKo1lV7SqsViM9Y w==;
IronPort-SDR: gPFa59SF9npYYOy1f4atUQlCOxCRq4c1SgD4GHSXBP86PgDYEiL6PgPcn9LwJNTdDKn/B6OFiE
 NwM53arRcPvhmhRAOz/rpwZGdJnq1hTNB0j3Fa7mk89W2cFM4p5AuBGxXdl6mN80qM+7+IJReY
 ft5gWSPMX1lBFv7dOCKTQB7jDDffSOE2Joa3EogqP3PhfV6+X1372Gn1x14ncmEoVlkvIgZZg5
 uQnIFHAHYAsUMq+7zU0xyxWyrDpqcq0JB4xjfrEwf3SgT7V85CAZNS1SOB0ZqGeBKPxgDnlRId
 7t0=
X-IronPort-AV: E=Sophos;i="5.81,184,1610380800"; d="scan'208";a="264264401"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Feb 2021 05:48:59 +0800
IronPort-SDR: ifxIW2qtJ68dfxt7gYs+l1FJ/vZMbB/qKrx59ngW4KfKfSexuiQmCWI9xMGdStVm18cDlV/fSS
 fBnzINJly2yxdNAQme4DHT85QlH0dPJWg0YeKft9jWAwb5N/3CLVfVE2x6OUGWsHtXeLmE3ecX
 OIP9q0EfS2M/fHoBTeuiEg77sB81x2kJWn+NdEDJpWRzIhSLrVCk4JQB585Rgb04Ru+Zo0vLvx
 nnxJcWc4CeL3myAo/OxjrfVoDiCJix6UfcTM7Y3cN0lxg5wHTZf/pXGKFefYPvyCk1bRrVRZcC
 DXynPV8LZLp4KXIc1eC5pbBE
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Feb 2021 13:13:52 -0800
IronPort-SDR: JEhSBabLjARSsyNZudjrxfbthH9h211sJ6gDPVW+xmmpa/Xo7sTUri6hzJs6d3so9BUu8wBvA5
 ySPvadVki9QVd0WITl0dE4ugigJj0vLvLuIz63tMnITmKbS9hekFOc2o66i1kOYHQtIVifUvDP
 ithmfpbIoM3dnZ9vx1X/vp9r+pSDo40dY+g3a5fyvQAuzg+a/qrXfByD4mwnAwIVznyt02LuYN
 DoowoYQs3008UFqe43yE5+xt1JAffWEKTgNf7z3KDFsP+xdj1SlO63/LlWGRLhXOOXLuuT9SdP
 0UM=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 16 Feb 2021 13:32:07 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 6/6] nvmet: remove unnecessary function parameters
Date: Tue, 16 Feb 2021 13:31:12 -0800
Message-Id: <20210216213112.20078-7-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
References: <20210216213112.20078-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210216_163208_406900_A401CDFE 
X-CRM114-Status: GOOD (  12.18  )
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
Cc: kbusch@kernel.org, hch@lst.de,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The function nvmet_alloc_ctrl() accepts subsysnqn, hostnqn, cntlid,
nvmet_req, and out pointer to nvmet_ctrl structure. The parameters
subsysnqn, hostnqn and cntlid can be derived from the caller's
struct nvmf_connect_data.

Replace these parameters with structure pointer nvmf_connect_data *d.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/core.c        | 16 ++++++++--------
 drivers/nvme/target/fabrics-cmd.c |  3 +--
 drivers/nvme/target/nvmet.h       |  4 ++--
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5915b7cc65a6..9ad001fc07f9 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1296,27 +1296,27 @@ static void nvmet_fatal_error_handler(struct work_struct *work)
 	ctrl->ops->delete_ctrl(ctrl);
 }
 
-u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
-		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp)
+u16 nvmet_alloc_ctrl(struct nvmf_connect_data *d, struct nvmet_req *req,
+		     u32 kato, struct nvmet_ctrl **ctrlp)
 {
 	struct nvmet_subsys *subsys;
 	struct nvmet_ctrl *ctrl;
 	int ret;
 	u16 status;
 
-	subsys = nvmet_find_get_subsys(req->port, subsysnqn);
+	subsys = nvmet_find_get_subsys(req->port, d->subsysnqn);
 	if (!subsys) {
 		pr_warn("connect request for invalid subsystem %s!\n",
-			subsysnqn);
+			d->subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(subsysnqn);
 		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
 		goto out;
 	}
 
 	down_read(&nvmet_config_sem);
-	if (!nvmet_host_allowed(subsys, hostnqn)) {
+	if (!nvmet_host_allowed(subsys, d->hostnqn)) {
 		pr_info("connect by host %s for subsystem %s not allowed\n",
-			hostnqn, subsysnqn);
+			d->hostnqn, d->subsysnqn);
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_DATA(hostnqn);
 		up_read(&nvmet_config_sem);
 		status = NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR;
@@ -1339,8 +1339,8 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	INIT_RADIX_TREE(&ctrl->p2p_ns_map, GFP_KERNEL);
 	INIT_WORK(&ctrl->fatal_err_work, nvmet_fatal_error_handler);
 
-	memcpy(ctrl->subsysnqn, subsysnqn, NVMF_NQN_SIZE);
-	memcpy(ctrl->hostnqn, hostnqn, NVMF_NQN_SIZE);
+	memcpy(ctrl->subsysnqn, d->subsysnqn, NVMF_NQN_SIZE);
+	memcpy(ctrl->hostnqn, d->hostnqn, NVMF_NQN_SIZE);
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 46578f98abcc..aa530e0e112d 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -188,8 +188,7 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	status = nvmet_alloc_ctrl(d->subsysnqn, d->hostnqn, req,
-				  le32_to_cpu(c->kato), &ctrl);
+	status = nvmet_alloc_ctrl(d, req, le32_to_cpu(c->kato), &ctrl);
 	if (status) {
 		if (status == (NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR) ||
 		    status == (NVME_SC_CONNECT_INVALID_HOST | NVME_SC_DNR))
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2dd4a91e5e0e..eaa5b7208a36 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -431,8 +431,8 @@ int nvmet_sq_init(struct nvmet_sq *sq);
 void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl);
 
 void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
-u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
-		struct nvmet_req *req, u32 kato, struct nvmet_ctrl **ctrlp);
+u16 nvmet_alloc_ctrl(struct nvmf_connect_data *d, struct nvmet_req *req,
+		     u32 kato, struct nvmet_ctrl **ctrlp);
 struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmf_connect_data *d,
 				       struct nvmet_req *req);
 void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
