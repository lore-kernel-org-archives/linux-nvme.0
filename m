Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA9FCC6B3A
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Oct 2026 15:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=; b=FtKMbHcXhETDvYGxFt/Gf0YZ0c
	forjZ0ivETDUGw+IqnqF32S1pB7E0CTB1zDecD4Lo13wvus5OCILumYdlgdIk6z2Z/AL3PR1VH9Aq
	z0AFb26Zxbd0jgLSx1PceZhwaJNZ5lMvZnANhM64BGbwOkBrlpedPhTsM2jIzY66x4EvoDpN04hP8
	AbXabDUrTq0DXJwd+XOxocdY37JUZsEc8OpbBaXvBEnExOAlceMt465LABqSPtV54xbgnph7zId0T
	QMK0jdO94R6QQ+2mBy1sbhIw1tnAfxZS5glv/uudEEarrfOE+skweBvuoBDzZY72FqA4qIUZnJ1Nm
	k8DURhDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xHMyB-00000000TrH-0PWi;
	Thu, 15 Oct 2026 15:02:11 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGwke-0000000FH2U-3n3N
	for linux-nvme@bombadil.infradead.org;
	Wed, 14 Oct 2026 11:02:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=; b=S1L6TJXkPMoWSqdhVmEugPOijf
	ESIP4XU8g3L5oL/drJkpzFVfvZJ2+Cy6+FQ49OKweS85joZQnPHOBS5NwaEmV01PHnlOmMNqS/yXz
	nNAtDCKuIaTzf15qcmt160eghlrlO+hQyFPrnDHFAprcZBMBfo7TYUIeboMyGohIqpKcZGXBy8mEd
	lWg0+ZHT6mUT7fc2NrDibfP32frLUYctRP4mdSxpL12tEX1FNskbaheQNqobT48AaxCJBmhP7dorp
	gxeAcsEJcR23pd0uMRjPkTxwQa0wR1oi1z18oF/MEewwTg1bNZF98b+Ri8DVsYlSm8NQxCw//G9wG
	W8rDzADA==;
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
	by desiato.infradead.org with esmtps (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xGwkc-0000000Gf1i-0DrX
	for linux-nvme@lists.infradead.org;
	Wed, 14 Oct 2026 11:02:27 +0000
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4a16af2a232so31348615e9.1
        for <linux-nvme@lists.infradead.org>; Wed, 14 Oct 2026 04:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791975744; x=1792580544; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=TONCTg/hpf08XUWu5wX6mgoPoq7jV/oduG8jWeZbf+9HwzLnseENtY1+DhN2PwHEwQ
         g5vudqJak7UHA6Kt+iavYKYIEciN7mEImTah0p0FhAVtBrO4Ww2gE/SY99qpZpfZEfA7
         QQDG9zScryc1ygUfjbTUGUrj3jHrYff3BkeTnP1cuFkCRE1QbY/KbZOXZfLVvLVMtmjc
         7vS4i4ofe+Z5Vk+q+UdTlzbyLrGvTAhk1ZR18brZWmDvcQ3IQ+/8RzXxhUMlDq5wqm4v
         suWi7M+/d9h69Cnkqnc7zgQaJCjl9Y/h0cvbSPp6jdQw+9BIREo2X8V6VOBY2zcgdpj3
         6yIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791975744; x=1792580544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BooWm7URUcyrH2E2qkRWxlx7KQoz7GWFpr53v56Fl9k=;
        b=pbWUYFhUOJOUOwzjQnjM4v/nWlbo1Pi9+11rvXPH0qU8LoQZb9q2R9mRxc1uwlMDX/
         Qfu//kUO31VkUXxRn6qLgOtnyawXWkuKn9PrTwR5/0c2Ozyo+R6IVHbt/hNLqI1Bu3ro
         Z7K5htPj+AdCTvcTl/csy6VC/gPy6YfiBP/DeVk/9E32otPKgG2oNjURO7zRD5+TA8a3
         D52Km7iDUBg9A2HyH0jopCFtrHmHwmL3bGQosJAp6p4Ncz+9MtcOziHXpNlcUhB2PTI1
         +w+QYqfbT1WP673Spz7nAYGkVpqZLj4w4CBeq52NhpriX6recdMFlyzZQelV5uA/lqC3
         Tw2Q==
X-Forwarded-Encrypted: i=1; AKwUvBxIKkXath7omD69U0BmKrCIJC3cmxyrPvTIG0Xi7V1l4j9MFQevjNG+Pp9U7nCuY0ShimblorS5nY5u@lists.infradead.org
X-Gm-Message-State: AFq9FYKc/3zeIijToToDwiajKSvHlxDa4o3UsRB3LLquiqS98mj83iYF
	lw7KxDJq/QL57gfaRxSukargbQ/SG1WFRs234gSgSuQp291Flmcx0QYt
X-Gm-Gg: AYBFou1/ZnfAkcjIpnaSVxyywRvdcAABxCEB7HLXKCg/03iu3gl15KVfPTNITL3fE1K
	X7jWDh+fi//aPblXUTOi0vCl3TJWlhJvlUPcfaqjH7mjFWd8ExUF5jF54WUxsLKMQgtJtg23zt3
	Q5urW57fvYatQXZTrdKVXG/zYfTk1Onp52feKpah+ojlVrbHzElG7J3o+UZWqrcdIjv2CCkUSJv
	brAKUhRdu+ZVV6Tt4EGLKBgwpvw7SxmT6+n+US0UKhb19hIqqt3BtU1VUI8Wtb9OI55Hfg9oGLO
	MUt1/mup9rMN1WXnd5Ft2H3cdrskPvoyd7sQwyJb1NNGC1yzhuXLdaFwMWdtfd6P6nHBNeibEkZ
	zVGrAhEtRn29Al2So8SUw8CasmZDgnHrGkNaV1MzyElyyU72AU2qeFR1FrL1olikF3iOoc60x5H
	646pzOAzbuNZTfgO/DWx0PQRli8Ld1Z7rbcyR2yqYV1cPuIUYtE/MrDQVxuOixoUELgULXZfFtu
	56tOXssrRooCAO8O1PGNzrabATAfdfVRcID0/BH8/09hFQXIzR+s3ESTrGMfFzmHJTGhJauKf0G
	Zw==
X-Received: by 2002:a05:600c:a088:b0:4a0:333:253a with SMTP id 5b1f17b1804b1-4a18e49c331mr307406695e9.14.1791975744203;
        Wed, 14 Oct 2026 04:02:24 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 04:02:23 -0700 (PDT)
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
Subject: [PATCH v11 03/13] block: always adjust bi_offset on bio_advance_iter
Date: Wed, 14 Oct 2026 12:02:01 +0100
Message-ID: <8e5a67c2f84b6df99ff57a7b3bf7b289999e0468.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261014_120226_258269_80B787C2 
X-CRM114-Status: GOOD (  16.34  )
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


