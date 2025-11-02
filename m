Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582BDCCF9F8
	for <linux-nvme@archiver.kernel.org>; Sun,  2 Nov 2025 03:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=PoN452LpHLrLmrCNSjn1enXWPSubGi5lK8DdRLxOXO4=; b=10Bl6SVb5d1wolFTn8bToh+3BF
	HdBPzTSh3iibIz3n8bvoBvmH4nyy1P7TmuH1CZvKb15ycLCEw1u19gvuFjklQOQ637aUpECoY97XQ
	QdnhBjT9+qyYoH2IL0IdbQBgQJPqVrVwvf66czmZC+Lfz9z0xQAUkOxzVir7uxR4RqOdDvD9A12lH
	U25aUNT0nbnYtiQXFKygEn1HPBN1OzbJZM4PpQQKuN1PtFBEqEz48vg/f/0UG+hda2yo/QfYCBfTK
	/tt/duAUk2BaETrWSyrNevc+XuQZLmhEUZDi3DtlfYKCMNA5dqf99yVKMzKi7SICIgPRh9zDqR26U
	ias33CIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFOag-00000008G33-2Z1f;
	Sun, 02 Nov 2025 03:17:14 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFOac-00000008G2f-3RYp
	for linux-nvme@lists.infradead.org;
	Sun, 02 Nov 2025 03:17:12 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-7a2754a7f6aso4305613b3a.1
        for <linux-nvme@lists.infradead.org>; Sat, 01 Nov 2025 20:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762053429; x=1762658229; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PoN452LpHLrLmrCNSjn1enXWPSubGi5lK8DdRLxOXO4=;
        b=RUBrJQeNS4vzeyI1/uknjj3lep5YTwwuivaLNGwZF4N4pYaqj9BAzQKcSF2Os3x+Lq
         uTB9Xlhcjzi/TRL/YEtP5w9iZu/52aXvw6YbfDmBrxrWikcDFN0uXJ1U3sSxnJPCQowA
         5fdCHbU9PK7WfZWguAzo9OSYBK0D7yurn+KkiTM/sxPurTVXPR4ZK1oY09i8bz42xcLG
         EsJhFDXk+L6tNpqsbIqFNgN6kYfziYYz4zvGdzH760OZpDTGuow2pYse1A816kB0k0eG
         3b0IyeYcDxrp3Ry4VmCCLayZenV9RwcHiRewWp+NtbRX5+7/velD7VFWAnEnSDd1cxnp
         ODzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762053429; x=1762658229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PoN452LpHLrLmrCNSjn1enXWPSubGi5lK8DdRLxOXO4=;
        b=QfB1MwwOJHgNyc2oi4gzXBFeyk4wLAgKtnSjfJ/6y7QKnDpQvM5eOqIL7J8Lmyy2Cn
         iUFqNfqIowNu2mUr4TrIN35u9zWma89rbSLfDMFoGb3iJKt5MBIl/ShqG6kOtsy6/PNh
         03TOm6912y1iCSEpEzMbn/l7H1tmqOS8wGv34J8p0FxR5UgXbiBH/mxRAhV5XPfNmzKY
         9axfbpTvxTZrdpoChmGJTcEUiT6e9ARYafIW9/y5L2ShnD1vw9nHVcu3UWHMGX4LuKoZ
         OY0ag23NTNinCGrXkNSsbPvXG+lYw7K7RrZKiHj3T6C0cNZWMn8+1au70/ovJa2wzVxs
         Yt2A==
X-Forwarded-Encrypted: i=1; AJvYcCXRx2v8Ltb4LQxgTFT6pfVQSFv86CpBLatju/RoqaYdChtCDHRZMw0hRQJFpv7dBVlfSHBtNWo2JUBe@lists.infradead.org
X-Gm-Message-State: AOJu0Yz0nSmm7Z2r/jDbRozRrxJzh9KFIae7ORJxkOQ4CmHlW9CIjmvv
	by2MsIy2GEcze7K2dHYXmgadblhv+zCiCIIHTqWTt6KEUVGFWj/7EmWg
X-Gm-Gg: ASbGnctn08FU4i3+46O4GAGRqKEF8GjG1DJqYUtYSkKbuztF4wI+WXxz7FkwtMPHcBw
	t90StZAa2MrhXYlXdZ0NCEvJYlO1xlamXTEih3aFa56qsuT3R61dn4q+V7xcY01RCIbf2NVxfMW
	9zqYLesKv3IT9Rikh3f/bxtB0YDPFvF564PuDnA1zTL9PhWA+Qp7DdKAm+W52FM1GZkX0TbprTu
	K2eYkNBZxhSw5UAS93hJm342NsZLDY+F1qGDTDesF9f5Dl72vKSxOQHiZID5VXFepu6cZyvz9Qk
	ua3KkYvAw30k5Jga+Hk3kWBJF/2ugzhl592eNRGgkyBRQXBJYZjmuUMWJE1Kku95LPNe/beLIyz
	F8W2z2s19FVKTxNy93BpbUhEkmMiNHVwPDCQ7J0JXYhMI8FG4DsBqzBX4Fg+72Eh+v69x9tulmV
	uevcwWdkt64dH3JzQgOdS1wUJXtbxe+yiG0GEzY2oNo1yL1wc=
X-Google-Smtp-Source: AGHT+IGv5XtuIfRmuWzj5wfND695aJMad6Ci0jh5V+smTkwRadpM+H3I0IBaYvEXXaJUFhW54KWPCA==
X-Received: by 2002:a05:6a20:12c3:b0:334:a599:bc77 with SMTP id adf61e73a8af0-348cbeaae54mr10634977637.30.1762053429439;
        Sat, 01 Nov 2025 20:17:09 -0700 (PDT)
Received: from localhost (ip70-175-132-216.oc.oc.cox.net. [70.175.132.216])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-340be3f48e2sm3558071a91.9.2025.11.01.20.17.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 20:17:08 -0700 (PDT)
From: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
To: hare@suse.de,
	kbusch@kernel.org
Cc: hch@lst.de,
	linux-nvme@lists.infradead.org,
	Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] nvme-keyring: mark nvme_dhchap_psk_hash() as static inline
Date: Sat,  1 Nov 2025 20:17:01 -0700
Message-Id: <20251102031701.69920-1-ckulkarnilinux@gmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251101_201710_862947_BDF7BDEE 
X-CRM114-Status: GOOD (  12.22  )
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

Fix build warning when CONFIG_NVME_KEYRING is not enabled:

  include/linux/nvme-keyring.h:57:4: warning: no previous prototype for
  function 'nvme_dhchap_psk_hash' [-Wmissing-prototypes]

The nvme_dhchap_psk_hash() stub function in the #else block is missing
the 'static inline' qualifiers that all other stub functions in the same
block have. Add them to fix the warning.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511011103.e6eXLAln-lkp@intel.com/
Fixes: 8d9937531a4d ("nvme-keyring: add 'dhchap' key type")
Signed-off-by: Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
---
 include/linux/nvme-keyring.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/nvme-keyring.h b/include/linux/nvme-keyring.h
index 6115bf5cf346..4bdac22b3cbb 100644
--- a/include/linux/nvme-keyring.h
+++ b/include/linux/nvme-keyring.h
@@ -54,7 +54,7 @@ static inline struct key *nvme_dhchap_psk_lookup(struct key *keyring,
 {
 	return ERR_PTR(-ENOTSUPP);
 }
-u8 nvme_dhchap_psk_hash(struct key *key)
+static inline u8 nvme_dhchap_psk_hash(struct key *key)
 {
 	return 0;
 }
-- 
2.40.0


