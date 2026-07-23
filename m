Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E0FC531D0
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=; b=AdYeocRWgTwtUkCU31cbqB0YpP
	JP4/ShD8G0T6JV+HAhKeekWkMnR1riFhkDC9bszk2pt6vZVstITDiXRQLJaQtk8vZWG5QW+GqjfY8
	MvfGl1hskuNlWt2d/BAccu+5yjiCCX7zOLKnr7iEYOXcGMHhMiND0YdVYP8WYQwoSM0QzWHVD60ZC
	/HW+qlGuddSo1frLG8qXHUpECSNYnH2ZmuYm/TyldxFGvLm51zIVgXbo+VJjsLCMtXaSqZd0O2rqU
	mbOV6j7YQhWJa1DZa7E8duxkU8ldPdJ0Fz3tDvh6DZFLAR/v9wLdK+ptKvE/P8nuo3c9Tvbv3hEA4
	f/hLeg2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0Fv-0000000F3XS-2jpq;
	Thu, 23 Jul 2026 20:42:59 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0Ft-0000000F3WP-1Qke
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:42:58 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-47f84023916so1008445f8f.3
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839375; x=1785444175; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=;
        b=hHOSO1ZFaC48FWvsFbuBAgp3U+F1aHspdiajEOMQHZQEwHuvq0SA527JpNjFtwG3I1
         RGzPnfW1UdT2ZWlQbPlEtmHjSec6V6jcuZT+N4hz+qx4V+70ZJmoHbwS1fhBiNJ1vhdM
         9HOcDBCZ0dXhjVPcsB83X9YUYGiQW00UrsWQfBL/IpGiLwQWpP/Jdc2NSPbyx/Ba8NHS
         Jro4MpM975Hbs6jHVxCII8lG1g2Anlrj4fkjTcK9pQwX2xYpo7i3EmsdeUzZzxrTMoa7
         XfamRuvk8f79nfqXhoPdn83mq3TOfbz5LJhPTVXA83DGv88ndewHoFREj7crERliLRdX
         XFHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839375; x=1785444175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=;
        b=Eyblo2i8GdzWTtepbS068tsQcmbTe8L2B6I3f/dWab+HZIUVEydqoQP1s7cxI+Lpkj
         q3cB/SdjbvbxcI7j1oh7mpC5tNYjUb969gA7/r2RP4kRH+XK1131SHcp61t2SWcNg2F8
         lb6EgQZi45zK2Ft71tVHKiSr6bWhoykC3pEGxlnBZUm4hUEmzHhUZ9lPgPpYCcXCDztD
         dOyyslsxoYGOwhl8NYkNxQEuhLfobDqSsF74UeLL9ECqCl1LN8uT/y8D67xEy3c/1sPm
         ynuXrtXHO3eY8zA8p9stIqrEXOZFQK3k6eiyLdY2WfjrvgLTWxNBjB25m/PnuY6O3W2D
         ZUrQ==
X-Forwarded-Encrypted: i=1; AHgh+RopftLAc0FlYNKP5bIbNtcmL1vA+QrtRnHKnyVeySi7VH39mTU0thIDk1FMhqz90BBXEnC8hroEhYQ7@lists.infradead.org
X-Gm-Message-State: AOJu0Yxn7m1+AyvqvJwLRMk1I3EajbbN4aVUupngglF61NHPuSrXV2YD
	8eaSIS9oFmUksiOBJmtSg5P3XhmV6KpDjBWoccqafL8mcyzgAMRv5NDovQbAha+VVA==
X-Gm-Gg: AR+sD12t1uJVR3lUGqbq1mesd3YrM5Fgs3+42VqVHJXFM10DGoMd4SQZ6WeVcVMV5kB
	Ws+lVvB43w4EgGaW00yLDkKVbeXqMPFBiTFTqF8EOBueKb+O4qpf3tWde+HuCqapeleAwWtIIUk
	LnRE5SrxU6w0vOFdY0nm+gxMmfKdlJyKAiYGWJucJrhhCaGFmzF80Xp/MlVRP19DbpLoXVAfRXw
	3nyhaK2yv6OuZd4HJ8K3vd3+T+AJKHMzfTtnX02vfsFzJI8so6YmyxQxu9e8ip2Qwu1mJqovNO9
	KxLW+dMov1wxaPdlNPResgFBoMrHGRlOm+p5AkExmzH7q6O5C5vFOzg1FnNLrzHr4kVq/oy5UE5
	PcMn6uc50IE1vEqPMnpiVWM1OEuv0V6POh5MGzpO3XaXkKTztyOTO0ozQIffGHUd2xB8bjY1asu
	zFTGiUCcEl6vcoU0VVDWdP+ukX3JDWJ5uhwHcS0FbFge4y9oXZEwYir9DRN0lNxYgLJ3ZCpHwN+
	LRxp9xJBbKYKBWxf3B/0LhNuVZ/hPaU1L5qsV6ZqA==
X-Received: by 2002:a05:6000:240b:b0:47f:87f9:6d06 with SMTP id ffacd0b85a97d-47f8da5e25bmr5949800f8f.61.1784839375286;
        Thu, 23 Jul 2026 13:42:55 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.42.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:42:54 -0700 (PDT)
From: Mykola Marzhan <mykola@meshstor.io>
To: Jens Axboe <axboe@kernel.dk>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fygo.io>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-raid@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Li Nan <magiclinan@didiglobal.com>,
	Xiao Ni <xiao@kernel.org>,
	Guoqing Jiang <guoqing.jiang@linux.dev>,
	Leon Romanovsky <leon@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Kiran Kumar Modukuri <kmodukuri@nvidia.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shivaji Kant <shivajikant@google.com>,
	Pranjal Shrivastava <praan@google.com>,
	Henrique Carvalho <henrique.carvalho@suse.com>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v5 01/10] block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
Date: Thu, 23 Jul 2026 22:41:57 +0200
Message-ID: <20260723204206.76930-2-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134257_400612_C4E6650A 
X-CRM114-Status: GOOD (  13.93  )
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

From: Logan Gunthorpe <logang@deltatee.com>

blk_dma_map_iter_start() reports BLK_STS_INVAL when a P2PDMA transfer
is attempted between two devices whose PCIe topology cannot route it.
blk_path_error() treats INVAL as retryable, so multipath requeues the
I/O forever, and callers cannot tell it apart from an invalid request.
md also ignores it for member failures, so a mirror silently diverges.

Restoring the old BLK_STS_TARGET would stay ambiguous -- nvme maps
NS_NOT_READY, LBA_RANGE and CMD_INTERRUPTED to it too.  Add a dedicated
BLK_STS_P2PDMA, non-retryable in blk_path_error(), and return it from
blk_dma_map_iter_start().

Fixes: 858299dc6160 ("block: add scatterlist-less DMA mapping helpers")
Fixes: 7ce3c1dd78fc ("nvme-pci: convert the data mapping to blk_rq_dma_map")
Cc: stable@vger.kernel.org # v6.17
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 block/blk-core.c          |  3 +++
 block/blk-mq-dma.c        |  3 ++-
 include/linux/blk_types.h | 10 ++++++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 365641266c9e..83cb5464265f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -177,6 +177,9 @@ static const struct {
 
 	/* Command duration limit device-side timeout */
 	ENT(DURATION_LIMIT,	-ETIME,		"duration limit exceeded"),
+
+	/* no PCIe P2PDMA route between initiator and target */
+	ENT(P2PDMA,		-EREMOTEIO,	"peer-to-peer transfer unroutable"),
 	ENT(INVAL,		-EINVAL,	"invalid"),
 
 	/* everything else not covered above: */
diff --git a/block/blk-mq-dma.c b/block/blk-mq-dma.c
index bfdb9ed70741..e88d6b3524e6 100644
--- a/block/blk-mq-dma.c
+++ b/block/blk-mq-dma.c
@@ -189,8 +189,9 @@ static bool blk_dma_map_iter_start(struct request *req, struct device *dma_dev,
 		 */
 	case PCI_P2PDMA_MAP_NONE:
 		break;
+	case PCI_P2PDMA_MAP_NOT_SUPPORTED:
 	default:
-		iter->status = BLK_STS_INVAL;
+		iter->status = BLK_STS_P2PDMA;
 		return false;
 	}
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 8808ee76e73c..c8de7809320a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -165,6 +165,15 @@ typedef u16 blk_short_t;
  */
 #define BLK_STS_DURATION_LIMIT	((__force blk_status_t)17)
 
+/*
+ * BLK_STS_P2PDMA is returned when a peer-to-peer DMA transfer cannot be
+ * mapped (typically because there is no route between the initiator and the
+ * target that the platform's PCIe topology and ACS settings allow). This
+ * is a property of the initiator/target pair, not of the target device's
+ * health. This error should never be retried.
+ */
+#define BLK_STS_P2PDMA	((__force blk_status_t)18)
+
 /*
  * Invalid size or alignment.
  */
@@ -188,6 +197,7 @@ static inline bool blk_path_error(blk_status_t error)
 	case BLK_STS_NOTSUPP:
 	case BLK_STS_NOSPC:
 	case BLK_STS_TARGET:
+	case BLK_STS_P2PDMA:
 	case BLK_STS_RESV_CONFLICT:
 	case BLK_STS_MEDIUM:
 	case BLK_STS_PROTECTION:
-- 
2.52.0


