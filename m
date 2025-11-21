Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD8FCFA747
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1V/r9ZPcuPpDeS+hBrkkwoFJqMj16O3RGCN2/vaCDuA=; b=f3Zo3hBE1zEebSzCLjzJ9Of9wx
	6kEwlW9RG6Kz2j6PtKpcluaXyAu24oIYLEzA8qKjAJ06gRlhNQjh8V57po3xF/UGDPld4SYz3TOKi
	4axXr2QAuyNO/9aA4iglB7BI4/XMKbwCzecKnqOaeq+5mBTjb7OFTnGch7YRwkX5zdPVa2swGkHCt
	PhNgKSt2bGN1I3L7eqbHKOf8i9hyXrZwuRo0Qay8B4DqcBcbMa2K5/PK4fJpkehcuf2hMIeE4AAwy
	N6K5pnPPH3cJESuqS8QEv9N9iGs0dkFc9AzYuhjCtvb4FO2iKBkwzZL9xyCEDAQ5Z1X3VJKstvCJl
	e4lrBIFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLS-0000000829e-0PQj;
	Fri, 21 Nov 2025 08:18:18 +0000
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLQ-00000008280-0gUP
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:17 +0000
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-298250d7769so13436145ad.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713095; x=1764317895; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1V/r9ZPcuPpDeS+hBrkkwoFJqMj16O3RGCN2/vaCDuA=;
        b=T8tPPD+AZKKad+Kk9mQKaPdnYqcka7FFlLULks0uKstkqE6DC1w2LdbglHy03hpRbG
         fUQimMhiK/I3B7WfFjhD3a187HNp017Vxw2QB6NDGEG9kTFRfRxtLXHo0S1k0l+jcP0J
         v5ZMxSFenE1P23Hbvsj2QQKEan5aCFJ+9Lh6sXet820VaJ3Yh0h508xFDuICtT1XO9HQ
         iA9niTGHgqaPUAirZZWx6CiTNhK6jYvXudWnwL6SPiMYO9TVcR1OxaySeLEi2dg/QX25
         p39cPJEwJKHYshCVIqxWz8gJbVq9VrqG1gl1AJ1xRtLfSsf7Fzawss0XeGC2pTd93oah
         C9aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713095; x=1764317895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1V/r9ZPcuPpDeS+hBrkkwoFJqMj16O3RGCN2/vaCDuA=;
        b=VJNgn+ZItu/z2MYKVHrJyLtfLqx/nn2FrYFQR5Y7efc3KMJ3xOWPl9mJ1vsFUuFnKT
         TGv38pB7TopzlqrcVPfYhnt+GSHULWKow4kDjIaEzIYR7EmTRZEXZyPo2sjzdE56qwG+
         8lAF4t4uv0gYQ7EyoIfvK3iZJAi7DFCHVbLeA20rRUTJVCYtZXJzLKPZjvdfOItE7E3Q
         ZHVbAq/7VWF9PrF/ZOgzksiDX5xNse2RsGvGQbDyJuedjRNQ1cFmOm9zyjQnUnTUHzWh
         IjlHAVelwUf1E2v7DT0fgLblJYrboqKXlO9NllZ2SgAEHkFxqjI92ttvZijC0gN9K7a4
         D0Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUDWM6/EgLgmxn76K4WDru9tX7s0Gs0UiopNn37XlBGfqP4MStpKxMHUBhzkXasZRp3wvK+G4xUTph9@lists.infradead.org
X-Gm-Message-State: AOJu0Yz7INn12NSzINxSc5heTI58Ly+iIkQ7GL6+y3gCsr1leVKQkv2F
	JF/kHKaVSJVymFTHn+2peIopB31XICuxH+ZBYb0LV2QDe/6TKhQz4VtG
X-Gm-Gg: ASbGncsCy5aRaoOacWOIF5hj2lQHWKz5eudNF9FX1v/RJCChcd5gZQKuP1G8r4vVedr
	Nw1Kws+SLoNhdB0WX2dGSyHVmPtT3WPsTDSU1W1nG/wPu2W5v+cMNHPlRCwGSNNkqj6UFRMerVP
	iIMjSL2CSEdt7l7trqBv+ktHhtbEiNYgsroLccsjYlQkhC0ofJwFy02ERxE8XH6EVKCfACnfjJi
	yYuj2fRYOpSNb+vz1Yta/u0Gccf8NE+PJt2dDBETTJ+O1Qom8kCXL+8lqM616Bnmui8uvfOmAEH
	VLZEK+UZk/EBVmaw8XyRaUWtmAklvB4YrHH/TXmaP5/LaBga5+fTU1FF3AqUuvWQf61Rgf8rawr
	936wGACNy5JL9XFVcJziQj1y43TDH2p8GbU+eQ+EfXW3QubI00PdJfZby5XTsO0Z9IqfDSNdtkE
	7Ga/b2zt1VNRX2p0/WskzicOAMYA==
X-Google-Smtp-Source: AGHT+IEHu/E6NqM3wgnO0PzNJHfm7ylIJ91XqRa53EvuqqhyyBcUb7YMg890bib+mDDMVjekZVw8IQ==
X-Received: by 2002:a05:7022:4419:b0:119:e569:f25f with SMTP id a92af1059eb24-11c9d70b0d1mr568161c88.8.1763713095153;
        Fri, 21 Nov 2025 00:18:15 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:14 -0800 (PST)
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
Subject: [PATCH 3/9] gfs2: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:42 +0800
Message-Id: <20251121081748.1443507-4-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001816_206138_E01EBF0B 
X-CRM114-Status: GOOD (  10.01  )
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
 fs/gfs2/lops.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/gfs2/lops.c b/fs/gfs2/lops.c
index 9c8c305a75c..c8c48593449 100644
--- a/fs/gfs2/lops.c
+++ b/fs/gfs2/lops.c
@@ -487,8 +487,7 @@ static struct bio *gfs2_chain_bio(struct bio *prev, unsigned int nr_iovecs)
 	new = bio_alloc(prev->bi_bdev, nr_iovecs, prev->bi_opf, GFP_NOIO);
 	bio_clone_blkg_association(new, prev);
 	new->bi_iter.bi_sector = bio_end_sector(prev);
-	bio_chain(new, prev);
-	submit_bio(prev);
+	bio_chain_and_submit(prev, new);	
 	return new;
 }
 
-- 
2.34.1


