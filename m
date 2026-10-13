Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C24D6CC6B3A
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=; b=3V0PPo7I3GI5XLJX68e7oDSJiY
	CSuoj2fPGBTisQgr4JOaL8gOJazkrAkiQol+YpvDsP6x49SGWP3fXDA/g+kMxkSkU9uuVEauNqGgI
	QomcbnNxQud6TuUp9hlmZGyuE4hzMWHTLH3T325JlIM0I3uFFI+Q7rD9SMLrO3TzVxC6+bFolDdHR
	HWQPZa4ZIzmsh96fKE5GdSMiPM2sSCOW1yuVILg+v4ErrOJOCINtqbjozvMz4QU4kspBNTdnZB8uc
	4IpzkKqsppxXm3Frw+RD9ulkmnB1T3onmeUpI+UnGHLWw9tQqXVPFYic1KDzD5sWhBe9V1x+Jd5wa
	oD8NI+kw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxj-00000000TMd-0hOU;
	Thu, 15 Oct 2026 15:01:43 +0000
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjX0-0000000E3HK-0ony
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:55:31 +0000
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-48b0584ad71so1974113f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924928; x=1792529728; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=NbB00aIrum4eR77eKozdUGMKrMwRfafz9M8tuiekfM1llp/qzcYFFnZonCMZnDrFln
         +Y/4IbY6hk6FEPIdBRKMbKabUOXJGuJIFo5tKq8MpOl5AYwH970y9wcGp10CjIHSKvpk
         3VdO4FsODL5joWYYyk+ZRA04l5NqprYEcS9Wm09Z10Rghd2G8xpIXikbEhWPQuAKIarF
         wVfQsJGKnR0brdDUTQj2VeipS1svFpA0O508n1nEfVAXYXdMzKxlcLB0fzIJwN3FqRSY
         Ow6yHj43/bIbM9L3MAs3xwr5BiOg7fbjNJQlaB2umj4WpylArutE5L1FRu/yduYVJ0at
         toNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924928; x=1792529728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
        b=sw8oYykXU3orWE6FXtksrfsjsYsFmvDccyw9wtmssNTVVdkEPTSQduBF4SuDG/fLsL
         mAiJIOelxOSu2fxi8F5vxHjkWDIZTc0k1/ni/mrzVsQjeJm1rymula6j8mbOM5tUBCB7
         zkEB0YoeUFn5XXH6YmYZ0M7oEtaqDAzpAOegCJYH6lthuFDq5Hpa5uWtRrbZfGtxrDSp
         M5m4Vj2Z5AWFeKzkIwuwKDdbbEge2eIuZ8jJYSxd1hxwbW4aTdOX1u9/sMs6CPJQ1kVn
         kWXrmf+FiNDtd4vOjcgq7w1Jm90uqlrcVMFYVhIXCa7uTHPOtF+Yvdm4/LqleQvNJRLa
         nqiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxbjJ2/mjLAobmizQz41123fz1tjohA2Zslm7xlE8qZW5fXxspZLnWwPpK4U+0CCdzAUwxnU6H16Nq1@lists.infradead.org
X-Gm-Message-State: AFq9FYKTP9IrXUyuEl1q0CB38LYlkJ+c8olcdoNr8PdQY52FyPOaI3gg
	aHfVvGyeeqyelOa2EBbjWwQltQ3vK3hoNM7U+f90mw74jepLXFmcPpjI
X-Gm-Gg: AYBFou2OOMRnShFBbEtBZkM5b1KOoN+wL854bbjvb67B2jlBDuOE/GchKDBJIHB86XH
	ZRkpHRqVZWItPPtzqSVgzDgIPRLauoq8FzkMAN5ynwOK08shFcpaC8KxyhBCivseN14QOuNL11v
	YiI3lBRZD7+ODNcopgxz9U4RTq5wABq0pSSbA6cxPHgzRCa1O7FKLdOOtxOezC+yzCVVUr1jXew
	yXhPlyMCeSj5C2u+7tQtcSud1bBxb8jDtamNWx4MYGpVZWWTrnpFsFdXZHsT1pZsWvGENX+dB9m
	W9D7c2LgGhcIIIY08RT/OnGnlFuJqkRJnb2/nYO2YIUUtz+4VnEpxDGLBASjdtfy4NtNrwocoe+
	oWGH9cNh8pSPwOcVNGbkEiYF9GllLptqZXmU5KLPwjoqMNWLYLQ89ukMepJdJWZUHRCCnIpyw0+
	CiQBwERjAYCEc2v5Jf1M9Rf8erZKJNmXHnpEMWuTJFrXNhLZDv/0ZsluHFT2ta2HWeuBnOo6DIC
	13Ei02iuQUVrc5H2z0TJf5iwmEvYRm79XmgNo4IOHZ59eA8ws8IcjuGjEhQk3Iv4jbNkaVpQi24
X-Received: by 2002:a05:6000:186f:b0:48c:7c69:2dce with SMTP id ffacd0b85a97d-48dbace9dfemr26073729f8f.16.1791924928152;
        Tue, 13 Oct 2026 13:55:28 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:27 -0700 (PDT)
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
Subject: [PATCH v10 06/13] nvme-pci: rename nvme_pci_sgl_set_data to nvme_pci_dma_iter_set_sgl
Date: Tue, 13 Oct 2026 21:54:50 +0100
Message-ID: <54f1186d20a7c24075dd38eda1dfc7ac3705a13e.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_135530_274352_EBE95C85 
X-CRM114-Status: GOOD (  13.49  )
X-Mailman-Approved-At: Thu, 15 Oct 2026 08:01:28 -0700
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


