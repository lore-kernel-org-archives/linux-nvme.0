Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28346C55165
	for <linux-nvme@archiver.kernel.org>; Thu, 30 Jul 2026 04:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IzAfbzgDHri9WWCcnLwMrUcO24mRR0M9EAlaNDeI6Ro=; b=ep56cemnnz+JPmFkkbkgYIdD8l
	RGhvNFURC2zvnm/UlZHRh9iUUf4FzZo08u/Z2juvyu4a0Qt7jMLcDXt4F0tl55BSHfSn//OunJdQT
	T4u8TtqYr9jV5CNPlPvUjx4wSOupLej99Duw3I+btfI8xAXTCWItWYPliNN2wJt6BD3td0gxQVzpJ
	mwc8KOGhXLFtK4fi/53eVJR7bQyjOYQPJB3RGaB0vVGlcbCr6CC0iM3YsgmgLB+IC2eatv9YmtPEJ
	GEjB2/8UZD2dEsLDz0Hs9uGqkPBHAGS6aJxQLc8q7x4Sw6lp8n0r1ks5UTcGhG4Yv2bRBQT8JfEwN
	hMuJxabQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpIQU-00000009Tp6-1EoQ;
	Thu, 30 Jul 2026 04:31:22 +0000
Received: from out30-119.freemail.mail.aliyun.com ([115.124.30.119])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpIQQ-00000009TlE-2xO7
	for linux-nvme@lists.infradead.org;
	Thu, 30 Jul 2026 04:31:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785385875; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=IzAfbzgDHri9WWCcnLwMrUcO24mRR0M9EAlaNDeI6Ro=;
	b=TCgMtcdjXoYG2W/Y8zg+EN3VaKLSDlfDET8z+MmlC36Wo90+yAFRQPcHLPt57u477JEZj96hpOybv0G6UvJClWRo6eYlbegJMOaxVL03gPhNuU/Tk/DhKefxWizUekIhm0Hq73A01X9/p59+7Xjqu2CvlBqBDr9xlqGfnLESdLE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R581e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0X83rcQE_1785385874;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X83rcQE_1785385874 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 30 Jul 2026 12:31:14 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme: clamp FDP placement handle count to the buffer size
Date: Thu, 30 Jul 2026 12:31:05 +0800
Message-ID: <20260730043105.3071328-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260730043105.3071328-1-kanie@linux.alibaba.com>
References: <20260730043105.3071328-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260729_213118_938726_1C234C23 
X-CRM114-Status: GOOD (  10.27  )
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

nvme_query_fdp_info() allocates the RUH status buffer for at most
S8_MAX - 1 descriptors and caps the io-mgmt-receive transfer to that
size. head->nr_plids, however, is taken verbatim from the device-supplied
nruhsd field, which can be up to 65535. If a non-conformant or malicious
device reports more descriptors than the buffer holds, the copy loop
reads past the end of the ruhs buffer (heap out-of-bounds read).

Clamp nr_plids to the number of descriptors the buffer can actually hold.

Fixes: 30b5f20bb2dd ("nvme: register fdp parameters with the block layer")
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..b1f444cd3daf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2358,6 +2358,7 @@ static int nvme_query_fdp_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	head->nr_plids = le16_to_cpu(ruhs->nruhsd);
+	head->nr_plids = min_t(u16, head->nr_plids, S8_MAX - 1);
 	if (!head->nr_plids)
 		goto free;
 
-- 
2.43.7


