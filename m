Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0AF7E9A049
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 03:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fJltEScUjLqhErd6IHPXM2JEHFKvvI69iCjPQeYZdOk=; b=MNLbE4c3saJINYdKulM/oX0Z4D
	T26nYcOSFhNjpKYzFMKowyuZ5yfPmCQot56o+BfZicB4cuVWrGcb+0OckjrFXyctZ/BH1tDvmPhmp
	4JdNjxQ3NZe0BecDtbYhqo28SxFfAD/ikKMt5KIPk+jP88RCgvtCDvxxjT6QylDKn2nPUGApe43xy
	jbsOXuoYnJoVHW14riwn53k43i3eeO34dEGgnpv5aZ+q/lB/I41JKPWJirw1wgxDXQzlSBgg79HRw
	6weZ2/cI759CDtymop0YOnGa/xHz69j9KwXQmKOIZYa9dWwswz8/SaMy7WAVHZ0LcjVvI1ANjrUyY
	QuDHIkfQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjz-0000000FnZg-0LIq;
	Sat, 21 Feb 2026 03:33:11 +0000
Received: from mail-ot1-x363.google.com ([2607:f8b0:4864:20::363])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjw-0000000FnWg-0OzG
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 03:33:09 +0000
Received: by mail-ot1-x363.google.com with SMTP id 46e09a7af769-7d18d2f87c4so439134a34.1
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 19:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771644787; x=1772249587; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fJltEScUjLqhErd6IHPXM2JEHFKvvI69iCjPQeYZdOk=;
        b=YbG7h6maWdiINLkcklqec/RMPZvVp8m1FCVyzD5B+QI4HWhjDjWvoodzDD2d9a+iDG
         1XpBgL3X0MJgwopNqkgnm2MGQ4xbYxKooy9RW7scTTqxrUpvYCJwdREDj2RxJyEWEveq
         YwAyFL8SZzOs0XUgCMXrsG2JSffjKYmGjMsQYLkfa+QnjZiSMybGaExLDbT5kmbrmJWa
         qcV30BohpXwl4KbWTYp1rjpz1w/lxyOJItr/mOFop2bQWNn3t4CfL1FODEIJ7gupWtdq
         Mbjxnav+t+1Su/3ZgiPQ8QSdkigJVytnrua4LH4khiCtQcyLg63ETnj5D93WMBkjKesk
         yfLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771644787; x=1772249587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fJltEScUjLqhErd6IHPXM2JEHFKvvI69iCjPQeYZdOk=;
        b=OerhR/srKEEnIpo2YwA9VVw5ijta9dOnFAu0yKemeaTlAxC0tFumaz1flZRSu89vci
         NB6IWwyIKWQDCSLz6/V3dKDe7cDrah6NBFCmXLsUMmEE0oe2QEJlDzkA+8O2k2PGHAO1
         5mxRgZWr3fMfa3gfKHwYeY2atDGRKIArK4C3Sy9rmSdwHQb9Yn9+8R4ZH6wrtIY28FQw
         kkzYECspfQBsswDbPBiCBCgrA4/sR6lJ1CDa8fGb+Pg6EVc2yt4bIFgTWmmCI5/v29S+
         615qFtm/bbL88peJTkZY4F3OyQI2Nlwwit7/xCO84fob4jy5Kjgu1ypGci2MHf1Gnvet
         NQFw==
X-Gm-Message-State: AOJu0Yx/e3k8LOf1DCdgl8/aCjO6BXJUvBWjQr/AYJQPQ9TJePZ9SC2b
	qUaAuk9CriyYs07lQFtbDmZZVnbY57iXDKZrNGVAzibZbx3E21Io8O22NfZ7nZA2+OD+03Sc7st
	/FdoJfo4vUwvfkGCvF+n99E9PobaywqJ14Gbnz9/hiq89JSeFvsXs
X-Gm-Gg: AZuq6aJgeXI+ujQSBty7oxYSIcmENQ1TIxH9YZEVEi/1yNaZNJhfJ4hKHZW1NuaWrug
	aJUZSCcOm74xXvSNJOTj/sTTOqHxPapE3l3s3HP0d6BWsefddz/dUskg+O/RX4WPgoT8IpmPAFZ
	NYElt2eHxngJmI/waaX+zHTcUWxL8cxe4y2Ylw2UKAB5G+3gboRiejzAFsubBHeJtCvNMV4uKnl
	MZmeT0Bbg5jzR/Z3djrzRxdU7eKoWOpDhUt6uSj4sVleU8ALkrMqR+zCWHdoZUMq3GSLnWBVCxE
	EUYVa478edmceBOUm6AEeTE/w84MWb72/T5YkOlqyLeBbmx5isCspgfPY2+zvKGdYFCbOE56ySk
	SAVtwvWSvPIYRw4QzCOTAgnZ02adj7VP9PCkHbLM=
X-Received: by 2002:a05:6870:2388:b0:409:54a3:6a88 with SMTP id 586e51a60fabf-4157abca642mr1008619fac.1.1771644786897;
        Fri, 20 Feb 2026 19:33:06 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-4157d392440sm182717fac.17.2026.02.20.19.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:33:06 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 99976340991;
	Fri, 20 Feb 2026 20:33:05 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 95668E427C8; Fri, 20 Feb 2026 20:33:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 3/7] nvme: update nvme_id_ns OPTPERF constants
Date: Fri, 20 Feb 2026 20:32:58 -0700
Message-ID: <20260221033302.1451669-4-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260221033302.1451669-1-csander@purestorage.com>
References: <20260221033302.1451669-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_193308_135646_C5FF9914 
X-CRM114-Status: GOOD (  15.30  )
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
 include/linux/nvme.h     | 4 +++-
 2 files changed, 10 insertions(+), 2 deletions(-)

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
index 1134e6bf2d5c..a025447212f8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -595,11 +595,13 @@ enum {
 };
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FEAT_ATOMICS	= 1 << 1,
-	NVME_NS_FEAT_IO_OPT	= 1 << 4,
+	NVME_NS_FEAT_OPTPERF_SHIFT = 4,
+	NVME_NS_FEAT_OPTPERF_MASK = 0x1,
+	NVME_NS_FEAT_OPTPERF_MASK_2_1 = 0x3,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
 	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
-- 
2.45.2


