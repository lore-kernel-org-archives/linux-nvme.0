Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48A4FF887E
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nOTrV0WGracSIFm0V666o5CRu83OUP8NlZEfiWwVSJE=; b=tviGwWlZcgcO5QWtWAwXGwCV5P
	SnApAmYl5bu1dbrqcKvrxJ1Fg3OLnv5q8whnn4XkIRNu4+hkyCxS1UiY+YRDqDDVXz9NNkahDrDCe
	qOzfE6DV+hg+IxM8vjiHZwj8ZQ1M3rWSxPIFFKgwABlrbQms6V4q1h7v0NDJVXAahQfyrjNepmNtm
	OEgHbfaaiCOMVoAvfpcS19+i3HIOwqWZFR6276N1FMlNTal1b09ucKxuAdJceSLaZlz4gppTecSyN
	mqGpY0onY3AvUgqEplnkiGUAAkrcVjOU/Z4VQAJFvRIEOuo5ifAtm/CI9ANJPiwmbh2iAUEwzNsTT
	+0fTM14g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6oC-00000003q9j-171i;
	Wed, 29 Apr 2026 15:26:40 +0000
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6o6-00000003q6r-43Kx
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 15:26:38 +0000
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-43d73352cf2so10680359f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 08:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476393; x=1778081193; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOTrV0WGracSIFm0V666o5CRu83OUP8NlZEfiWwVSJE=;
        b=YbeTwUMHrK4yPpXMs1fKZQZDL5+u4GhvES3HyeXiH0aN7GWsZlP6oEssrakYkglkRN
         zl1WgcAsoR/eBEO7Te7LxW3NywziXiL8lA/o8xAYdUwhL6meFC8DsHop7Mn15IDEL5Rb
         fhpl2fS8bg2XpSgWA+NZbVB4mQ2/PdRH/nFO2MiR2fANZ1GSa3hoj9l1swBJA0FFLwnS
         5CCKDsvVJJJiO5sXGNvmYpJBrG1/nwM9+/0Drrh6EM35QAUdRxCOHXeH5hctPmyN0tQp
         2KzLEsQOr7IREDCx5ECVLUcVoFNQuQBiDc3UoMFS8q8AnjcYvF6X6UO74BGps7P5T4sN
         l0pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476393; x=1778081193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nOTrV0WGracSIFm0V666o5CRu83OUP8NlZEfiWwVSJE=;
        b=jo6WMDfAINwaeYGKff7Lpo59m2UUETD6vZuDjC82IIVPXjzys/mgW7lHIfBzsy+gQM
         SgDhVoqIfloEr8pd5H/8w9pO0B3neG2Q4M9wE4p5qt5PKgl3vxts06JUsWny7B2yH/0E
         tS5W9wRiBQkLXJCu5IJZ9HYkj3NUmM7nSCs6RLeQpHGZFYbEc6g4PaGRb+aIf2pLoIQ8
         5bl0fx9WEeA4a2Lfl0IYaSndhn/2Ntj3Af5SXKIJTmLksfHrpVN1f1dbLlWZ5nycsxZJ
         dEIum6b5hfyFJM9VQE+mXyVKsef4GCemjjKOz8Zspb/dIbUS7uZursgOQtyt/f2KuGWy
         y1BA==
X-Forwarded-Encrypted: i=1; AFNElJ/JXUZ1wZAJOCubvIcxrHooIsW66LCPG9qmDToVaXRv8UAfrED8B1J8sph1g3vbP+O0g38bOJqBSPFz@lists.infradead.org
X-Gm-Message-State: AOJu0YxSHs14YOadNC1m6GnlmRsckwtefgi1luO86n3LHiAnxAerG5Xq
	zWuQIf/J+SZ39TQpfMSJZ+p7Msav/aE+aM2u4hIc8Wu4jSAyl1+rqdZZ
X-Gm-Gg: AeBDievLObQkdNM8n/Zun0QpUPYtQgRFJQy9csJBgWKEew0RfUxy6E51NdFKBZyJP5m
	44YjRcMiizDAxLjScXx6PFXoOP4oQj+EeM3l89AnkHdFFWZ6MDlemnn//weSbf+89MjraHEM5sg
	oY/Y6ktgg9LPvFOQ5ElHy4yqaUpgNALdp7/1Who6f23EVpY367Ny44oCnMpkknItgP/fEXcHsjh
	Yx/TTw9deCYATkMyyq4RAzOOHxsdJOyFdt+hCM2O4NKIeTk2oAvPeXrghMJsj5A9epEKpp5Xhs7
	Pgi0LWUTnWp4I5c/vJNDYqy+CukB8f2uWPOikRwzxVRm0inFtUtND/vlg8p0nGuERANXF7EqXeI
	EE1syZpWNQny4MsyzwfiKs6PKKIOoM6VH7a4BkhUkq4T/QOpQxS5jebjFN7uHY8Ilv7B//q/iGw
	uHwLZ2jKuS4LwtaGotW/AdJUWsmx68M0nR1AyPCInkmvlKq4ZWg9kexIq/HGtnY770DH8N3254x
	G8mjrWxQ2qzyEhI6G4pugc/p3bfgPV3/ZgxQkGud3Ao
X-Received: by 2002:a05:6000:250f:b0:43f:e41d:85f2 with SMTP id ffacd0b85a97d-4464839c9bcmr15101656f8f.2.1777476392719;
        Wed, 29 Apr 2026 08:26:32 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:32 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 03/10] block: move bvec init into __bio_clone
Date: Wed, 29 Apr 2026 16:25:49 +0100
Message-ID: <43a91f54d61d3329316e40c69ace781b4d35fe0b.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_082637_468840_1BE536B5 
X-CRM114-Status: GOOD (  14.73  )
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

To quote Cristoph: "Historically __bio_clone itself does not clone the
payload, just the bio. But we got rid of the callers that want to clone
a bio but not the payload long time ago". So let's move ->bi_io_vec
assignment into __bio_clone(), so we have a single point where it's set.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4d46af0cd256..0734b50d4992 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -851,6 +851,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -893,8 +894,6 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		bio_put(bio);
 		return NULL;
 	}
-	bio->bi_io_vec = bio_src->bi_io_vec;
-
 	return bio;
 }
 EXPORT_SYMBOL(bio_alloc_clone);
@@ -914,7 +913,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 {
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	bio_init(bio, bdev, NULL, 0, bio_src->bi_opf);
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.53.0


