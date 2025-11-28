Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE50D116EA
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEXNzDk3PZG7Vl6bACrm82r4Ym6fDNxq87feOMpROvE=; b=yZDePEDKRWDhSsYAL6fxtOy0h0
	kPcKXlTYwF99JN95hdCJ+5kRznlS4/kQGipvzB1LFGpVRxeARYp8VnPA8tADuUZMITBS1KPZ6vCR/
	g/1WM089eP6BCeNtDwWcMcqb06nKQoF1mTH4l8ReZSJZrvVg+TXR9TwVn9NnGeBlw9i3fto7aNi6C
	nKUsIHom/x+Lr+f/TVoA5A87kcxGgyYMkK0To9/4ONKdi/MxpQ/3Wk0I/GMVTsnSUySJxQq7ByQgH
	/dZFQeKDVija0gs7m165osADGBYI3TUokRNzw0/A1jveOoKLg8WuA3l4t3fQZV3mRoEpW8GNmY0Fc
	HGKUudbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuI-000000009Gz-2aAY;
	Fri, 28 Nov 2025 08:32:46 +0000
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuF-000000009Ft-3zj7
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:32:45 +0000
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-7b852bb31d9so1825601b3a.0
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318763; x=1764923563; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wEXNzDk3PZG7Vl6bACrm82r4Ym6fDNxq87feOMpROvE=;
        b=IrDu4iIkFghCyvIbwI0fkD1wSANgObszHS+bd4GiAkKLxc8RJ6ZMaBcio+nIEhbIDW
         jeJ2kN6h92Rn3TPi3LqhyQBbUZo7UOj1g/dlYmUP/72P2yXEKJT8SFHhnjTnx8xbfPZt
         Rrhs0Q2xq/VGPP2R5QBceYT64gHhrccTInsNyqTfAQt8qlhJJWN2u/C+szEF0S4nDo1X
         Pfq1ZnelD+nGslBQ5HlyVbNNrH0Vq/0/HlV98smQeenbfvYj5MOoXPX+pHwC9A+sDNAk
         jAtkpvabLj6Komjv4gHJhmgTQifYw0P2YKQnVqHcfUad80+9l+VITqbG6Us2BOeWx3G7
         QeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318763; x=1764923563;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wEXNzDk3PZG7Vl6bACrm82r4Ym6fDNxq87feOMpROvE=;
        b=gu60VVZsYN/jOT2nyX0Ascox2M9j2av/Wfna5/peGSALnL5mxif1yWrBsg2K4MgFd5
         wz99JLkPC9MfHPjR/e3iKC6ScNGxGHvzg84EeDhQ98O/H4kooO7A/7p4CkReq+B5MaRE
         XvarC+y8hGBb9kEgnik6cZDIWWsd9xWYpnbtojfPkqijGKwBZOPmN6VPqZh/PIX9r6ZA
         3v4lGDzsEqyO9IWa8JcrAZeoqmrkxvqEVHaqqyHOJUER+Pes7yk/+pwBKjT2npGv7A2F
         6OgXnbzFafEll5OVMVXH9uydQ+o+ECo3mKYS1X13hOFKEEo/LRMeJQBAMCSOY8zbQVWT
         NUvw==
X-Forwarded-Encrypted: i=1; AJvYcCWHC8Nj5hhNp4Hmc2M4fXvQqI7+ZRl00TaXjp3UxxN6pNmQWI7ZvmDXsNZLroZt3IYN3E5OIGMLz3PW@lists.infradead.org
X-Gm-Message-State: AOJu0YziELXX5BtDuIx7plzMZwRudl+qjgmXXutehHvaUiANnLi5nfyl
	0pAX+mG2YFtvAqZq0v7aPty4qFAPSI6dK6ZOFWTn6WJYbV6yujOTB7de
X-Gm-Gg: ASbGncvM1r4OV49jy1E1kYH+W+zvNVAeFmRh+go5n+P1ncJ3pm9Ic7Iwc509zWY9mAm
	tCp2gKuZdbHHTvCsKfYmuu8B4Aus06dw6lSL1mCEqQN+n4dD5tohgQXg7oFMdNrrATo0YwzdvkB
	d9hX6s8NtrGDzRyibZY0pErSw9QSDvq8RcGA2rj0q2BjoAn77/raHsAGpH7xi5OCPsHZBOvLAEL
	u2OhtaD3aREF/LypictfIcN+UmHmnoBDOwSTlEIKBA62uyVp7efE6eMEyWAxZb43/jgtLTVckJA
	ZZkWKyrQbPDhryLkkIIWJ6sn5rHmUf5fs0ghO54Uv8PA+9JS2VqBLkehcCIR/6NSz8FqlwVZHNj
	DuFOb7tVdbsZnY1KGf8VYF4r9wG4Xldgnf/IM2A+tjsMSn0ii2uUlz34y1Y/q3BB16vjZrxdrBL
	3RdYRJ1Q8fg0TXBYSv+l0aO9XouA==
X-Google-Smtp-Source: AGHT+IF16ld9QNCqaVETJUBsXYjs2kY4Pw4mcEH3R6jDofKcar8TG/UX/uqF2Rs9fZ+s8kH1ElEzpw==
X-Received: by 2002:a05:7022:7f1c:b0:119:e569:f615 with SMTP id a92af1059eb24-11c9d712704mr11436137c88.14.1764318762983;
        Fri, 28 Nov 2025 00:32:42 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:42 -0800 (PST)
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
Subject: [PATCH v2 01/12] block: fix incorrect logic in bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:08 +0800
Message-Id: <20251128083219.2332407-2-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003243_999456_10EA0B5A 
X-CRM114-Status: GOOD (  12.67  )
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

The `__bio_chain_endio` function, which was intended to serve only as a
flag, contains faulty completion logic. When called, it decrements the
`bi_remaining` count on the *next* bio in the chain without checking its
own.

Consider a bio chain where `bi_remaining` is decremented as each bio in
the chain completes.
For example, if a chain consists of three bios (bio1 -> bio2 -> bio3)
with bi_remaining count:
1->2->2
if the bio completes in the reverse order, there will be a problem.
if bio 3 completes first, it will become:
1->2->1
then bio 2 completes:
1->1->0

Because `bi_remaining` has reached zero, the final `end_io` callback for
the entire chain is triggered, even though not all bios in the chain have
actually finished processing.

As a quick fix, removing `__bio_chain_endio` and allowing the standard
`bio_endio` to handle the completion logic should resolve this issue,
as `bio_endio` correctly manages the `bi_remaining` counter.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index b3a79285c27..55c2c1a0020 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -322,7 +322,7 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 
 static void bio_chain_endio(struct bio *bio)
 {
-	bio_endio(__bio_chain_endio(bio));
+	bio_endio(bio);
 }
 
 /**
-- 
2.34.1


