Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC1E0C55173
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 03:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EFH8vOoiDFQZCYpaxErTrMRVSXs/prabJwi1NgylN0c=; b=2ZGqcCVYmfygfzCR142niuw04h
	R1mKA/ilZub/I+vdEne2CJHIOAXcaI1Wsxexj8elzAR3MJr61uZdqxfJIJYhBx85JOUcU/hpYP/nx
	9fMCivy7MR2TeCN8ONAKEaIfiNoZjdKMybvnflPz38lVwQKy07k6QUTAgXIT7lNsHnLdf9/uAAIHH
	M3yf45lRSRYBawZ4+K4XHg0fTYAQ3MTXl3TNXlUhsClLcvHBYEed714LLAzBA7E5uEzhhp8cGICMi
	L4PTQXp3tV4xrxinkcnP6r/76CZrdArtbhAXaNZipZ1/GicFLx9tAR+bIqjjEH4TTaY+mEaWqJC+m
	iAur19gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdnl-0000000Bfi7-1RuN;
	Fri, 31 Jul 2026 03:20:49 +0000
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpdnf-0000000Bfek-2WqV
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 03:20:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1785468041; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=EFH8vOoiDFQZCYpaxErTrMRVSXs/prabJwi1NgylN0c=;
	b=otOOW/iXR7JI66E+aokCDTKxPIcAmgiN+Y9aXcu30IOuP6u22hdJeG2XHs6TIeFQE9KNXiZEHLEWq7EdJaZB0CWoadL6Vz5cTGkpCOVWlueY3nOcnQFSgRfO9q1ehjHORXLUymWphheR/fnsI12yUDRiLGHNfYFf1Arw0q5aPUE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X86hYwn_1785468040;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X86hYwn_1785468040 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 31 Jul 2026 11:20:40 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	nilay@linux.ibm.com,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Kanchan Joshi <joshi.k@samsung.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v2 4/5] nvme: clamp FDP placement handle count to the buffer size
Date: Fri, 31 Jul 2026 11:20:30 +0800
Message-ID: <20260731032031.1090755-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260731032031.1090755-1-kanie@linux.alibaba.com>
References: <20260731032031.1090755-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_202044_122147_D479D5A7 
X-CRM114-Status: GOOD (  10.98  )
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Reviewed-by: Nilay Shroff <nilay@linux.ibm.com>
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


