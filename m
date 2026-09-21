Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6051CC982F8
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 15:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=; b=cD+PPT7k2MTIKbif5eqZMozMwn
	S29gs/jPg5bAWQarm/6AQy6tI7GN+39r2m9bg0I0lL8VQazyogAcuK0Rt5ULBleWhWu8CgBvrfLM4
	F7wEY13I2giqqNpZwfChNjtUN71hRC2YVpUtfsNHj5oITjU4Cwdzlgjrg+/H2eKOqVA/8kD+nfT2a
	Uvkb1jLs0SsKK7/fuGIHyQxLy4yJxIlSJZBBcDZ19AXexMHWgfXEsJmEr2df0byodWGAvgQRwLu+m
	utKX3ZK5rBzznEVuEKRCq36DIUGYwwKOWj7iPCqyEOqAkWTcXFSAAnttj4/NNBAI7RNpWCPxmIeBU
	XvFl6lqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fWF-00000002VhL-3Fjg;
	Mon, 21 Sep 2026 15:01:23 +0000
Received: from mail-wm2-x11.google.com ([2a00:1450:4864:31::11])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8eF2-00000002GSl-0osl
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 13:39:33 +0000
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49b912d37b5so17497555e9.2
        for <linux-nvme@lists.infradead.org>; Mon, 21 Sep 2026 06:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789997970; x=1790602770; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=QeVFpmVNOfi2U/v+3BOuW+Oq4Wmck9sPJMJXQPxeD3X0HOPRUlDLaTFqOJMqtC/Cwl
         YgY04Kfo+CX41ruDq05DZVY5SKOKHEsUWk2ej8tkpNKfuJ0PbV+4ZbiCoQlodYtgR4KX
         u6kUeCWGP6Xh3xh8dfN4I0aJWfpfr/77MUpS4Ly/UzoNP/T7iUvMq4l+GanEMf2UR5Pf
         DYoIj2Qy3WL536WD9+u9XNwctr9UK1W/EwwNJbCkxxFJc8N6YI3GxKzajFjTsfTZrFc2
         3xKCMbycUUaKmkZ3GnH4Mk3WJfMJxWFEvf0r4Mg88feEPkuuM6sGHZQs1JQJRFLht2+W
         8XtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789997970; x=1790602770;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=0ZzW8ffInceZFdyVHjpamK8Mc6l3YZp8T0NvtrwdtZY2wOIzfAimJ0uIEpeWmCaJ14
         Tl3x5ZBqMzsumsKFgGmEkLlrHmuKSvafsLMsareAh9MtzZDvwEGxb/TO2xjGVDJWGyFw
         4RStJv65smxTBMRWWzqoyfoXDA/fTl1mH4dIhVA/RH81Nc3BfG+OEeLzcyF7jLdG97bk
         HKsBW3OPW0ONGBCh9QrfYGKvVrkDNzScaJGiC6Tqd6YSPlBMRUfQKkhGxiOBhnEvLemV
         Ugp4mgnvcfI3TXmsAyCW5fWleCtuwkbRUcJ0LgVVJxgIyOcgYMAlkjVZnh3xiJsVXMVi
         CfXw==
X-Forwarded-Encrypted: i=1; AKwUvBzyQwky7aW/C+YjxMwhcDqXIVF5yW/YG3WmaBzfRjyQG1I9QRo7Ear47w4cDiJha57FTEsLjo+xLQ7Z@lists.infradead.org
X-Gm-Message-State: AFuF++lGEb76/7vPHmmA5833SffZJCzVGq/wwO8Z9lqmhyZu/q9Xv9xd
	QU67gFwkyrrPf1m0/MM5+yPHkJ6EZRr8zC9fELfNldJMnQe1PUcFnIc7
X-Gm-Gg: AYBFou2OdBJDoarDMZt7WMeL8OoSt2OJXhd8mqqPMDrFkUhuHzfnTutUTpIQJWwV8GB
	+D1or/Nn5CeulUvAjzQpBBnK/zEfXof0rQCHfLF+l5RtU2W/pEOnx0CbYBNjKOcvYSblZKZWUiC
	bEzQtsmronhDpc0vS4QEyz1zLFt4JXSorCZD4LEoonBpB55NHDmQYdd0th2aXgu+Ncb5wWgHaR6
	2D3rcdafuC/pKftzhU/jVE7fRHcifGEaw+Ds7+vA6S4wFJR9H4ANgv0wu9NIuFt5N2f5ZGG1z6S
	SvfW9aGw3SYXIYMW3tSrV/NynASK3sKk6AMly6KSFt5O4LO3jjznq9WbPnov/UAwu3VAYK4ayp9
	prn3b4461tgEsKXsdrxbuL/huitMmEDT9+lXvxyyIAjoAAZ2jQgzmiNdU0cWGgeCLkMoFJfCkKU
	YLBrxX1hnKEh35M3uFc5ceS6FvbR/3wWlite1C4MbZ2eDVrMdufoerT9CVH+bRsDRb3PlH80BwR
	cea/MnQC6NIg57nMhQmtWzABrQM3g5VruAI63zSEYJhwAq3m1lgt0pzvA5rWhG1iASS65SbeP7s
	nWgnrhbAtaQeoa2LdwuXrHBtzdo6DA==
X-Received: by 2002:a05:600c:c0c3:10b0:49e:823a:9dec with SMTP id 5b1f17b1804b1-49fc5a10b5fmr145292005e9.3.1789997970323;
        Mon, 21 Sep 2026 06:39:30 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 06:39:29 -0700 (PDT)
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
	Phil Cayton <phil.cayton@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Benjamin Marzinski <bmarzins@redhat.com>,
	dm-devel@lists.linux.dev
Subject: [PATCH v6 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Mon, 21 Sep 2026 14:38:47 +0100
Message-ID: <f3c6132b313e7bc6e237e1a16ae8750be5988a40.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_063932_249629_15C1D015 
X-CRM114-Status: GOOD (  15.41  )
X-Mailman-Approved-At: Mon, 21 Sep 2026 08:01:20 -0700
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


