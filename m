Return-Path: <SRS0=morU=AH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B13AC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 17:46:50 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AADA207D8
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jun 2020 17:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zwZyisG/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AADA207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NG99WjpmxK5bkefVdllGji4XmaCyvfF3KGTZd/qihAI=; b=zwZyisG/XpvohsUXemUI3mul4g
	rEyk2cGy/8ibe9iT2wkQGAgsJPZq46urCo6vE7v14QfqrrYKJSRH0ZeL2gRvDLvjny5GK7jVA+uqi
	T19PYAptpuPDBs6szewhYjp1nYMtGl8FMTaxuF31iTfp/itUjw/QCEzlwbgcHI4Est7eItMwT06eS
	2p/7SvxGt+DW7RfIysbc87knJIWzacpMBz/FxL56fdhv0EQRXYenVwEvYgYbD2HBOD16uz+xAit9C
	HYeWGTs6weIYsw/e+vWBxRwhhByTseBHA7WmZQZ+hOoJ9ubcQXmNsuSm/fzU6VR/eeeDs4a5L/B2K
	5cs5gpgw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1josQy-0005NJ-JL; Fri, 26 Jun 2020 17:46:40 +0000
Received: from mail-pg1-f196.google.com ([209.85.215.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1josQs-0005Lj-AP
 for linux-nvme@lists.infradead.org; Fri, 26 Jun 2020 17:46:38 +0000
Received: by mail-pg1-f196.google.com with SMTP id e18so5252557pgn.7
 for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2020 10:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=0ExYsU1oSDgUomvrDt8oACm2fThWTpr6UnkafTckKXI=;
 b=seWcHvYs4QIWgChgAsr+/xbFSEQ5PhJKymv++eYJLC6CeGxJU6DTKQaRQXuFqyT4dZ
 bZVrrPsjNoGLz+IG1j5xC1yhJMW3MUi1YBayIp3+ui6dQx/FB9Nvgr1tBReEcXcm/Prn
 bfpDema1IQ5GDo2A7jEDjrVio49S/MumI+6HQVes42M7j7NFjdqnAEsS7ViLtTIXyhL4
 BFbKM0uM2W3zZOva4ZWqBaKfdNkO9vbhR+He6T6Z41JhQittqRHj1ypbbDvV7keUJ+Ch
 zb6UpSkfSwO0eBo4P3dZSkat9E8nb/8aWYA5idNAEbVrZRXRdbNzvpeWc3QQSlV7uQX6
 /EoA==
X-Gm-Message-State: AOAM532IVB+/IDTqEQKJbc96W25thFjqd3u7eL0xm9hVlAsgDNu6rn8y
 kSBfMZNLF60GMIpLGNTiH02kCn39
X-Google-Smtp-Source: ABdhPJxjPWmkO697WA5bNtLlNTof8mGoZ1xoQTK0/zVLwg1bkkUL4c3Ynw14nfe9EOKQ/AhPmfyk2Q==
X-Received: by 2002:a63:ca11:: with SMTP id n17mr3658872pgi.439.1593193592241; 
 Fri, 26 Jun 2020 10:46:32 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:4c08:474f:e61d:6947])
 by smtp.gmail.com with ESMTPSA id n19sm25748580pfu.194.2020.06.26.10.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2020 10:46:31 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3] nvme: fix identify error status silent ignore
Date: Fri, 26 Jun 2020 10:46:29 -0700
Message-Id: <20200626174629.115730-1-sagi@grimberg.me>
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
Changes from v2:
- added comment on non-trivial code

Changes from v1:
- remove paranthesis

 drivers/nvme/host/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2afed32d3892..92dc2327bf3a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1128,9 +1128,15 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 			"Identify Descriptors failed (%d)\n", status);
 		 /*
 		  * Don't treat an error as fatal, as we potentially already
-		  * have a NGUID or EUI-64.
+		  * have a NGUID or EUI-64. If we failed with DNR set, we want
+		  * to silently ignore the error as we can still identify
+		  * the device, but if the status has DNR set, we want
+		  * to propogate the error back specifically for the disk
+		  * revalidation flow to make sure we don't abandon the
+		  * device just because of a temporal retry-able error (such
+		  * as path of transport errors).
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
