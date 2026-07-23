Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65165C531CC
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jul 2026 20:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wlFyTwpdvsIeETeN6SJHO+G4KnBBWZplfaizFoTi1JY=; b=wVts8KIppot6bbETj2JZ+u58LL
	UoeirUTdh8PNUcN0Z3N99RXoK1RF8iCWupMnS37g3pubRX/s09jyFTnDnRG+yzJ/lUUUSyB6uGsXc
	xJQ2bEy/OmGTANfES7XqZL+1Ec9H8iVSC5f1Owe/e2uDHRNZYf+9q+Cqd6GKhOMli4pJtS2EOfs0H
	JLOyiJI+rQnb+UC84ccLjdeTwWmJJEaGLnK+EOF5Dbu13BKav4UfW5evLYmpaYagdaxaLvQmLfC7d
	xmRC6iILxzMudpQYPoKSMnxBIZw7HEnF1aku0d08r2PsqbLdi2VEYmwN8DSNzDv+iwGsePBjiDjqC
	eLYiDhQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0GF-0000000F3pG-0Hr1;
	Thu, 23 Jul 2026 20:43:19 +0000
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn0GA-0000000F3i8-3Wv6
	for linux-nvme@lists.infradead.org;
	Thu, 23 Jul 2026 20:43:17 +0000
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-4799b3f7c83so785187f8f.2
        for <linux-nvme@lists.infradead.org>; Thu, 23 Jul 2026 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=meshstor.io; s=google; t=1784839393; x=1785444193; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wlFyTwpdvsIeETeN6SJHO+G4KnBBWZplfaizFoTi1JY=;
        b=Av7RW0OplCWGp9h7UF4udqMvHbrEIlqTVNC074DKWFzfN0nKdsiy8lxAKR2q8ifek5
         FHyIswjdUzd5x/rS9fq1tSoxDUdgSkrzOFXo6P0+xpJ9E5CfXDjAnelbTLJyEWRDTx+s
         DsH47tT6QCOQaNVHCGOnVwan4fDmDdBypKeTq3NvgFBBM5YpEmJ5NDNu6GXC3wvdxUzj
         ZGPQRcZjK/mf8lI/mMEiYEBHpLq7y1vIoYR8EsfaNBMpXR2c/CTcbuKQQoIxckH7R8RT
         vcGgbCPhlMDrtYCpa3e25FeZnopqQZ3RbfTplAJL/nlLkDVqjmn87WhQkU+M5U1L+Kdr
         G/Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784839393; x=1785444193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wlFyTwpdvsIeETeN6SJHO+G4KnBBWZplfaizFoTi1JY=;
        b=nSb8I9T4TKyy107ZQ8z2S1M2M5XMkM0Kswt0AHzMGVu2KVBUFJ3DQJgnxov/QcJPJg
         5HZlrJQAD4Uc2yDMgDipYOAUbPMlDyCJBy5xIgymeoA+aWLbgL7CzsvhunK2LDmZnOBw
         LvWJIvRykd3ghlwVInfu1P5AN7F1F8k4V7/2k5prly6nYg3flKXo1gHk2DIApGxt3SzW
         yIhSgjkHOAqQCXud5k/yyIc5f6RavcEtQ5pkNFRBxPlZVxBHJlF1iTuYmI9qOLCk6cqE
         2v7J72Oz/eb8/XTvlGCx/PaY4x2wKDCJ66SbvTtaRkOOfNhFTJ4W9rvVbD2gZJ4cD5Jb
         uBqA==
X-Forwarded-Encrypted: i=1; AHgh+RrvmvbJoQj9yrURWISQqTG3E1ad9Ge1gQcSZ0GAvGbwhOxumPJLITjYaEu1XYyK8bowZ2y37wFMHy3i@lists.infradead.org
X-Gm-Message-State: AOJu0Yx5cz4fnG2DXUHx2ikxFcjKn9k6Pwvyde1GZ0DWFXIcjJVoA1pY
	6jZnYzesXQXR53W3l9xY5Ew4pM22lKBdldy/6UeGmk/CpdI1vLknW/m56JKa4ea8fg==
X-Gm-Gg: AR+sD12c68/Wh4yKhje1rpr9MZFN8GioxyLFRACwMowsVPwIFZfjPev/Sz6Ijgwq1Uv
	V9FjBT3Hyi1i2MbZOfJ5DT3WpxZyFvfhT8ko6qpiEdriYShArPM/0uO+cWeikKiXcgf1t6b6qFY
	K1zjgPqD2jM8w0abIFpVp+sIIPtZj5D6OFJuWeouCGDKCvL3AX8ysM7/rFpr08sWWHJupYjzKMp
	OXNpaaktUEo/Hh+rqUVhopc2q821hfxB0bnW8/yzpOo244B0cGtZQUg6DoJoFZmQzxR5s0MOTt+
	AYSk38PlLPK6VgwjYo5RB6q5RNT+e8+jkc4zC+fm5jA7dCHqUIyadglazl9uZ5Sx9UMhTVFcJHE
	naKwqZbCt0hZn+Fh/1UMVdZQeDvJfyAfcQI/ZAH0vZhGuUgkjklM1DTV++NwIK4Nl5H9stJz4PL
	HqBLm1lSIssTDv/iWFz/8hBT8gdV/up4X+X9gSdt7DL0mRYjP2iCNkpZcPTFeslr79Zq5vKvucY
	rRjrKePy2UXby8jumlorTdQi3uDsi4XdbNPlmElKQ==
X-Received: by 2002:a05:6000:4203:b0:47f:7b75:61a with SMTP id ffacd0b85a97d-47f8d71f494mr6221114f8f.15.1784839392888;
        Thu, 23 Jul 2026 13:43:12 -0700 (PDT)
Received: from meshstor-pc ([185.87.42.56])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c52fc0sm18268192f8f.23.2026.07.23.13.43.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 13:43:12 -0700 (PDT)
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
Subject: [PATCH v5 09/10] nvme-rdma: use ib_dma_map_sgtable_attrs()
Date: Thu, 23 Jul 2026 22:42:05 +0200
Message-ID: <20260723204206.76930-10-mykola@meshstor.io>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260723204206.76930-1-mykola@meshstor.io>
References: <20260723204206.76930-1-mykola@meshstor.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_134314_896386_4A89F200 
X-CRM114-Status: GOOD (  12.98  )
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

ib_dma_map_sg() folds every mapping error into a zero return, losing
the DMA layer's error code.  Switch both scatterlist mappings to
ib_dma_map_sgtable_attrs(), which preserves it for the next patch to
act on.  No behavior change: failures are still reported as -EIO.

A local sg_table is needed: dma_map_sgtable() maps orig_nents
entries, and the embedded table's orig_nents is the allocated count,
not the count blk_rq_map_sg() produced.  rdma_rw_ctx_init() does the
same.

Assisted-by: Claude:claude-fable-5
Cc: stable@vger.kernel.org # v7.1
Signed-off-by: Mykola Marzhan <mykola@meshstor.io>
---
 drivers/nvme/host/rdma.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6909e3542794..63830334c73e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1469,6 +1469,7 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 		int *count, int *pi_count)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	struct sg_table sgt;
 	int ret;
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
@@ -1480,12 +1481,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 	req->data_sgl.nents = blk_rq_map_sg(rq, req->data_sgl.sg_table.sgl);
 
-	*count = ib_dma_map_sg(ibdev, req->data_sgl.sg_table.sgl,
-			       req->data_sgl.nents, rq_dma_dir(rq));
-	if (unlikely(*count <= 0)) {
+	sgt = (struct sg_table) {
+		.sgl		= req->data_sgl.sg_table.sgl,
+		.orig_nents	= req->data_sgl.nents,
+	};
+	ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+	if (unlikely(ret)) {
 		ret = -EIO;
 		goto out_free_table;
 	}
+	*count = sgt.nents;
 
 	if (blk_integrity_rq(rq)) {
 		req->metadata_sgl->sg_table.sgl =
@@ -1501,14 +1506,16 @@ static int nvme_rdma_dma_map_req(struct ib_device *ibdev, struct request *rq,
 
 		req->metadata_sgl->nents = blk_rq_map_integrity_sg(rq,
 				req->metadata_sgl->sg_table.sgl);
-		*pi_count = ib_dma_map_sg(ibdev,
-					  req->metadata_sgl->sg_table.sgl,
-					  req->metadata_sgl->nents,
-					  rq_dma_dir(rq));
-		if (unlikely(*pi_count <= 0)) {
+		sgt = (struct sg_table) {
+			.sgl		= req->metadata_sgl->sg_table.sgl,
+			.orig_nents	= req->metadata_sgl->nents,
+		};
+		ret = ib_dma_map_sgtable_attrs(ibdev, &sgt, rq_dma_dir(rq), 0);
+		if (unlikely(ret)) {
 			ret = -EIO;
 			goto out_free_pi_table;
 		}
+		*pi_count = sgt.nents;
 	}
 
 	return 0;
-- 
2.52.0


