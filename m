Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF91CFD376
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hgav++xVu99AZZZMA2bV1F+Nxhf+A3QsmIfb5iyDR/M=; b=ZkKt82yS1hv/INHbQav8d4Ytna
	FJ+Q9y4WwBQE8nN2IVXXguElLVMN80KgbQkn5CPpcoDrnobuu/2f+xLvy0gZcvivmbofg9yEDprPg
	iKIH/zRwfHDLlibsAC79pY/Reajsm/h4qJbXUzggcevcmAhfpv7wAp3TNSF5WWlIY+rAjjvkbJYIa
	3u0SbD86iC/VMbQ+jgCILmU9FkzRxBL/gz8I87pSiD1t7nspYUit2zT7SSBIeKis6kWB93sD0s4Ra
	S8hF9y5J6POAmjST76XTubdg7TFqQkMjfDbCXnBf1c5msWnHrpLAxghZfnqNEw7UDDBUHZ8byfoJ3
	9IDfTLNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuW-000000009OE-39E8;
	Fri, 28 Nov 2025 08:33:00 +0000
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuU-000000009MJ-3BS3
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:32:59 +0000
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-7aae5f2633dso1827487b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318778; x=1764923578; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hgav++xVu99AZZZMA2bV1F+Nxhf+A3QsmIfb5iyDR/M=;
        b=XObSiZkbiBu6nwPL8vTZLSiVd+3b7zxwQ0DOOgbExsrMV/wRTCl9pvW7oJUnSyl/qR
         WIXvofoDDOBC/tE1tt1AC30LWkH0vhbGXoUSUsSZHPhxNczmbsRUb37nVjh2guirNqpa
         5Xo6cwQx+J/68myKOzLr0G3VomqvJu4ucT0uRn07XWaL0qnqKOfqWUqKd02wEAEdOcpZ
         Mnr5DB5azRQpFcQwjw78dkypncmBHn+0mCFLK0JFotaSiZBhVu3NqIcyymjE+9O3Bzzm
         M1Gs+2EPJt+1mBsG5x1jd73y2hUrzBMZZY+qTGaT3R00gwxCg4HMRtfbFMB47h+EEHWf
         WAKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318778; x=1764923578;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hgav++xVu99AZZZMA2bV1F+Nxhf+A3QsmIfb5iyDR/M=;
        b=DQ9Fc3Q9QfEudyeaw2Ktma9PjsPOO1CyUWio9I+FPt8herzPwr69KnX1gp4SoTg1wI
         iTX7cfJtR0cu6OrERtNh9mx2mVmma3ZfuC1PYBUI41OzJSSAyPWOBa1UJtYuZ4ftlmtj
         rSHrXIa7K3LbTeBl44oiciic++GjqJgU8KJedAKzKlWygNDsyzGxCnFhIBlWpCf+eW19
         vcu1uig3hT0igpW2hXmvJ/+g9L+u8tOTehfi5zGkkdkeG2kkEo2mb06x2iIOtQ0PmBPl
         fGcJVREObF7YVGq8lCcE7it4s9ColpwHtSB5qQ+wEsIw7l0/BMnbAjM/RmuLpz8Mkwp5
         mI5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUejpH56QnMgRrH53K+ZRntC3Qjb+7Q31pBIddxjO6vKuDuIodqIW2Z7NJ8i9v+hBfUvR7t2vf6oMkw@lists.infradead.org
X-Gm-Message-State: AOJu0YwpmbtJCdBoqkgmIaSRsB9uD7vbBxgEn8RO9jqVPbytjZHc2wNQ
	fIxvmgWqiOVTGwa/7fyHHgCQ9um5f/S+M5j+lOLQ9q0/YCGobptmLLoe
X-Gm-Gg: ASbGnct9r0oAwojVPKLmzw4K9v0SATFHW0pibm+oBQdA2CfgiM6O00MrcM/92VwR4JK
	+MTKmGM1AGDH9YhQ374LQ8Co8rm9h14gAXXoSpbMeNsneEWyg8nMTdJPESi50eypNQMv/gygl1P
	4LFI3rxuOER/qMRxDm3RcYFWaqioh/Kxf9SA8uI7xG5kUP4SkLls9fX2ewEt+7sv06i9UUuCoco
	2Q3vEifjxV3M8+6Nw8Glu1sgowVvWdVebqhCbTrbGxH9XvC/ebmlV6h/kZ4iShhnHbtsv08QHTU
	cMwMS9isY1ZyDhmsnm4WsxOKdTJy9HENcYdJ9j3wg2YC2QJQgAwD4O32OMRXDaV8PYzWoWIbAYg
	bzqYAYdDyaxY03pz0Q4m0na5MLjQTTDi617SA+WviBrjkP0lvMzkkHURaHxudXchZKqDYw/OUtq
	ld0+tynLPO8antoQ00vJorv4Ffvw==
X-Google-Smtp-Source: AGHT+IHuO0sAEeNowy1+oe3IeEgaIYQcRN0FMbygDOiWMPQmdT1sBtyBJY7y0vyzVSrhuxE7eNWdhQ==
X-Received: by 2002:a05:7022:5f0c:b0:11b:88a7:e1b0 with SMTP id a92af1059eb24-11c9d8539f7mr12036129c88.26.1764318777892;
        Fri, 28 Nov 2025 00:32:57 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.32.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:32:57 -0800 (PST)
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
	starzhangzsd@gmail.com,
	Andreas Gruenbacher <agruenba@redhat.com>
Subject: [PATCH v2 04/12] block: prohibit calls to bio_chain_endio
Date: Fri, 28 Nov 2025 16:32:11 +0800
Message-Id: <20251128083219.2332407-5-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003258_797553_6746FB36 
X-CRM114-Status: UNSURE (   9.98  )
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

Now that all potential callers of bio_chain_endio have been
eliminated, completely prohibit any future calls to this function.

Suggested-by: Ming Lei <ming.lei@redhat.com>
Suggested-by: Andreas Gruenbacher <agruenba@redhat.com>
Suggested-by: Christoph Hellwig <hch@infradead.org>
Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 block/bio.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/bio.c b/block/bio.c
index aa43435c15f..2473a2c0d2f 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -323,8 +323,13 @@ static struct bio *__bio_chain_endio(struct bio *bio)
 	return parent;
 }
 
+/**
+ * This function should only be used as a flag and must never be called.
+ * If execution reaches here, it indicates a serious programming error.
+ */
 static void bio_chain_endio(struct bio *bio)
 {
+	BUG_ON(1);
 	bio_endio(bio);
 }
 
-- 
2.34.1


