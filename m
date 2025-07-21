Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00846C83F26
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Jul 2025 17:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jYmCvDsWSgjIdzZa1VBL7t1D5Vt1lUnsckLJAjLWeRg=; b=ZNjqMMJsXnSYz2JiuMcTsJjex9
	yshKES8zJ2MYBdY+tH6tpjZiZIfjoYw5DaFkhoFUmaR43FJ64QsG3G4Lq8AIx2Ajeeya6ueldkbqz
	EFprC0zQEodoH6VzHKwfqIlhRaNuxPx2brN3YLDcAUBKdhXYn4uesoUAnkHxgMAWEwEbhpivJt7LZ
	PyJpFr8SXY4aZRzXtUUGyRlIm7SCb9xFvztH2zjjQ61BksqH7fhQJYfIurrJWzrcqN6myySfh79eH
	k8dnUGLZgA7YybjLY0afobiBRGDOrcZ1BrlMcwoTf6tDur1LjbSDcBLIpr5T6rhCheOM4Jw7DYjSN
	1uYK4iPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uduiL-00000000MzP-3r0c;
	Mon, 21 Jul 2025 17:54:13 +0000
Received: from esa5.hgst.iphmx.com ([216.71.153.144])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uduRk-00000000Kjg-3tdH
	for linux-nvme@lists.infradead.org;
	Mon, 21 Jul 2025 17:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1753119424; x=1784655424;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ojnyY42uXK0qbv77GdAfr80+l1AwHdnMVYTMiInndRM=;
  b=aqypEs+gZ+aQC8guNRPbMSseAfSVoR61tmiX9gJIQd/7YHxEkoCWRmBA
   yTb0SAFJfWrN2kfX8ax0raVts0da6ayi9kocGsh5j5tYhv0Q3C2RAAIPG
   FLFA0Ueyw55AEGkhjm6gx04Mrz/Q0jXmtT4q0DmlbALO7xjuwbFGQ2Dy1
   s6outiV434O7uPXVZiZSUFQclcxlEfJ9z/zAS4Efsw3GCjGOtXqPwK+D9
   j9zknUUfSAya4CldSdPae0j75iPv+atoSgck+9s0YJEKiQaqwgYopttgL
   RRjjT/zYl8Flk+WV2wwPyHh0Hyl5F2tGVxEu9A5QGnWgQ8oD0eoi7lD28
   A==;
X-CSE-ConnectionGUID: bO/pFuWoQHybiPEN91MSkQ==
X-CSE-MsgGUID: AXkI7ulsS1+wg6C6+8fvjw==
X-IronPort-AV: E=Sophos;i="6.16,329,1744041600"; 
   d="scan'208";a="93974990"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jul 2025 01:37:01 +0800
IronPort-SDR: 687e6c13_PMuvpU2W22TuW24+5UK0XEm5L9TH+8Pjq00GcJF2b/wzfdE
 448qWkZzywlS8KKR+tH5u4e+hApltAN4l/b+Q4Q==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Jul 2025 09:34:28 -0700
WDCIronportException: Internal
Received: from ros-3.wdc.com ([10.23.145.79])
  by uls-op-cesaip01.wdc.com with ESMTP; 21 Jul 2025 10:37:02 -0700
From: Kamaljit Singh <kamaljit.singh1@wdc.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: cassel@kernel.org,
	dlemoal@kernel.org,
	kamaljit.singh1@wdc.com
Subject: [PATCH v4 1/2] nvme: add capability to connect to an administrative controller
Date: Mon, 21 Jul 2025 10:36:59 -0700
Message-ID: <20250721173700.4153098-2-kamaljit.singh1@wdc.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
References: <20250721173700.4153098-1-kamaljit.singh1@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_103704_975472_CB2F0016 
X-CRM114-Status: GOOD (  14.68  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add capability to connect to an administrative controller by
preventing ioq creation for admin-controllers.

* Add helper nvme_admin_ctrl() to check if a controller's CNTRLTYPE
  indicates that it is an administrative controller.
* Override ctrl->queue_count to 1, so only one admin queue and no IO
  queues are allocated for an administrative controller.
* This override is done in nvme_init_ctrl_finish() after ctrl->cntrltype
  has been initialized in nvme_init_identify() so nvme_admin_ctrl() will
  work correctly.
* Doing this override in generic code (nvme_init_ctrl_finish) makes it
  transport agnostic and will work properly for nvme/tcp as well as for
  nvme/rdma.

Suggested-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kamaljit Singh <kamaljit.singh1@wdc.com>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e533d791955d..a6388ed3ddca 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3149,6 +3149,11 @@ static inline bool nvme_discovery_ctrl(struct nvme_ctrl *ctrl)
 	return ctrl->opts && ctrl->opts->discovery_nqn;
 }
 
+static inline bool nvme_admin_ctrl(struct nvme_ctrl *ctrl)
+{
+	return ctrl->cntrltype == NVME_CTRL_ADMIN;
+}
+
 static bool nvme_validate_cntlid(struct nvme_subsystem *subsys,
 		struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
@@ -3670,6 +3675,17 @@ int nvme_init_ctrl_finish(struct nvme_ctrl *ctrl, bool was_suspended)
 	if (ret)
 		return ret;
 
+	if (nvme_admin_ctrl(ctrl)) {
+		/*
+		 * An admin controller has one admin queue, but no I/O queues.
+		 * Override queue_count so it only creates an admin queue.
+		 */
+		dev_dbg(ctrl->device,
+			"Subsystem %s is an administrative controller",
+			ctrl->subsys->subnqn);
+		ctrl->queue_count = 1;
+	}
+
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
-- 
2.43.0


