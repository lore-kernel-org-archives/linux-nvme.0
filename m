Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A70A4CFD376
	for <linux-nvme@archiver.kernel.org>; Fri, 28 Nov 2025 08:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=; b=vYG+z94Oaymvne980JyQjfOXNl
	YK1sBtKjXp2E5Uj689RO1rvbGmsy0//a5nWmvmUDUiVqg633DLXFm0A+t99uBG4GSk+x0e//2r7gh
	mnmM0MfkJmOM2nU0jbEz13uFMc7/eNooTqq3k9vEGlV/NP0oWAi/UQN3kaChfD2uNTkeLeTYymuSL
	ERfqiVmPdd6ZvV6F546QIzXFRxabn/WRPdy3e2giE2nWMwDgqfbxXlmpow8hEz6Ffv1KWV73W+Z1D
	DB/+9MwBOtC0QEfzAqpoiOy0SzOLqSh+XjffHyPXMoPkPeaL/PsG4/5X3Ry1kqdnAnmepN+FmFbKr
	gZFP2xmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtv1-000000009mZ-3Z2a;
	Fri, 28 Nov 2025 08:33:31 +0000
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vOtuy-000000009j6-3lNg
	for linux-nvme@lists.infradead.org;
	Fri, 28 Nov 2025 08:33:30 +0000
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-b6ce6d1d3dcso1459042a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 28 Nov 2025 00:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764318808; x=1764923608; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=OluQZbi+himU4AK+tKUWrBK4sZXu3+P6fx90Su6uuBARXNAPQKPsA1eLdr4yhjKtf0
         hKj++dlxoYdJUtAZhcYXYvefCvOEhGl4K5qvzF6JciMp4QLW/LxILQSdjUWBReMWASrr
         ePSS8KsBycPY7ybuQrxEfUNNCMyZY5gqYoNRrQeBAIYWCto0ugf6/Xofno0Y+rUgn0u/
         OZtKbDUb+Mc0m5EfTCHeohH+u6k3wM2kbjUm/WMoQnI5h6NxFT/5VRjE9aR0l+0rr+Rc
         mj8QfwmbC3xN4ygNrKWigW0tMjRn6nLNAfpUzJWDSs+/cVzgyvQGIBiM83UOdcK+9qXp
         RUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764318808; x=1764923608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jJti1W24hnwF4OFg7cS4jWnw0eZv9xglyyGrmFluATQ=;
        b=jubPWxgcJJNOIy5h7HEi/yRawo6WAOJOfHaWtnQm9DUSsdUdavDJpPZ+2qHSOrxgYF
         06OLwVSNnLAd337+l5mWoY2HNu4TgLGjwkTVa0HdA3V035T2rKDGIk3+x3TSFh1XIsH2
         1efgFIAXXl6C/08GxxSJR1oQZbZVNrDb+IWlpgloSy6SLPWUzfXpMvjk/M6raoHqZH7K
         +uLHs92JqoYimd87VmsuwHACcmzHTCM2uZCPm+POTYATnnHjp2ZUmzLQS31+P9dOwZne
         R7NIr4dc2qtBxzkadyQqthalIhYrm0IJWH0wFYwT81eevTRxB4f3Dcqa4GxQ9iSDmEbd
         V/5Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrQAZSiaKGTdUX1YBke2z7wK8WSNDGrFDIxiaZRGh3IBK7DYCS38xOenHqhV9LwZ41MOhrnKT7jb2a@lists.infradead.org
X-Gm-Message-State: AOJu0YxzFiL8VMjSPMBgQPrM7L4Ynl+t8923kvDgF0R/gJ7wopql1wrz
	DmnnYBP82SMOqBccD8A+7sxRWGYC4mx4Rc0eHYu8oF6PlpUU2lLMDylt
X-Gm-Gg: ASbGnctHid1VJtEOU/iMTeqFC2WclRutFi9EVxCdBaVTYZz1urgmB0co5FNh/bUU1mR
	JcL7d6otNIhsIlen/hI+lOXotGbHOJKmZ06gVhIXd2iTulMaPbfP3tI6pHg5xROJRYm9ucYCOZL
	oPwZpl8ZKHWERQOPJahdsEWPCtYGOKTmwBfvJNrn+yhQmeTBrFMv3DU8G3BYWsCprMBhotiZ/KX
	OetAdRkAL1L9gXe9ovv6TBh228lw+wfSsMIUaLab+8XisFCFhQIp5dC/gNuZtbeP4GUAKZ/Gb5q
	qWB45oQ+Z/OAQdRV7z6pl3Mfh/ALnaKHnLCMC5MyezSWDazDqQNZIfoPbYtUiTMrIsQ2X/tXGwE
	zEhrlCKihB0nWSDjuzw9rvmATgMR7H44o2v34wjnWrzuq77aUvmZR5fWVJ7vvyR6oy6TBuo1Vb5
	oaRC2e/ESbNFdUbpjS6sqmx3giZyQ5KshyWTac
X-Google-Smtp-Source: AGHT+IHDsMToqUoj0PcNSA32TYDuHE8zhBuDir1BrYt+w5Y/wAZYCWlUzMNg1Dgih3T9wVkLcbd8Tg==
X-Received: by 2002:a05:693c:2488:b0:2a4:3593:6464 with SMTP id 5a478bee46e88-2a71929687fmr16240699eec.20.1764318807899;
        Fri, 28 Nov 2025 00:33:27 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.44])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11dcaed5f6bsm20941371c88.1.2025.11.28.00.33.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Nov 2025 00:33:27 -0800 (PST)
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
Subject: [PATCH v2 10/12] zram: Replace the repetitive bio chaining code patterns
Date: Fri, 28 Nov 2025 16:32:17 +0800
Message-Id: <20251128083219.2332407-11-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251128083219.2332407-1-zhangshida@kylinos.cn>
References: <20251128083219.2332407-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251128_003328_939162_B347457D 
X-CRM114-Status: UNSURE (   9.71  )
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
 drivers/block/zram/zram_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index a4307465753..084de60ebaf 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -730,8 +730,7 @@ static void read_from_bdev_async(struct zram *zram, struct page *page,
 	bio = bio_alloc(zram->bdev, 1, parent->bi_opf, GFP_NOIO);
 	bio->bi_iter.bi_sector = entry * (PAGE_SIZE >> 9);
 	__bio_add_page(bio, page, PAGE_SIZE, 0);
-	bio_chain(bio, parent);
-	submit_bio(bio);
+	bio_chain_and_submit(bio, parent);
 }
 
 static int zram_writeback_slots(struct zram *zram, struct zram_pp_ctl *ctl)
-- 
2.34.1


