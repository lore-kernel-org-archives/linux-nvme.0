Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3F23C25B50
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Jan 2023 00:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=npwpQy/HVI20kutjln5Lf2b88ckv+Ow8Vy3KUkf6Gug=; b=WszE5c8gsJ2/UQIu1qPU3JXBYO
	Lkbm93i9Cd+ByAvQMHgAXDfUKkneO/Ni+FRU4o39KkvTFcmf2cxiU3LrBibvAdj1WB973DhEt1+3p
	u2umttZ3yAQL5WdTBhQn5HV5EDuwv4sHjGLneonfsxv5G7YDLau88pIMs49PrXeZ5iMewCnnCbFf6
	GkwgVYAJKgoZT4CzLjJEXDJYZz5xnYNKUTI8Qtyx35SCScxy3IAErinoL9UY+CB1j5JvaM3Ihxutv
	2mJtdJO6k/G5LtinA5eef2L7DaB1Nb3WJQxLnt9lQ653Te87A7VQaFIoG5cLEid9+aBGtSZb5vSSd
	AXDYBozg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK7Rl-001xRQ-Rj; Tue, 24 Jan 2023 00:45:57 +0000
Received: from mga02.intel.com ([134.134.136.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pK7Rj-001xQE-5p
	for linux-nvme@lists.infradead.org; Tue, 24 Jan 2023 00:45:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674521155; x=1706057155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/wzLkEnAqdDrA9q6+UgWLb7nmAJz6Hrh36W9SoY5p20=;
  b=bNvL4tGGdTPs6lBCmIOcZWkpFysqNzQNuuIsUtyiC7i0R661OivCU5Gu
   Hct3FnLXcBBBD4Z9ngMA/nQIHHKq0s53pI2iademKI12oVRuowYX3o1fW
   5WE0ATwtz9LB2NEYdZn8TRThFxn+ODPVz+pjbydBTTzY7E5xnrd6YAd0D
   aNkHahb8Vg6dGnyq8gDUETBqOuujlQy11e2gMG70ba8LFhzLPByKrcyM6
   neAAnb5epCfOnUOWgn2K/lgfM7dpu79B1mmHzL+MGVsefKwNxs9lL4ZI7
   iu6PhitctbYLtDLM79p19Lx26CEir3tCaUpiEThPQb4I2WdXuC+vX4HlM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="314101092"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="314101092"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 16:45:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="611855604"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="611855604"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.55])
  by orsmga003.jf.intel.com with SMTP; 23 Jan 2023 16:45:43 -0800
Received: by stinkbox (sSMTP sendmail emulation); Tue, 24 Jan 2023 02:45:42 +0200
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Gerd Bayer <gbayer@linux.ibm.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Jens Axboe <axboe@fb.com>,
	=?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>
Subject: [PATCH] nvme-pci: Switch back to sync probe to fix rootfs mount regression
Date: Tue, 24 Jan 2023 02:45:42 +0200
Message-Id: <20230124004542.29659-1-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230123_164555_312388_548669BC 
X-CRM114-Status: GOOD (  16.86  )
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

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

Async probe caused a regression where we fail to find the
rootfs in time, leading an unbootable machine.

rootdelay=1 can be used as a workaround but that needlessly
slows down the boot by a whole extra second.

To get the best of both worlds perhaps there should be
some kind of async probe flush/sync just before attempting
to mount the rootfs?

In the meantime just switch back to a sync probe to fix
the regression.

Cc: linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Jens Axboe <axboe@fb.com>
Fixes: eac3ef262941 ("nvme-pci: split the initial probe from the rest path")
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/nvme/host/pci.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1ff8843bc4b3..d0f5e93d977e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3514,7 +3514,6 @@ static struct pci_driver nvme_driver = {
 	.remove		= nvme_remove,
 	.shutdown	= nvme_shutdown,
 	.driver		= {
-		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 #ifdef CONFIG_PM_SLEEP
 		.pm		= &nvme_dev_pm_ops,
 #endif
-- 
2.39.1


