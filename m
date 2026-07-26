Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A157EC531CC
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2026 11:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=; b=fhWnwb8Bk4cppTaJ35UKSKlCCt
	yYduuEOhhM9KaV/S1L738Y+btdN4/QYtL+JEAtjnxofxqK5txCOrw6rEcz/vIAhxD18gWTEAumP5u
	gctkpj4pLSVvAJ37mmLkGuQlTsRAK5W47gxSv6FSBgYRV1vw7lUP/JKHnzfN/iqn8rLwGmZMeya9Y
	UCkd8zcwJinuSA9f9M9HCJit3RB7O1Xs6Fhl2yAOnKEDZ+UapEphwnK+mClzOV2EC1x1r+4ggYnv4
	FvzFR05pwg2QaNjf8hfRBbaKMGq18UUvjs27Y1rHG4MZJHzJJbYXw9yFiVlH1MwRhZIANftiTZiq+
	wTFKVQqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx60-000000016vi-3dOd;
	Sun, 26 Jul 2026 11:32:40 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnx5y-000000016uy-3z3Z
	for linux-nvme@lists.infradead.org;
	Sun, 26 Jul 2026 11:32:40 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-47f92e3c14bso1731885f8f.0
        for <linux-nvme@lists.infradead.org>; Sun, 26 Jul 2026 04:32:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1785065557; x=1785670357; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=;
        b=bS44DB3b5uFaQLL5tSZhXm5ADvZxSIDtAEqLoB2j7qWP/Kq31T7JXiRLPL6sPvHRaq
         a4WEdNnB/sVdYqkHGI2zbqQXuMldQIKNDcEaVPHIIr/4/4P63Z+LQeHN9aO/wK4Su/dp
         xT7EMHFKAoLmuzrA+KyqlkGvzW/huBUBAWTQ59YcizuUkjcJIJ9bLHePbFzT5uIxliv1
         S3nLTN1QECjfiembeh8PkETOOnSVI486s3pooTsBJ07fcvy0UnOJwDjZYLBJu8xTfddX
         0WEnexzIZ3b7OD1KZTSket1yqXy3Chwoe8Q1iJdlka7+8EBF20ELlKDkAXCzsQbX8Ytc
         NqmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785065557; x=1785670357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LNWXk+rlZiNRYyXRDGVV7qCvY4AZPHPO/XYCzCCpSWs=;
        b=Dg7IFQ/dMAV1a/ifI2ye72GeyJxIWNzkWRWvSDo7nc3ovDNmEfM++1/HPDyuRw3hLV
         8/F2T5A5cT985K7P10qTs9q0c6AJtBs9NB99MwsZs3FOycB1gpzloHfKbk0az4UlFxqh
         rQcRzdAiPPoIVT/5h7z3o2stGY6xdc55Ywx2URKQ5GCVvbZLSVkbn4xtY56cfMYztmN8
         szm5XNXpmH9ur0vYyVIq9FVZWaYYSxRK9Qf6cflbM2ziHq3seP2rIDNXCqe2WKD+AWCQ
         NknXPh2G33/QkAOafAe+6GNQPGujmxSQm8R73UJj2IE5bI4t0VqmY2DbXtitH6Is5zaX
         PL0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rqvi6h67Fztt/tAzRjGQHeqnvvzgd3el5s52kzsyTY/VDF5eXu4M+ja1thCGIfE7sWyVKIggCQGm4+5@lists.infradead.org
X-Gm-Message-State: AOJu0Yxpqc8UGrv1LqqJg+4/ElaiR5OhoKd0rG7fUbDuDHBqCxP5rEMz
	Ejh0qwPRdL5lZNR5aT3raLGUbJVPmuLF43vR0BeZkhtW2f5YlqYT09A2Y8FcEN2bVw==
X-Gm-Gg: AR+sD11yr47zSIDZ4XkFnLCHLSicaiVdfk0Zp6fvQb8NzcJpLpLfqOdUPh762sAdjFM
	sSdtnDuw2xAg8cu092lufBWP/pJ+8XXq0Hz432Kn+USLHKYItkma4RxCwHIgdyBj9s2nsNozUeb
	fXZRy+/QMPlzskTAe0NudP1zXLStRtzHOpJVJ65+qa+AaVC4AutpQIsn0/pdwV8E4eE5D0caHB5
	NoiFuqAZqM4nCQ9HR3YxKC4KteQ/Y2SiNCZYWQkMTrNPMc4xxObjWvosvBamjjDso9EUy7Cb8+c
	5I6w+acFgslA/VI123PmP4Dmt3s6Wrjsn4VkFQmeKF2pgNBIUya/8Vxu1mORLgM7J5EOggruiVS
	JNkaU/6NWyjm1TcxImF3jTDw++FK06evURyqoqVmfdaKDfpKwnaJ0OuZaWQ/ghWEQNyyS7hgaLC
	QkqaPwByAkqeO2n/SlYnKVwilKCmRGhf8Df4otXtnEm5jEynqMVylF9QLRbO77bizRNnOQEasog
	MQ2YTjjOscGteMu9XU6B6So7591Ai8gX07ulqRrcjJBiUQCIen4
X-Received: by 2002:a05:6000:4012:b0:47f:93e1:e7d0 with SMTP id ffacd0b85a97d-47f9fea2d2emr6157677f8f.36.1785065557128;
        Sun, 26 Jul 2026 04:32:37 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bb57cfsm40533083f8f.11.2026.07.26.04.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 04:32:36 -0700 (PDT)
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
	linux-pci@vger.kernel.org,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH v6 01/12] block: add BLK_STS_P2PDMA for unsupported peer-to-peer transfers
Date: Sun, 26 Jul 2026 13:32:18 +0200
Message-ID: <20260726113229.2154269-2-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260726113229.2154269-1-mykola@meshstor.io>
References: <20260726113229.2154269-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260726_043239_006318_0DAE0411 
X-CRM114-Status: GOOD (  14.26  )
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


