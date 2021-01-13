Return-Path: <SRS0=mLmp=GQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BCCAC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 16:08:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FE3823437
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Jan 2021 16:08:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FE3823437
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=smartx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GH/X/K6luHfutKVg/WsbsONxG6wJVmYMEKYKja9ivbo=; b=y0gUvLUhQdK6xmjUypPDiUHpQa
	ifxvrqXgDPUIsxE96D+H7lQoIKWH3n0A5HuLKlJuUlkpD31WI/pAkoWOUEQhsG6AmJDt4awCl6Zsa
	0TckHUuaffmDCTktRjJd8G+7fMx0RrFY65qrT8/qujoV4W2LP3LoSMJpcyBHgVLpD3Id9OdPYOXJC
	0yaB+KzgSuSbOucJ4RsbULNFB2SV1nm4l+xE18nSd/SDZaKX98Y/FF+cH3Cyi1d5CpTbT6t9WjdIA
	rsBcjYcU4POSKQsErSepdfHRnqdkLs5MBdODIamNHocv3/8E43ap//NK0Sr0w22kEBOUNJDjSFRvx
	EfVz1LlQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kzifp-0002ny-Fn; Wed, 13 Jan 2021 16:07:05 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kzifl-0002hN-AH
 for linux-nvme@lists.infradead.org; Wed, 13 Jan 2021 16:07:02 +0000
Received: by mail-pj1-x102d.google.com with SMTP id cq1so1423098pjb.4
 for <linux-nvme@lists.infradead.org>; Wed, 13 Jan 2021 08:06:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fWYX5axM/7U2whKGEikiA25DwObp3mUK6JPnMa57LEI=;
 b=GA59jukFTT6iMUmAwfJg3XjWW6Ao2tQZ0kIPJ1t496PV+tsNcMA9uK5QUfiY9cQpz0
 UlWFRF8Mq2Ki0T+153ZL6r/j8Up/Lxik74QvpZFVTGVWHVNgF3Y4mEXpjNy4sCd71DFZ
 lmxphMcc7H20liGUcucFywLy0Uury7jUTP+Oqy0Gc0INLscFLaxUt6Gnjg9yb5A1fve0
 PYCwDj8viAqHWdwfnITTatsVpN17JZe31FXIHosIo+0t8efRifKUwMGQiDwWYedCKw66
 xzmBO5ruKnACJT+bQCLbtgk3sXSQ1R4C8o9CeC4mBTRQcOj+UjCf3U8njbjYLteohy3x
 K6nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fWYX5axM/7U2whKGEikiA25DwObp3mUK6JPnMa57LEI=;
 b=XiKhY23TcDD3mITUUoghWUHMizo8b8ClvNJIPWcx7IIUlAZNUdgZMZIlGBYHC+6r5O
 bwHtkJCfsqu9U8ahKKq/hJ9L2OXRiLZuoJIWldGHm1kB0RF6lNQr4y3/s4y1KswnhlAv
 rjJpkbhxSwHU8LprklYrpUnklRKvxh1uaZbWB7QluknoZtrarwBf/1IB4ESemxipaTsy
 6W/BwnVepBi+s4P2G92G2C/UDpUzu+fD2IWLZVFse58kcAvQCHAvfZLtb7o1rHOWX6Gi
 KcQ8CBisYbp6HzRpr72UnGJ3SzE9caNyQGnqC6RHGdj5BxzkbzoVf2uCQazoaBjGRaE6
 fUbA==
X-Gm-Message-State: AOAM533RtnJEkwEDtVqgAPXZbetFYSE4Wm82m/7FsErXTEZjIMsB1vK4
 7fb9IvaK7ICd4UrCYIjOBYoF4A==
X-Google-Smtp-Source: ABdhPJyIHERuVcZam0dSWgr2tqyRZNV0jSQu5v3V/s8IzWrs+7OAT1lO97HIK1ZvDbN0+FS5jwsPjA==
X-Received: by 2002:a17:90b:23d3:: with SMTP id
 md19mr3199618pjb.119.1610554016394; 
 Wed, 13 Jan 2021 08:06:56 -0800 (PST)
Received: from localhost.localdomain
 (ec2-18-163-103-0.ap-east-1.compute.amazonaws.com. [18.163.103.0])
 by smtp.gmail.com with ESMTPSA id c11sm2425384pfl.185.2021.01.13.08.06.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Jan 2021 08:06:54 -0800 (PST)
From: Li Feng <fengli@smartx.com>
To: martin.petersen@oracle.com, Johannes.Thumshirn@wdc.com,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-nvme@lists.infradead.org (open list:NVM EXPRESS DRIVER),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] nvme: reject the ns when the block size is smaller than a
 sector
Date: Thu, 14 Jan 2021 00:06:21 +0800
Message-Id: <20210113160621.98615-1-fengli@smartx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210113_110701_501137_CA12249A 
X-CRM114-Status: GOOD (  12.13  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: lifeng1519@gmail.com, Li Feng <fengli@smartx.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The nvme spec(1.4a, figure 248) says:
"A value smaller than 9 (i.e., 512 bytes) is not supported."

Signed-off-by: Li Feng <fengli@smartx.com>
---
 drivers/nvme/host/core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f320273fc672..1f02e6e49a05 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2161,6 +2161,12 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_id_ns *id)
 
 	blk_mq_freeze_queue(ns->disk->queue);
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	if (ns->lba_shift < 9) {
+		pr_warn("%s: bad lba_shift(%d)\n", ns->disk->disk_name, ns->lba_shift);
+		ret = -1;
+		goto out_unfreeze;
+	}
+
 	nvme_set_queue_limits(ns->ctrl, ns->queue);
 
 	if (ns->head->ids.csi == NVME_CSI_ZNS) {
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
