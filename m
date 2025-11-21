Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B818CFA468
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Nov 2025 08:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=teKvOHrBXVsyNlkTSBs+xMQTFkH6mnVNybU85CGmBRM=; b=CvoQzKzVFZxi539W3IEWRZsTn8
	fLKj9SFLsXAqTh6NV8YeT1jS/g5HjWFVr3FbwyBf2COLWE4ZsuOYp9dpheXdsMHcTA1bxyBjpl1Ir
	T0QP3zmC2ovDQ6qoWulC1+zl25/+OdShFhkki0ODIfCFjIEJFls0jAF8IARb78DiJjONbOaZMP8bJ
	Ip2MP1MooZA/SD7X13SUgOqepT9TmJo6OD73XPylJvbZ5Ft/Nl7CpPVlNqSSFuJX3L8T649F+JCz3
	TZUHV4tzcbSysXW0CH1zW4UX3KKIL9bZHbBdBo1/x64d9xwZkOEmcalhV0KxwPbh82t1opp4SnrfV
	eAUgpRuw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLe-000000082JW-40iQ;
	Fri, 21 Nov 2025 08:18:30 +0000
Received: from mail-dl1-x1236.google.com ([2607:f8b0:4864:20::1236])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vMMLc-000000082HO-49vn
	for linux-nvme@lists.infradead.org;
	Fri, 21 Nov 2025 08:18:30 +0000
Received: by mail-dl1-x1236.google.com with SMTP id a92af1059eb24-11b6bc976d6so2581406c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 21 Nov 2025 00:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763713108; x=1764317908; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=teKvOHrBXVsyNlkTSBs+xMQTFkH6mnVNybU85CGmBRM=;
        b=m7Z/+Tavoe94pjbyXzBMDoe292ZtpuHLj92+pjThl1I8oRGEbMxq9ZMjROVJKHGIMw
         NvnCVrmvYj4mSvqxb5Lu/6hsz4BXHwVjDxKSrcPhznOa7kzjL0ptZxJpCUQdIILj0QZQ
         gJK1xHrq6ePLF4OhVIDlaKWpjbxi8wS8Z7JAOl1nY2vJxFBZWPu+1YqlTmGd/hJ/IjQZ
         vCHh4blamjYAeCQZrn2/pENi5NRkFEXyYast1YxdKLhj873J42Gdr1ZGIA9tmYIDkTl0
         UPhyUfZ05uJ1CHb1sDwd2MJxHBZBOqkiVQ3u1VSZamcyw+26bNFX8vhqk1J2ZhPkEhQM
         GPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763713108; x=1764317908;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=teKvOHrBXVsyNlkTSBs+xMQTFkH6mnVNybU85CGmBRM=;
        b=ZTGm1MtJMptOTQZRhj/8cXNba5nNSIODUAlXRWrFkwnA7bd4+C4Iiuc3NE58iGjwoB
         7n1q6o4D0LiJ4zgkOaQ0QcEleFD85aU2QrMNXsOhXxkrOE9WAH7/kvlqdECMipdNSwNB
         +zMRJ94CV/CaWN3IvmTl0HVtiCAjeywiEDQzH46XPilsv4Pa8qImDmItCURUbvNNI3uO
         EAD/JaBwJNzCludz84txYDzhMo8K3MfN3brYkETBvHQHCNxVoBDZ5Yl8dSwTNrEfNmRP
         5JbTNRNFUzGxY4QXvI0l1pE6SWQaRMre0eirpC5T7sAnNOuY5pDSaSM7AQtBpUlblfjX
         JnYg==
X-Forwarded-Encrypted: i=1; AJvYcCVLougVORu55XotMa+AF/7+v5mjmj3RQnovShQfoqkePxYFd6qBAUaFHhEd10M6yxjIAWCrqf8JUtze@lists.infradead.org
X-Gm-Message-State: AOJu0YyaBaNl5tH+gs6iMaSq6OD31hlddFxfILZo7Ku6rKcpEaY0SJkB
	jQqv+tWBkfDgdhwlj1b/WvA35zsY9cNmT1nTC2OeoBM2QPPaO3H+I6tM
X-Gm-Gg: ASbGnctz5Z6fq7UekA7pnJCn4tJRUVYIdVMU/mB5jEkozDvDGtXiEiofccepm8FZ5nn
	h7sY45OPMYAn/n7Q3avGSD+br6MeMCl9E7+kxPPfzy82Ul5j87dwNJGSmrq2HN7AuTagJo5ul6e
	yhM37a/wudE3jaTS9GLYcxrcx1w8beaMLwfPryg0xP/2doMnW+AI8RZUgguzI6nZPZOwhOfmSGd
	ZYF/rrfeS+RJNmnS8EAjZcKvp098icjgaHNXAgXwWuEaoGmQawguuIzUa4KM7A87yQ8LzsdN1uM
	ltXsAwjQ7UkHD3Hag6WFbkgsoG5BzF2eJfZgOnQR1SfcXj0m1dvxkQOsWHo4/xeJpbgsaodJSBj
	pCJFIjJrn/ioY4UGpURImUeHifxMzm3dr1h2q2Ei4mRVKF7F8AQTSu8QHLaybojdUqew62Hdf4V
	FKjXLiTyjoS9RSHCLzoor64HKWpA==
X-Google-Smtp-Source: AGHT+IFrMbMVzab5Rj4WbT0evERr8uBJOd6ao5iaP3Dv1k5XAo7Ky5wuHi6tXAqFVzNQo5RQ6s2gYA==
X-Received: by 2002:a05:7022:fb0b:b0:119:e569:f85d with SMTP id a92af1059eb24-11c94b90cb3mr1713151c88.20.1763713107996;
        Fri, 21 Nov 2025 00:18:27 -0800 (PST)
Received: from localhost.localdomain ([104.128.72.43])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11c93e55af3sm20997352c88.7.2025.11.21.00.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 00:18:27 -0800 (PST)
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
Subject: [PATCH 7/9] zram: use bio_chain_and_submit for simplification
Date: Fri, 21 Nov 2025 16:17:46 +0800
Message-Id: <20251121081748.1443507-8-zhangshida@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251121081748.1443507-1-zhangshida@kylinos.cn>
References: <20251121081748.1443507-1-zhangshida@kylinos.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251121_001829_030977_918DF12B 
X-CRM114-Status: UNSURE (   9.97  )
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


