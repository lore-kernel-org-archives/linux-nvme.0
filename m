Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F305C388F3
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 22:27:25 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40202217D9
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 22:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="riYAk7c3";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvoUk7U+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40202217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=u1Ty/Zztq28GIsRZJ9vKVPoBKVWfMqDw14W4kweyYgg=; b=riY
	Ak7c36LVysw/DffXEe/X/L5juPNelfYjWij3F98Q2DLNCMoAnyCqA63IwLBSgjND3QjvXSJkiqnBM
	kTicZjavoY31n4y6CCIEI3Uu7hRPlEN/a5in4oHd6BX8PCwG/4T+hujpRR1wNURcgIjyoWKNWm+hF
	J9vX1Xfc02hD+Z5k6jJ/7ztA0JBDX1N6R2KgenxCLFOfyM28AT7VxnPMorcrO8hfJI+PHybBNjFvm
	DdlT9c2j2V1ZjyLO0UTYLVtAnJPg5u2/gzO2I00mkS9WaLPChUPDm0ezU1oIrpdenb8RkPg5kqlgU
	bFRkmyWLklXFragrTIP/qtGJkYNMD6g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDyhu-0004OL-HA; Fri, 27 Sep 2019 22:27:22 +0000
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDyhr-0004Nl-V4
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 22:27:21 +0000
Received: by mail-pf1-x442.google.com with SMTP id v4so2321168pff.6
 for <linux-nvme@lists.infradead.org>; Fri, 27 Sep 2019 15:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=htKoag7l58Zi38H+hfaNMCS1bVXuCw2QBsdt/OVLMSY=;
 b=gvoUk7U+5zh81IZq3BNs3lMu99esxFdflddP/dVy/JEDd2frPYZ4YESBW0YpwGKXfZ
 9LG9gHiPcjg/nyiBWVJDqWDi8cx/08X0jcn/YrNQxMpLSuxz6p4v7R3yPRHxFYBvzJ5w
 GRP5ohkl5RWnJ8kDGwuidnE9mc6Xknhn1Sq+UwpsVeTAN1YkIVBHQhSHlGYMy5UFnm8W
 iOnQsy1zjMksQrDXCbk843QTP6UqA7UE5S3N/qdYtEcfXL9PXn37soPONHs6bY7Ef3TZ
 0Uk1LzmprP1RzoN5H8GJtM6A2H5Dn9X2u7j1OuXRfUNSzwlCSojuL4nerOmYwA+PZVEj
 CELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=htKoag7l58Zi38H+hfaNMCS1bVXuCw2QBsdt/OVLMSY=;
 b=ljSLj6oZ5oQ/yvqNYBFlEqVyC57vw/CUEq5I/SdpEliENJmE4IGBlLVv6zUMndIjm8
 nvcwscc/1Gji/DWgU1JSvC0cTMiDhgdpaN16ohdHxPhLIUh2XTY40/IrqadBiaA6ao8p
 xtiGsNw0J/qlML+b9t+2AmJckISY6TJbfud/3SntaGZKrcdLCKcZCs6qmdyWNCcsUtrv
 H4uwjTn5TBDZ0hreVgC+bvnfpwGlUL8XGcGXiz+pWNwx2xACKatk1qLwqx2DOk+CCrw4
 1Jv+3W6zwWTMz5A59qLaxEdswNiK/6FT8XNDQjX760ZhORLaM57SLNnZfT91jQASt+Ke
 x1YQ==
X-Gm-Message-State: APjAAAV2rZGjzmBQ74N15KEd4CYpoeJxxlnJcuNAMTe5BY6qx9f1+YTA
 A/uSgzoLKbdCCh6F/TGZmqiWf6ih
X-Google-Smtp-Source: APXvYqxWmhDMPRfluZewhnVjKkASSAMMzJ80xW4oiMeCDI64oFr1IyBd9fNQHnOtqWEuzvy9LrbISw==
X-Received: by 2002:a62:5c82:: with SMTP id q124mr7156559pfb.177.1569623239241; 
 Fri, 27 Sep 2019 15:27:19 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id s202sm5223271pfs.24.2019.09.27.15.27.18
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 27 Sep 2019 15:27:18 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: clarify error messages
Date: Fri, 27 Sep 2019 15:27:11 -0700
Message-Id: <20190927222711.16556-1-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_152720_022446_740950CC 
X-CRM114-Status: GOOD (  10.35  )
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
Cc: James Smart <jsmart2021@gmail.com>, "Ewan D . Milne" <emilne@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Change wording on a couple of messages to clarify what happened.

Signed-off-by: Ewan D. Milne <emilne@redhat.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b880c5b3d3e0..714a1c3aa0c5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1264,7 +1264,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	if (fcret) {
 		ret = -EBADF;
 		dev_err(ctrl->dev,
-			"q %d connect failed: %s\n",
+			"q %d Create Association LS failed: %s\n",
 			queue->qnum, validation_errors[fcret]);
 	} else {
 		ctrl->association_id =
@@ -1363,7 +1363,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	if (fcret) {
 		ret = -EBADF;
 		dev_err(ctrl->dev,
-			"q %d connect failed: %s\n",
+			"q %d Create I/O Connection LS failed: %s\n",
 			queue->qnum, validation_errors[fcret]);
 	} else {
 		queue->connection_id =
@@ -1376,7 +1376,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 out_no_memory:
 	if (ret)
 		dev_err(ctrl->dev,
-			"queue %d connect command failed (%d).\n",
+			"queue %d connect I/O queue failed (%d).\n",
 			queue->qnum, ret);
 	return ret;
 }
@@ -2695,7 +2695,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		/* warn if maxcmd is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
 			"queue_size %zu > ctrl maxcmd %u, reducing "
-			"to queue_size\n",
+			"to maxcmd\n",
 			opts->queue_size, ctrl->ctrl.maxcmd);
 		opts->queue_size = ctrl->ctrl.maxcmd;
 	}
@@ -2703,7 +2703,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
 		/* warn if sqsize is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			"queue_size %zu > ctrl sqsize %u, reducing "
+			"to sqsize\n",
 			opts->queue_size, ctrl->ctrl.sqsize + 1);
 		opts->queue_size = ctrl->ctrl.sqsize + 1;
 	}
-- 
2.13.7


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
