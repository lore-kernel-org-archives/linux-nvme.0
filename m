Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE889C55171
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 06:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UQw568s99USSdIytlPm2Vpoz5MduETOEjKRltqiPXcQ=; b=0YBXPfXlVgFvWz6gklVzYzcNah
	MgV83Efsu0POPDpvA1dSKj0bc2ykV7aiYCH4SVRakAJXHR8+syJbLRvvT4i6PZn7kxZF58kF0eKKJ
	HBKLooPJ21eNQ3T6vZ/m4v/qqjgU+POjs+J3m4hIttegegwg7j7xH0XhY42uElwKx9rkLYEJSD4Ba
	a6c9E7OhrNx/b73yF7ZlG9UGMYsFdoHs6Wj9gWWqkSt5ifQWhDKT1gO/vg/j9ZXqgO3qqsqrNeltU
	xnoFuTtBVCOBXNBkr2E6dH3i8w+zpGsRR+ZDj+y4UyYggbZgAAy//VPltjzVx4KOOZAh8IC3yPrZy
	hDMezLJQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqPX7-0000000FON6-2M0q;
	Sun, 02 Aug 2026 06:18:49 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqByj-0000000EpD4-09I9
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 15:50:26 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ce7d2adef4so32824785ad.3
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599424; x=1786204224; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UQw568s99USSdIytlPm2Vpoz5MduETOEjKRltqiPXcQ=;
        b=EwoAOcS4H0KQH/Ly5JGBh+ttksxUpGRC9VuctOgPjVO7+pdeFy5GO/Y7NfwirUZOVM
         nE+6UCz5H9Jt2TLhkQ+hyyXdRukMlijrEcc/rpFA2JZK818rMENjE+dqmBMgK1hT1gHr
         HLyhghQv1Zvh8J5wuMBRVJJE1gq2zF0Do8DgGFCdSkaACj4oOmpW0IbTXFQG3xWTNazL
         XhuN7kg9MlX3uFo7I68Rdomjz5Hwvdpw1JamxVxy73rPKiXqmLp18CjIGY0MeRfiD29a
         XSBaKYoeYc+Th1/QYQADYEcgS/oWi4h/SXyKwrsG5zGdkh6X8Xs3zaRR/maqon6ZXiGI
         zWRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599424; x=1786204224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UQw568s99USSdIytlPm2Vpoz5MduETOEjKRltqiPXcQ=;
        b=eg9txr5x9fwVlYH68dkWf4dIawqIt5KR1bBP0iNEf7y/qcA7HRad8ARYJcpJhoVGuw
         3FUyrM7l/IlI6R2BFG3PHdSqKyQSS67eDVnChf2kIiSyrDqqbhXPxUPCU2ImAp9jMm5h
         HC035G2C+bOlq/vT62uxtxmqWUxUJdh+M8mpNrcOMS6FFAhASWtxZmKVATZI/auoM21Y
         knw9Ol+WvMH6zZzp/aVxNpD25LvqwUT1S3sdXLIrPNeJzq5mn1Z2rH/xTYc22YC9Xa0j
         0JDpn2F66g9ySSzJoqnsQ91WRQSWDe1WnJZY88gSTrAcX5RuDKUhVkAEflyTcfaKXa1e
         0aew==
X-Forwarded-Encrypted: i=1; AHgh+Rp/nVb93bbBB20tm9Hdl1s9JFeuj5CdqzCaRDKZmeEKv03HxuYBhqgtUlSiV8x7+Ii18TRT6Yt5ASs/@lists.infradead.org
X-Gm-Message-State: AOJu0Yzz5AkDhBp2RkTSI0WRPmzEhU3h3FrzTcRwmIRxMybvHfAJW0ox
	iHtud+owPnV1PjI1VrZgfIb7+W0nSr3AZsuH9C8ANQ5OewLI83aJDLGt
X-Gm-Gg: AR+sD13K+ZiwnLgIIT32PlocTuW/zU3G2nHsuKXKtkK8IpUg96RnNgBmLq3HNSXQ3vA
	0ByG9GlXjz7+iOVR0hJyH0Pt2VeWWfegIK+3gUpr3TVWIL4uHMe36j70ohAtwEm1I5vo/Tm5yGq
	2uVeH54+qu+iWxuqkKDsMrWDgyxEdPuCVSReyC7VSiHPgVjHEEAATxeOnu2ZTQpWDDnZqlW5Ia7
	Rm8ydHfbzVBF7WZ6sMemyULuY++wK0WT0Uy6Xk2ig91Kt1g71y+/eV8AsBq2oRPa0k11Zu+BxMD
	pLtELM/w4u/7hebefcp55QMb4iKfn8xFTJwuTMpXxAE4Kv6G0yWvKn1LYkl6F6M/WYWnGR6WjnO
	pFb9HiPrSyndsRBRA3akLPJT5lgaOajOSaNRvfwHg0xFNtHAo5JTM4oYx+lOor2hCXFZEgVa6jS
	K+gOpe/VaC0V4mxZdK8sMz5Sb6qeCQeS4+YrC+TmRo5an9UW38RyQoMIiizD1fHDR0YgunsUMhv
	McFxddRiLAg7EhQTyxVx46f4P/Cte/E2tqUInQUGgOpyt8zKIXoKKb27w==
X-Received: by 2002:a17:902:d2cf:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d0521a5657mr42155635ad.8.1785599424386;
        Sat, 01 Aug 2026 08:50:24 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:50:23 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	David Sterba <dsterba@suse.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	dm-devel@lists.linux.dev,
	nvdimm@lists.linux.dev,
	linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org
Subject: [PATCH v5 10/16] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Sat,  1 Aug 2026 16:46:22 +0100
Message-ID: <ff507b4895521074938d82fe2647e003359ec2be.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_085025_083182_DCE98E46 
X-CRM114-Status: GOOD (  13.10  )
X-Mailman-Approved-At: Sat, 01 Aug 2026 23:18:43 -0700
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
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5608ede6c479..7b8ed101a13b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1287,7 +1287,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1317,7 +1317,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1339,7 +1339,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1502,13 +1502,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
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


