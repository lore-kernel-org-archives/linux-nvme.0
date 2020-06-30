Return-Path: <SRS0=73dC=AL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_ADSP_ALL,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB043C433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 12:29:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7970F20672
	for <linux-nvme@archiver.kernel.org>; Tue, 30 Jun 2020 12:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gElQ/0vA";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="UnIpBBvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7970F20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DefcKWxvlTrCTE8VOCVyNQ2JbxiF0si78D+gojsinKo=; b=gElQ/0vALEOtL344Pjca0sSyGQ
	OavAy7dfHTmuhGcxmnekcH6wjXoThSjOtq8Ax6l3Sxo/kgoa67bhgQYSA6UngMLclkoRDd3VCKWgg
	7xOoUv+tdgERuKZR1yD7aFNIeHu/33M7olmE0l0j4K0xCzDGJtlnbaZxeWWtvscKe6+BliMepSWdw
	O3ApJYlDTRujOuxZscABr8GsYuvnqGnaXJ7Ow7PwV8A05gFnNoukjOsr8iQbz8E7DyhVsPcr4oGdE
	z+/KVwWfsoOZ1ZcwsT2Dk6VrEjQ9acsFkg3NbRLz4MM4g9/PFpY9klTgUk+AR8AAt9cmq9eC6gwgQ
	sFq/Q15Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqFOX-00058n-Nn; Tue, 30 Jun 2020 12:29:49 +0000
Received: from smtp-fw-4101.amazon.com ([72.21.198.25])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqFOS-00058E-Jk
 for linux-nvme@lists.infradead.org; Tue, 30 Jun 2020 12:29:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
 t=1593520184; x=1625056184;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=1SYBHjTB+q5E+ZB8QENYuEXlQudyQrqQO5pO6Am+EEU=;
 b=UnIpBBvkK/eA5Wsa4tP1IwJkNvC+7iklZ2pkzfTVAA/lKGxnJg98cu12
 lfLTqFE3MaWgPvgXPovvSunSLsCJktu+DrcklFGC0Rpktrg1MDrcMp9r3
 kJgjKG54ryEsakUqzeuWKeXHf8J6GKwRL+gStTthURKRb1ZY1ayVBK9XW E=;
IronPort-SDR: 24GE8aKjT5T9+JGempUpxCY0xCGWdMUQzMqL9jkMNbtduu4ZyyCdQF6qGsE8klTAMuwe714Jgk
 xvtVzeu8wrVQ==
X-IronPort-AV: E=Sophos;i="5.75,297,1589241600"; d="scan'208";a="39354207"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO
 email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.43.8.6])
 by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP;
 30 Jun 2020 12:29:39 +0000
Received: from EX13MTAUEA002.ant.amazon.com
 (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
 by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (Postfix) with ESMTPS
 id DD6ADA23B6; Tue, 30 Jun 2020 12:29:38 +0000 (UTC)
Received: from EX13D18EUC001.ant.amazon.com (10.43.164.108) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 12:29:38 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D18EUC001.ant.amazon.com (10.43.164.108) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Jun 2020 12:29:37 +0000
Received: from dev-dsk-mheyne-60001.pdx1.corp.amazon.com (10.184.85.242) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 30 Jun 2020 12:29:36 +0000
Received: by dev-dsk-mheyne-60001.pdx1.corp.amazon.com (Postfix,
 from userid 5466572)
 id 92633222EA; Tue, 30 Jun 2020 12:29:35 +0000 (UTC)
From: Maximilian Heyne <mheyne@amazon.de>
To: 
Subject: [PATCH] nvme: validate cntlid's only for nvme >= 1.1.0
Date: Tue, 30 Jun 2020 12:29:23 +0000
Message-ID: <20200630122923.70282-1-mheyne@amazon.de>
X-Mailer: git-send-email 2.16.6
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
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Maximilian Heyne <mheyne@amazon.de>,
 Keith Busch <kbusch@kernel.org>, Amit Shah <aams@amazon.de>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Controller ID's (cntlid) for NVMe devices were introduced in version
1.1.0 of the specification. Controllers that follow the older 1.0.0 spec
don't set this field so it doesn't make sense to validate it. On the
contrary, when using SR-IOV this check breaks VFs as they are all part
of the same NVMe subsystem.

Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
Cc: <stable@vger.kernel.org> # 5.4+
---
 drivers/nvme/host/core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 28f4388c1337..c4a991acc949 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2773,7 +2773,8 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 		put_device(&subsys->dev);
 		subsys = found;
 
-		if (!nvme_validate_cntlid(subsys, ctrl, id)) {
+		if (ctrl->vs >= NVME_VS(1, 1, 0) &&
+		    !nvme_validate_cntlid(subsys, ctrl, id)) {
 			ret = -EINVAL;
 			goto out_put_subsystem;
 		}
@@ -2883,7 +2884,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 			goto out_free;
 	}
 
-	if (!(ctrl->ops->flags & NVME_F_FABRICS))
+	if (!(ctrl->ops->flags & NVME_F_FABRICS) && ctrl->vs >= NVME_VS(1, 1, 0))
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
 
 	if (!ctrl->identified) {
-- 
2.16.6




Amazon Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 149173 B
Sitz: Berlin
Ust-ID: DE 289 237 879




_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
