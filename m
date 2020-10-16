Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E50CC433E7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 22:19:19 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AD8E221FD
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 22:19:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SN2EaY/O";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="W7LEcXEZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AD8E221FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=deltatee.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-Id:Date:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rAv8B7evsCkhB38oTuDOvcESWINNS2J6ob3iju97nQ8=; b=SN2EaY/ONz9/BPOwL0gw74fLlZ
	hSoCX5zaTifw8CcS+GSA/LChc2jcqgxgZaSEtrVxEis5hRSmdhjtcwCj+jKVUZmn/d3LS83GNyRC8
	2BXCyqnmtYoBozVM1SY1xx9IquR5zQLaS9roKjiDPv5Eff/kfiO1pIbPtQ2Sg1oZCeJpfzfFqCUW7
	Wot9qIeWwPeAKQ5WwlXkZGeywX7EmQ6y/n2Vn2tJ1GLi/6ngYjSxnChh9NUEc9/A/1v65OHMwH8GO
	OzvgSzUjWTxXNJ7o1DyWFqgSQxTx8wo3FhGFrUCNFj/TTiKBUN1QoZ19V6tzesga7qiXapKOx8Spl
	3s0xcLxg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTY49-0004Ez-Iq; Fri, 16 Oct 2020 22:19:13 +0000
Received: from ale.deltatee.com ([204.191.154.188])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTY46-0004EE-E5
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 22:19:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=deltatee.com; s=20200525; h=Subject:Content-Transfer-Encoding:MIME-Version:
 Message-Id:Date:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AJv32GnywgQjRDQTfyPvhjUlp/gp51Zxz7bbL/TuwAk=; b=W7LEcXEZDK54gd7Z/MmQK99ZuV
 aeYY0rLkrOdkeZ7b60Lks05Zt9HouoEXiDYAoyDCZWrsl8+jfYsZVRXae8wp8FD7VROsDPpYNVuek
 ox0Dz5/B8MlSQ7uaOIViceuby2k8eGloQPcsHs1HaY6Ii1WCFud4MTEgQxvGnxwcRpsEKAnn7aaPg
 U6cuPVC8pBAylxfb+JoXtqUpeizH38T8sbehsVQuQng1QYNRUV6vRwAfi5wGtBvqHDW5zwdc6QcPM
 QtjnkxFEeYnOlUkgqMnGB0T0ST6E7927qdgITKQhP55RsT20Eft6QoVvJr4afFM91jd87890j8PwT
 pJhHWArw==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
 by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <gunthorp@deltatee.com>)
 id 1kTY43-0005Mk-4Z; Fri, 16 Oct 2020 16:19:08 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
 (envelope-from <gunthorp@deltatee.com>)
 id 1kTY42-0001EL-D6; Fri, 16 Oct 2020 16:19:06 -0600
From: Logan Gunthorpe <logang@deltatee.com>
To: linux-nvme@lists.infradead.org
Date: Fri, 16 Oct 2020 16:19:04 -0600
Message-Id: <20201016221905.4686-1-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, logang@deltatee.com,
 hch@lst.de, sagi@grimberg.me, chaitanya.kulkarni@wdc.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
Subject: [PATCH v2 1/2] nvmet-passthru: Limit mdts by BIO_MAX_PAGES
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_181910_499274_BC47A488 
X-CRM114-Status: GOOD (  14.10  )
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
Cc: Logan Gunthorpe <logang@deltatee.com>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

nvmet_passthru_map_sg() only supports mapping a single BIO, not a chain
so the effective maximum transfer should also be limitted by BIO_MAX_PAGES
(presently this works out to 1MB).

For PCI passthru devices the max_sectors would typically be more limitting
than BIO_MAX_PAGES, but this may not be true for all passthru devices.

Fixes: c1fef73f793b ("nvmet: add passthru code to process commands")
Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/passthru.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index dacfa7435d0b..1ab88df3310f 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -26,7 +26,7 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 	struct nvme_ctrl *pctrl = ctrl->subsys->passthru_ctrl;
 	u16 status = NVME_SC_SUCCESS;
 	struct nvme_id_ctrl *id;
-	u32 max_hw_sectors;
+	int max_hw_sectors;
 	int page_shift;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
@@ -48,6 +48,13 @@ static u16 nvmet_passthru_override_id_ctrl(struct nvmet_req *req)
 	max_hw_sectors = min_not_zero(pctrl->max_segments << (PAGE_SHIFT - 9),
 				      pctrl->max_hw_sectors);
 
+	/*
+	 * nvmet_passthru_map_sg is limitted to using a single bio so limit
+	 * the mdts based on BIO_MAX_PAGES as well
+	 */
+	max_hw_sectors = min_not_zero(BIO_MAX_PAGES << (PAGE_SHIFT - 9),
+				      max_hw_sectors);
+
 	page_shift = NVME_CAP_MPSMIN(ctrl->cap) + 12;
 
 	id->mdts = ilog2(max_hw_sectors) + 9 - page_shift;

base-commit: bbf5c979011a099af5dc76498918ed7df445635b
-- 
2.20.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
