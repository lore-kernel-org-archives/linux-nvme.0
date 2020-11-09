Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8988CC2D0A3
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 10:57:48 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D856120678
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 10:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GtvBxSCS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D856120678
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6WT1A3tHF12ndCybvacrlycgJoeYIlCSH0tYd9xZp8U=; b=GtvBxSCSAW7r3tmKPBJnVmCgRd
	U+wtbUeFTodpZS27V6hyC9y/0gDWrYczrtfHexmF59m7Xt/Oznuc1kU2Y+ZnAfUFbEXS6X1/mgiso
	9dF/l5yzmfQA1dQGzrbkkc3vBwBBDzHHCRnsdDmvXpfliMC+PbCMzX4VsOdN/4EtyvfmroIdjbybh
	9ilWXLbjL8eEO/TA5w+8YO0enXFxCTT9+5MY4UBimZL0llKHbyuonp9MXDo0L+hg9kCXOriI0wS81
	xRYIZLwLb9afAb7ebluhB59zZhAcYqj9hn0FRWWwqLUQqJMWjEBzyb2YpxQR91NNmnHyPkoGs7uzn
	8RyLTSqw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc4rm-0003NC-V7; Mon, 09 Nov 2020 10:57:43 +0000
Received: from mail-wm1-f66.google.com ([209.85.128.66])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc4rl-0003MC-2a
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 10:57:41 +0000
Received: by mail-wm1-f66.google.com with SMTP id p19so5203763wmg.0
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 02:57:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=02Mfma5N2WSo18M4vZ2ErwniAk8MVsl6DIy9sheLQAY=;
 b=PQLLntHI+jpONS6wplvrQ30IX0zd3PbGLxVRbqcXxBDUe8N+NEk9GsNNflH7VsTlND
 4924gN89bnNatFvctArN8pz9ft47JM5EbSSMn1tZap8zCssWMAN5cF6rFrbL+XeN5mZg
 ounEAh0euImJeEl+D0V/EpVUl4o0MhlWDn3yZBr0Xp+3/QI8keFZJiS3dZVL3CbqIMJD
 YxXesihaT8gqHwcPCYIM43dBMlFTlCnclLAuKOw0QCs0GPZVAhAssKz3vwbNMEMrozOh
 XGteWZzTsqsVyZ/V/vqHRsHNFeAlM3otk6ryyrA31x/bq8cz+9IGkd2OqNqFLIhQ6jar
 u+EA==
X-Gm-Message-State: AOAM531/E2Hv8eU59gv7wVwHC+dn8Q81vOvnCkLh3yYflrKw9kiFg6f2
 yQ7J5BdXDzcwt1zTH9cn+CfqXk8+i8o=
X-Google-Smtp-Source: ABdhPJwk7cxnsDYm8HHVGxCcsM+Drm9I3bNMCUU4QaXVu4C03QxWsU4e0SBhk/078IwzJfqk9LiYYA==
X-Received: by 2002:a1c:b70b:: with SMTP id h11mr14677002wmf.185.1604919459688; 
 Mon, 09 Nov 2020 02:57:39 -0800 (PST)
Received: from localhost.localdomain ([2601:647:4802:9070:d1f9:34d6:950b:391f])
 by smtp.gmail.com with ESMTPSA id f20sm12044620wmc.26.2020.11.09.02.57.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 02:57:39 -0800 (PST)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH v2] nvme: fix incorrect behavior when BLKROSET is called by
 the user
Date: Mon,  9 Nov 2020 02:57:34 -0800
Message-Id: <20201109105734.251971-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_055741_149827_CCF43872 
X-CRM114-Status: GOOD (  12.51  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The offending commit breaks BLKROSET ioctl because a device
revalidation will blindly override BLKROSET setting. Hence,
we remove the disk rw setting in case NVME_NS_ATTR_RO is cleared
from by the controller.

Fixes: 1293477f4f32 ("nvme: set gendisk read only based on nsattr")
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
From v1:
- keep the ro set, remove only ro clear

 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 40ca71b29bb9..9b01afcb7777 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2060,8 +2060,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
 
 	if (id->nsattr & NVME_NS_ATTR_RO)
 		set_disk_ro(disk, true);
-	else
-		set_disk_ro(disk, false);
 }
 
 static inline bool nvme_first_scan(struct gendisk *disk)
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
