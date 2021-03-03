Return-Path: <SRS0=PLgZ=IB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69581C433E0
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 15:02:40 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3C7E60240
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Mar 2021 15:02:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3C7E60240
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=R9DtDK5Mh/6e8ouWeK6b0BGcvqOGgI8B6aK9eaj03mI=; b=WUoYZnUeMbgUGZ66/LMs1xvjK
	XiAhECp0fxn0n/1n9+sVCVzAh8tsdFPtUiIVQCq5SljjecryD+z2BCgNh+7KqczkF/mAd9JJK7S1K
	lpcS3blYyIqi1AZ/Fj1zFjw276NBxHF788qb9hWmcaV6UJnh0C7zeMxNin8q7kyShHsVFhiclZaLU
	yc/0BNVNzQeMQStvpUh2gjY4zniArQM62epTMfa0bg+oiH+HiTHjD+++rCJ1bAfH3Vy3WbYEgZnCO
	PypEEH/Qw/ZoYoMutB2Eh0UatZinbOQsQy7W18zGV1WOxqg4k26Wazn5iilisOVGsWpPSxfrXbVXx
	vcivhkILQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHT18-005HD4-EN; Wed, 03 Mar 2021 15:02:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHSBh-0054St-6U
 for linux-nvme@desiato.infradead.org; Wed, 03 Mar 2021 14:09:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=XotSCO7ha7at2xsaOlSaJDESrmdtEFNZrKyCaxNjFH8=; b=KfyjtIft50ayw135chXlkTKKde
 gQVJr6HODLADVxWLjj6kOpS95WraTnMZJuHhbvtXeJgWJWjxI0Ti2U2nF6tTCWtX0u7k+lLbfbXHY
 tHn+rvR9AIGfoLeRxi6KeRY0qjFLoxmyHWuv5a8k5vPOP4E9BCOmvmf9W12eIK+pyzmdIjtnHsjw2
 O+yZyQCA++/jXzPVl9NtjCpe/y1h+bdVpRmvvzP5zwoB17vhPCAxgR5ZhuIfpCRBVgWochJeM9UuL
 kNTlPh4pjRido0t3ELJ4sZRyKvejRoP7MW5uWmy+9d9gah/qFRqqBluH2fB/Yz1aGlJHDsnvrUvT/
 Qm8+hs0Q==;
Received: from [2001:4bb8:180:9884:624:26dd:6387:40e9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lHR0V-002cTl-TG; Wed, 03 Mar 2021 12:53:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme: allocate the keep alive request using
 BLK_MQ_REQ_NOWAIT
Date: Wed,  3 Mar 2021 13:53:04 +0100
Message-Id: <20210303125304.1200789-4-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210303125304.1200789-1-hch@lst.de>
References: <20210303125304.1200789-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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

To avoid an error recovery deadlock where the keep alive work is waiting
for a request and thus can't be flushed to make progress for tearing down
the controller.  Also print the error code returned from
blk_mq_alloc_request to help debugging any future issues in this code.

Based on an earlier patch from Hannes Reinecke <hare@suse.de>.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bdeb3feae61899..8a4a9fe96cdf83 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1241,10 +1241,10 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	}
 
 	rq = nvme_alloc_request(ctrl->admin_q, &ctrl->ka_cmd,
-				BLK_MQ_REQ_RESERVED);
+				BLK_MQ_REQ_RESERVED | BLK_MQ_REQ_NOWAIT);
 	if (IS_ERR(rq)) {
 		/* allocation failure, reset the controller */
-		dev_err(ctrl->device, "keep-alive failed\n");
+		dev_err(ctrl->device, "keep-alive failed: %ld\n", PTR_ERR(rq));
 		nvme_reset_ctrl(ctrl);
 		return;
 	}
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
