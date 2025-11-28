Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39586D116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fqwLZMa4ASc5Rs++C65X8rlK3EmN43I2MLDa5i9050U=; b=dZV4bCs+qCw4a+eLLAesTeGZCF
	PvseDZGf54eJCr9dS/XCrTNgCZh0Jt6wmmQnQFl1Pwkul5yjBl49KNi0NSVnavrcKdNIqh1bffe5+
	jnAgfJ0jGODoaAB78xRf+6Xp+RwcZb+rcYeMeM4baMrnIMSEKaPtjyhfSKQQ8pUix4Q5XjvXLAKMV
	bdeoiu/LbcZts+xcfNjNzqDn9ybn8JhZA0Zdz2tAgLEBDeS3ZclMMINbxncCYpbB4HFtOLc4xObyo
	Mx3zqGsnbyyO5pcN1ttLcnL6UJ/OBrVtUUapC8YcOOJC2EicOi8C8qmGjv6fCF4VKTjIji0WmBByM
	QIZt7krg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuw-000000009gv-29gX;
	Fri, 28 Nov 2025 08:33:26 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuu-000000009e7-065G
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:33:25 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7b9215e55e6so1091879b3a.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318803; x=1764923603; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqwLZMa4ASc5Rs++C65X8rlK3EmN43I2MLDa5i9050U=;
        b=Ta7C6WQ2y3uIRiUK3Ok5at4frR4q0eTjJgIDcY6iyo4XfmyoYGIxWoakd8/nxLeBro
         +3bXXS8hNYw+5pQ3StH1jsMhu8Dlo9+IkUI4YGAVSoEsb/sieNQWzg57c69S1D/8Kqag
         WJGS875ExbUjn+39P4ahVNWlc1jdnnXu6Axu5VX8Fvip3ZEFkYtjJKW7HxzgguhF2pWq
         gwxT5rq7dkOIIh7taILOSDyQYbV5qzn+sgK6k2pZ3pcjjkzxJE1t/YXKucmAWBKp5+AP
         0r5609QkMEmpfjcTYlzcAEWuRadbVaETFhCGkSob7R42FlJ2JXJ292jwyRc9FRGUt8pi
         UT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318803; x=1764923603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fqwLZMa4ASc5Rs++C65X8rlK3EmN43I2MLDa5i9050U=;
        b=aGt9jqio6dvkSkyMLkttcL20Yt8bgwhbNCvK/MFG78WQeMIeGuIIoCLgB2dy8aVDZw
         yc6VypNvRWZ4WV40W5VX2L3PwZPoE6QVX1ZK+XTwR+35UUMx5xJTHNzR7I+R/mjBrgtW
         eHRmrLWfOsjtslzI5Mii/2okKSi0SSqTWa7/jadzaGbHeOQKo8nLyDbOx/fwkUVXnyiJ
         cXdbozSrdMpaut2oyz1h1sptc3RzTZdaO/b9L3/OeYrJtSgeOvu9kCK28nru60K3Fyb1
         kLWym+KP1K/CJZOSkBrXnC0XWHGN5szYGue9r8kit9YILo6f1LBaBFqbPEEUI9cUc+8P
         Y9rg==
X-Forwarded-Encrypted: i=1; AJvYcCWs7JSfmv7jdbXj+hrXieYyoP4KefRZsY8InEep8LA9ZuuvbOTE2lsWX/IeXrQzYG9PLRaQd0xeG20h@lists.infradead.org
X-Gm-Message-State: AOJu0YyIN3J/us9YzIyCV4SG+l06wWDvN8fRswNdzN+wBZHmaJ0MIYVD
	nHx+udlJf3Ij1/UNRoBP/KzhW1C956SkZfb1z6/HkfBcdSJXQ3wR1VDN
X-Gm-Gg: ASbGncs1XuttDQGcjL0LYL0w/DyVSjNgueDqCliKU0mju4FDn5vnGOmGo+fyWgfvhwB
	IEKxhvbWdlYrbYsRP35Gt0U1Tn89ySK2Df8m9XbULVp9WzspohxjnBOHU0uf1VfgV8KIm/T8MZt
	XFks1WdxFZXxBg86rttL9iHKY5KXOrTg1nVbOXJBe6kb5HqwPn2/bUssTTkuMbQHNhQmRq10jCs
	FpQH4znj7nPLOJ2zCYbP4Qe78nv6VqsB6+ye/adXonTWX7cMTFRNvmSysth5aZ2eU6v8GHWHNC1
	VD4dRkrsOYITwKnhQwaXgfYF/gu2aysnubtHn/BdmUqPUfaOw3rhPFKYUUViyVCOQmKsT4+/QJz
	Qw6FwALSTv8+lDLGfDWM8ISRKoN7YPmtstdKqVXhoHAp0Com2mGg32WUBb936PucIFGvO/5V4Ik
	OB40gTr0tigXkatb8JUQiRAfUxpQ==
X-Google-Smtp-Source: AGHT+IHfWqQfXtBplCGUlpvV4df9l3L0Dj70ayVkP4asUXlu5VvYmL6fwPY6gq5t6aD4a2b+6FhgOg==
X-Received: by 2002:a05:7022:2487:b0:119:e56b:98a1 with SMTP id a92af1059eb24-11cb3ecc3f2mr9865235c88.8.1764318803303;
        Fri, 28 Nov 2025 00:33:23 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:23 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: Johannes.Thumshirn@wdc.com,
	hch@infradead.org,
	gruenba@redhat.com,
	ming.lei@redhat.com,
	siangkao@linux.alibaba.com
Cc: linux-block@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH v2 09/12] fs/ntfs3: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:16 +0800
Message-Id: <20251128083219.2332407-10-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003324_091666_7B19F3B4 
X-CRM114-Status: UNSURE (   9.19  )
X-CRM114-Notice: Please train this message.
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

From: Shida Zhang <zhangshida@kylinos.cn>

Replace duplicate bio chaining logic with the common
bio_chain_and_submit helper function.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 fs/ntfs3/fsntfs.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/fsntfs.c b/fs/ntfs3/fsntfs.c
index c7a2f191254..35685ee4ed2 100644
--- a/fs/ntfs3/fsntfs.c
+++ b/fs/ntfs3/fsntfs.c
@@ -1514,11 +1514,7 @@ int ntfs_bio_pages(struct ntfs_sb_info *sbi, const struct runs_tree *run,
 		len = ((u64)clen << cluster_bits) - off;
 new_bio:
 		new = bio_alloc(bdev, nr_pages - page_idx, op, GFP_NOFS);
-		if (bio) {
-			bio_chain(bio, new);
-			submit_bio(bio);
-		}
-		bio = new;
+		bio = bio_chain_and_submit(bio, new);
 		bio->bi_iter.bi_sector = lbo >> 9;
 
 		while (len) {
@@ -1611,11 +1607,7 @@ int ntfs_bio_fill_1(struct ntfs_sb_info *sbi, const struct runs_tree *run)
 		len = (u64)clen << cluster_bits;
 new_bio:
 		new = bio_alloc(bdev, BIO_MAX_VECS, REQ_OP_WRITE, GFP_NOFS);
-		if (bio) {
-			bio_chain(bio, new);
-			submit_bio(bio);
-		}
-		bio = new;
+		bio = bio_chain_and_submit(bio, new);
 		bio->bi_iter.bi_sector = lbo >> 9;
 
 		for (;;) {
-- 
2.34.1


