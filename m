Return-Path: <SRS0=T5dq=OD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEF2C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:47:32 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7E16610D2
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E7E16610D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z0R6jU8qBI4icofFEHbWb1NI/9FpiTzop7jqukkC1Io=; b=niAnSGgV/3z7eH
	nq4ZVebcmE9GlGW+b57GNZX2we0yjwNfYc+jeCrIW/toLyJ8t36qfVEXo2tIHZ79owHhY0lX0NZBM
	hiJwtO/6wl5W8oqQEXSaQoqAyrySb+srVqo5QvzcWdJL26/LywI3jpCRVPFNWCkVHMHiLL3dGC+Vt
	XGUIA6QkUstKG3TUCajWOWu3REa4FFB4K/z8o5NzDL9ccljqECbixCPfcAsxyWRKTxrvy9vVpD4RZ
	h9CoQeauWGBs/tQkZ3REam5YjsKdE3/2mfaPJot+jCaiNOCPwj68dw+VxlwvoxmmYC9T4em2mH632
	MRRR/10HhkqH94uAo6yA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPtnO-003MEf-Dc; Mon, 13 Sep 2021 21:47:22 +0000
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPtmx-003MAT-A2
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 21:46:56 +0000
Received: by mail-wr1-x42b.google.com with SMTP id d6so16824843wrc.11
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WA/+YhlZ5C36MWeS2nSLnseQEHLLuoX21c40E+bwvGc=;
 b=N6ktFQVuYtcAalXFoMdJHhh65xAz9fUfGGK/3D5ktGqbkZ4dxQJ8cwIc6KXEmjP87u
 vHtOlCQ4yO90PuyAJOS4JsCh5oZOfwTGrpCFUjhV1WRYOkFk5/qRXRpLPGVjeWlsmfRy
 UsrnmvdD4eyM1Jls5R1hc9VW3giqNirQxNnN2l5D9S1URQXLELc197gbC1LwujFhoOD5
 W/g5oRqXF8IzHx0Y4CmiAS2akdF6i2aoy4jq6lf7fezNMxrJ1VJqP9VFTypbLuIsjkBT
 jJGkoYOQ4EbJ6NmXnD2x9Z4dvWXt3UI2oHv4NEW8FAw7ZU0J15M9a68Ts/k/yUx1dG+S
 tMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WA/+YhlZ5C36MWeS2nSLnseQEHLLuoX21c40E+bwvGc=;
 b=s3RpXKw5xb/n7j9vKPBVkioop/uavUrQySuajeUElLz49Q2C/YWkExX/J0YgdUv/YT
 Fi8gLzsGtPvZtNcg4jHpJ2ZWmU+5RCryr5SQpIyO2v51G2HTQFwLZa2cI8qI0CEZ3zFQ
 eDozfq+DTw//8wYIT02y45O8RYLM+Ahk7wO/yYcKJA3fzvRNhWR8vTmujCGdcBXj/VAM
 fxVWk8jkwsyo1DxKe3P0h2nleOdif79oYBkRfEqFGw2ZTLUV2GairL2A62Kw8cd97xt6
 DVC6pOmTlTlIC86DiG9AWNi9G9+p4YHTzYyTZMMFwmQg95iRHOgnmSyHs0O89plRxLYj
 5hPQ==
X-Gm-Message-State: AOAM532zIK+a5SF8Z5vGbA/EbCbTgbhhdGU/sB1L/imQs4cA3k+1VZhC
 JRGQuDipWDYu81tmetHCT3bMCCqvfgpMtw==
X-Google-Smtp-Source: ABdhPJzT0iVkIRfSHCPrBYxCtucqj6jLd15KNgrxzZaJ2ej8V6oz9dzQP+qOUJBriVC1R9xJukBtCg==
X-Received: by 2002:a5d:5258:: with SMTP id k24mr14999357wrc.390.1631569613938; 
 Mon, 13 Sep 2021 14:46:53 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id f7sm7776194wmh.20.2021.09.13.14.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 14:46:53 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v3 3/3] nvme/multipath: fix stale ana state for namespaces
 just added by scan work
Date: Mon, 13 Sep 2021 15:46:32 -0600
Message-Id: <20210913214632.88294-4-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913214632.88294-1-anton@lightbitslabs.com>
References: <20210913154229.71757-1-anton@lightbitslabs.com>
 <20210913214632.88294-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_144655_392491_B9E8B77A 
X-CRM114-Status: GOOD (  14.99  )
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

Scan work initially adds new namespaces to ctrl->namespaces TAIL.
They make the list unordered temporarily until nvme_scan_work()
finally sorts the list.

In case nvme_update_ana_state() runs while the list is unsorted,
the recently added namespaces are missed and their ana state
may remain not updated forever if timing between scan work and ana work
is unfortunate, e.g.
Initial state: namespaces = {2, 3}
scan_work: adds nsid=1: namespaces = {2, 3, 1}
scan_work: finds nsid=1 is still Inaccessible
ana_work: log page has nsids = {1, 2, 3, 4}, all Optimized.
ana_work: updates nsids {2, 3} but fails to find nsid=1 in namespaces.
scan_work: adds nsid=4: namespaces = {2, 3, 1, 4}
scan_work: finds nsid=4 is Optimized: sets it live.
scan_work: completes an sorts namespaces = {1, 2, 3, 4}
Result: nsid=1 will remain in Inaccessible state.

Solution:
In order to preserve the way ctrl->namespaces is updated and sorted,
make nvme_update_ana_state() deal with the case where ctrl->namespaces
is not fully sorted and has new namespaces appended with potentially
lower nsids.
nvme_update_ana_state() keeps track of the nsid seen in the list,
detects the unsorted case (rare), and restarts scanning of desc->nsids.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index e1ce80c12815..14504a71711c 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -587,6 +587,7 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 	u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
 	unsigned *nr_change_groups = data;
 	struct nvme_ns *ns;
+	unsigned last_ns_nsid = 0;
 
 	dev_dbg(ctrl->device, "ANA group %d: %s.\n",
 			le32_to_cpu(desc->grpid),
@@ -603,6 +604,11 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 		unsigned nsid;
 		unsigned ns_nsid = ns->head->ns_id;
 
+		if (ns_nsid < last_ns_nsid) {
+			/* Unsorted ctrl->namespaces: re-scan desc->nsids */
+			n = 0;
+		}
+		last_ns_nsid = ns_nsid;
 again:
 		nsid = le32_to_cpu(desc->nsids[n]);
 		if (ns_nsid < nsid)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
