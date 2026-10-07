Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25E7CA9EC4
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=; b=g+U8RpFmQ8frLj7GvIwwJvbVLs
	Gsd52itnK5WUPoADgrugT+CvwryI0MOpyzrItm0LJw1az84jtYGJQ0Z5GGEgVW+TiDt7uGr1TDasy
	TI+FLNsTmXtY7OrPcgeFIk+JCeTITBZaraW6BsmYoswnPFK/WVCt9Oq90U4kSDlUCDRtLCfQlAz2p
	pRBqCj5t2CUWyliERobkauzy5EcSTOdhkH7XbPwTAgicHozW99gr7qKCR8kxPqFCLDm2CPt0fcGIK
	5W/JILG3kmJfxcf1GrJCzrr92zJR+gAu6OfKfZmwNSxX9OtC5py+1U1HinyjmL2cpeMQ9eUlYZrw7
	c1r3VxEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtd-00000006hXG-443J;
	Fri, 09 Oct 2026 16:56:37 +0000
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGW4-00000001auI-3OPE
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:32:21 +0000
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-4a168355946so11746065e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336739; x=1791941539; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=jBJe6/aTdKXTjmuLLCrda05Clu5WaK1q7y92j0n90vUR2sVddzGDTlYCsTY72ssxDf
         KY1iT5nzSXzZTbNPyEJJdrXL/pyPNpAS1hVjwQOVsam5pBxXLFZOAtyOKBx5KMjXP17n
         LYMmJ2Hzad29uTSLO2EEMz3X8dpJyfO867NN7r12XdrSipW1gInPi+1gKdHBkcOSGJdd
         pLvjzwpy7RjPwVMWsBPjto7ia9oBxy6E2TxUt6ZMrJpFaZv0WT7T4bYCdRxKXuGjTfbZ
         c2+e7Aixo7jdevTKm0opN6wzZGqTH/Bqs3vqKsbHiHXwBZmP1WGnqcWkIWRkhh7sRcVt
         QMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336739; x=1791941539;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=bCpOanaTa0uLtP8Xt+cqg/pBenqdabsfisHQBLG2QODP1rPJXWyLJopxFedOsdlm+t
         pzY1tsO4zzrCZd+YDgW2c8Yi7pWAggNm0ueTYf0xulM/s+iuxTcZwkzDIZ0hEb9wCwGH
         pjgUCW+zstD+BfXEzKEnOlfy4HYsu5xfDIKvH1E6Iww+CtYqjm4iHyXfmFO2TFQHv9wo
         WXX/BDRxCrhVG/O4w53uqrN70ltRIbvGDGhbGyKGgq2Pdgc2e5Wt2rXT0Bz4OstNRlAK
         vUV7l3cBqX9rVMfHn4U18eOYV2swwD/cP07OOR3hZyX5dPVsDTff8iMmgkoPB2lj9DVT
         p/Aw==
X-Forwarded-Encrypted: i=1; AKwUvBx18ferzM8uo/vXfj9tmIL02lLjf6KyBgZ4sACIcwdStBQL+GkrKD2jcmBbtvIhhElptJ5/4rWicsMr@lists.infradead.org
X-Gm-Message-State: AFuF++n3XDZNI9MPjm92S18Q6hl2YlmnfdPkxek+Gz7EfcBJwQFk8TVQ
	fGNgv2TL5apoUrTAGbqxRZ3e312s7wV2MoKHoaYhU4E1g1yzygJvk7C1
X-Gm-Gg: AYBFou3gncGWe0INTJKlYtSTvSmMlpIRvVQ+T/ufaJG7MgxZHtnmlv/Bvuqr7I9iBnu
	aKAU7UpsAdFmjQaAoISCRAIqX23hBdJ8vO2YliwvlHCz7YiWL+XiRy+tvWwxyTJwjebp84AEZEo
	HwsmJlaOpgK1YfU+ZEDBmi1o5D7t2yqNvE0KEdsFnfgAPAag870+UZ3Jnl1AqSXjL1w2HSLcRsq
	LTbYnKfDLuzUy/OOEpiWwK7kheZhDjoeJNCEn35ouhDojyezXn4kMPl4rwssiDZ4yAh4mGLtWx0
	b8zDe/vvyOTO0JKX9Zbo4ezFx0PjANp1Uu9RRlHkh3Ozl5d8AbRQVSrTmhWUNASZ+hRhRQ2woW+
	ONkBXNYKhIu1jrrBzmKnzXA7IxtXkKupG7RhCfWVGOZKcBncbYcXY04iYkwqzIdbLYWqwGDmPVI
	571JoAwzA9XsoCo1OEqftOp0HKPwOU1mzifsZAFdLjlZfa2ozemp5CJOjbSSSTGY5ppybmQfOWG
	ZTKdDaIBFgEfFUHnRV1CW0uRDWBvEE7nOgdKmOD/dpf+tyeoPW+3V30fK5tsZqRFaWjdnNOhLQG
	un4MksKhFAc=
X-Received: by 2002:a05:600c:3f0c:b0:4a0:251c:fa72 with SMTP id 5b1f17b1804b1-4a1803038damr7433835e9.11.1791336738926;
        Tue, 06 Oct 2026 18:32:18 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:18 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jens Axboe <axboe@kernel.dk>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v8 04/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Wed,  7 Oct 2026 02:31:47 +0100
Message-ID: <2f8b57f68fd3e432085b3a7767971778bc7d1919.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_183220_880629_36CEC1D5 
X-CRM114-Status: GOOD (  13.91  )
X-Mailman-Approved-At: Fri, 09 Oct 2026 09:56:33 -0700
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

From: Anuj Gupta <anuj20.g@samsung.com>

Rename the blk_dma_iter based nvme_pci_sgl_set_data() to
nvme_pci_dma_iter_set_sgl().

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9..a65b77726e4b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1147,7 +1147,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1177,7 +1177,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1199,7 +1199,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1359,13 +1359,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 	iod->cmd.common.metadata = cpu_to_le64(sgl_dma);
 	if (entries == 1) {
 		iod->meta_total_len = iter.len;
-		nvme_pci_sgl_set_data(sg_list, &iter);
+		nvme_pci_dma_iter_set_sgl(sg_list, &iter);
 		return BLK_STS_OK;
 	}
 
 	sgl_dma += sizeof(*sg_list);
 	do {
-		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[++i], &iter);
 		iod->meta_total_len += iter.len;
 	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
 
-- 
2.54.0


