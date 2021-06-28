Return-Path: <SRS0=8S6Q=LW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 049DFC2B9F4
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:17:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B825A61954
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Jun 2021 05:17:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B825A61954
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ZT4gc7rMqIsjWm7jZOBFv3e1IDG8sBXPEntKRnIFs5c=; b=3clNQsKMpy3aSx
	jTpaJdnJvQ+QB7VwB0HjuV1bDs2GpcTlUufNQdcf1QAc0T6DZHElQwYkMD3lzZ8GCao32ANBhhy5r
	Y+yS18iUubutVGUyYaqE8LnYFsxk9UbyU0lYYfXZLW9g3v37rbn8ak/1Ye4Pl1cbnfWJjuGyeoipf
	zy1AEqcPkJBIXS6b4smOu0RxoSseL7Hj+x0Xy3vWdiSB+pNbYG9zAfMj6w3jNrShjQJHMukedTsc3
	gVA2KClR/vgSnbCWkHWy3DSRUZsK2cOjDB/P7Qcc8lPXUwbU7e5IDMGIdV5z48OrmyOQ6gkUu8AtA
	j2eQi7UI9IoPsC0MV0pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1lxje3-006n6I-IE; Mon, 28 Jun 2021 05:17:19 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxjXg-006lkq-TE
 for linux-nvme@lists.infradead.org; Mon, 28 Jun 2021 05:10:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1624857044; x=1656393044;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RFvlh3Opww22uItoLxmMR7Kc7fMIXDvzKSUWT6kxgjc=;
 b=ENKWrhawdNdwTzWcDsgsImwPwXCcXWPLLeIc9iP5EQGjoHGnO/6pAVpK
 QAOMfNWC4AJOVfL6wPCwYRdmq8Tq1xC0duh+GCKIgdPjcW3+ahJL/L387
 7irSUnAWzwzALs0Zo8iGimfU56hQymkNs93/tdJERfFBduWYOpLMlTmv2
 dLXs0VTItXj24JS+835rBkzZ9PBnjg5oixO+uChJGcorKR20c5sicNjwg
 AsKYBMfI8nrIagnUjxS1a0c8qO2UgcBAL7l/LeZjRZyYktja6Q9Vqrecm
 kJ4gQH03SQ8odI2m/jfxDsNUy0jxSTslRMvTdot9bStEa/GJHc2mFbDnp g==;
IronPort-SDR: uxHWfE/voTLO0gIbcV83c/BF/m4HsyQHixbLH8czTvx7lVfzFIF38f8QugyPisIgbPmbOYgYpN
 kMqUZl3HGy2nxiamqluO7jtvqeOGNXcsvDrW3imAPuAQwptnq8i3K99jmZXbcPuezbhWJm3UOP
 aU7wO7HONc/lR6vbBr5ZBeyBPpzZAzILGJBUddNbVGaXkoPPtE4ZUFfLoe1LicC2Qq1CPU2bOO
 mUbPL99C8NJY+ssYz8tzBfH+6ZTrZoT9WGWuZSz9LjuDrptvsGVjXAtGF8LUfGAWwZAi0z0K9s
 Fbk=
X-IronPort-AV: E=Sophos;i="5.83,305,1616428800"; d="scan'208";a="284548788"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 28 Jun 2021 13:10:44 +0800
IronPort-SDR: aRjZuy+1d/8oeqgJSMKw+p6zXOI/XdMvX4Bdl8hNRExjCYZ6rxnKpHtf11xClT28unafx2KT95
 +d+HXHBB74H7ex2yKCXKxf2qXbcRfrQTgauogKkcm7wvcLRb96Lb6k221FfZ9wZl1QNy5zbCv3
 HtTpW28nfUfD/yXNj5SjhIrll7xEcCXY/UIPVFFcNUcP4rJ1Zz6WGnwNP0gmCQGZF6DvrSP2C9
 fjP1Rcnx2MnU04XHgg0m8d74Q49aDPZt+2eqEH3IMj8m2wOKjwmVhmYPoMGl1JWflGGOh4LFJx
 dAxMAoicf3WaLqcziqFU6yDz
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Jun 2021 21:49:13 -0700
IronPort-SDR: Iqrqf6MfopI1gF59F/uIsP40WE2wza4bKKeDcfULWT/xYCDUT42c+CrSgEzh0kGDAnaT8uZ2Ob
 xMU3BKvvch9eKNJMjrvrZS9qtvaT/Npa2jOQEbuyXiG65UHT4ZPN1GMXjVpX16cQHTbfR1bfuS
 bFreMNcS/WGg4qAfq2HV7LtvzA+ZcjIoxFzt3aIQJfRP+NTN9ViialmMOV8b73uK8Cib3Z2C0a
 k85eGxce4CnuC/bb62G6Uf+oOdoONznbMCoo4dDhS2V5fzydl4f5SY/i4Z7f+TgR8su5s2kVC/
 Oow=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 27 Jun 2021 22:10:45 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [PATCH 14/14] nvmet: remove repeated call for id-cns-ctrl
Date: Sun, 27 Jun 2021 22:08:17 -0700
Message-Id: <20210628050817.19788-15-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1.dirty
In-Reply-To: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
References: <20210628050817.19788-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210627_221045_037548_97F33217 
X-CRM114-Status: GOOD (  13.42  )
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

Return status from nvmet_execute_identify_cns_cs_ctrl() and complete
the request in nvmet_execute_identify(). This reduces number of
repeated nvmet_req_complete() calls for identify handlers.

Also, now we can get rid of the goto and out label needed for request
completion and directly return.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/admin-cmd.c |  4 +++-
 drivers/nvme/target/nvmet.h     |  2 +-
 drivers/nvme/target/zns.c       | 12 +++++-------
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index ef6982beb6b0..1a8ca93b6bb9 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -709,7 +709,9 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED)) {
 			switch (req->cmd->identify.csi) {
 			case NVME_CSI_ZNS:
-				return nvmet_execute_identify_cns_cs_ctrl(req);
+				status =
+				nvmet_execute_identify_cns_cs_ctrl(req);
+				break;
 			default:
 				break;
 			}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index f1c9cd445c74..b2eeb296cc37 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -545,7 +545,7 @@ void nvmet_ns_revalidate(struct nvmet_ns *ns);
 u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts);
 
 bool nvmet_bdev_zns_enable(struct nvmet_ns *ns);
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
+u16 nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req);
 u16 nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_recv(struct nvmet_req *req);
 void nvmet_bdev_execute_zone_mgmt_send(struct nvmet_req *req);
diff --git a/drivers/nvme/target/zns.c b/drivers/nvme/target/zns.c
index 2e1f01ec0dd1..28a1de2e0fbf 100644
--- a/drivers/nvme/target/zns.c
+++ b/drivers/nvme/target/zns.c
@@ -71,7 +71,7 @@ bool nvmet_bdev_zns_enable(struct nvmet_ns *ns)
 	return true;
 }
 
-void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
+u16 nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
 {
 	u8 zasl = req->sq->ctrl->subsys->zasl;
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
@@ -79,10 +79,8 @@ void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
 	u16 status;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
-	if (!id) {
-		status = NVME_SC_INTERNAL;
-		goto out;
-	}
+	if (!id)
+		return NVME_SC_INTERNAL;
 
 	if (ctrl->ops->get_mdts)
 		id->zasl = min_t(u8, ctrl->ops->get_mdts(ctrl), zasl);
@@ -92,8 +90,8 @@ void nvmet_execute_identify_cns_cs_ctrl(struct nvmet_req *req)
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
 	kfree(id);
-out:
-	nvmet_req_complete(req, status);
+
+	return status;
 }
 
 u16 nvmet_execute_identify_cns_cs_ns(struct nvmet_req *req)
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
