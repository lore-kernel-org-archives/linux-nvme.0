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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C87C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:15 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A81961056
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 15:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7A81961056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5wfbCYgzc3HObKWKTBcTIkH0L7Vo1n4KBeZ4oHp9Mxc=; b=t1lgubLjZMMGcQ
	VmFbMSIw5H2GIJ5lMkM+qp+PIEMFlzK5an2Y79dhH7iVSaTh5aOX17cuotgLzbzhgN86DQaOZZxYy
	a7PIX4K5+veHMgTi54Y0SH4YVQ4/eij898vfqEpW2YXp2UYBez0iDmBigm1lEnL9GSnADcYttHNDU
	Tfbgj7M98od8Q+ppgZ4ddTB3bPcSEewslUGuQRW4Qsi9U8DX3mJOYgOPKeEWVmLjB8VSRWH69Hozt
	U9ONxokWWJ+Ye+dWancSAr2mPIykO6YdIToPJI3OVJ4NkYtCYDJ8MU0nxQu1q5Vv3TLgxrd6+jTQd
	ErkP1Y23Ga5K1Q1LcLGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPnvN-002AxA-41; Mon, 13 Sep 2021 15:31:13 +0000
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPnvD-002AvR-8k
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 15:31:04 +0000
Received: by mail-wr1-x42e.google.com with SMTP id q26so15345711wrc.7
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 08:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z4fGpZPa4sVdTvq4PDM3uN1bROXMjFpQEKxZL4RZd0Q=;
 b=SRog65j7QU9biP2Go5Ka0tc1Y+vEPSVqck8F9+PGnRjTsl+fzYmkIOFd/d6T6HIqDo
 F34Q8Ronr2JOe9sGFqEATg32Hq3mrs/hYTmYq83WcudgmTKlF4N+ZDpDQ97rSC0C3F0u
 kMXXWbcyYOSlD7DMQum+Lvbec82RpoXfW7cHkgyWz2CcPXqNX5RykxfYWwsx2HnczcVw
 6Ypu4P0Ds6BUtHDtiscqS61KM9QTWoIt9FJDlnrQrxWeOfeh/wY35IdBVXD8Tsx8aatP
 SAw2bu60K+4gmmifi9LiN/GjrMAsaduE+eqHKqIh1pQpj3v4R0mdjs6tEg2kPPq/qAVG
 7T3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z4fGpZPa4sVdTvq4PDM3uN1bROXMjFpQEKxZL4RZd0Q=;
 b=3KtEBqz4muQFO6sJyNlj/fE8BftelDNMaO7hODv8YwpPIaUOBD8Vyfu9hLlcjX1cEy
 s2ALzyKvfK/RG9A0HhXNv3P3QlPf7vQINbii2voelJBAc5Cef8kzost/gvJYPemE+Ih5
 j8fFNbbhoPDObnnHjUQe3+m+5AL27isXXX9q8PSfUI9YLLgjuj18ym1+cK+1Xr/VQLlU
 /C5nxtzQsYsqHF5n3/wi2zn49qABEBQRtTrObr+tVV3c7WRl6f3Hmbubc55fH4K4/6/2
 AYCfmNnQteAN02LLNd3FRdvELt9NV24DZXUVwX79sWziHn9oEAh+KCUaVXZmU76sMDUB
 GTqg==
X-Gm-Message-State: AOAM531FUjm8RErppzl/o+A+H9ZUE92kKKu6BBfVg/LpojgxkSl/a1x6
 GOpFLglhd7lfVbYyJhuaNdWp7wc7r1TtVA==
X-Google-Smtp-Source: ABdhPJwfXP+i3o6XDp/ZP694qqM3kANyK1yaMLDzvkOQzFi2xpiRXsVeitPeJV0RSqpx2gKT+e+E+g==
X-Received: by 2002:a5d:66d1:: with SMTP id k17mr8828267wrw.200.1631547061170; 
 Mon, 13 Sep 2021 08:31:01 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id h8sm7054087wmb.35.2021.09.13.08.30.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 08:31:00 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v2 1/3] nvme/multipath: fix failure to update ns ana state
Date: Mon, 13 Sep 2021 09:30:21 -0600
Message-Id: <20210913153023.70879-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913153023.70879-1-anton@lightbitslabs.com>
References: <20210912185459.13496-4-anton@lightbitslabs.com>
 <20210913153023.70879-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_083103_365961_8C945D6D 
X-CRM114-Status: GOOD (  13.00  )
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

nvme_update_ana_state() has a deficiency that results
in failure to update the ana state for a namespace
in the following case:
nsid's in ctrl->namespaces: 1, 3, 4
nsid's in desc->nsids: 1, 2, 3, 4

Loop iteration 0:
    ns index = 0, n = 0, ns->head->ns_id = 1, nsid = 1, MATCH.
Loop iteration 1:
    ns index = 1, n = 1, ns->head->ns_id = 3, nsid = 2, NO MATCH.
Loop iteration 2:
    ns index = 2, n = 2, ns->head->ns_id = 4, nsid = 4, MATCH.

Result: missed nsid=3 and did not update its ana state.

Solution: when ns->head->ns_id is higher than nsid,
increment n and RETRY with the SAME ns.

Signed-off-by: Anton Eidelman <anton@lightbitslabs.com>
---
 drivers/nvme/host/multipath.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5d7bc58a27bd..e8ccdd398f78 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -600,14 +600,17 @@ static int nvme_update_ana_state(struct nvme_ctrl *ctrl,
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		unsigned nsid = le32_to_cpu(desc->nsids[n]);
-
+		unsigned nsid;
+again:
+		nsid = le32_to_cpu(desc->nsids[n]);
 		if (ns->head->ns_id < nsid)
 			continue;
 		if (ns->head->ns_id == nsid)
 			nvme_update_ns_ana_state(desc, ns);
 		if (++n == nr_nsids)
 			break;
+		if (ns->head->ns_id > nsid)
+			goto again;
 	}
 	up_read(&ctrl->namespaces_rwsem);
 	return 0;
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
