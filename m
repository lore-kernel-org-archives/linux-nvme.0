Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 622DCD116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h7vHs8yXaPj8mv/GRmviioQ8omsZI2Wqns1LW2Ikl6c=; b=QpY3ujnaBI/pAoJfuL1WJtGUwV
	z961c5PItxjjQ6SH8aKnK2F+cMuB/1gU2pNsMtWS2pg5Vr/o9PaAm6L4t/zu3xLbGikeFCGhOIjyE
	1QmDM0uc7arZYTC0fJtEbww3LvDMZXLwNqxEmop8YIRy1HXgAHORClIWVV2UrwWgAuyqrxdtfFSoB
	4apZbrPrYU3bZswCKpW6pXTkxd8yn9/Bzh8cTb/34+j0YWlOse/qF77jlrsnnuSw4lgnybyMWTvmI
	j6bF+8Sf9AnR57nhqA1aGo1N8K09YA1wB9Gf4ainf22tKw8/xyBYQ/peVilRcwN1nHBWQvmuU4VR+
	4Lk9MX+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtun-000000009ZB-3JyD;
	Fri, 28 Nov 2025 08:33:17 +0000
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuk-000000009WX-2nEo
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:33:16 +0000
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-297e982506fso21631205ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318794; x=1764923594; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7vHs8yXaPj8mv/GRmviioQ8omsZI2Wqns1LW2Ikl6c=;
        b=HKpgOFRAhZ1kdbEwljWimJwj5riATVfq0cZtADoSTN/m0dOzhrr91d7ZBEVag0t8ab
         e1DD4EuymeVXAm8cEvEaxbRaZknftg7SseyNowmcxNekpm0U09ZfReg3QuosxkTxLi0d
         YwtaXsNgogFOSxVoKVWCHzQLH+3/CtW3nXPmkm/Z9bnk1wN4wNj+/wzWX2Toh0/kOT/e
         L+22QdX7WR2L259pq3BgmIT5upDOPsodjA18Ng39jk2EdTo+b6xu7rbwWeCj1zNamgoo
         brYD79LqmpBMyX3KR3uoKLVErlmVg8hCst6bruDG7UTv4KKhCVY91YEucP6AdjjnAlDx
         ztiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318794; x=1764923594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=h7vHs8yXaPj8mv/GRmviioQ8omsZI2Wqns1LW2Ikl6c=;
        b=aYYEpPxMFTkox4rrAbyDB2+D9lcPFN6AcckrtRlAT3mYwwX8ZtYCPUAZYG9qxk9zNJ
         WBwyECL28QGb+S0NMoXvoWmCh5FV3FPkrNvumG2mZWGz+Fo/BcXVoJIVUQb5tvaoubCw
         wm5YpRxO6PIbsAXOZ4tdSmSH05WS/UMk94lTBzeTXYjMbIyqfV0LhaEOtJOTYiNDn9h9
         l4YnTJSwxzp4f7lobTQg6SwdsS7P+vz/EJ07kuitJ/YMsfu88tq3xVKt15oayb722xKV
         f/18K3l0DjtAD08ys/SFE9D2GWlVmjK7nQFOoqAAzqyiXqGSlbg2+uFxZT9Cs2Idqouw
         6EgA==
X-Forwarded-Encrypted: i=1; AJvYcCWLWdc0YB0f2sxe6OW6ZNoSwQn+ZaBEWGQg/lIfmh+d/lzjatkXAsGds5BJGN+d7RKTo/3n9Jr3QN2i@lists.infradead.org
X-Gm-Message-State: AOJu0Yz+qvMFRt1L5qR1UkxDxvldCKcLUWd2YMwio0PlZPYpHnf/W6xS
	B0h13jt0CWhDnVJffbUFW2BtXrHC+lgCIEfOKgSuz+3fNqMnzRLF2nyq
X-Gm-Gg: ASbGncui4fRZgMxykUgaqHLV0pVGvDf129D9Lgm7MkPosZLq2zCl3QvP31sVzxtlFSW
	mLUA9+GIwyO83inV97yxyhukFK9FQ4rRSvdlYlF97wMYdcmWdG/GHQNsPRsRaFT7DA7upibs+7/
	Pl4HYe6KV5v2IUN0fT0SstUpR3v07et/cFWLDDqvrR3PaQMLyKQPWvGxDP1i4VfsqsoYBO/U/OJ
	zLxN6lH1N/FnM7rVklUvcwp0x8TEe7uLPXhUJNLExDtNncbZQTkbMz/NcLT2NkZZm5fimT9QHwn
	01It9+rcBsKzOExSynC10AmousNOHaf3VIM8o0JhPj9XD219HlSruER1ltWTsJVX9McfiKCjsWv
	HKngPACfVW25g4HG9G1R2j+9E8ve2Y+QevCyl/erxVrz4U2xngrfYQ5PMcYdwULzJCMtN6hHrrT
	HS+8mPp7WWb6mSOwalAqB4TZlf2w==
X-Google-Smtp-Source: AGHT+IGKjtGYvF0Bq9aksrL28VuK/U2PkCtZPwPR3BXXqxprAsbvk/b9CT8/yxSPTU2xDb2fwzHbRg==
X-Received: by 2002:a05:7022:41:b0:11b:b1ce:277a with SMTP id a92af1059eb24-11c9d8482b1mr15434117c88.28.1764318793604;
        Fri, 28 Nov 2025 00:33:13 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:13 -0800 (PST)
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
Subject: [PATCH v2 07/12] xfs: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:14 +0800
Message-Id: <20251128083219.2332407-8-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003315_017019_2F4234A7 
X-CRM114-Status: GOOD (  10.20  )
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
 fs/xfs/xfs_bio_io.c | 3 +--
 fs/xfs/xfs_buf.c    | 3 +--
 fs/xfs/xfs_log.c    | 3 +--
 3 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/xfs/xfs_bio_io.c b/fs/xfs/xfs_bio_io.c
index 2a736d10eaf..4a6577b0789 100644
--- a/fs/xfs/xfs_bio_io.c
+++ b/fs/xfs/xfs_bio_io.c
@@ -38,8 +38,7 @@ xfs_rw_bdev(
 					bio_max_vecs(count - done),
 					prev->bi_opf, GFP_KERNEL);
 			bio->bi_iter.bi_sector = bio_end_sector(prev);
-			bio_chain(prev, bio);
-			submit_bio(prev);
+			bio_chain_and_submit(prev, bio);
 		}
 		done += added;
 	} while (done < count);
diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index 773d959965d..c26bd28edb4 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -1357,8 +1357,7 @@ xfs_buf_submit_bio(
 		split = bio_split(bio, bp->b_maps[map].bm_len, GFP_NOFS,
 				&fs_bio_set);
 		split->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
-		bio_chain(split, bio);
-		submit_bio(split);
+		bio_chain_and_submit(split, bio);
 	}
 	bio->bi_iter.bi_sector = bp->b_maps[map].bm_bn;
 	submit_bio(bio);
diff --git a/fs/xfs/xfs_log.c b/fs/xfs/xfs_log.c
index 603e85c1ab4..f4c9ad1d148 100644
--- a/fs/xfs/xfs_log.c
+++ b/fs/xfs/xfs_log.c
@@ -1687,8 +1687,7 @@ xlog_write_iclog(
 
 		split = bio_split(&iclog->ic_bio, log->l_logBBsize - bno,
 				  GFP_NOIO, &fs_bio_set);
-		bio_chain(split, &iclog->ic_bio);
-		submit_bio(split);
+		bio_chain_and_submit(split, &iclog->ic_bio);
 
 		/* restart at logical offset zero for the remainder */
 		iclog->ic_bio.bi_iter.bi_sector = log->l_logBBstart;
-- 
2.34.1


