Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D288DF4BB60
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Feb 2026 17:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ooHjh6HrTZHmSmxByDLdiCmY2zTnKYEXcZkNLfcMiWM=; b=kMUC2K2wxVQ/SDa5XoHZ1hT5xX
	xmWArMLB3Nd56CpLYd9SBdD/eAs7Wa91qVWGEatcQ9+1yj3KmpL1tcvkkOjRdeC5Jb65k90tJ8/3W
	9V9cRP1OiLDKXTMO2zJ4nHvTUpm1naEbfTWRPPaZQMum4gPQ6hKljd/EVXdyEeUmqZzVqsRduMbpE
	nmSVq/IIWhyBm64+1bqKQYiHXogeisIT2SOwjgAlrevg4uG2HxX94rsa+NAkKBgSzXUujW8yMxJna
	0dbSjM8udqfHD7qDOB+5RQXC46/SN9iMoyfcUwjE/juMSAPaK4zX5JEzxFE1ftN38NGzFeW7LG9ge
	4Eonx4Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuw05-00000002SKN-3gOk;
	Tue, 24 Feb 2026 17:15:09 +0000
Received: from mail-ot1-x364.google.com ([2607:f8b0:4864:20::364])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vuvzz-00000002SEK-29ms
	for linux-nvme@lists.infradead.org;
	Tue, 24 Feb 2026 17:15:05 +0000
Received: by mail-ot1-x364.google.com with SMTP id 46e09a7af769-7d4c5efea44so793787a34.1
        for <linux-nvme@lists.infradead.org>; Tue, 24 Feb 2026 09:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771953302; x=1772558102; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ooHjh6HrTZHmSmxByDLdiCmY2zTnKYEXcZkNLfcMiWM=;
        b=OutBt/huLWBTQoNe6ACb0e7zDnbtWfsXK1oJYHSbxEh1sVmV4GBYgud4hlDEnCLR3p
         lBYriqT6tGbsi9hwcjLVwV0diJ1ynZQtvkabyEkgEMamgdYMJMG84B3BaeXHXRXStNBx
         Ex6wWhJAxMQ0VWm3k7zaF0MaOab9pUoX9qXy4OC0Poch057HEH/dm16ugjjIQXsrVmlq
         wXavVLaKlSanxGoAOHnKF7NRP66Rwv4+7xoLY+qqnJe1IYsvvhd/fxxXOlj6eFYgnlzL
         Nog0COm65z0Cw6HFTKXcH6u0cUuQ7zCgGQ8f7aLxmMAeocfgXl053gfJ19+4oao07P+p
         RHiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771953302; x=1772558102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ooHjh6HrTZHmSmxByDLdiCmY2zTnKYEXcZkNLfcMiWM=;
        b=tDNreNXAuqAlwFG769hPVg3WvYOQ4mw2u01CdGCO7a4uz5I9OuLikfjCVoox0QgvTS
         cz473cnohv05+EaN3Mm6KAafpIkl2R9kd9BKoYJnXpANQjZQxi7RnCQDHOUyEkfEMqt2
         yxvkYSL8ur7nFWVQ93M0S4aeFId/tCUiPD5Y4A6bUcRS9BIbsFxnOyahnp7ETI7ZZS4o
         kjpaeDXQf5HKd+rvVvNbS+nPy2qtv8itlVpMYeiXI56TZSTF6l4Z+pak5ZgzopwnSkRb
         lo6HoGFslXp4ou4ZW7Ou4l3c2Ds0Ards4phAOTUrQSkiA0YIXjOsZ4PjKqd2S2ofeN2O
         YTkQ==
X-Gm-Message-State: AOJu0YxehiuFBxxsxl57djRVZMvI2YPfjNZvGGIY33l1Mp98NoIn28+i
	G75LKHJyfp6fQCCdEDZ1nUA87a66/zUxsZXXCwZFXy8BxGdDtjZLg0JRJy8q893RVV5B0clEAUt
	PpEWJLoik5F+jk3v1h2abNeHr6cfM7kTTl9IX
X-Gm-Gg: AZuq6aLiMjUTMnHJZM2A4ZHJMCSP+ctzSAP58NDgLWQa/qWP5Cn3ptV+fXjQIXQvlBX
	DliKD9doTBqJIiDEEN8+d7nXb6vQoifJsMZfSJ7uKgxC2yY7qbv4CiurguP/+ETBb5mfZftjlh7
	MuvQzThpORcj9zlqsEoh6+FZLSR4q45i2+bjxToTN9tITU2KI6ds72xqTY4jVYLqmC/QMQra6GN
	I5+NHcpps2+vqUEob1ptBHa3SU/Pnppef5WTa8TbMj/WvBSzW8sO9yEvI1XdRkLUFgI7JG2tA83
	0uOW5xXND+YsvBVwSChM80a9BkkTahTIvfBTSiPBZ6aOEpc5kJzvXRiafPpGLVlvFJVDopUpMBG
	6NvbWwOsmceKkmwfviI7NDkoZytnwzaQQWIPCS431hcayEVQ/newEpA==
X-Received: by 2002:a05:6830:71a7:b0:7d1:4684:ea96 with SMTP id 46e09a7af769-7d52bf24219mr6568321a34.4.1771953302166;
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d52cf74750sm1233685a34.2.2026.02.24.09.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 09:15:02 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 4CB4A3420C0;
	Tue, 24 Feb 2026 10:15:01 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 484C1E41254; Tue, 24 Feb 2026 10:15:01 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 3/8] nvme: update nvme_id_ns OPTPERF constants
Date: Tue, 24 Feb 2026 10:14:32 -0700
Message-ID: <20260224171437.3175993-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260224171437.3175993-1-csander@purestorage.com>
References: <20260224171437.3175993-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260224_091503_565955_B8608D29 
X-CRM114-Status: GOOD (  15.89  )
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

In NVMe verson 2.0 and below, OPTPERF comprises only bit 4 of NSFEAT in
the Identify Namespace structure. Since version 2.1, OPTPERF includes
both bits 4 and 5 of NSFEAT. Replace the NVME_NS_FEAT_IO_OPT constant
with NVME_NS_FEAT_OPTPERF_SHIFT, NVME_NS_FEAT_OPTPERF_MASK, and
NVME_NS_FEAT_OPTPERF_MASK_2_1, representing the first bit, pre-2.1 bit
width, and post-2.1 bit width of OPTPERF.

Update nvme_update_disk_info() to check both OPTPERF bits for
controllers that report version 2.1 or newer, as NPWG and NOWS are
supported even if only bit 5 is set.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/core.c | 8 +++++++-
 include/linux/nvme.h     | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8dda2fe69789..bff6f26d7bcf 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2062,10 +2062,11 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	struct nvme_ns_head *head = ns->head;
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	u32 bs = 1U << head->lba_shift;
 	u32 atomic_bs, phys_bs, io_opt = 0;
 	bool valid = true;
+	u8 optperf;
 
 	/*
 	 * The block layer can't support LBA sizes larger than the page size
 	 * or smaller than a sector size yet, so catch this early and don't
 	 * allow block I/O.
@@ -2076,11 +2077,16 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	}
 
 	phys_bs = bs;
 	atomic_bs = nvme_configure_atomic_write(ns, id, lim, bs);
 
-	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
+	optperf = id->nsfeat >> NVME_NS_FEAT_OPTPERF_SHIFT;
+	if (ctrl->vs >= NVME_VS(2, 1, 0))
+		optperf &= NVME_NS_FEAT_OPTPERF_MASK_2_1;
+	else
+		optperf &= NVME_NS_FEAT_OPTPERF_MASK;
+	if (optperf) {
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs = bs * (1 + le16_to_cpu(id->npwg));
 		/* NOWS = Namespace Optimal Write Size */
 		if (id->nows)
 			io_opt = bs * (1 + le16_to_cpu(id->nows));
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 1134e6bf2d5c..d840f5fe79fa 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -595,11 +595,15 @@ enum {
 };
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FEAT_ATOMICS	= 1 << 1,
-	NVME_NS_FEAT_IO_OPT	= 1 << 4,
+	NVME_NS_FEAT_OPTPERF_SHIFT = 4,
+	/* In NVMe version 2.0 and below, OPTPERF is only bit 4 of NSFEAT */
+	NVME_NS_FEAT_OPTPERF_MASK = 0x1,
+	/* Since version 2.1, OPTPERF is bits 4 and 5 of NSFEAT */
+	NVME_NS_FEAT_OPTPERF_MASK_2_1 = 0x3,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
 	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
-- 
2.45.2


