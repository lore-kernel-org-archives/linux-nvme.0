Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DF1C54F52
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Jul 2026 02:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9CVR7oFwap/NcOYCsrr92EnvOtaWQ9jX22O00IMi0SM=; b=jjKKWoSu0MQYtmzmxc3WM9zMo/
	wJWYbTbxTmC/aNnC+0Dj6GWbGShau8BL8bkxVFCLKF6pQAWcyvcNu7SWPKQcndKpEPWt1Ql6i2qSq
	VRTqUp3PN/Ulfvd6NO3hbr/5ls2Xs69lJIglFb8C8ZY38H57Aoc5p6suFYHgRIXLAfbhvZ/adKXGh
	Tfx8r1LZRBUlHGFaVmrXkJyBeAN2Yn6tT6c+xQQoM083olfY33JThkZRsmMs9Kg1YX7wbzIAqz5ET
	ORTxIejUTEySbh7e/dK0nuVlgAIwD6whxCha0na2BrqZDwI++1NYgBNt8KKlmGiZ8Ue0BXEWHBHob
	fgE2sfAA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wotqF-00000006fQh-2QMJ;
	Wed, 29 Jul 2026 02:16:19 +0000
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wopN2-00000006KJP-0CGh
	for linux-nvme@lists.infradead.org;
	Tue, 28 Jul 2026 21:29:53 +0000
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-47f707e5d75so224905f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 28 Jul 2026 14:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785274190; x=1785878990; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9CVR7oFwap/NcOYCsrr92EnvOtaWQ9jX22O00IMi0SM=;
        b=UEL1Evm7wBD4815cQl/a1h+IKHFa/kW3WRcf8pPfbz1Bvqi3w2weU7POoMemo99DWl
         1lEvtQBo/1HWkxNBghlxCMyYcjtQ9P/7fiOw2WWRlvL9fiPpq2ZOxTUjp1hddCIlhmbR
         bSe5LItE0aDCGr27z8PyUyy1tVrqigwsMtxmibAqiFgCkbSlXedqRhBREIfH3B+cADsg
         Uewqcsnmole+j+hBDOm0GARlz0jSxkvf2WYDAc9JOC/RUKrHmk1gV90/QxUaffDeS7JT
         TFXIrO6DDK8ASY7675neGbVhgeOKdivzfsTYY0Hxkh/T2gHoJXBrfClI06zSD3uCAkaT
         UiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785274190; x=1785878990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9CVR7oFwap/NcOYCsrr92EnvOtaWQ9jX22O00IMi0SM=;
        b=rm3e16PI2Linb3bKMx2JVeuqvucwBS5vRvpByzFaSkdEUQGKYNtOFhr0PZ4bWtjmGc
         +zcotujVOkLc0gH75KUGi5Wc3hrlOdtXW0tfdQEG7CFG54Llb39CItLc4nYE9+mucDnd
         EgUAkfbllj3TtQgyi85vZdLz8CwN4D4dqYxBKBYhBaRjVrrXTPYB3Ifg7jfq4T7r0yMq
         YG3kgmLz8wZOOjGJkhNfMu7Bg7wH52pi+j8IJVSaauqer0qGffEQqPZtMJnJ92vqOX30
         hbqgoOMZahshbp6zi6iDAncmVLPA0RYXBVp4buVP7ZTXLqNEWcQkLwAF7vibp3HuS1BI
         yKGg==
X-Forwarded-Encrypted: i=1; AHgh+RqibisyvhVLJ1wfHiE4ljXzvWQKCR1DSAh5/ELJxkuXOmmTsEJ0qzMTvBBv50+TLUH1qZgjfm6rtHmX@lists.infradead.org
X-Gm-Message-State: AOJu0YxmDV7editcdZPlJ/E0LAZClpZ4qrd19LpTKbJ0RMqRcvc3iSQs
	9q3lHv4K/rexgodyKODXkGZgpH7l9c3ZTlpelFU8iGMX3yZkTHzVfgw9
X-Gm-Gg: AR+sD13cp/NuO1QsEKd6l7efqvYUl5BS0me4SJOCfOuaWPKLB0eu9fYda1FQJY8tDB/
	zkVs7LyRDaQnRICBVS8yj3MGRObgbLAJ9j6TeT+yLClrJCN+LXt8P83yWWLwmKTMlDZP/72Rfnx
	rtVLax/Bx8buFJKe6huN11XYW5et4mvt5gkWGBRMU6TZkYWhQjQHx0fFkB+Dt4R0uClYhZsEPmH
	9yi5x4kBBSnh1ZzU+m/O/DJTHpUm1hsCXe0mlcPGQUG6v13teaiJhvfeWvMuO1JTnXmECpP3krP
	uEC5uGPq7Bng+NWhkVGo8XL6pE4Gv9k3J+4vfAM5EhOIhSe3B6C2CoPW+xsR93lnMG1PwJkMFfE
	q4kogru2AvME79heQvBcc4XwB05TYzWTCOYHmLpLaRZGpxpdw9akOnwCdwYe5yiITxgd8NUSDue
	E04R+lDfOlAzWbgS7HQe99XneGOcJvvsC+Jy1J505MLxg9WhZQO+rV06uoICNKCW1Z/RqebdNRx
	rQ+k/8n
X-Received: by 2002:a5d:584e:0:b0:47f:95ec:a49b with SMTP id ffacd0b85a97d-47fb1ea7d64mr4772853f8f.34.1785274190146;
        Tue, 28 Jul 2026 14:29:50 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 14:29:48 -0700 (PDT)
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
Subject: [PATCH v4 04/14] block: always adjust bi_offset on bio_advance_iter
Date: Tue, 28 Jul 2026 22:29:16 +0100
Message-ID: <8d4f786e3cb9ac6002bde5f3271dcb6d22c498b0.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260728_142952_107886_1F635A15 
X-CRM114-Status: GOOD (  15.22  )
X-Mailman-Approved-At: Tue, 28 Jul 2026 19:16:17 -0700
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
index 8f33f717b14f..dea9f567379d 100644
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


