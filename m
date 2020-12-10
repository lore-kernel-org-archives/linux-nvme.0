Return-Path: <SRS0=ToWz=FO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F205C4167B
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:08 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D53362332A
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Dec 2020 02:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D53362332A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=DMnFMAgrt21X8Rdd4tUzMtpkoDAkCnsK/rifhkD7vbk=; b=H78ssrda380sWejvoLnEmc5s+
	dxMuWl3t+++kEcvQXSrYlo4K7FI9RazPlg/e+JMfXeQwbbJUwFb0HPmDxlTnD7XenRYkyLRrDVtHu
	iqPXccG5BXo9q3GCP+6FFDs7hI3rblCkU/L/zT2/ZX+f9I/d+xh1tT04Sjh+4Qi+3uoewuQc9Crim
	R21+oI49gV+rmq/jNzs0ocNlqKaIwbQTiMGf8cp1VgwEfDjMBu5P0HA/x8Ot8ftUSCcI5KzqiY9Ei
	qkkHU08iJ1PswAB79MJmVgWrso8TLBnZTGAxoWdgV97vKc3Klm9jLiFsIjZLt4mT4NNq3g4dCByNd
	b9aBjXCDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1knCAY-0000DY-8b; Thu, 10 Dec 2020 02:59:02 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1knCAT-0000BF-48
 for linux-nvme@lists.infradead.org; Thu, 10 Dec 2020 02:58:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607569751; x=1639105751;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=r8+CSwQUHkQ11e1bMsWsbJGKZh+AxQm5+zNBAuqytxg=;
 b=dnWdskmzD7qzwohZSXdBmXWCzmASzcQGIdIADdO5h9NqCLBSawjliHuf
 oYUUsidElxl/gyrqeD5stv8uY1iw0e+79Hd3mhRnGORPq49BGqTEJKu8s
 LIfYIF1u1HUe2lvo+jgDsKelTICHLlttRSXeht4ohZOPPxjarV0UME1At
 v997b7Bmz+PWEN1vqa6od26llA82M+AAIVsqhxGd1Y59iAL5gE4kqn+bJ
 klabw+DuQHQE3vhw6JNfRTwCEaZBbCgVjTkBceQEbXkN3C25/Qj4E97ll
 bTEOlCXGP0TcLXfbN1f96zZ6f+Qm71PyDqG7RXbJWh0ziQ5u/LCip93CQ A==;
IronPort-SDR: xHv2BZZhMtCEe50bH4qSorYnIpQp5y0dYBwE7W3oGVlPYXJHb/CRlT9hnUOpzxwhreLym2rsfh
 waEhA1E1HjkX7ir0dX3Ep/nslvFX782jCz7t/gJ+YB1cAKXQoITmw8TEUhQYrMfrjev7KLPs4C
 qLxFcB0dOUehHdLaa8iSdVJVQ7thvdfssx889c+3uThVSGyZFa+kOtcizvW+8EuQmxKqUdOYhd
 t7qTxpDZRTGYX1yZL+vw3TXmyatmrrvLYuP45RF5s2Q2Vm/sLx13Zp7is/Xbn9Kp2w8QmR6jP7
 tOM=
X-IronPort-AV: E=Sophos;i="5.78,407,1599494400"; d="scan'208";a="258549084"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 10 Dec 2020 11:09:08 +0800
IronPort-SDR: XH7vXR240oCxGiE6Wtao2b5c+9CKGm+vK6eFHswpg0BKzaZHaeCJoB3cVsW7DNzUymMvh2BLTr
 v92+k/wuPKK9tw0Pm6UhCk/EKN8suBeFE=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Dec 2020 18:44:20 -0800
IronPort-SDR: qYSXxpA96iP0HtD20itQxooqlGGyny+KwI/3/0me6b6H9laOaPmgg9BJUIFEMmachZ456Yy/Ij
 FkUCwoIu52+Q==
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 09 Dec 2020 18:58:55 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvmet: remove extra variable in identify ns
Date: Wed,  9 Dec 2020 18:58:46 -0800
Message-Id: <20201210025848.46903-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201210025848.46903-1-chaitanya.kulkarni@wdc.com>
References: <20201210025848.46903-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201209_215857_334334_8C37F757 
X-CRM114-Status: GOOD (  15.89  )
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
Cc: sagi@grimberg.me, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We remove the extra local variable struct nvmet_ns in
nvmet_execute_identify_ns() since req already has ns member that can be
reused, this also eliminates the explicit call to nvmet_put_namespace()
which is already present in the request completion path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 31 +++++++++++++++----------------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4241cb072f64..86b6bd9a662a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -468,7 +468,6 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
 
@@ -485,18 +484,19 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	}
 
 	/* return an all zeroed buffer if we can't find an active namespace */
-	ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
-	if (!ns)
+	req->ns = nvmet_find_namespace(ctrl, req->cmd->identify.nsid);
+	if (!req->ns)
 		goto done;
 
-	nvmet_ns_revalidate(ns);
+	nvmet_ns_revalidate(req->ns);
 
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
 	 */
-	id->ncap = id->nsze = cpu_to_le64(ns->size >> ns->blksize_shift);
-	switch (req->port->ana_state[ns->anagrpid]) {
+	id->ncap = id->nsze =
+		cpu_to_le64(req->ns->size >> req->ns->blksize_shift);
+	switch (req->port->ana_state[req->ns->anagrpid]) {
 	case NVME_ANA_INACCESSIBLE:
 	case NVME_ANA_PERSISTENT_LOSS:
 		break;
@@ -505,8 +505,8 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 		break;
         }
 
-	if (ns->bdev)
-		nvmet_bdev_set_limits(ns->bdev, id);
+	if (req->ns->bdev)
+		nvmet_bdev_set_limits(req->ns->bdev, id);
 
 	/*
 	 * We just provide a single LBA format that matches what the
@@ -520,25 +520,24 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 * controllers, but also with any other user of the block device.
 	 */
 	id->nmic = (1 << 0);
-	id->anagrpid = cpu_to_le32(ns->anagrpid);
+	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
 
-	memcpy(&id->nguid, &ns->nguid, sizeof(id->nguid));
+	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
 
-	id->lbaf[0].ds = ns->blksize_shift;
+	id->lbaf[0].ds = req->ns->blksize_shift;
 
-	if (ctrl->pi_support && nvmet_ns_has_pi(ns)) {
+	if (ctrl->pi_support && nvmet_ns_has_pi(req->ns)) {
 		id->dpc = NVME_NS_DPC_PI_FIRST | NVME_NS_DPC_PI_LAST |
 			  NVME_NS_DPC_PI_TYPE1 | NVME_NS_DPC_PI_TYPE2 |
 			  NVME_NS_DPC_PI_TYPE3;
 		id->mc = NVME_MC_EXTENDED_LBA;
-		id->dps = ns->pi_type;
+		id->dps = req->ns->pi_type;
 		id->flbas = NVME_NS_FLBAS_META_EXT;
-		id->lbaf[0].ms = cpu_to_le16(ns->metadata_size);
+		id->lbaf[0].ms = cpu_to_le16(req->ns->metadata_size);
 	}
 
-	if (ns->readonly)
+	if (req->ns->readonly)
 		id->nsattr |= (1 << 0);
-	nvmet_put_namespace(ns);
 done:
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 	kfree(id);
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
