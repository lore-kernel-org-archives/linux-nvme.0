Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33311C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:11:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D41C120775
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 12:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0NVVp4cD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D41C120775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bvZvbVTZflXBEmvG/WQQdP4oiLE3cjxpeXFF5PRaldU=; b=0NVVp4cDs4eEiy0NkWpy+CLWkC
	BE9TUzDXgZHoSa62bWuX9OzjJS+sEW0xNKINr7uOitB21GUzkcBoup3DnwU1Mp2GoavqJ3O2QoQMd
	aW3v6l2xkRcpLGYKlEnSgDa5uETYFpddSPN+xmi11F9+pzDiTjhiEd1VqYhPlcs6gu3HGomtel2NA
	23NJ0bscnnvol5zvgGcmK9Revg4juYu0vCgxZkjzA5AB7e1iHeHVtJVfmn3aGmTEnjVYf1wwXP8rt
	hd0veoxzE4b01WqYao7aeUkS70DMTQ/2fzAFsw8mgsUFiZfk2xyMFIg6jmoaP5dhpFN0/mqHKk3L4
	2xycy6SQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jonCm-0006hT-9X; Fri, 26 Jun 2020 12:11:40 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jomlg-00025R-Tw
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 11:43:49 +0000
Received: by mail-oi1-f194.google.com with SMTP id a21so7786845oic.8
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 04:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=usp8deldTBUJnG62UlFHDIBYbAhJ44k/40p3DbHwZC0=;
 b=b6hcY3YchH7Uqqg0lPf4h9kjzT0KyZ38faxKSxT69w4TzngQ7MFITjbT/QU/fTDw92
 lVtDmVRObY7+sGqVcLIuayM/ofH32CJ3kmv7pSWG1bt/BZWd9/k4sXd8ZqG/YvjGSKtE
 Y2PTEBfbEhERkzk0NmNd4UArkr2UEf69x6QRa9ejQ7LCeGbGjM9ymLA2yDCqR0G71Kon
 2nspnmove2HU6cZXC2vAeC+WZRLSOQjo6fkK600q+rCh+D03QB72VSiFH/QYll7VtJgS
 10y1lSfYYvJN5G8T7wDrBB9tYNc2OINDduTfmctb5692exQFdsqN4Yvx6TePrnjQTGRv
 rj4w==
X-Gm-Message-State: AOAM530+PygdDMogIGppeugb5fBub+NnXvVGy2+ukta5jPVoLPRf1T+7
 vwbzWK1hVi2Dr+dn/90KHTb5hKKe
X-Google-Smtp-Source: ABdhPJxAPs7NG/cdqDJFHqGw8/GO+9iScNVG8flMAukKKhjwAwTip7aq75BaRlTXwMxoCfE58j9O6A==
X-Received: by 2002:aca:4b41:: with SMTP id y62mr4043166oia.176.1593118436541; 
 Thu, 25 Jun 2020 13:53:56 -0700 (PDT)
Received: from sagi-Latitude-7490.attlocal.net
 ([2600:1700:65a0:78e0:30a8:2583:4785:22e1])
 by smtp.gmail.com with ESMTPSA id f26sm1109552oop.46.2020.06.25.13.53.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 13:53:54 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v2] nvme: fix identify error status silent ignore
Date: Thu, 25 Jun 2020 13:53:52 -0700
Message-Id: <20200625205352.73198-1-sagi@grimberg.me>
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
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
Changes from v1:
- remove paranthesis

 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2afed32d3892..fedd8c2aed53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1130,7 +1130,7 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		  * Don't treat an error as fatal, as we potentially already
 		  * have a NGUID or EUI-64.
 		  */
-		if (status > 0 && !(status & NVME_SC_DNR))
+		if (status > 0 && status & NVME_SC_DNR)
 			status = 0;
 		goto free_data;
 	}
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
