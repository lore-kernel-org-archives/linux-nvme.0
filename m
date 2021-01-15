Return-Path: <SRS0=b72z=GS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C24C433DB
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:01:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54FEC23A5A
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Jan 2021 02:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54FEC23A5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=abmi11MJ3NLLNI6GBwsnunjVd1TT2U7fhRcKCbEHqKM=; b=UqA5K18FQsNZFj/dKz7o0U4jjP
	9HoDgFye8xIfdwxiao9MUDgCzKGDsSyhlq8WLUk24PNSCl1d+SRYKMA6DXLboGtPnyugSwnkTFbX/
	08qxUlOk8dJr374u/Qncgak8NACP7a3E+6e7ec4llhddvTptx/9Mof4PKLcJohCfCpM8BZ9yVGLyI
	fTvM6VlQ709eU1a2g6RMfqIeFGcDJmcyMs8G4Su+vRy+9Z+PRlBNhSm87vRt+WmJfdZBH8gUF2sHx
	yf9CjEpR8p2qgKOXmmSJxR+FEvsmSSnG88GLSKTynGNFuHK0LEEs70Ic/aFKqEESwgsWvThITjb+f
	ptgOE7Uw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l0EPs-0006kg-GT; Fri, 15 Jan 2021 02:00:44 +0000
Received: from mga14.intel.com ([192.55.52.115])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l0EPp-0006k2-V7
 for linux-nvme@lists.infradead.org; Fri, 15 Jan 2021 02:00:43 +0000
IronPort-SDR: ZmkfFbS/33V8pWCjm/3JFp+b9cs7ifMU+IlwIvcmj+zaMgFlSjMpXPieO1PWxAn9c948/fkbej
 o2ipxa/SUs1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9864"; a="177701817"
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="177701817"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2021 18:00:35 -0800
IronPort-SDR: WhBNKSenLTHVZAvC1ReoRmX2t2kUP8fJiIvprAsbct1GQas0xCrwaoJTaEnstZfYVqGn3DVKKL
 NjT7IwHMHLuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.79,347,1602572400"; d="scan'208";a="499778226"
Received: from linux-machine.lm.intel.com ([10.232.116.101])
 by orsmga004.jf.intel.com with ESMTP; 14 Jan 2021 18:00:34 -0800
From: Revanth Rajashekar <revanth.rajashekar@intel.com>
To: <linux-nvme@lists.infradead.org>
Subject: [PATCH v3] nvme: Check the PRINFO bit and the Metadata size before
 deciding the host buffer length
Date: Thu, 14 Jan 2021 18:55:07 -0700
Message-Id: <20210115015507.45615-1-revanth.rajashekar@intel.com>
X-Mailer: git-send-email 2.17.1
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210114_210042_165735_A329CCA9 
X-CRM114-Status: GOOD (  12.66  )
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
the metadata size play a vital role in deteriming the host buffer size.

If PRIFNO bit is set and MS==8, the host doesn't add the metadata buffer,
instead the controller adds it.

Changes from v2:
1. Use sizeof(struct t10_pi_tuple) to check against MS.
2. Use if-else statements to set the meta_len and metadata

Changes from v1:
1. Remove the definition 'NVME_PRINFO_CTRL_BIT'
2. Remove variable 'control'
3. Remove test_bit and check the bit with the CPU arch's native endianness

Signed-off-by: Revanth Rajashekar <revanth.rajashekar@intel.com>
---
 drivers/nvme/host/core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f320273fc672..ec9f8f686460 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1543,8 +1543,21 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	}

 	length = (io.nblocks + 1) << ns->lba_shift;
-	meta_len = (io.nblocks + 1) * ns->ms;
-	metadata = nvme_to_user_ptr(io.metadata);
+
+	if ((io.control & NVME_RW_PRINFO_PRACT) &&
+		ns->ms == sizeof(struct t10_pi_tuple)) {
+		/*
+		 * Protection information is stripped/inserted by the
+		 * controller.
+		 */
+		if (nvme_to_user_ptr(io.metadata))
+			return -EINVAL;
+		meta_len = 0;
+		metadata = NULL;
+	} else {
+		meta_len = (io.nblocks + 1) * ns->ms;
+		metadata = nvme_to_user_ptr(io.metadata);
+	}

 	if (ns->features & NVME_NS_EXT_LBAS) {
 		length += meta_len;
--
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
