Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A31FCA601D
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=; b=0OwlVy1PDz7nz0s9wK4SrJbPsh
	KicPf3Djf+30gG/wO2nFs+RV4f1DssXfFH4mcIVCeHSLUafOa0Xye/CKtLP27L4+Oe4jWRE2nbHmy
	rUaLZ4BQd9O3ZlYy8FzftO//rkAFwSoBz6FlHapLvwTcy2VdRGFt7uCGc7n8c28oAqrsdW6/kTNiB
	2vDoLPdABn0mTi7Pa7mvmISuNY+DBTH8vpMZklBk12q3uDkTZ1qjTTCgEWhs1sa52CEqGMS7b8T8P
	TMwi4iUOTbT3gISf0qAwUibZBb+zPZROC3IGUdaAUWsjkTsfXTfJGxE1kOwAoeybo11YLzUeD5xFD
	n9x4sIXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtq-00000006hqi-0Jqx;
	Fri, 09 Oct 2026 16:56:50 +0000
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGgj-00000001cEX-1Kfu
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:43:23 +0000
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4a02718da81so10913325e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337399; x=1791942199; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=rGFGFf9Dn7Jn1uA8gpoGcKgkbSCJOF61GoMekWOYlF2I0H+QCe2w6Fl0DuwJEyTtOZ
         qdBrRVczCAdPoESnscC4FGFjYhFM/Ypd/8k9CIcQwbBvqJM2T/5wMW8AqdGpBsnB1q5Q
         Mo4t/CMJK1bwRfIav+ccITv5y7pkcWECiVN9cHnPaiESvt+SR2gs4fvPSoWY6lDeWXyd
         WDeBXQPCCytgErbdHeE2PUXCp92xtL0Hio/r7mNg4SNCav9DmjCZu9tgTqk1upmJIBg3
         9CLo20JTFQO7xik6l3fGVjcMPktSNIOzKP4+jjCqcBDcsW3gGmPk1+fpUg/kqn2XufW4
         H4hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337399; x=1791942199;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=zRo8xnIK0nBcmold2vPB4TMvFNi8+COR386r5ZqRrdSM5DYUNrVAc4NL49uW/KjGzK
         nyIDx+jdn5a/4r3jsuu4Qfjjd0Mzq6OqqRi/iPEvoXyB7qzCIa0+FPNfezeSpu4Uuhsn
         5JZmCxnX/HDL613xzAslJO7PoV7dSh85rdicgpXXPnnh34QA1H4J4HMyHsJ1IYKu17xe
         8nbl+pYhYgKTk74u+z6myoG32AUyxDxox+nCBSpRd1OuD+sCD/6FUh25+zptJLcJAx1Y
         6Ab4scVR1aH+mBAdkXyJY+pbcwXJhYF9i1vDiurG6DzyscRgQ9gPMRcWDA8KkiHmgCAh
         /Y7w==
X-Forwarded-Encrypted: i=1; AKwUvBxv2o0l+UUuYUzFa6HGKriZhcTiC8pzkKPsDUhfG8qopDRF6OnwY3+Uyld2/JFVOFEtr6qdIpOjR4Yt@lists.infradead.org
X-Gm-Message-State: AFuF++kJ2q6Cu5x2NIKsJ0d/nzqZeDquQpZNLBekOzTInqlz86ebgXeN
	ZznQmnAe/Pmvjv9sPOsVhOc05BKZoew4D79liaH8UJkUZgndT4xXwPfK
X-Gm-Gg: AYBFou0zOiYKYZ1g5+Rc651dZvV/0nQGut5pWCjHQle6PcsNfncyvhsWIzbek3k2sXK
	n+ufT0kY8EAmL0sm3dP9irYCp0hAGUu9+E5ekVeo+TON/zVAOCJKAikaTOW1BMRAkzEDsmAWNah
	43oAGqA4DUK57zNJrjhgU6Hv6c7f6uMR5beM+zHecLrawAiJWGxDEgDg8DvAnpam5NQ/ZMc7Ih4
	ULMquFV4oLlGCf+pAiNA9HTYyNGzGTZxsB1/qL0vIHD7tQVbGPfKfHrG9RjT80lkenWnlB50j7F
	4PT2YZDh1XPUJxYiNxOYbTrL1i1byPmSDaaII0VeSJNH8nsyTYnm6//YJmpvw4cPGQBpjZIYRQg
	iXmcQnoKu0cs2AV1rsZnykFxDGUMsamHhokAVNjoVvvBRDpB0nUuPI7kkgXSBH2M615pHFDKP/I
	Fw9CKhssLlO5KlbBUSWhxTx4vjYdauGeobTmspdbqOKvQHi1lsYBQEcaV1pn0P1Nycmc73xWmVi
	/vtL6SLJniCENOZiSTmGk6ELvFrJk8j79wGESYN/5E009EEQTnN0/dqCsMjr7hFLJVrXIOiOXQ7
X-Received: by 2002:a05:600c:348f:b0:49f:dd9f:6038 with SMTP id 5b1f17b1804b1-4a18043b38dmr6958715e9.25.1791337399492;
        Tue, 06 Oct 2026 18:43:19 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:18 -0700 (PDT)
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
Subject: [PATCH v9 06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Wed,  7 Oct 2026 02:42:49 +0100
Message-ID: <2f8b57f68fd3e432085b3a7767971778bc7d1919.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_184322_334926_92C1A1F0 
X-CRM114-Status: GOOD (  13.81  )
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


