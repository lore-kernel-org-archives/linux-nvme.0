Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABAF4C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Oct 2022 00:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g68N+8WEOflW10ZQeX8CKTsTZZiLJOjQ1Rr2ylmkeEM=; b=W6TNT8ahJWeKjwkC2P1NdJMSCe
	/FWH8y2bV5+ZvsPQtWTwvywZyU6p5pwNJk4fjVOsZcHB0pSQiNRzcRFPPIRRO/hQ8u5n2VlLzpqfn
	zN+CPmRbqC05+n7CmKFME4K2bJoc5x+4yqMQ4mFV/AdrqYMb7+KrAE8LnXN3u/AftASzPsbY6Uh/M
	K/xUK9BbRRPH53RDcFpRBM9wZ8EHqXl9P2BW4JKFTIAwv93GIQWhIzBUnKVqztyZWtZiegMWW9yG7
	37fPFR0S9CplXZsKGh20I5fslsDUFGzwR/38nfFPvOWNfYUIkB77UUDezBO/h0aToffQ94DHReKZa
	ipid0iZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oimIj-009yRL-Dw; Thu, 13 Oct 2022 00:42:17 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oim37-009qsq-RM
	for linux-nvme@lists.infradead.org; Thu, 13 Oct 2022 00:26:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6D41FB81CD5;
	Thu, 13 Oct 2022 00:26:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4594C433D6;
	Thu, 13 Oct 2022 00:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1665620767;
	bh=HWJFCQPIjhn238FA1JB7Bz47RZsjflnrkViylqrq2ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Dkj01VR1ePAQRDC08Q2EAzNVW09WxQMik0N0wemgZHBKEiEgVdBhYeunmnpVr7IdT
	 cMIKUwyW4BUsjuqluKiu/ur6j3irG8VfN9TX3D1WUIho5OnolNkUAZC5TZjJxbnUhA
	 uh3Y7rkykD63ESO9QBHyWvirSAqvApj1gCIQ/xU5Z6Hm5tshuSqbv6GsLOBora5Oe+
	 UZKY/eEW7w3pu1DunqEgKiRqON7Z2mqm9/DdoQYmwYwH/HIVC5tE5c3t2fRAVhacuD
	 l9Tf9KobNGtkl0j+t1zuDOP3UvBN91f2HRe9WHXNgVyCe0zUG0CcxqdqRnZnJLZbVv
	 EM13UTJ9GdX6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jeff Lien <jeff.lien@wdc.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Chao Leng <lengchao@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 22/27] nvme: copy firmware_rev on each init
Date: Wed, 12 Oct 2022 20:24:54 -0400
Message-Id: <20221013002501.1895204-22-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221013002501.1895204-1-sashal@kernel.org>
References: <20221013002501.1895204-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221012_172610_115292_941B2632 
X-CRM114-Status: GOOD (  12.49  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit a8eb6c1ba48bddea82e8d74cbe6e119f006be97d ]

The firmware revision can change on after a reset so copy the most
recent info each time instead of just the first time, otherwise the
sysfs firmware_rev entry may contain stale data.

Reported-by: Jeff Lien <jeff.lien@wdc.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Reviewed-by: Chao Leng <lengchao@huawei.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1717f34b2f3..6627fb531f33 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2671,7 +2671,6 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	nvme_init_subnqn(subsys, ctrl, id);
 	memcpy(subsys->serial, id->sn, sizeof(subsys->serial));
 	memcpy(subsys->model, id->mn, sizeof(subsys->model));
-	memcpy(subsys->firmware_rev, id->fr, sizeof(subsys->firmware_rev));
 	subsys->vendor_id = le16_to_cpu(id->vid);
 	subsys->cmic = id->cmic;
 	subsys->awupf = le16_to_cpu(id->awupf);
@@ -2824,6 +2823,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 				ctrl->quirks |= core_quirks[i].quirks;
 		}
 	}
+	memcpy(ctrl->subsys->firmware_rev, id->fr,
+	       sizeof(ctrl->subsys->firmware_rev));
 
 	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
 		dev_warn(ctrl->device, "forcibly allowing all power states due to nvme_core.force_apst -- use at your own risk\n");
-- 
2.35.1


