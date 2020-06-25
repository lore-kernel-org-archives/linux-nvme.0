Return-Path: <SRS0=w+e8=AG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D119C433DF
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 00:03:23 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A476207DD
	for <linux-nvme@archiver.kernel.org>; Thu, 25 Jun 2020 00:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ZieykZXi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A476207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RKRFTnleR+NxtTc+6s77Du0ST60bK75wB96NVHIr1P0=; b=ZieykZXi9J3QJCSqdp1HEYYTsO
	+Ccytv9fQw/GsZ1PLVmLEsx7FIY1IJxSdDev0aZY1CG2WLiJoB4Eb6Sof7XX6oScoOIzUIP3VjAa7
	t9VIGrxT+aI99d+pbfYZjWHP+eijx2p0RWj3iLW6cLbmKi3D0Zv848aj9599mT97DA89VCiARuLFq
	giCZkwF4BZUg9usdeyVqCLp1ODiflQvmk3TWHXvd45SjW3BO74ZslX7NbVpgwEVd7OMnNmlw+pR7J
	gYC6Y+MT9WSKKIcRO2u/hx+LCLrRpnBXEkeFMAoWOB78POrylSrDbFUfizGHEZn11DpkHWKEzOg4l
	DJCzPvfw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1joFML-0005Mm-UP; Thu, 25 Jun 2020 00:03:17 +0000
Received: from mail-wr1-f67.google.com ([209.85.221.67])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1joFM8-0005IG-60
 for linux-nvme@lists.infradead.org; Thu, 25 Jun 2020 00:03:15 +0000
Received: by mail-wr1-f67.google.com with SMTP id a6so4002436wrm.4
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 17:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=wywlvmRu1mfUIVJ41TRmrfAx3KPPFw8gsPRSshHGf0A=;
 b=ky9wAJWABzUgjx5HE05mtNVz1+DYkMxqSzP2vCzHjJSkEIo8mua0g1qLlDRJSIP1zj
 auZZZOxv8sc08xAfpMZjVxwU/XFZQ3mFcwITXeHybRXOIMnxFJfvuZzsA9vm4uvDGlft
 aSJBeCAquPOaEU3bA+MQyWxDKKDdJbm8qMSQDtxC/S5ElkuSU4sycAVXin16q4v2vi1j
 EmA55L+POTKyztPhk1Y2cL1YbTvJh871Hlad8yicOM5/LPz0ofzpav3MlHSNnWzW3Vm9
 kj08eOPSIaS0srOjJR2gKeeaPJJhc2BKfSkYw2UwEwo9cMGrdgkcHes0oSingvPJD/eN
 JKjw==
X-Gm-Message-State: AOAM5303xCT+74zmBc+qMthbbQtg9tUjKtnh5fBrGXZU5cdi35XZ9pEu
 QOjWXYdiY51ZUzC8ltuwglRiSkRb
X-Google-Smtp-Source: ABdhPJznB+o2kBVo1Nu2SIcZcVnkOM8GIMgAsZI5ffz2CaI84Kienc5NRIeVisO8eBBc1grNzTs6zQ==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr34208356wro.317.1593043382715; 
 Wed, 24 Jun 2020 17:03:02 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id d24sm9519866wmb.45.2020.06.24.17.03.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 17:03:02 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH] nvme: fix identify error status silent ignore
Date: Wed, 24 Jun 2020 17:02:57 -0700
Message-Id: <20200625000257.29981-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

Patch 59c7c3caaaf8 intended to only silently ignore
non retry-able errors (DNR bit set) such that we can still
identify misbehaving controllers, and in the other hand
propagate retry-able errors (DNR bit cleared) so we don't
wrongly abandon a namespace just because it happens to be
temporarily inaccessible.

The goal remains the same as the original commit where this
was introduced but unfortunately had the logic backwards.

Fixes: 59c7c3caaaf8 ("nvme: fix possible hang when ns
scanning fails during error recovery")
Reported-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2afed32d3892..3e84ab6c2bd3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1130,7 +1130,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		  * Don't treat an error as fatal, as we potentially already
 		  * have a NGUID or EUI-64.
 		  */
-		if (status > 0 && !(status & NVME_SC_DNR))
+		if (status > 0 && (status & NVME_SC_DNR))
 			status = 0;
 		goto free_data;
 	}
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
