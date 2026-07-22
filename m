Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81417C44536
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jul 2026 18:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=; b=CLPXeVq6m9gk570EEIZb5yzjDQ
	w+Q80MAC1aN1KvPJRrftnXACnuhlfqHw+5hOXSmMqyXUXKItD5E+i1HZJGk3fmymnGR4zPHw+HLc/
	ZeB75dasukdKz7fGRVCOHJ9iy2v76Ea6N8m3/iSpIbiNAQDZTNpjHGx+zBxhgE1vrKlmFoMRdLLUl
	p7x3DBNbdNAtm9/tBFBUvW/LJ1sOw/QeEiErh4z41sR7CpI5yDzFzc5PBwYo/sXNqEJiao8NQa1Sl
	RBa8leZ3CUoXXZUnoWNiSwABSvg6GEs0qdqUzN/g2DCbm+ysDqzlMEGunkSIWwwGDbeg6czCtIxVt
	5UKSegFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9o-0000000CafN-3TGM;
	Wed, 22 Jul 2026 18:59:04 +0000
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmc9m-0000000Cae4-0Nf5
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jul 2026 18:59:03 +0000
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so69840265e9.2
        for <linux-nvme@lists.infradead.org>; Wed, 22 Jul 2026 11:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784746740; x=1785351540; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=;
        b=pzGVfeaEmrzKRFIgBz43K4DgK/TSd2/3blInmkDNFgOupq5C/fapRaCnHunLUbJuKn
         pn5LOzjeBOCJz4nUkLFmYB9/FusFYIt43lRsa5NzyoJe+wSKP6dmRQtGx+Uy9mbIcA56
         ns0pv8KGthkSpbVVytP4IGh7aDBj59YN+1h1nQCSxniyjQIC6Y3qDfLuOYA+uFEuxX7P
         j8FxTGPCzrsv1yqPub6SJm0pyCtcsC5rVWKnGKkPf+SPyusb7PvPoIf2CTq7+n5mMKms
         1wWiKFKAX6rGyPsff1N2buQmww1mzMFVFcZZqIA1Lh7En/NYX0GpZ00XhZ93TMNHQ9qE
         7ZEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784746740; x=1785351540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=;
        b=mzp+FABXV48y0zsoBlSCN9s7PA4PkI5iZ+Fo6uDHZQDh3Vyw0hSgMcp7bPs5AUzouv
         e2DlAiWNqnoID7qoEybrHGrai0P8jTrkHnxbXmRf3DpPlA/u6LEeQIl2RcxV805s5BgL
         lk5tdEEv/nJiA1/YiSztmqulSgdkyudaLidu3Pa/fQtQXZFsZFmgrAgVcCw3xhbCuIxq
         y2cQyuqjTxDvdmH5BiKqZzayGGnmAFXTRCLbEo8yoojqChM7lRyROOATNp2QcmoQd+a/
         iWeOLwKXlzwcr0yb4Zqr4JjP0aabHPFx20l3wVJ2ivne1cG18h4gSGHaV+UDUcsO8iIr
         ZDsQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxU3FaskDfauNVENWJmnnFVUcSOe8K3NouzyMcmChHSnDWxwLAMzzoqtAofF9hhqSfPXAmu22AKVKu@lists.infradead.org
X-Gm-Message-State: AOJu0Yy4tmTlQCorE2mBqNfMqJV9MYCj9+eLkO6hxavprAzQ/nrSXQoM
	Ox+CKMddSIHetoSyI+LdGo10GfeWUM7L4eZtV58qlxdC08d2pHW9XY1da3BjyLbxhQ==
X-Gm-Gg: AR+sD129KWsXMK0fy2gkbyQeIsoru7/XgE9Sgl+TO0MmqCZxaMcPMDpWnYX+3whCJJg
	8cR00Dd1LAulkeb1CSK403yoRHCjjgNC/muvepUhgASDuPrMcYToa9mn4B/gTZ/dE+64QEmn1Th
	owFWxpUqt4YN5EG7nZm9EGomRyqPds3HajZm+lEbCKQYJjlEZzex2xTgV5UYm4jS/c88AzI0ols
	N/gT37agSFKG3yE7GJLDpageUlepy+iDUnNjWuPuYXGru3ss0D7DQzEUR+FmSn1MbSfjc/GkdYJ
	AApFuQN82UOCM3Sjaftx1tWtAeWJKs9c8dzlfHJBJC9SNpN7zJ35MW8UcJXfl+1cFl74AFfo+fW
	NQoAlzhJOLrD8ze4F+h85bh+2ErClHdMpQxFFejc72pFegHDkNhXGQGKfLHRSg/AxzTogkn4NEk
	mohoRbnawIcWJsTdFxRuKpECYQlEgT41kkSCZ+RpF0vUzijb4=
X-Received: by 2002:a05:600c:3153:b0:493:e97c:216e with SMTP id 5b1f17b1804b1-4954a41382fmr294367705e9.39.1784746740281;
        Wed, 22 Jul 2026 11:59:00 -0700 (PDT)
Received: from ai-pc ([46.172.241.174])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495730353d9sm13740055e9.12.2026.07.22.11.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 11:58:59 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 1/9] block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
Date: Wed, 22 Jul 2026 20:58:33 +0200
Message-ID: <20260722185841.449934-2-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722185841.449934-1-mykola@meshstor.io>
References: <20260722185841.449934-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_115902_149060_FB81E46B 
X-CRM114-Status: GOOD (  14.43  )
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


