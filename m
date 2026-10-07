Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C75ECA601E
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=; b=SOPdCBTunTPncmqObb1Poe4EBq
	JMYLnbxkn3WT3ndAwFhjbm7t5ZNnyVXlMniQM3u1ucYVs+V+cYmn4GBGD4i/linkRVfQcLzr0l2ql
	c6RE718q4jF9FpGcFtwdYFRJIh17kaF4bdCQz4svB/542ih8uU/N5Ya1SAo3ZdOLEVH+9DM1UA7pS
	irsz0BAeFoFOYW9XWi+nwbn4zzv5AaF5IuZcCg7U2IbGyMaB+oOqRyIE2ohmste8DFboQ8RV0Qq4l
	SaKLm7fKX3iItVO3uY++KT3jfbMPuTGCTOVTwLueHNLGukjeqKH8ls4xNbYqgU/I6D5HPNPwnrmPI
	hE71wfXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtp-00000006hoc-0RbK;
	Fri, 09 Oct 2026 16:56:49 +0000
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGgd-00000001cD9-1QFc
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:43:18 +0000
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4998b5a63e2so33268745e9.1
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791337394; x=1791942194; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=Tr2hRfNQ6srZFljU0NeaNsuE9OWFzdvMQ+f8Eln1oV4ZL0oEVtQ57Eup+0YRjShlD9
         i+MXymtPKsqx5om1YSBCrnwY1EvMtwIhW+hJgVDa4FoZCBmE7qJzxiBWjOeY4OXLs2A4
         Jih+F1KthJF4vGAmopLZLoq9iTeojIlrTOg/E+tfKo57shc+zdbHTnL1Jocpq9QSKSfQ
         /jpH+HWUDolsO+OzKakhsr0522pfmohg5rieFOEpzA2dTOaNPNaFMLD0IOOLisW8vqL1
         Vor87cDwvcCaSUfnS5F4jK7OL4nwhhbj4g4PlhrPBifSCLK+VPI+oxJpv1EsawmzGbgM
         oe4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791337394; x=1791942194;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=WVjwhIj2exZ4awhQoy8WyEzKdRXVQqa6fyd9Cz8uSxeMWJyOoPNVBZqtdAVYhWVGQ3
         tv0GYBCrpVRTeV06EhZeR70ZIuBt/JyKUm3macXyBsS0nOPMom0PcfnUydKYYTbHz/jx
         ZC/82UAKrYbwqD4rP390kjZDzbXu4ZIlbVhveKXP0GznKGL1ASaqDbev64Veio/CibGw
         o6ubD5OkCcSrU587VM+cuF7O+yiuJDd5mujQAkwu+QVT3MwPw/4vaF/EA+QLdhQbB4TZ
         F1jgPt0upTGs1+wdil0mUsiIivMX7yAj5thSOoDV3w5iipZi7fD02gHYHkFPElzn5mze
         7Xrg==
X-Forwarded-Encrypted: i=1; AKwUvBwjFCu2kOtsT4lKCpj9QdJYcfffiva6dzW5m8npU+paU3Y+tkSDtse84m9KkWBAbI5KFWPcEPs1xWZO@lists.infradead.org
X-Gm-Message-State: AFuF++n+pIgojYZZmMDRpXNN9tJOwgpj/c8SS26MBbBlLgIOw99q2OX6
	IOX18wKAe8geRILBTWC43DZdw3Xl3+0RYz/fuA76bTcgsm3MApnFYqOS
X-Gm-Gg: AYBFou2FVcsaYcZiPThi7g+biVOJLxCiNu2a0577kZf9LHcd4aCB+tTuNHPzfwPLO7R
	4kigPXV9T7X2cKZ+xPlPKSdspTH6tlCN7zdn37YD9lWmcmB2k39Il3y04Q+hm6ic/r67GAiGUzu
	+K9g0hZ4d07ZFEKTSj24gP09Q8+FKN42J9Y14i2a+ezBK0rdHlh1hRXjgR7gA49r71XDlxemDKB
	B/s331UVgJq0KnZ82VCRmMM4OwfU8DKzCXi9eqWrZz/V6nhCaEGNGgsMx9xPSfXXN67O75b/l45
	5tEnmKjkMQv4qq8UVXw4CPBTT0BqoZM5sc2JiAvfsUR0EsubZHLrp8aMr8IpH2zUZwjWx5DgkrG
	wL5L7hOY9qFn4WqVpiF/G8c0CUTOQ5zXA55jk3MMf5BDmppnaiHlSfPZMDLL5LE4I1UkOE4wovj
	qcyQzmDjUJzMW9oVZAs1W3QHQ1zooUSoOp4Mz0XMSGIn5X0PtgcwwNZrZY2A8cb57l3s0bpachM
	dG/h/qf8pAH+hBDHpc+cSa8bC+keckV9hmw2hBEWDnUuEQcilS0JXXBwFQDRjEWGtPGJHuM6J6K
	WsjsYStOEf0=
X-Received: by 2002:a05:600c:6097:b0:4a0:1f90:594b with SMTP id 5b1f17b1804b1-4a18064cf5bmr6446075e9.22.1791337393761;
        Tue, 06 Oct 2026 18:43:13 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:43:13 -0700 (PDT)
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
Subject: [PATCH v9 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Wed,  7 Oct 2026 02:42:46 +0100
Message-ID: <beec7303891dac21cd620d2a47842f843b391192.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_184317_774978_3026423F 
X-CRM114-Status: GOOD (  15.65  )
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


