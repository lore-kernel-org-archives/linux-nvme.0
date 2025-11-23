Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4A5CFD2F6
	for <linux-nvme@archiver.kernel.org>; Sun, 23 Nov 2025 22:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g6fykkTkHS7qppZkkxaQlxQiAfIqxjHL5zv+seY74S0=; b=3Jxt1VXuz0QfLnzlTIkN/eUKD8
	vySEgMhOKwpv24UP1UlLS7EjB/LmBQ/m4/rpgQGA76C0xsbIjgBx220/vENrYbg+PbB4QSB+JFqOZ
	9Wyu2k9zKUrUvuSAVa//ad+E4eNn6aSPG0/FlnLlmJ12ej9ahb/+/oketSUGvq8z2qMIy/zyP1ZXs
	CUrXz3yqSUSODxUtsEZjxWznzszYiJ4bHpun0FSiISpLuUk6seSNjeBYq7xwmlMBZZJvFG5U8M8ZI
	42Xsctwmz9Ar3Cz2LBQvZNRgx1l69V0RaRNj1M4aeGlEv9+nL/0CcgTq505WTV/X/FTTHHnuJ69Pm
	Th1IJejA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvv-0000000AkjK-40cO;
	Sun, 23 Nov 2025 22:51:51 +0000
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vNIvr-0000000Akgs-2XSw
	for linux-nvme@lists.infradead.org;
	Sun, 23 Nov 2025 22:51:48 +0000
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-42b31507ed8so3157896f8f.1
        for <linux-nvme@lists.infradead.org>; Sun, 23 Nov 2025 14:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763938306; x=1764543106; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g6fykkTkHS7qppZkkxaQlxQiAfIqxjHL5zv+seY74S0=;
        b=myzSNWhFDLBzBtu4BDdv7pof8jlLrwKGmXPg8zMd2Rx3QTCHtTT/bMzUQJPbjGO/Ty
         NpxGj0G4NJfLfNMwxzbHWdBVCfy75iIGNyjH9VrWFqSnl/HjMaQLN9eKg360BPGA3ODH
         fK5/q5wwH6YOjK557RNBkyV49o3S7PX3jJarzc3pTIDdkJheKlCTh6+JeyOcwGGPoQu0
         zVloFg40dgYNhifWUq2wQ2YfSGwPL4r+IH+s26Q/QH31DjSqW8qbjXIY5leGFy0xo4oE
         9qOKSxjmn9Q1Vma5JAGDaPjDzekpl+5Q3F1+tYyB+BiblfQqpH3l9JwEBNoLVoiLdDsF
         n3HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763938306; x=1764543106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g6fykkTkHS7qppZkkxaQlxQiAfIqxjHL5zv+seY74S0=;
        b=aicBV8lIACXpbvoA1Xz01aK4WCRC3fb5mcgdS6xQUUG8jElGn6he2Y6sRHM4AwSXyq
         IRlXd/6rIZMk+0h9FKC+DDbtSz2UGu6VaOxfynP+lSQzJJC7i4wh1BHIR61v9VpQm0re
         Zyq1qetvmPGu5E1SIP7hiBGqpsY3+CDZeqwDvubi35CKUDxkZZOYPa8SMIDs29bLRSE6
         y3fLo6WgUyaHx58dHItYkk8Bcz/WMOhApdAPg8xS7dCTDAU1riGlLeaPd1gqtFyy+LUj
         fmkpoLr+KVJxzvro/ACFY1aWE9ZkdX97S2OFDoLwBbAZDkYOht0MEBJtvWVcMWhHMD/I
         ekRw==
X-Forwarded-Encrypted: i=1; AJvYcCX8BFF9n8bOZF2V8cYQHPbC8jXMGTQ+Ln+7c1sti05/Mwx2w8v+9dVY8/mf7D1gup84qQwGjfyzXEc/@lists.infradead.org
X-Gm-Message-State: AOJu0YwC8VAPnSwzXJ95iTEa2uFTZ+rxPe0Y+LO3hc0BikscXckACCPA
	MohG0CgtHxtkjPTb7VhpiMUnu27i1NIN3jBQ87L/TB22ic97B8YJ5RxM
X-Gm-Gg: ASbGncutglWOXqjjeTeL51krQDu840xkvhS1ShYVOuSSJsWvS5dZNuwisExYJh2vkcZ
	1knYJo7l78vThMuJ6Mfi+GJa732d9Fn41imTQjtK6jOBVUUvaKwDhnrA3+JoC+nRIAQPrsiQSFG
	ciAxd/GQ1gQ7O96KtIp6Shl10D0WR0ktovt0YIiQzgc2enKbpy5on2tucUSsT1pHGmsn1XF/y2h
	S/SStUn3UJvpp9lItqEFj+Psk5buv0HjrgEGrWnz4NM8TTbFiJ/p18WJcdWrBV/Sp9ZI5ij9t45
	S9s2d65zqZ1ApgyEcgF9seueb9i0rfJWqSsHY35UIYXJ/NWRQItR8+YLOGwGF0c7T/uuInJ/qVb
	jRlLtzjQymcupoeCezZ9o6H1yU9zwqMltgcuoC4inyBZArcDqDWDOnYjMu/8/fC45rFp2z4lC6d
	SD9M4XlQZhiEygww==
X-Google-Smtp-Source: AGHT+IG6zETWdv1uNEXL1H7qlBK8rzCntcx0G5cI2YCnUx99f9VimwWWKVBIKAVqjQPLH9huSPPJwA==
X-Received: by 2002:a05:6000:1448:b0:429:d3e9:65b with SMTP id ffacd0b85a97d-42cc1d23c3emr9659226f8f.59.1763938305625;
        Sun, 23 Nov 2025 14:51:45 -0800 (PST)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm24849064f8f.33.2025.11.23.14.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 14:51:44 -0800 (PST)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org,
	io-uring@vger.kernel.org
Cc: Vishal Verma <vishal1.verma@intel.com>,
	tushar.gohad@intel.com,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: [RFC v2 03/11] block: move around bio flagging helpers
Date: Sun, 23 Nov 2025 22:51:23 +0000
Message-ID: <6cb3193d3249ab5ca54e8aecbfc24086db09b753.1763725387.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1763725387.git.asml.silence@gmail.com>
References: <cover.1763725387.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251123_145147_656429_8E571D8E 
X-CRM114-Status: GOOD (  10.61  )
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

We'll need bio_flagged() earlier in bio.h in the next patch, move it
together with all related helpers, and mark the bio_flagged()'s bio
argument as const.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 include/linux/bio.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/bio.h b/include/linux/bio.h
index ad2d57908c1c..c75a9b3672aa 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -46,6 +46,21 @@ static inline unsigned int bio_max_segs(unsigned int nr_segs)
 #define bio_data_dir(bio) \
 	(op_is_write(bio_op(bio)) ? WRITE : READ)
 
+static inline bool bio_flagged(const struct bio *bio, unsigned int bit)
+{
+	return bio->bi_flags & (1U << bit);
+}
+
+static inline void bio_set_flag(struct bio *bio, unsigned int bit)
+{
+	bio->bi_flags |= (1U << bit);
+}
+
+static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
+{
+	bio->bi_flags &= ~(1U << bit);
+}
+
 /*
  * Check whether this bio carries any data or not. A NULL bio is allowed.
  */
@@ -225,21 +240,6 @@ static inline void bio_cnt_set(struct bio *bio, unsigned int count)
 	atomic_set(&bio->__bi_cnt, count);
 }
 
-static inline bool bio_flagged(struct bio *bio, unsigned int bit)
-{
-	return bio->bi_flags & (1U << bit);
-}
-
-static inline void bio_set_flag(struct bio *bio, unsigned int bit)
-{
-	bio->bi_flags |= (1U << bit);
-}
-
-static inline void bio_clear_flag(struct bio *bio, unsigned int bit)
-{
-	bio->bi_flags &= ~(1U << bit);
-}
-
 static inline struct bio_vec *bio_first_bvec_all(struct bio *bio)
 {
 	WARN_ON_ONCE(bio_flagged(bio, BIO_CLONED));
-- 
2.52.0


