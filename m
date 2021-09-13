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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 636A7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:47:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19B2860FDA
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Sep 2021 21:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 19B2860FDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5wfbCYgzc3HObKWKTBcTIkH0L7Vo1n4KBeZ4oHp9Mxc=; b=wbDZb7gDtjmfv+
	BZBSn8sBYfiVB/n4p0/ZKIBt1hIdWtEACj3B/KmJl00qjyG71LfLjSRsII5jxLBytwbjGA4hvOeOH
	tAbARigBNnDReFT0XCfs5w8NsvUhX0NX8moif5jGD5njkhR9dTUIRKkphef3mzycgENmsxThRE0KR
	hzT98UzBywLWAyfceeq4oPA6R+qw5irJTiSrBLNL+lIwrMAc5IL/YAeBKyfugTmElxuvCMsWn135y
	UaM+mWLhxAh77C1igtm65LYM6M6w2ybKMtM/4BUv6NgblRQu+7oSfbbObMjcDYpUitFs3T0CwgjR+
	GbKQa5sDR/ntkBmXGxfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mPtn3-003MBI-Me; Mon, 13 Sep 2021 21:47:01 +0000
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mPtmr-003M9F-UD
 for linux-nvme@lists.infradead.org; Mon, 13 Sep 2021 21:46:51 +0000
Received: by mail-wr1-x433.google.com with SMTP id q26so16837918wrc.7
 for <linux-nvme@lists.infradead.org>; Mon, 13 Sep 2021 14:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Z4fGpZPa4sVdTvq4PDM3uN1bROXMjFpQEKxZL4RZd0Q=;
 b=mb+ARDVjPhDDbK4jqjRtwegObgIsoc0Hx/bc1tFTA0B5g0bQrHrH/SqCsIKgf/+ZUn
 Te3WFJqjdlDv8CoM+m53Xi5XrZTUF/rES0Y/46NH8lY3/LAYsNcnom3KfteYTh1+YVXY
 efzd1RozSGBY/gCNGv/cqzTm1Msuf4uh9tK9qaY5HYBbfdUCR2rt1LtE+VImLQuZpFSp
 beRmBqEVwSU1AVQxkodRqX/XWCQer3BuzakNY9EbkqR7sEJYki/d/1SYviQMOfjy1CaP
 YRB5ieNCTftGLpZm3EWdcKBmXSuy/u95UQGIS8D47yM42RfOqCp8wBJbx/j4SBUFv4gE
 YgSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Z4fGpZPa4sVdTvq4PDM3uN1bROXMjFpQEKxZL4RZd0Q=;
 b=k8ym6KwT6dMFv0pBq6uEr5ZyPDj23rgKyQRwSSKeYNSgq/ROkggv/iNkSctpXH9rh3
 +YCaN/VBd/DBg6rKFdZpB6VrsVyLXJMqEdAPVJ2g7jeLavwsp+bCIwFZnf+jdyfpoK0O
 njCAVVLXnAKzCoj6k+8pEJc2QctmIcE/EEdOtFGzulkMVtYBiEskjY/BysDZbzXCSM4d
 vvZl68ZAXNYS/J6rhoMZiwWsGkWSWeJvgq4Er6g9e6ptxtPhnrohn1UNx65bz0l3wc4M
 MD6YBmjBThm29V1ow3v9LgIx44nyoxvwQxDjQ7TOnFiJ1omHjM95OHfnvPZUzTH1z6on
 g92w==
X-Gm-Message-State: AOAM532Hq25qJ1P9KfvIqueYod7m+UTmwXFkUlXHASO09i0HGxceRVG7
 ksWJjQtBMfP/lfXDthi3k7u5yU/dORQBGA==
X-Google-Smtp-Source: ABdhPJxYj9y15zbCHFxfnFnW8AlKodSrRhRa8JdVAniKOwQwKZfHhrOO+76x5ad2VQk05H7gTC9HVA==
X-Received: by 2002:adf:b652:: with SMTP id i18mr9071778wre.117.1631569608214; 
 Mon, 13 Sep 2021 14:46:48 -0700 (PDT)
Received: from anton-latitude..lbits (c-76-23-2-87.hsd1.ut.comcast.net.
 [76.23.2.87])
 by smtp.googlemail.com with ESMTPSA id f7sm7776194wmh.20.2021.09.13.14.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Sep 2021 14:46:47 -0700 (PDT)
From: Anton Eidelman <anton.eidelman@gmail.com>
X-Google-Original-From: Anton Eidelman <anton@lightbitslabs.com>
To: linux-nvme@lists.infradead.org, hch@lst.de, kbusch@kernel.org,
 sagi@grimberg.me, axboe@fb.com
Cc: Anton Eidelman <anton@lightbitslabs.com>
Subject: [PATCH v3 1/3] nvme/multipath: fix failure to update ns ana state
Date: Mon, 13 Sep 2021 15:46:30 -0600
Message-Id: <20210913214632.88294-2-anton@lightbitslabs.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210913214632.88294-1-anton@lightbitslabs.com>
References: <20210913154229.71757-1-anton@lightbitslabs.com>
 <20210913214632.88294-1-anton@lightbitslabs.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210913_144650_038384_7557E010 
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
