Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4099DCCA461
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=; b=I8SCTXFNjykmgBD/j/qTx3rRLD
	FQ7XnbtdunsdA4fSBVCgkfaQ+N/UDdrg+zu6JOwdOwapbAF+E2kmU1OgnTR/jVf/weQnwT9hmneX2
	NAQLAuIcMKsfgCTrkeVcW76Twl1zJtDwpOCn585+em9Np6HbXq48TCmb5jIlvyl/bV0u3sFJ4MKSg
	ifnD2tKkRCAT4M1+59e88J4Uo4HXs5Fz+w9UB2GWh6H5s4vSwx85gv/tb6iLeiNdqhtnSsBMw403B
	5SXQuMkWug53r16+YbXkJZxJf2syEMm6wXdyYvo88Bq/Lku77sXqbBxE3sW+HdY0kkyq0VzJWQdxn
	Em7ShmJw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMxa-00000000TH4-06JV;
	Thu, 15 Oct 2026 15:01:34 +0000
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGjWr-0000000E3F8-3Euv
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 20:55:22 +0000
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4a018dc1f98so27442285e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 13 Oct 2026 13:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791924920; x=1792529720; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=DWfGZX1gX3kCDnKrkk95Z/NAQZizRhrJpL/6M8pCV5LIrPVEW7wflCKS131YDybVZE
         B84hXqyLWg+TGZia2DV6SMzfaigbl3FDif9WtbHJ+c+hCB0GAANjRcIUC8rF/kCoyp3X
         qJ8ys1P2wwaPGn9K5ItcPS/p8lZgiqwsxJQ1Tuzg1SVsVHcnUNQF7ESYsBjLmy2MNBrF
         kK1bAOn1mxE92ZOZ67RUBXIyYw7zFjURBuGhzkl5rDTSzw6Jwrf369ccn++l6Q1vvlc+
         bTyfaxVtu1N13f1mK4PDptjSYgnOO7cyFYF5/q4LAAxaQ/flb/d5eXoF5e13Hk8+ebYy
         p1Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924920; x=1792529720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=pRqYe939WP0mkF497psLOoREaKJX5g/XS2tWn/9DhvlA1QDCAkjRTBdBZg30ywZgT5
         bA4PCEQm6rZVgYmoXWJBk0v3069qyUvY3tKER2mlVBFQg5DRE7yu+hH2qg8g2PBhADic
         Q3KJXy/NZMv+cW8k3CrBmmZYespWelrC64XdXoK4RsVfTllAUDgKaQNmIqVItYnL0yNL
         zxUBQb6yulFgzPFatHUC9iup2x3S+gyRVYJROsrNt6KP3TLhrJVDSIjSNpVbtsK4vUUf
         TxN2+lGbQkEKvynC0E19Pt3QI4RM/3ThFiL1KCmDzlYfxXqEWIbKN+iuzCmE2LRNFfx3
         hGQQ==
X-Forwarded-Encrypted: i=1; AKwUvBya66hQO88TX9kYrVberCcsE3FUX/X9pmqHEDUxtEsxggWOEMy3TVp7aUbHUu+RRbYwUs0BgGszky4K@lists.infradead.org
X-Gm-Message-State: AFq9FYLFsbOto/VkWfR2K+/MMhhv1pBKVXGipmMwp0cIRU9jrwwa4CGV
	2ZcJA8M0m/RNqW1WIS8TQet8viB4BPy9pubNuPxo8DZwJIieoU4qamQM
X-Gm-Gg: AYBFou2hNzJiBDYZ5Nc/SKZQnEeuFfLrkfOZWrnjwkpzCvL4j1L0zX25CcjoSaSaV4V
	Fapw7eIlQzzr7bl9gSFa2X5swzfgSV9icFD1py+zw274EKoFjgO0hiAzfFIQFvGKpYq38Xqv2RG
	fqSDCLPLBMr+06UFWdrB/Sv/Swbigy7MmVlA+y6yKBJyAw7P+//jATsQVyPEhB9lXJ2bITA/u8P
	KPOWRzu791EfE1ZuZ5MXNfEYakn3Bq6VFc0qbN0+wIlj21DeHoinaSSEbj8WMH7rI4iANA/W3Fk
	4USGVA8R6jWOcAgkoNCeIxZAfBF6jBjGpFIvw6DN1RmXdh+/GrBgneggo/S05CNIIwxY/Gy/nUD
	eEONfayTl56PXszRz7kolTIWtcUzn+ysyYhoeWb/r7LAidkvLNI8+KDLSWIdabVhs6Z8WYddKCl
	Z+6gtinNt1mLPTsWUa53mGqOQhqNoaFDLRfHoRaYG/ufGMW29WAOWtXtBfYKkciQJOVP00tFeDB
	+Q3jml13EkMkRVT7cBt+uh/Mtj18JrjK5StXSfjPIU1YPwe76Egc9503CzhokJBQFtLRkutOrxl
X-Received: by 2002:a05:600c:3e83:b0:4a1:6d35:779a with SMTP id 5b1f17b1804b1-4a18e446880mr243665015e9.3.1791924919983;
        Tue, 13 Oct 2026 13:55:19 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:55:18 -0700 (PDT)
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
Subject: [PATCH v10 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Tue, 13 Oct 2026 21:54:47 +0100
Message-ID: <007fe19ad4e949ec70ee74ef5cb05774656c62e2.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261013_135521_846348_E38A9746 
X-CRM114-Status: GOOD (  15.30  )
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

Extend bio_no_advance_iter() iteration to also increment the offset.
It's not currently needed because the currently listed request types
don't have a buffer, but will be useful once we add bios backed by
dma-buf, which don't have a bvec but work with a single range.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/md/dm-io-rewind.c |  6 ++++--
 include/linux/bio.h       | 12 ++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/md/dm-io-rewind.c b/drivers/md/dm-io-rewind.c
index 04f3fc8aeb6f..b22719c6411c 100644
--- a/drivers/md/dm-io-rewind.c
+++ b/drivers/md/dm-io-rewind.c
@@ -113,10 +113,12 @@ static inline void dm_bio_rewind_iter(const struct bio *bio,
 	iter->bi_sector -= bytes >> 9;
 
 	/* No advance means no rewind */
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size += bytes;
-	else
+		iter->bi_offset -= bytes;
+	} else {
 		dm_bvec_iter_rewind(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 /**
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 17944e44b584..892ca469c570 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -113,11 +113,13 @@ static inline void bio_advance_iter(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
 		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
 
 /* @bytes should be less or equal to bvec[i->bi_idx].bv_len */
@@ -127,10 +129,12 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 {
 	iter->bi_sector += bytes >> 9;
 
-	if (bio_no_advance_iter(bio))
+	if (bio_no_advance_iter(bio)) {
 		iter->bi_size -= bytes;
-	else
+		iter->bi_offset += bytes;
+	} else {
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
+	}
 }
 
 void __bio_advance(struct bio *, unsigned bytes);
-- 
2.54.0


