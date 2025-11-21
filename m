Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B26CFA747
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/2hQwsn6Sms438Pv0Q4ngdJSSkLE/b11prNvkoKJDYo=; b=uLmYFZ3KeceQ+jlGsp0/dBqBJZ
	PwDIlE9tj1JV6PQmpWOcrcdqhqwzq9T5OQeKoZGTeaO7yXrgLbWUBVCj68Lh+iUhhxBo32+pRb68r
	3nDg+j8cGliJmI2M05diZakszczN7auMuyyHebPdFDaLqPbQekULPtHdMAwzbyNjbH95xi2lXbUci
	lGJBPyurpexFbDi5ITot3NMesUioce/Ac9wdPiEBp1JRoTBemNnWVAIS4Zh1KuqqUPc1b7vfEe3+D
	7uh4i9pjmse9fxGLN3PWZdI9PVepCxKK6Hru3QYVGEIXErmpn6MR7HxipafOIZWlkLjjncl0T7U8S
	k9AhVrrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLO-0000000827O-3IRb;
	Fri, 21 Nov 2025 08:18:14 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLN-0000000826W-0xTC
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:14 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-297e264528aso20395645ad.2
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713092; x=1764317892; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/2hQwsn6Sms438Pv0Q4ngdJSSkLE/b11prNvkoKJDYo=;
        b=eRsnMTC/UxhrkW7+ePrc6Fp649zsaMw+memtovnPgls9m4NszDuu4lGdt25Bh+B6C2
         ZcFFpwmc9vSpHHJKmt/ksbsiNxGqREwVVJQJR+4QDtoxG0oL0rYhBmz+eBe5ypSV9Uq5
         qesgb3lboGrWsDYFNV4lmgEOOsRfRrAo82Nu4+LHK+on6OxINLT03Xj61DXiFxgC+B4O
         HvVv6CSqACwtjK4+Cj6zsTJCpeboKiC+MeD/RIbpATHuHPQdfKWzHc2GNulMIqANmUgv
         abO5qJPojrbt6TtyKcEwsydQyNrRDBvglLrqPaIXwtL7+Ox6/3mGhRqcbrZeHfRtD+qF
         6w1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713092; x=1764317892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/2hQwsn6Sms438Pv0Q4ngdJSSkLE/b11prNvkoKJDYo=;
        b=EFBbdKFwtbP1WBP3Mlrpiom3SdaoY8SWoZMIEqxFlvQkkdbZEtUKRCPhaNaPO1W31S
         DFI3vVF5FtmxhevnoztzQycCJZw3JyxgNk66c37sseCyYwKMEPSn0gdH9mc3HgzBMBEF
         Z570ffLCViMgV+WszME3VsZ56U0UVXDrEB6dMLStgz7WELEsfaQ6S7HA5PaWfEobdM95
         kKRbp0UIUO/V1X+rD2F654HkYYMIw/F0dy9XeaqSAqAkqd7UM0qzXPzOEecJDNWrVhT6
         Xnpx+M3SO0B/sh0D1+90wwtGOh2EHUFPa1RfLdI2Agnk1UyUCUCIQ7uq9NDVGa2mbW6z
         Llew==
X-Forwarded-Encrypted: i=1; AJvYcCWOzle11+uiiZfU7ECI6keFsvqpu095cZATE1+K0D1LulkEY4YeWDVo40E/TVkywEqQbLzh2hs/IWI7@lists.infradead.org
X-Gm-Message-State: AOJu0Yx+dwjDDRxpIUgqbM9XZGqjeYR8boMjc5heuUeaOQPk7zAGR5pc
	bUVkcLsGgpxXXPPSndm0fsA2G+AKECYZNozEAxdG6Nraaj3M31iYPwWo
X-Gm-Gg: ASbGncuo9C8r3aoD/OJffI5cnOwIV0eIv4FfMvs2CVP9jec3/xb51B5SVpsnN1dxdJN
	NoxkBWlm+/t3ouf9LHWF7eccPWwy/DiSd5G3yAjd99pcwr6WPIvd8z4+k9sobGZFs6VUi9HC2u/
	sk/3ySFG+dGn6IJZLWCEI9aTzYEEweTnBFcPpKtT4al2nIA1B0NdIe8Enw05PzMVtbPjao3fxaA
	ppho4Xl9EPib8yrqysQiIjvB7edcRzluKpaLQKNiufIiDtpKZFBn3MUXF2ioWT6UTjZN15kr7Ji
	JaZDGjzHFS7JLG2aH/1Me0OGxkjhtQfo623cvfkVZTHe1KYJqidAAKS7Mb+MLDdbtIuAITugMcW
	h7OP3imOcIkqsz2+37iWMxwZ2jkGjLXWg4uqGTEqvxBwYEX8bqd7JoCpSJlc6fMDbcUc84oVf1C
	ZcwgaIABtXpueg5vbsemwdfSuPIw==
X-Google-Smtp-Source: AGHT+IENbSLlagXc9NX/smNIF96UgKjh9NXUi+KBRvhy18+CUMO6BxslQvGRE/2mRUDvnGhRtmvCRg==
X-Received: by 2002:a05:7022:ba1:b0:11b:b3a1:713c with SMTP id a92af1059eb24-11c9d60d20cmr498283c88.9.1763713092239;
        Fri, 21 Nov 2025 00:18:12 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:11 -0800 (PST)
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
Subject: [PATCH 2/9] block: export bio_chain_and_submit
Date: Fri, 21 Nov 2025 16:17:41 +0800
Message-Id: <20251121081748.1443507-3-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001813_267165_5E02A9FB 
X-CRM114-Status: UNSURE (   8.38  )
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
 block/bio.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/bio.c b/block/bio.c
index 55c2c1a0020..a6912aa8d69 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -363,6 +363,7 @@ struct bio *bio_chain_and_submit(struct bio *prev, struct bio *new)
 	}
 	return new;
 }
+EXPORT_SYMBOL_GPL(bio_chain_and_submit);
 
 struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
 		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
-- 
2.34.1


