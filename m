Return-Path: <SRS0=B93q=GO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B45AC433DB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 16:31:42 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F21C62076D
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Jan 2021 16:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F21C62076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7NpIjQ8djURO/gmudr6xw1AUgMlkZN/YsOFYqHO+wA8=; b=b2ziBs67Kpwlfz3V2PYImS4MsQ
	H00hXxgX+PgwFNWQhhLgH/7/7n7rmZFSESuwy0MzEy4pcCDL8nNvWH4MlGrWpJlglTrhUyYXgtbPx
	Qt+qB33YDWPZDGYhLWESJgZa2lr2XOrWhDVtZRrBBhBuKpORchLxE4pMlKRxDVp4vCFuq9qGBbc9F
	bhDWPWnF9/Q42SaVYAQ0CaJ7mLwgEGEtI+U2UgQO/q/T/GplwEaboH4Sa0Nx4FcJYPbOrcd5rH00m
	IDkWWWhBtdtkihhUbcZkfx2J98s3lcv3/q+YYdlGr/enNtGLNdWMdJLsNnCZAX8BeiMMAgpihhO+6
	fgwV7w1A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kz06R-0001QX-Fc; Mon, 11 Jan 2021 16:31:35 +0000
Received: from mga11.intel.com ([192.55.52.93])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kz06O-0001PG-79
 for linux-nvme@lists.infradead.org; Mon, 11 Jan 2021 16:31:33 +0000
IronPort-SDR: ZLZjeE7UKxdwRbB2BcVxZlNi/mNmKTO96aX3el4PU8Z2wQcKTZ3MEmr9toGf3YF78Y2Pxyv9TY
 W5Z7hWUyjOMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="174382850"
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; d="scan'208";a="174382850"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 08:31:28 -0800
IronPort-SDR: 9Z2rMiZkgJkj1vtv+/2GMqBlk+drEwYTomIskKYO+7nu2mb+OiooScWt1IUcOjvh6NUBgs5asH
 q30VooxCWk+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,338,1602572400"; d="scan'208";a="399853720"
Received: from linux-machine.lm.intel.com ([10.232.116.101])
 by fmsmga002.fm.intel.com with ESMTP; 11 Jan 2021 08:31:27 -0800
From: Revanth Rajashekar <revanth.rajashekar@intel.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH] nvme: Check the PRINFO bit and the Metadata size before
 deciding the host buffer length
Date: Mon, 11 Jan 2021 09:26:02 -0700
Message-Id: <20210111162602.29305-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210111_113132_444425_90E70A19 
X-CRM114-Status: GOOD (  14.20  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Revanth Rajashekar <revanth.rajashekar@intel.com>, hch@lst.de,
 Jonathan Derrick <jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

According to NVMe spec v1.4, section 8.3.1, the PRINFO bit and
the metadata size play a vital role in deteriming the host buffer
size.

If PRIFNO bit is set and MS==8, the host doesn't add the metadata
buffer, instead the controller adds it.

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 drivers/nvme/host/core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7a9642719..5efacd596 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1273,12 +1273,14 @@ static void __user *nvme_to_user_ptr(uintptr_t ptrval)
 	return (void __user *)ptrval;
 }

+#define NVME_PRINFO_CTRL_BIT (13)
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
 	struct nvme_command c;
 	unsigned length, meta_len;
 	void __user *metadata;
+	unsigned long control;

 	if (copy_from_user(&io, uio, sizeof(io)))
 		return -EFAULT;
@@ -1297,6 +1299,12 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	length = (io.nblocks + 1) << ns->lba_shift;
 	meta_len = (io.nblocks + 1) * ns->ms;
 	metadata = nvme_to_user_ptr(io.metadata);
+	control = cpu_to_le16(io.control);
+
+	if (test_bit(NVME_PRINFO_CTRL_BIT, &control) && ns->ms == 8) {
+		meta_len = 0;
+		metadata = NULL;
+	}

 	if (ns->ext) {
 		length += meta_len;
--
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
