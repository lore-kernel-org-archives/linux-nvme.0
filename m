Return-Path: <SRS0=U6YU=AK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25643C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 14:34:29 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB1B223B32
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Jun 2020 14:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="dPN8i+us";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CNRiyn8A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB1B223B32
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oG8lt3vmxkx0WBOzyoSRpc2rov1Onbel86Ulk//vMIY=; b=dPN8i+uskcUl8CpUbEqtuljBMv
	ZoiyrDfLAOgOV4cAccUszufwkhAaCNelv7oSh+60r3kc9/TvDpv+o4xVOvKjo1u83VJZdGOPsH7SG
	7Zo2uGS/u8rXO14FqcKLsdTmq5DAjtLYZuJvFoiJdmG220NXhGNsD4L874YeHHjv/JqMO7aYNNyna
	8NlCfE0b8M85AP9JDlXxqM2vgChXGmwpG86aCYVR19JrHjWfGrzUBwRAIBhCQ2ML3rQ4AdcsEIDMA
	lqDexPcYr67nJulGEuSVNfFJ696+rxSCO5hgOb9hOC6IyRNA2p61pfoqbPmk0y5XH8Qu/Zn31vgo6
	1qjrqHnQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jpura-0004TQ-9p; Mon, 29 Jun 2020 14:34:26 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpurY-0004T7-TL
 for linux-nvme@merlin.infradead.org; Mon, 29 Jun 2020 14:34:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=lm3zcLY1y9kwd3Xy4E3/scdNOhY3tR7sjcctzGwGwGQ=; b=CNRiyn8ALYPYd+8cFT0yBTEUKI
 YJGwqyOqVdsgIk8M3zAL5oRCRGPg1+5CxmOrCSSg2BKnPrsp0CWuoIarGali0WFt6kKylJNm031/0
 sOzj3uLJl1Dqke1EYQYrvHXIy9YZSF1tfXQ2uSY8Ommadf2K3gVBPNtrnm1XdBbnUG7lkH4CSoLTQ
 W8pFI+KwpPM6nJYlQCxA5w55B5rwk8/D6xbWukXML8iuqrzz1f/FuWK2AqxlUg3zHuTEiodo8I0+o
 7ijgnYo1PFZPYDbvOZ6MD17/Afe4s/K5o1HULntntqJk7ltlP+674o5ZoCwLU+ckSfcrEHxHUudIl
 yrZ5jbDQ==;
Received: from [2001:4bb8:184:76e3:6bff:e1fc:8865:1ab0] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jpurX-0001Bc-Le; Mon, 29 Jun 2020 14:34:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Subject: [PATCH v2] nvme: fix a crash in nvme_mpath_add_disk
Date: Mon, 29 Jun 2020 16:34:22 +0200
Message-Id: <20200629143422.2695541-1-hch@lst.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Avinash M N <Avinash.M.N@wdc.com>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

For private namespaces ns->head_disk is NULL, so add a NULL check
before updating the BDI capabilities.

Fixes: b2ce4d90690b ("nvme-multipath: set bdi capabilities once")
Reported-by: Avinash M N <Avinash.M.N@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---

And now with the compile fix actually picked up in the git commit as well..

 drivers/nvme/host/multipath.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 18d084ed497ef3..66509472fe06ae 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -672,10 +672,11 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 	}
 
 	if (bdi_cap_stable_pages_required(ns->queue->backing_dev_info)) {
-		struct backing_dev_info *info =
-					ns->head->disk->queue->backing_dev_info;
+		struct gendisk *disk = ns->head->disk;
 
-		info->capabilities |= BDI_CAP_STABLE_WRITES;
+		if (disk)
+			disk->queue->backing_dev_info->capabilities |=
+					BDI_CAP_STABLE_WRITES;
 	}
 }
 
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
