Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8824CCFA13
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Pdajlfqb0Mkqw7FfTkWcBSlkNtUxKMEiU4sOjeajLqA=; b=cEbANARPSRgMPkji4T4DZBTDTu
	uM+0UlN6SDdvEXodVcGVwCRQ3QwAfrXrxEQi44pMDsEIEVReF/Vp50DkOjzhmyn8oZE0BkHp282r9
	TYeO7+y72xadYJZ/M653xF9Cy6gmI6zzSefNTxgvH++mHWzqLzpj0tqnSEZghLdXOLRr0Tu6h1zYz
	BD/VbcMnD5JEk0FZCKoBVkwVfGhAdjIO3NDPnKjlVrYeWJimp4xd6RA14QrljWTjC3oWgV8oOMYgY
	ZTD4jhn3g6XH45IDSYmJZrkckj7d2cjO+XRKeiScrGSOp4lhqM6lfLBflopa3zpWqnB+RocLYYZmz
	Zx+cJHmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6oR-00000003qLV-0L1k;
	Wed, 29 Apr 2026 15:26:55 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wI6oN-00000003qHx-0hX6
	for linux-nvme@lists.infradead.org;
	Wed, 29 Apr 2026 15:26:53 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-43d6fbd0954so9596365f8f.1
        for <linux-nvme@lists.infradead.org>; Wed, 29 Apr 2026 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777476409; x=1778081209; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pdajlfqb0Mkqw7FfTkWcBSlkNtUxKMEiU4sOjeajLqA=;
        b=E6hLW7fIlSX+6QILCPRQippK6NHyfwJsfAyWinmLrAnQZj1lAaj5fkSboa9zgaRZGj
         Her5+30xD8scadsytKCG2cZMOdIedLS8UTGatfTK8AM04tliQv4KS7Q+VUHsgMraycz9
         lBvDiB1D+1a1pnHNfc70TNCtZeNE0hq4bcersBtLr7DcLzUbHPKLW5DYM6RBk05R5in6
         W/S+hWKtyElInXmEX2PGKVNFCUJj/go7QGF9rdtlKvgQLRmXLbp7/9z4oW3Q/4v8d6Aq
         exOv45kIxG1IGgZgY7w81ol4njzBYUrL6zQ9OyXfp7iELaKJ7157UMVNzvxyey8F8QzZ
         C+NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777476409; x=1778081209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Pdajlfqb0Mkqw7FfTkWcBSlkNtUxKMEiU4sOjeajLqA=;
        b=boLutWoz7s9ZEaUWrDPwxSbjYCDGbK4NCebdJeuoQOznKdV8GOeyCyL5bJOk6k59cb
         8xvpq3yCLnWSD+UKkSXYYA/7z4P3k7QYIPLRvw/cC+iX68lPsUAf0r8SHwy9sxN5jNZ7
         +0p2muvi4rBuB12TAiK8y3pRWiF04twFPQ7XTnqqJ0uqIId3Lz4Ng4VjW3alE0+Z70cZ
         /TMPUp+xsdhZjAnfn8Ha5DXB4jwgtSwBmUNYF7MLCascBM3L4F7WXigd322aJ6aXBo9A
         VCSp5/2c/3Rlh8pEoz4aN4U73P00boRZJ35ePQWFwx5qR+vPCvyRhxo1zrF+OTx+2VpI
         L8lQ==
X-Forwarded-Encrypted: i=1; AFNElJ9B2BT3+ZkC5EL5vzyd/ywvTpOadiBGDXx+3UNzOpCdWU3GB2QMPPstqnhtoV/XUWD6RePMn/hxED7H@lists.infradead.org
X-Gm-Message-State: AOJu0Yzh+r20k7afWKp8Aa1LExLPknBe0j8vt2B/u5OynZatW21cjuVi
	5e534XD2Vo/y0dbfRPqKyUGk8W9skRSC8aMMnknH0brKNl+p2AzVgXh0
X-Gm-Gg: AeBDiesK6f5OSbWjupxW1nAqEUcLnwZW7IRpes8NIA/WttYqALcEvTsdub1D/Vq/zMj
	iT6T8uuOnwlaksRS8bP99dHiwAMj3fZFZvR/G5AaFfrBwywHZfRG9uHYRGdkmuddEacoApwZJU+
	J/yxUrP4p1kTiapWdbmAfst53JIsirWIhE/dqFnxADlmSyFFjLwjdtibPshDSuPZfQFyRzFm8hf
	8KTWGaQImXkJjWfg71GEn/KNW3Gh3C5Zl6lbdVS9mKuzGAipGpwtur2iNMcatru435ksIejnda6
	JT1nOYDDn8KT6+XQzE9Czxd1w2v+jzQ+c0pSjxkhhJaLJDDDFdUDhE6tSoM9NxgE0wcIeT1by0e
	5ylsbKFlkWb18kc8MC59MRBivqqXDwHmVhNLsEh9bcVIPKvyvhD1bcxM7CvLWK/NWR4o57B0UqK
	oGfWKysK2YSmDVfquctKiLSPVFnFhxqolebtqhxc3O/JOGtPOeajAkTg7W9uKKLIELgi9DTfE9X
	OkismM6S/SLZyDnqhv0E1JJhoRs1GUk1DkB8eaaZD34
X-Received: by 2002:a05:6000:2002:b0:43f:e9ee:5610 with SMTP id ffacd0b85a97d-44790d12be0mr7198547f8f.43.1777476408973;
        Wed, 29 Apr 2026 08:26:48 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 08:26:48 -0700 (PDT)
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
Subject: [PATCH v3 06/10] block: forward create_dmabuf_token to drivers
Date: Wed, 29 Apr 2026 16:25:52 +0100
Message-ID: <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260429_082651_220348_88958787 
X-CRM114-Status: GOOD (  16.51  )
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

Add a trivial implementation of the create_dmabuf_token call for
block devices that forwards the call to a new blk-mq callback if it's
available.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 14 ++++++++++++++
 include/linux/blk-mq.h |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 713a3ba3f457..3d8a48a7d645 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -951,6 +951,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_create_dmabuf_token(struct file *file,
+				      struct io_dmabuf_token *token)
+{
+	struct request_queue *q = bdev_get_queue(file_bdev(file));
+
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (!q->mq_ops || !q->mq_ops->create_dmabuf_token)
+		return -EINVAL;
+
+	return q->mq_ops->create_dmabuf_token(q, token);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -969,6 +982,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.create_dmabuf_token = blkdev_create_dmabuf_token,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..ee31fb3ada10 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -15,6 +15,8 @@ struct blk_mq_tags;
 struct blk_flush_queue;
 struct io_comp_batch;
 
+struct io_dmabuf_token;
+
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_DEFAULT_RQ	128
 
@@ -684,6 +686,13 @@ struct blk_mq_ops {
 	 */
 	void (*show_rq)(struct seq_file *m, struct request *rq);
 #endif
+
+	/**
+	 * @create_dma_token: Create a dma token, which will be using to map
+	 * a dmabuf for IO requests.
+	 */
+	int (*create_dmabuf_token)(struct request_queue *,
+				   struct io_dmabuf_token *token);
 };
 
 /* Keep hctx_flag_name[] in sync with the definitions below */
-- 
2.53.0


