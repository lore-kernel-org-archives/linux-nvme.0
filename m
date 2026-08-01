Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D75DC55175
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Aug 2026 06:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fyuZF+rseQvIVevAALiITcY143h/8lAr4kofVhDXVW8=; b=xXOypcyl3zEDtBJlqPTzZIbNIg
	mNiDYP4+MDosLYE+gBZ7YBCtRY5+xaNsG9sPzENQc3jHKYAZ3MZGt3v6tn5CbYFhXM294jJb0uwRb
	GvCYr7cCdNXKyk+HIWQL2sw0dsUk09bTgOBMJtsOU4hIdh3s4jB/fqPx8ucUKYeOnJqmBECaGZu9x
	ziRjZsHU+Fa3Rqtq/3md2QIAE0aKFGEqh2mJNQluHutkcYHu+3RnuN5BefBJKRpCZCm8GAH9i9+3b
	BrfDgHsbXUk8MJya34UQcl8hUPYt16eBcbV0Ohq2cazuXqjfve/ivHJcuTX/lSKxtU3kgEW++dbWg
	Hjb03Xug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqPX6-0000000FOMX-3olp;
	Sun, 02 Aug 2026 06:18:48 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wqBx1-0000000Ep1n-0Jde
	for linux-nvme@lists.infradead.org;
	Sat, 01 Aug 2026 15:48:40 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-2ce98cb8165so20866885ad.1
        for <linux-nvme@lists.infradead.org>; Sat, 01 Aug 2026 08:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785599318; x=1786204118; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fyuZF+rseQvIVevAALiITcY143h/8lAr4kofVhDXVW8=;
        b=BY5Wuja/lvWrMLVIUkuDg6KXvKXiiIVg35L4jAt3zDyCLDIGMP6MIi4RLwiFDUxb0h
         Q0Shs9bUQ7O8Q7bSu4YbI2q4q6QEZsWAG+ZpKaWFxOu+AQ6eE85U5v8pVOMCiQBSTHAT
         WotmSf6zggvHL9kqwGjEokw22Da7Nac5DlfMs9DHDpel39FIkJrdAsUOMS78FaaDkoUE
         92KaqMTMJm3iu85eVM/6pY57zwWKM8H941cXl3enwrUewyabF5aRbti9kkJL9QV9UaKs
         bk7kW0oIw4BbH/2Y/KBONVCGQsTNrPKrGfCM6HzVHVf2HEknpVt6k9Knwpvu1fHQ4gwf
         TOGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785599318; x=1786204118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fyuZF+rseQvIVevAALiITcY143h/8lAr4kofVhDXVW8=;
        b=orX5fMfHxzj+J/KoSSiuJOW9h3l+J2qvismBPNOyWu7OW8Zci85ew0vUx5kXdCm9tS
         W9JtcZbAKDs2KNz3Bque5KKB41ozPHMloy7i2lt8L8SBJuZy/bWaWRTWa8lpQKjj3Gql
         +mlDKYPXoggRmus5lFiQGvL1ZuWmUmPtcwZ6kLGg88QRMMOL/V/5TJ+z5bxiqeGnc/p2
         NQFhIFuUcvxLCnDj4KJVnbYSjd8Wq8XA42fosVCZ1tuNN/d6t5s7kFc0oxt2kfhFixCH
         5OA2+4ND3FwMejIbDvduX3oK0u7Fnl1NFe8wKevkkzLU1uagltyLD8PcLSnnl8RfZpmu
         eJFw==
X-Forwarded-Encrypted: i=1; AHgh+RonxJfA5FZFCQ3xkX4BAjOYYwDt731EnESUQzE+kP8BadsC87KJYZjidGTvKhI8GKKEOTmYsJXHz9Wf@lists.infradead.org
X-Gm-Message-State: AOJu0YxpVO7NwSOPCg7UmecZ4Yp+LWelHkmNPiH9l1xFhyfLsL0I+Een
	A26PWS8OToBpqKeFXn5SR6h0YkNb49dN6XXxvKipyvb5iHy4sh1cQiHD
X-Gm-Gg: AR+sD11xXOe6IfjGlQgHZfoF+v6MEYq4jrdkIBtHdDD/jI205QBNPMNYxjwMwKegS4o
	tRbpkZfWzPskGl55368PXYQGSEvadI2KwvWxmNZLD9tguG/h6Fzmr//Xx4dxZRNTPcp599rvZTf
	7J6V37BT+K1wGnR5Tlir0nx+6Mi1f7SExSdqSs9rjGZQDnDZqgCfwz1O8yRSSvmJGuWZh4zbA8Y
	QorAxWkvsY5ZJ8AMAnBCZSK0CH5kQra/10nhwIDhmO/wzxbUiVD/83Zg3txen2/j/GcyTJShhxX
	iF5JAddTnRtUwkZut0LXGP6Jtv5WTk3dmAQcG1zxSKga6c5nF8LGdCfGF3df6V45dFEe1rt/6Gw
	JPKJ7UgQCbZlCgRB3uLqS2t0AzN3VqJZb2t1fdWpq9Ac8L1sjZpeerWj4BAYBgYBOCUwXUKY7bH
	BILHLc1JVUgxk371pUHrk1hkauY7BwBc+sJM8okhwkckz7CYjIMnie4SqbT0wsjK8XPC/+oEvG/
	c1a5KgETPDuCJKQH4YQdYgwpJ8gLL4g793JmH+ctsZ1Zro=
X-Received: by 2002:a17:903:2c0d:b0:2c7:f5c6:c4a6 with SMTP id d9443c01a7336-2d0535b3b1amr33657505ad.7.1785599318082;
        Sat, 01 Aug 2026 08:48:38 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 08:48:37 -0700 (PDT)
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
Subject: [PATCH v5 05/16] block: move bvec init into __bio_clone
Date: Sat,  1 Aug 2026 16:46:17 +0100
Message-ID: <6ecfe8f9b1c6bfb8665fba7daf55d9ad7a8a3243.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260801_084839_138973_82F27FE0 
X-CRM114-Status: GOOD (  12.95  )
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

Consolidate bi_io_vec assignment for cloning in __bio_clone to keep any
further changes in one place.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 4074a0496b93..00f99d03ac91 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -860,6 +860,7 @@ static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 	bio->bi_write_hint = bio_src->bi_write_hint;
 	bio->bi_write_stream = bio_src->bi_write_stream;
 	bio->bi_iter = bio_src->bi_iter;
+	bio->bi_io_vec = bio_src->bi_io_vec;
 
 	if (bio->bi_bdev) {
 		if (bio->bi_bdev == bio_src->bi_bdev &&
@@ -902,8 +903,6 @@ struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_src,
 		bio_put(bio);
 		return NULL;
 	}
-	bio->bi_io_vec = bio_src->bi_io_vec;
-
 	return bio;
 }
 EXPORT_SYMBOL(bio_alloc_clone);
@@ -923,7 +922,7 @@ int bio_init_clone(struct block_device *bdev, struct bio *bio,
 {
 	int ret;
 
-	bio_init(bio, bdev, bio_src->bi_io_vec, 0, bio_src->bi_opf);
+	bio_init(bio, bdev, NULL, 0, bio_src->bi_opf);
 	ret = __bio_clone(bio, bio_src, gfp);
 	if (ret)
 		bio_uninit(bio);
-- 
2.54.0


