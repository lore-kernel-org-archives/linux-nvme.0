Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5E58C433F5
	for <linux-nvme@archiver.kernel.org>; Sat, 12 Feb 2022 20:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VAjL5Qv92Pxy2zp/7vR4qSvR0kIaKLtx1kCE04PHKn8=; b=q3WIDxcR/DVp/OeP1N9zFHZX3g
	z/kn6MrygfdoTuWVz6isFrugR/nt5Rw6au06ZMHD0h9xiz4Rctw2Tvxft3FL3BdP8DBQlW+LIRF+0
	A8bMXNPHxRpj6ZxiNO1ax/3inCAeetpskDWol9r4ee8Cwa6I5k79g8MQIgC1COx9L5O2n75t2IN2f
	Vu4QNfyRfKfVLZVJ3oK2Y1tLgcEvKUKtrhV3ulrRNjlE22IwgSl72tE0JiP1yd27hWOBJC7J+VAnB
	34njwPJhhdLJUg9nAoEijbPCYPu5GB/7GnRnlYwFKOrNhc0XwMIPua8HzcuxfHtneTjx6MSDhvZEe
	WYobM3ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nIyg1-00ASln-8i; Sat, 12 Feb 2022 20:07:25 +0000
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nIyfs-00ASlC-34
 for linux-nvme@lists.infradead.org; Sat, 12 Feb 2022 20:07:17 +0000
Received: by mail-pj1-x102f.google.com with SMTP id
 h14-20020a17090a130e00b001b88991a305so15146159pja.3
 for <linux-nvme@lists.infradead.org>; Sat, 12 Feb 2022 12:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VAjL5Qv92Pxy2zp/7vR4qSvR0kIaKLtx1kCE04PHKn8=;
 b=nTX4IXliMiahAw9sSIQp/dfna+S5bVPuLeWZ4RbFisrTklsVlytUhJiYzrx81CCRP4
 hLpWjnAnFD8aFhpWOoNofkUgUCcXbemeXAIPeQkD6qPd4LcAspoRoBAiWxfLaQ22UQL+
 eB3fIO87JiIjra4Uda/zunIHi3EVD4n5fxVFy8KJ+ehNy0+jaR5FcTdOnXaZFOL3+UYu
 VdIx8bl0PnSOneNNI3Op8uaQd5HmSzbSVZLFbagD2CwLqyGTm3SUrS/jj9GdQJ5/YXRr
 37O/+GBIeJryzocxQDTBVyz44rxQnVOyO3/6Np+uqjr+Buer1AsrZvgtDDUsnZPAxn7M
 QMFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VAjL5Qv92Pxy2zp/7vR4qSvR0kIaKLtx1kCE04PHKn8=;
 b=LMAoQUNi4JxFJvkP9r3sAO9hjCeRWXgkqlS7fAzsveHY5pzQByrS6bm+YqboQZdfoO
 b6utUC5OxKP4ZdgNa/Ikbsp42CsvwK2SGIKuiYyYMY3QgL0qikcSd9U0ReG35b/BiTI/
 YIi+SIxacFp33E/nJcyxzATDKa00gVF1xtsemQJpge+S1d640lRMdh2zM0Ef30bPr/MV
 krKSUxn6gwr7H0UVnhGgFH5/n8/0iB6qkIrQrn3PI8igkZUz1YbN7gWrY99ItcRdjORi
 vIUxQ/Lo28s1/3u7wkw5l5K2Q21WB3z4KIxq5qg96yBEm1gj0EN9nP2m/3CBYHhzlPGf
 d0AQ==
X-Gm-Message-State: AOAM53277hXurjMQOy85hj8SMgj+e97DYiJj/A+xjWIRL3SCd+Yhfz48
 r60mmoltf6ulrRygAjQZRmc=
X-Google-Smtp-Source: ABdhPJxsYmAwLDSkoFML1ba8Ws7Gtqqzyx3B2ySQcnCrNCDEbdINIGkUaKeg6orYdntfwnyYGBS+GA==
X-Received: by 2002:a17:90b:4f8f:: with SMTP id
 qe15mr6639155pjb.94.1644696433022; 
 Sat, 12 Feb 2022 12:07:13 -0800 (PST)
Received: from localhost.localdomain (67-61-67-61-208-168.cpe.sparklight.net.
 [67.61.208.168])
 by smtp.gmail.com with ESMTPSA id q12sm32958758pfk.199.2022.02.12.12.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 12 Feb 2022 12:07:12 -0800 (PST)
From: Matthew Waltz <matthewwaltzis@gmail.com>
To: matthewwaltzis@gmail.com
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] nvme-pci: fix prp list allocation
Date: Sat, 12 Feb 2022 13:06:49 -0700
Message-Id: <20220212200649.541061-1-matthewwaltzis@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220212_120716_187569_0A8F7ABC 
X-CRM114-Status: GOOD (  18.16  )
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

Fixes kernel block errors originating from the hard-coded 256-byte
alignment of dma_pool_create(). The NVMe specification requires a PRP
List PBAO offset field of 0h, i.e. a PRP List must be aligned to the
configured 4096-byte memory page size.

Essentially reverts commit 99802a7aee2b ("NVMe: Optimise memory usage
for I/Os between 4k and 128k")

Resolved by using default PRP pool which is properly aligned.

Signed-off-by: Matthew Waltz <matthewwaltzis@gmail.com>
---
 drivers/nvme/host/pci.c | 51 +++++++++++------------------------------
 1 file changed, 14 insertions(+), 37 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..4fcb159c7df3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -119,7 +119,6 @@ struct nvme_dev {
 	u32 __iomem *dbs;
 	struct device *dev;
 	struct dma_pool *prp_page_pool;
-	struct dma_pool *prp_small_pool;
 	unsigned online_queues;
 	unsigned max_qid;
 	unsigned io_queues[HCTX_MAX_TYPES];
@@ -228,7 +227,7 @@ struct nvme_iod {
 	struct nvme_queue *nvmeq;
 	bool use_sgl;
 	int aborted;
-	int npages;		/* In the PRP list. 0 means small pool in use */
+	int npages;		/* In the PRP list. */
 	int nents;		/* Used in scatterlist */
 	dma_addr_t first_dma;
 	unsigned int dma_len;	/* length of single DMA segment mapping */
@@ -598,10 +597,7 @@ static void nvme_unmap_data(struct nvme_dev *dev, struct request *req)
 	WARN_ON_ONCE(!iod->nents);
 
 	nvme_unmap_sg(dev, req);
-	if (iod->npages == 0)
-		dma_pool_free(dev->prp_small_pool, nvme_pci_iod_list(req)[0],
-			      iod->first_dma);
-	else if (iod->use_sgl)
+	if (iod->use_sgl)
 		nvme_free_sgls(dev, req);
 	else
 		nvme_free_prps(dev, req);
@@ -635,7 +631,7 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 	__le64 *prp_list;
 	void **list = nvme_pci_iod_list(req);
 	dma_addr_t prp_dma;
-	int nprps, i;
+	int i;
 
 	length -= (NVME_CTRL_PAGE_SIZE - offset);
 	if (length <= 0) {
@@ -657,14 +653,8 @@ static blk_status_t nvme_pci_setup_prps(struct nvme_dev *dev,
 		goto done;
 	}
 
-	nprps = DIV_ROUND_UP(length, NVME_CTRL_PAGE_SIZE);
-	if (nprps <= (256 / 8)) {
-		pool = dev->prp_small_pool;
-		iod->npages = 0;
-	} else {
-		pool = dev->prp_page_pool;
-		iod->npages = 1;
-	}
+	pool = dev->prp_page_pool;
+	iod->npages = 1;
 
 	prp_list = dma_pool_alloc(pool, GFP_ATOMIC, &prp_dma);
 	if (!prp_list) {
@@ -753,13 +743,8 @@ static blk_status_t nvme_pci_setup_sgls(struct nvme_dev *dev,
 		return BLK_STS_OK;
 	}
 
-	if (entries <= (256 / sizeof(struct nvme_sgl_desc))) {
-		pool = dev->prp_small_pool;
-		iod->npages = 0;
-	} else {
-		pool = dev->prp_page_pool;
-		iod->npages = 1;
-	}
+	pool = dev->prp_page_pool;
+	iod->npages = 1;
 
 	sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
 	if (!sg_list) {
@@ -2727,7 +2712,7 @@ static int nvme_disable_prepare_reset(struct nvme_dev *dev, bool shutdown)
 	return 0;
 }
 
-static int nvme_setup_prp_pools(struct nvme_dev *dev)
+static int nvme_setup_prp_pool(struct nvme_dev *dev)
 {
 	dev->prp_page_pool = dma_pool_create("prp list page", dev->dev,
 						NVME_CTRL_PAGE_SIZE,
@@ -2735,20 +2720,12 @@ static int nvme_setup_prp_pools(struct nvme_dev *dev)
 	if (!dev->prp_page_pool)
 		return -ENOMEM;
 
-	/* Optimisation for I/Os between 4k and 128k */
-	dev->prp_small_pool = dma_pool_create("prp list 256", dev->dev,
-						256, 256, 0);
-	if (!dev->prp_small_pool) {
-		dma_pool_destroy(dev->prp_page_pool);
-		return -ENOMEM;
-	}
 	return 0;
 }
 
-static void nvme_release_prp_pools(struct nvme_dev *dev)
+static void nvme_release_prp_pool(struct nvme_dev *dev)
 {
 	dma_pool_destroy(dev->prp_page_pool);
-	dma_pool_destroy(dev->prp_small_pool);
 }
 
 static void nvme_free_tagset(struct nvme_dev *dev)
@@ -3080,7 +3057,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	mutex_init(&dev->shutdown_lock);
 
-	result = nvme_setup_prp_pools(dev);
+	result = nvme_setup_prp_pool(dev);
 	if (result)
 		goto unmap;
 
@@ -3109,7 +3086,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 						GFP_KERNEL, node);
 	if (!dev->iod_mempool) {
 		result = -ENOMEM;
-		goto release_pools;
+		goto release_pool;
 	}
 
 	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
@@ -3126,8 +3103,8 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
  release_mempool:
 	mempool_destroy(dev->iod_mempool);
- release_pools:
-	nvme_release_prp_pools(dev);
+ release_pool:
+	nvme_release_prp_pool(dev);
  unmap:
 	nvme_dev_unmap(dev);
  put_pci:
@@ -3198,7 +3175,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-	nvme_release_prp_pools(dev);
+	nvme_release_prp_pool(dev);
 	nvme_dev_unmap(dev);
 	nvme_uninit_ctrl(&dev->ctrl);
 }
-- 
2.25.1


