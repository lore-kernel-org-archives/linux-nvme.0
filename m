Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC0BCA9EC1
	for <linux-nvme@archiver.kernel.org>; Fri,  9 Oct 2026 16:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=; b=QoDgUOq0LVdMJpM2A8GY67eBzQ
	lJEv44QcwHrQhi3miuDaxjMteRGLa0rak3WmWzHryqmvXrTCX3hv8Oot4fLgWnBq7fp3j8teYDYqA
	/A8CvoNpQHu223ty+pbsICwx+YrTwjIYueMLzl+3m8Rf+4iIUfUCGEKPnmI7VLaMq3MyXvhUF3D9H
	oxl8o/ZH6AH+jfmbUUepqprpfTGfvSb9iIP7J2vAVeQUUxl3dzRm/OcmELkr5rwNXPy29qVdTroSA
	q7VxfV5FVsqJoUalIXpHi62PHmmD1aEMpafhaCaaKlcVfgX2FmGi5Hkz6DtwxPVwPkbSbCz4JOVtw
	++Za0MWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xFDtc-00000006hVU-1Zlp;
	Fri, 09 Oct 2026 16:56:36 +0000
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xEGW0-00000001arm-0829
	for linux-nvme@lists.infradead.org;
	Wed, 07 Oct 2026 01:32:17 +0000
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso15398985e9.0
        for <linux-nvme@lists.infradead.org>; Tue, 06 Oct 2026 18:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791336734; x=1791941534; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=FUzVnADuQF9n9yFf+W7MCtMBQ7epl8bQ0+ATJiv7PRDte7vCZCOEY14kk0s2MJOPZF
         0zZGIQqeTmz959hY9OjU9mDBTViFCzdXYVJRSNCqp/61hRNtjr/JaE7/FdmbffVoFwSh
         lhJSHLZGGXWumQVGKXZ2RHH5+d/RA1bSSgWx5l67LpchdWYvygb2MvIE84+QURb9NoTr
         e7tBkAtFSoR6ldrfBmv05umUvvtxCJJ75Xl+clJnQOd61s0U5/NLnwVrZlHm25Ywlnie
         hHIig11kAIHbxmWHszlVCDkLwnOqaZjA1rJ3B9TubtobVRjthVP70TzsXLk2TY6xIpWx
         z6dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791336734; x=1791941534;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=ZKM3La7nucUTZsLbHq+jX2DOz9ccbWEqx55LMNBqGkfUEi/0RRtmHuJvJZokxj6qtE
         h1KoVRB88RDiMSfjP/kg/5HxJzKhg33ERx0Q7Drri8/ycGus5ekHyDMjq8Ybnk7g6Gop
         jUkk4DMokJsUVUlfMY3zHNomg0A1/hJXx4k/ZWXkrb8OjMYKhZhJDfZNMgvlKbZpniuW
         c0JzefxlPYSorHDltWJU22Fcx15SDO7DKCB9zg9CG41Jr6heXn6kd2QSEkwlT3LvcUSL
         hjOST1DtNEsh2inyFqEfVFofIyaIqQ49nWf1OCjPwz6jMKPedQRX74pB8rkq6Zff98we
         358w==
X-Forwarded-Encrypted: i=1; AKwUvBwDZcrcBF43FrPfZ6jygpajhPqNMmYQ36tVV4rxz9jT4JfCMkKZdA1Xjxd0GGZs4xGRaBRI9TnHspXx@lists.infradead.org
X-Gm-Message-State: AFuF++mg5wc3VROwPWOT9G3R6XlmzBEpTNkmovFc6DrPv3W0TY/h4Xm5
	XEhef2EraeYdN3PMz+L7iVLRY8PJseMnei52Eok18ndqB6ZClPuErPO+Wv48fQ==
X-Gm-Gg: AYBFou3gVlG0ewOL+lrcbPaddRyMPElqOVfLttVOUBcd6CU9/If+2fE0VSX3uRXwKik
	AJndBkhsGcrRhz2ZyBhBAS0oUvljlcddOBwlubvWBymQX3IP9VHHQqmEaTufWAdengkpLogq55I
	BzyFAFNG2EYPIpakTuKNJ5iEphXpwnb9CfEh6uMqXLnqknaSzaz6zdrQWfAkN1Fv/78l0mMI4cS
	PISAF9aPv2CQZDGsYkfJpuFBKE/HbyEsXBVbgb4/r5/qLbLHt/5u0IT0ElhhOX9TIw2ffOYQIlA
	aPZEu9xW00RqeKd2IY7XqmeQyvrvEN0ibQ8yM2qXNbL12hRsY0HFwsOhZMtHEODZ8N6UUgYbW/H
	eOkHHmbikKiOW1oLCM0oJXE3sjw50WjsnMlnWqTm07XYyvou1fQKs5vZ43Se0oUomnPx6BtFFXn
	aI1Q/xofAvsDzODW0AzEvM2icg2b7/bcoC0hAl5QxH/oMaMOhwIdZeEl8N/ZggAcgmZhCdbqfri
	Z3YfoABZpJlrULwirDIra5wqIJsSZBWCwY9wpcV5lASuJFPJwCHsospZwpulQ8dQmYhiNXBTG0b
	ODgfqxDY9d0=
X-Received: by 2002:a05:600c:810c:b0:49f:c5aa:9ef4 with SMTP id 5b1f17b1804b1-4a180422b6fmr8623225e9.8.1791336734141;
        Tue, 06 Oct 2026 18:32:14 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 18:32:13 -0700 (PDT)
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
Subject: [PATCH v8 01/13] block: always adjust bi_offset on bio_advance_iter
Date: Wed,  7 Oct 2026 02:31:44 +0100
Message-ID: <beec7303891dac21cd620d2a47842f843b391192.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261006_183216_094143_F3D7220C 
X-CRM114-Status: GOOD (  15.75  )
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


