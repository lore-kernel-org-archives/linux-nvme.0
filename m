Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C8FACA5FB5
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Sep 2026 08:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OcUXv3wgMOdU2Q5PfJeVzuf4KJvyhVvGu/xuChutEvA=; b=iUD1q00imgXJbNa//T4Z/jwY/B
	Z8mHgvz460FWWzRVPbTdvBqvQzmFUH625L3TmJo8V+x/0oTN7DoJjZmS0jnn8pQERKecRTgMNH9Oh
	mJiqibvy01hg5f3WomZnFr1SMeoVxJ1J904kbr/dxvqPuGuk+9WYabsCG+L0e/PmgE/tF3UHP1JMt
	fi2XbtJsNGwSXFvdJQ2+9OAr9grtLf80hb1vMM3Ykt6Yfq9TRLHjqQ3hlwXgHGgTCAhTpViHQy0fu
	GmYFH+GNGtXbjrrxdgXyGuzbqfJXnrQJHMk2X0JRe/1XPi82zqfPwu9t/0B39ffTm2DnC9RefA7cC
	aPNg8x6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBT7b-00000002jK0-2wsb;
	Tue, 29 Sep 2026 08:23:31 +0000
Received: from mail-wr2-x10.google.com ([2a00:1450:4864:30::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xBBTN-00000000fC3-4AsV
	for linux-nvme@lists.infradead.org;
	Mon, 28 Sep 2026 13:32:51 +0000
Received: by mail-wr2-x10.google.com with SMTP id ffacd0b85a97d-486e1a044c5so2569495f8f.3
        for <linux-nvme@lists.infradead.org>; Mon, 28 Sep 2026 06:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602368; x=1791207168; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OcUXv3wgMOdU2Q5PfJeVzuf4KJvyhVvGu/xuChutEvA=;
        b=e2uY0JSxWU/ZEMbzrhu1xNjH0COd60yas7cNPzIcAKkFUqm/RLOeJZRKAMMEkG9yOz
         +cm24AJzsiKzLrFUpfz/1ROjPXY4FHzarAXBU1+MERwfLR91aMlu16Qa3ZKPuoqj/E9x
         NsmIQQe9mfLhugXJACuSfr6kpH9jQrnnhuk/kHX2c6NCZS+Y22VzOXYOZiO5lTVwAAkr
         TsgzFucWwW6I1KrgwQ82DBNB9TDz23Dz0f8Tr6f0OqyAfLoWgj++Ppt6KE2G9WTubcbF
         /MddgnQaxZ8VAYbYFhH947RuyybT/ZSgRQIarLGhdoKjIgbYMlfFHXaxiCBEL7R2r7By
         D5DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602368; x=1791207168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OcUXv3wgMOdU2Q5PfJeVzuf4KJvyhVvGu/xuChutEvA=;
        b=v6Zf3gx4953BEg7vrerUP/TtDS1lKM6ediFLP0SyaJA8K0kuVI8V/IPQN1p8zfuneC
         Q/ovLJY+Vo0NGcuVEccex9IQUdd9EViEGBqgtfcyGUoddEH+v6czASzmUkT55XJZi+1L
         YRJrurQvGzX4IkCx94At88vmF3LtMXZRB6j0xjLNT+SKMIDYLVUQDuVx2UMRcoAtJ92+
         E5VNeb20C+14MwX7tAmiEknxaFJgZicrV9Ae4Lilmoqszm4yys8xQ4Ul3CHkGGGmLnTY
         CdyrzKs5tLV7YizLFZfvz5D7Vdc3lU1/HCJ3tONJ5S2jHHcCS9qwNwk+7qmKmzIakpiN
         evlw==
X-Forwarded-Encrypted: i=1; AKwUvBzfjE8XDAGZ5NrrvUoNah9z8yGgGibV6CezrKqdUPmH29x8dg/E79BahoX37DSMPUIu/+Tk5GTyaY+/@lists.infradead.org
X-Gm-Message-State: AFq9FYKvTJL1gPkedOUX22ZfiJKbROf4Y60oLpASzR41Y/kuWao389bs
	+q3jMR7TvKOOA7y77eS4MuEYGzF71EzDzukBHOzYrl0kTxj8HYzHUuaK
X-Gm-Gg: AYBFou1z0o6uWfKzc0/AjuLLr3aBcXP2Kt3Q6pmUYHYVBHvxMft2QDV8KLVEpceQ++9
	W1bNhLYC9SR/O2p6XXo98DlmGbH8+JJ1vBS3fj/9hGNFTbJblQ44e7SH5RxoMCd0d7CfUuVbuxS
	OxhwggMbhar79Kqtk9b7Zse1foiSCYCgCWeU38dAz6BZsKf+AFtMLyZ1HMfUwp7kMov30IyeuFb
	6P8+zxvBSAyPrjWLK1u8oXXZWb3tMLwxpknLv8fgWcgxLWjInton13v+amW4fYMuzHL4REPFpLX
	6Zq5PPZpJhDudORF4y4rlReUNV8FYFwKL2TD1bxNtdT/orx9zJEWoPEDm2D2X7rtBtw0GELiGRq
	8fSV0S3s1sRUl+OsS+yDYWvgBkR3/AA3MIiFd8PivT2+87HwwrSwxe8UcWwU/zbLmRz67Qi6B4t
	6AsP3BOQBDPrLba8kkMbDn4n9NduTwbWWO/dpkrZ1cCJwNRrHhDH4t11f60Os+b8PaszGW8wXLS
	xYly1F3cNSQs7eAhtwImokpioaXIlvWERp+AmcAnRyPvG7yK0KoIjDfGiVGDg==
X-Received: by 2002:adf:e19c:0:b0:487:11c3:b004 with SMTP id ffacd0b85a97d-488719760c4mr23422853f8f.52.1790602368298;
        Mon, 28 Sep 2026 06:32:48 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:32:47 -0700 (PDT)
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
Subject: [PATCH v7 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Mon, 28 Sep 2026 14:32:19 +0100
Message-ID: <39b4cb178513b33726c8d2ee0824f7324e84828e.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260928_063250_053510_1BE5538E 
X-CRM114-Status: GOOD (  15.57  )
X-Mailman-Approved-At: Tue, 29 Sep 2026 01:23:30 -0700
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
index 75f8086351c0..10ece05cbf43 100644
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


