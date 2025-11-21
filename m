Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB57BCFA747
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ti+pzdwk6nGkvRYiXxAYuzkkiit15aTQXXZIirIbYng=; b=oIWVhc7irYYCC4FipWOq/r8xkr
	+ShmI90jPxYRIs1jMAqMx+xjBDQlYeV1NM6IFKyIgRtvzqTClpoeO5SDE2ono61fq2hwmngLBTa5G
	dOnuORLT1cc9fTdc0HIOCfL19nfGCwz19g84RXxQSbMfFRdKyzps/wHzwrzzaEu1g3S7w0PV3lhu4
	KmE+Rvu743msbrQwAO9oXJVLywjCEhsHZq6dtvIG/GZvBx7YBA9cdM6upN7WgzMm/HdAxHXFVL1Yn
	4FzzKgozxFcx0g7kkcb3mKo7kfl9i/q8UdeTgINRg0Gd4jjs5WZpWVv29XL897AqeGpfmvxVb/vcm
	KVXSZp0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLV-000000082Bx-1o7o;
	Fri, 21 Nov 2025 08:18:21 +0000
Received: from mail-dl1-x122b.google.com ([2607:f8b0:4864:20::122b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLT-000000082AF-0wwk
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:20 +0000
Received: by mail-dl1-x122b.google.com with SMTP id a92af1059eb24-11b6bc976d6so2581269c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713098; x=1764317898; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ti+pzdwk6nGkvRYiXxAYuzkkiit15aTQXXZIirIbYng=;
        b=caIptxaCWloi0803x0sF6Nf00KH4H0tEgGogDU5zCeqj/31e5zo1mAPpft/zBHjg/B
         y3CTfNbnzG5nWUBtGyxhygI3kPB8SlF6nv+nwjg3gNDLzbxEQ8x409cyvfGcBLTBehj5
         WG7TEkoo/ez06vomMMVqld2L1MT0/2nWY63CzMVQDlzjLEvrmXNgk5cKlcUkq4fBwJFA
         RMzaCWVPz7z8h6emR7XiNoQO4trn/wbM8FBETlc/j9a6HrWDO5hIMEz5Q8Eo/x1E02wT
         qyk2j6w/UaczNmwQGpFAmZmAj461YLKdKvIOru/Jwxh73V7EDlCUhs+sI25d3N8AAjOZ
         TaEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713098; x=1764317898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ti+pzdwk6nGkvRYiXxAYuzkkiit15aTQXXZIirIbYng=;
        b=tqcxsk0635RKjHApjbFykwPXQyLnliWWGfgnpSMWL+vNjyjE8iKbPnEInRNTa2id1e
         n5vPXnXRxVbzTZlT3TT1mjYZnsfFrhZC1eDOfyvfHzteFOTEjK/A4SmGcXprFbmVqZ68
         LyRPdMa1eXU8DqNsXPwbW2hTbVmJk15Rde1zWWqEixN+grMKAiRkz+yb/dpCAA40JmjS
         hZ6ZC8nR+3Cop+1hJwiakPPb3uCOa8yptX83TNboZ2YEim+k1xgqOsNaJeJYA2JaEikU
         rUd5U6uCPqtt8Cmrceitff0qb1O3R1ncoAhVvoqfIcF2k1wWS1mw8craDyVfzD5RaN7P
         PKrA==
X-Forwarded-Encrypted: i=1; AJvYcCW5Jm+hUiLr/p1G15bjO1gLsB4saW0umIfvK2OkCmNoXtt3bKJMvPH6RZRZPCcgTM3qVUuK2n+2RfMD@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0Gub6qTHVqZ+rHbzcFVmsz8yuwfqeSm1GYa15i12GrnR5beW5
	EY8oyZdX22sGI8Yrzp4IgBeSEQloa+5tV88i7Os+aQr247hHrHdFA8nBy2M0r3BaYFE=
X-Gm-Gg: ASbGncsKp9CAqGcINWpdta/csJ5gKiKmPZO5ATs30R1BL6mCj9LCHJuH0o+K4unsTiK
	rXSatMFLdME4StFk94J0O8mRzBZVPj5XkgGJebrAXxjgBii6vJwuAu4M4Pw517qVdo0sMkwuvB7
	aiqq+U5WOdu9MCPBgHkuno2p6eZmgZSOhQQciYBhdx0TnNxgp1pJIG9o0a1Zp8edFMuThLM+rEq
	n/jzEqD05rET17grSe7aSH1IITNYQgQMw6rQ4GfkwL5O/eXp2xAxasvxs9i/L2lNrDMjfK2CFn8
	uy6IBurMTwzwhFUjadYwPxMT0lICN1e6DEGQ052Aw9a82wKl1lpBdfi+py+XcwTc6moF6IkkJCI
	shVzwbrgWfFVRi/2ilKYVYyeqfrNM/OghiCwVmzgTdWQ0BS8J1796NhWd4ggKW1p8ANLWHKp/D3
	HQo3XB3Xb+1KR4N0ZW3znHubP6qg==
X-Google-Smtp-Source: AGHT+IHOO8G/RNP4+N7h+q+3n5RC1e80lk0gJCjZ+Jmb8LlUPm7c2u0245iVMv+KJKdve3qFM22yaw==
X-Received: by 2002:a05:7022:ec8a:b0:11c:2632:b7c1 with SMTP id a92af1059eb24-11c9c8a63a8mr515277c88.0.1763713098073;
        Fri, 21 Nov 2025 00:18:18 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:17 -0800 (PST)
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
Subject: [PATCH 4/9] xfs: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:43 +0800
Message-Id: <20251121081748.1443507-5-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001819_268712_1EB3E0FD 
X-CRM114-Status: GOOD (  10.54  )
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


