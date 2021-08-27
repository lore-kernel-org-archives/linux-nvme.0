Return-Path: <SRS0=9COT=NS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845A3C432BE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 06:18:09 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BADF260F92
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Aug 2021 06:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BADF260F92
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=/qBDHGEl3Hzt81Dbi7eToXrdSSvqezk6WIH1cUsdqik=; b=WTfQtEqI4SSHER
	nBJHnQaMyKJ/i3074Zh1U/ciGR80yhi+htI5MeMh608ulJMeNr1vk+luAbdaRKKUoR5q0tSPGGfef
	ZvTGhK/eFjBbyd4GyHFpJzSoxAKIqDHK+YPk1xFSexaWXM+FUeG61gwm1wMNx88hIoaXrwzaqbTCO
	ZC/A7CIqMfG1q3wrBoHV4AM3P3myekEvqIPEj29uGzJFyNnfOogRa1UGXwLjdrigUX9Zk3UM7pJY7
	iZ3p9zW+q/M5PEpILNsIxnBgYY9Vs5oYqQrsQsd1MghGdDk3FggpRowxd1n0oMtCkyj8OWFMhOoTE
	24DNCvbdy+WRzwHumQhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mJVBT-00BfXM-8p; Fri, 27 Aug 2021 06:17:47 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJVBP-00BfWk-AA
 for linux-nvme@lists.infradead.org; Fri, 27 Aug 2021 06:17:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 8B7A66736F; Fri, 27 Aug 2021 08:17:37 +0200 (CEST)
Date: Fri, 27 Aug 2021 08:17:37 +0200
From: "hch@lst.de" <hch@lst.de>
To: Adam Manzanares <a.manzanares@samsung.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "chaitanya.kulkarni@wdc.com" <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] nvmet: use passthru cntrl in nvmet_init_cap
Message-ID: <20210827061737.GA22583@lst.de>
References: <20210826211522.308649-1-a.manzanares@samsung.com>
 <CGME20210826211546uscas1p1e181ca820e506c7c195b933168301dd0@uscas1p1.samsung.com>
 <20210826211522.308649-3-a.manzanares@samsung.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210826211522.308649-3-a.manzanares@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210826_231743_705511_E33D93F8 
X-CRM114-Status: GOOD (  19.71  )
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

Technically this looks good, but the core target code should not have
to poke into the host side data structures.  Does this version still look
good to you?

---
From c5777caf1562df35150a71e5c91c5b272956beee Mon Sep 17 00:00:00 2001
From: Adam Manzanares <a.manzanares@samsung.com>
Date: Thu, 26 Aug 2021 21:15:45 +0000
Subject: nvmet: looks at the passthrough controller when initializing CAP

For a passthru controller make cap initialization dependent on the cap of
the passthru controller, given that multiple Command Set support needs
to be supported by the underlying controller.  For that move the
initialization of CAP later so that it can use the fully initialized
nvmet_ctrl structure.

Fixes: ab5d0b38c047 (nvmet: add Command Set Identifier support)
Signed-off-by: Adam Manzanares <a.manzanares@samsung.com>
Reviewed-by: Keith Busch <kbusch@kernel.org>
[hch: refactored the code a bit to keep it more contained in passthru.c]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/core.c     |  6 ++++--
 drivers/nvme/target/nvmet.h    |  2 ++
 drivers/nvme/target/passthru.c | 10 ++++++++++
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 66d05eecc2a9..11c44706dc2d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1206,6 +1206,9 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 	ctrl->cap |= (15ULL << 24);
 	/* maximum queue entries supported: */
 	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
+
+	if (nvmet_passthru_ctrl(ctrl->subsys))
+		nvmet_passthrough_override_cap(ctrl);
 }
 
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
@@ -1363,8 +1366,6 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 		goto out_put_subsystem;
 	mutex_init(&ctrl->lock);
 
-	nvmet_init_cap(ctrl);
-
 	ctrl->port = req->port;
 
 	INIT_WORK(&ctrl->async_event_work, nvmet_async_event_work);
@@ -1378,6 +1379,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
+	nvmet_init_cap(ctrl);
 	WRITE_ONCE(ctrl->aen_enabled, NVMET_AEN_CFG_OPTIONAL);
 
 	ctrl->changed_ns_list = kmalloc_array(NVME_MAX_CHANGED_NAMESPACES,
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 06dd3d537f07..183119607968 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -613,6 +613,8 @@ nvmet_req_passthru_ctrl(struct nvmet_req *req)
 	return nvmet_passthru_ctrl(nvmet_req_subsys(req));
 }
 
+void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl);
+
 u16 errno_to_nvme_status(struct nvmet_req *req, int errno);
 u16 nvmet_report_invalid_opcode(struct nvmet_req *req);
 
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 225cd1ffbe45..8784c487e462 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -20,6 +20,16 @@ MODULE_IMPORT_NS(NVME_TARGET_PASSTHRU);
  */
 static DEFINE_XARRAY(passthru_subsystems);
 
+void nvmet_passthrough_override_cap(struct nvmet_ctrl *ctrl)
+{
+	/*
+	 * Multiple command set support can only be declared if the underlying
+	 * controller actually supports it.
+	 */
+	if (!nvme_multi_css(ctrl->subsys->passthru_ctrl))
+		ctrl->cap &= ~(1ULL << 43);
+}
+
 static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
