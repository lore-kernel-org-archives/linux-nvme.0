Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8806CFA747
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I9uQUsysFrv2eFtHnu17b6ejhzRgB/BOqXyxbR99K8c=; b=wrse9VnezRy6+a0Cdhu/N6P0V9
	aRcCOwYhhXoYmW7Y3tvhTv2m0vr4jFtVR9jme8Rbv3IwHh2UZ6Cfyv56Zqn7mt3tqWYtwPimSe7VR
	FOEpoxIsLiIgPxRF57LcTwIcfwQFIKSH4yCQVBd78GuJUAO6ss/+mHTFXrEFhLKs/B0vsrYYQK8OW
	V+S6f5xBizsvy4LaNX3ZBhGOKAS7K28Ehdv3f4huD3E+UV+W1T5xpvX4DnecwP/RI23qmn79LzWxA
	wQpAklFutLsYzByXmAZufvaVGkCKgRRGQzmtmaG7NflWer+lgb/Tix3l55Sw4h3pXDNtHlAvisL5d
	IjxiZsFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLc-000000082Gk-0LXs;
	Fri, 21 Nov 2025 08:18:28 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLZ-000000082F6-2ZEv
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:26 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-11beb0a7bd6so2462008c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713105; x=1764317905; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I9uQUsysFrv2eFtHnu17b6ejhzRgB/BOqXyxbR99K8c=;
        b=MtTSuVgdnUJpEcuOmH7byd6PSlpu4IhiMsn0PUKfH1r3UZvXjuZ0FENhXOEqQG0Pga
         AWYgTrB/qFNhcu7MM5SeHYBzamrSmnNtSPSu3OW68G5h45i202hkg1mVhTNbJCmq1QXa
         AO3eBEEhpAPv62ENcaYsDpxvPHMrHsuuo7nnq309xBtxFabsOyF3j3SOcPLXce6ftTfc
         edfbKKYcY9mN+aq1vQDZwGf9J3MQ5V3lAT/FmOhAt2dd3KPWaGu1hBmIqHbV9a752nYZ
         g8it8FzENYOjE/mz+okOkasB96obx59lI4ZQxu15fYCdyXcDNNGIjNShbLJNDZCY+B8L
         su5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713105; x=1764317905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I9uQUsysFrv2eFtHnu17b6ejhzRgB/BOqXyxbR99K8c=;
        b=V/Ewz/OUBpTdgdhJaXmHFxUId0tSxVuU5xIOQj55+ijop05LAXJQVc9QY2Y0BI7yt2
         IIPvciJwLd0M5FlKfAtW12IH1bchTC17mPSjpI78A/jh+emk32/pPJ7vxnU1CzfyIOIf
         hp/o1ulkTNhDzI3pH6CTZsTl5kZDp4Y3bw4IpX1GCUxhZ+sNFKSckkZEGCtrgKKXgbyM
         wCP0oGMM7djC5Hwz5vSzFkyMJhGBNZsp0Fug6WDHmj6rFFlHmWVay2qxuHACbTnUHjC1
         CUD6KgpHu0dPgK2cFoCaHlg6U8Y1/B1MMBiHHCAsP73IK2Xl4YbgrxiEEKWcEnEqrxXn
         0cag==
X-Forwarded-Encrypted: i=1; AJvYcCWXGzTKaGD4TPSSeqURkD6S6/u6ugX2tepenYsxDW87z+ccAP1r7n91oE/gsGtyeBC36QOWuZIclFsK@lists.infradead.org
X-Gm-Message-State: AOJu0YwN8vY/tlW1BJqHK1vqsLhcA+PBZSSxuZTIVrvdexbeH/jivnBt
	pIvbVwOGDlVhOnBgkkR2EtcseGAa+MlfgPlQLDfFJ+zcF42y9UVF0IS/
X-Gm-Gg: ASbGncsDQ+BqDZsIg6ujH3vAz2pjrbh4VQU5JipXqstSXYgjB/71TRkbWQhFnQXGyWk
	GnyW55hYY8qiGPo9zuaQrFsRv843bmyvL6ODGsvVIlZIMkW5GIUgYJv2GPLBbyRxIzOnN68KsAp
	G18dD8xYF6r2w8XCe2hLg28mqihSc2gfqqX+EphxLQTnSuOgt85jy3gXF/auaOmwVbsMPZQp9oo
	B+YtEKRcChjwWIn6Tw+nKDkfFm4HN4Q008uePyXFOwviYnYgyXqTm+hlqk9Gl1kaLbVDc4mz0Ra
	2gSe9AmfQ1zMdAwAQ7Tmmhv+Dn/biDdSxNzq2vrtl05wsiqR3l7uxC6k1GQ1kQ7Wu1Cl76LDVBh
	p7/sIn8pYvdUqKQe5iNegB/MOnZiDatOJDUoLuCX2cqt6BeEhscPvVnrBl6+nF5efolKCGbtLJu
	ZqXf6dpy81ggA6HkSoaGdgStXtfg==
X-Google-Smtp-Source: AGHT+IHMz3ddZnRtvaJ/THHwP1wUMl1t1R0JBJZczRRfd42vINt7DVj8VsCW+6dMTczCFjZ0JXIsxw==
X-Received: by 2002:a05:7022:a93:b0:11b:a738:65b2 with SMTP id a92af1059eb24-11c94aefcabmr2003355c88.5.1763713104659;
        Fri, 21 Nov 2025 00:18:24 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:24 -0800 (PST)
From: zhangshida <starzhangzsd@gmail.com>
X-Google-Original-From: zhangshida <zhangshida@kylinos.cn>
To: linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	nvdimm@lists.linux.dev,
	virtualization@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	gfs2@lists.linux.dev,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org,
	zhangshida@kylinos.cn,
	starzhangzsd@gmail.com
Subject: [PATCH 6/9] fs/ntfs3: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:45 +0800
Message-Id: <20251121081748.1443507-7-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001825_649567_097D6CD1 
X-CRM114-Status: UNSURE (   9.53  )
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


