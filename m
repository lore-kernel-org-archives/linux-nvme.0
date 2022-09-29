Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D081EC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Sep 2022 22:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d58NEBn/3mVENL2otu1bIeVM+r1HvA5Ir++KV1R84/s=; b=Ic329VbF6G4ks7WbKZpvp/GZMD
	u4mN6/ZPStL1+7Yp8TrufkeAbHUy2mwUk+f6Vh/wz3qRL9UpSkTTmy73YWfPoE9e1Y2kwixvxDFIU
	k8+Vl4UQXbQCk44IkOdGUOqLP0huwzrQHtJ2HVHN2GMafJG6zdhLKVLU1IVKtgU4gpz6FIr1OmsKF
	0AzZ7lf/k7rsHz8ZvCHqI6sotVMtpU5nLJ/gDoJ8fl5hWprRF/z5TSlx3hHQLls2z5WOsulfSgd9/
	yAovTl2UYswQ7FytYhtHA9xk/5mzjvK3zq+/ruH9QWQsGKCQWJUy750ut6+IDcG9766VK1ioJFo0U
	0hRHSDxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2CT-005lIF-LX; Thu, 29 Sep 2022 22:40:13 +0000
Received: from usmailhost21.kioxia.com ([12.0.68.226] helo=SJSMAIL01.us.kioxia.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oe2CR-005lGv-3B
	for linux-nvme@lists.infradead.org; Thu, 29 Sep 2022 22:40:12 +0000
Received: from localhost.localdomain (10.93.83.20) by SJSMAIL01.us.kioxia.com
 (10.90.133.90) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 29 Sep
 2022 15:40:10 -0700
From: <clay.mayers@kioxia.com>
To: <linux-nvme@lists.infradead.org>
CC: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph
 Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH V2 0/2] nvme: Support user mode processing of ZNS Zone Changed AEN
Date: Thu, 29 Sep 2022 15:39:53 -0700
Message-ID: <20220929223955.3275715-1-clay.mayers@kioxia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.93.83.20]
X-ClientProxiedBy: SJSMAIL01.us.kioxia.com (10.90.133.90) To
 SJSMAIL01.us.kioxia.com (10.90.133.90)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220929_154011_154449_A8A3E676 
X-CRM114-Status: GOOD (  11.15  )
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

From: Clay Mayers <clay.mayers@kioxia.com>

This adds support for the ZNS Zone-Descriptor-Changes AEN, which is of
type notify and uses CQE.DW1 to convey the NSID of the log page to read.

Patch 1 adds non-zero NVME_AEN_DATA with the value of CQE.DW1 to all
NVME_AEN uevents.

Patch 2 generates a uevent for all unhandled AEN notify results instead
of issuing a dev warning.

This support is planned to be used by both zone based applications and
another unreleased device with an alternate command set.

Changes since v1
- Break up into two patches
- Only inlucde AEN_DATA if CQE.DW1 is non-zero

Clay Mayers (2):
  nvme: Include AEN CQE.DW1 in NVME_AEN uevents
  nvme: All AENs of type notify generate an NVME_AEN uevent

 drivers/nvme/host/core.c | 21 +++++++++++++--------
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 14 insertions(+), 8 deletions(-)

-- 
2.27.0


