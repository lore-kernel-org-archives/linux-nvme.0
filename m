Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5E4C531FF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 03:28:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ptMOCF8NjnbTdAq6XG34n7GRmdz+Z/rsqtMtW/eBnI0=; b=Q2CTaVRT/sdrHHWK8OKlMY7jb8
	4ClvDcOAoH31V9q2hqMdznY5/uiG546pyccvr30EHMLnhTErG9ZLA6KeqsxIQaPJP4/IMSe3GtkFK
	VI0FxWo/NDwEyBfdhsy4OoAfg5pDeaNUyDgKlHrF0JICI1F0FXaaCK6mUFIDI++uUEHY/ozw32izF
	5ZvVgddzZBZXkCf6Z2JumkuP5LpYo5uCDzfWJvJsmDB7+5XIA53la2MsaNLFphQYDIH33QxgAKX1+
	EZFOb8tjoW1+J+M5G5twCLhgeFgVgZjGc0oZgP/lWudZo4Xb9/TbAOhRKZBKGyur6en9YR2LyCj9o
	KwDyktNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBm-0000000DA9O-09Ts;
	Fri, 20 Feb 2026 03:28:22 +0000
Received: from mail-qv1-xf64.google.com ([2607:f8b0:4864:20::f64])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBh-0000000DA6n-45xg
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 03:28:20 +0000
Received: by mail-qv1-xf64.google.com with SMTP id 6a1803df08f44-8946421dd8fso2307906d6.0
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 19:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771558097; x=1772162897; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptMOCF8NjnbTdAq6XG34n7GRmdz+Z/rsqtMtW/eBnI0=;
        b=NsHW4qSjBQiEGOp0qHTDwol4/eACUVfNPHZxrEdAXhff1rpf1KdzLwKIShBVJV3KSj
         ZLggZg8TSRNY5vIo5saEkVmGNt3BebOGdThATn5Djv1ytKbuvI9GxpA6kXmmC1XT17xO
         b4gkYYI7A7fgTSosVf2QWfu/RrFRi3PlwKQWeGHttFry6gUZOTUMZCRpH3WrRyrOrqSi
         42zeSHUjR6YS6RnFUCNWOp7LXDMhIM5Y1hU9P69nx4mNnSKp4hDg3A/MBB/YyvxaoVAn
         cwZWX2DFY6olouqsk72kOOos4BMDteH7Yy8d7f4KmADmxPeRNUGEZhs2WZDv2FQ1iUOX
         Xkmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558097; x=1772162897;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptMOCF8NjnbTdAq6XG34n7GRmdz+Z/rsqtMtW/eBnI0=;
        b=CaNa00xyPDMlDyDLugFB996R8oTLn7vxCrUB8xC1ylleB6pntFdoo07xjw/9Qonk6Z
         Li0asqAGR1pBIBFRtMBdEIrvrXCNKlR/DXc6xBQGXIr+u8XMaGycosknXk7Pz5cM39zM
         5gV15x5KQrY4N/Boiilkwg3nzoVnAdqMPZ9BtoV+75Do+X5qhR15oQb6KUlLOhpQSIWS
         EpTL0ECRSW1cCMXlObuy/Hqs2dvBKi0FQ5DXTVDdN9mszkVva8OB0XgvBceLGmSoItJu
         G0AbGevZ6ckxWGdS8911QDcOHTDm3J8SLG8V8lJ700m92H/4/TEKLscIyUMe1a7w7S51
         nLvw==
X-Gm-Message-State: AOJu0YwL0xSAq4hJeyYUbNbPCs5FrCHxW6ju0kw7D/xqLGT/LfMOkpiu
	CNm1wnADd1fYVspofeUMhZndEJw6VyTl5BLkFMjJ1Nv6xIVpgSl1PcbW9E1cB7XivWhHUqPTDVC
	HFN9j30RF1KR7fej2qFdfaZ6u0BdHhAGsFuzTjK8c38vizHfHDcM0
X-Gm-Gg: AZuq6aKuMbW2TFniG4SZu7naYuwcszu88pl/Q3aIBkFBpl+GnWuYf/TijNOPc+Q7m6h
	4jIC6HDYDaeuGhOU3rH0IumF4gnO4CXO/e65MAni90IWwo8d+ahpwdZCG541bwsg+5QW3mLVb6W
	Jx5Js7kerEKax6OxgCy4tb2lx4OnE30j3dlJ1j/b9Dj8GbpdEi5lhfUR48RmIIX98Kz1Rgdbtl0
	iA7Sv+n8/EB73e7cKYfIy6EdwUN4EgnL4bjEfUwtSqBOsfYj6idXslNnWc69jLol9s5M9cpmjQc
	S8QOY5/6/W/vQM57QSLd7WK8mLFTbTId6+cP5RhbsWRtEYNaHXd+1Mr9WjLsWyIoN2B1dy7vzCn
	7wkKNn3g2F/iF6LAq2PdJfAe7l8d4CNSSrWFudZk=
X-Received: by 2002:ac8:5e53:0:b0:4ee:1db1:a61d with SMTP id d75a77b69052e-506a6831f24mr237407291cf.3.1771558096686;
        Thu, 19 Feb 2026 19:28:16 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-50684a3e737sm27357291cf.2.2026.02.19.19.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:28:16 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 0B2FF3408B8;
	Thu, 19 Feb 2026 20:28:16 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 0814AE420F8; Thu, 19 Feb 2026 20:28:16 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 2/6] nvme: update nvme_id_ns OPTPERF constants
Date: Thu, 19 Feb 2026 20:28:05 -0700
Message-ID: <20260220032809.758089-3-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260220032809.758089-1-csander@purestorage.com>
References: <20260220032809.758089-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_192818_074352_E8A8DC97 
X-CRM114-Status: GOOD (  13.13  )
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

Since NVM Command Spec 1.1, OPTPERF comprises both bits 4 and 5 of
NSFEAT in the Identify Namespace structure. Replace NVME_NS_FEAT_IO_OPT,
which represented only bit 4, with NVME_NS_FEAT_OPTPERF_SHIFT and
NVME_NS_FEAT_OPTPERF_MASK.

Update nvme_update_disk_info() to check both OPTPERF bits, as NPWG and
NOWS are supported even if only bit 5 is set.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
---
 drivers/nvme/host/core.c | 3 ++-
 include/linux/nvme.h     | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3a2126584a23..674dd823b209 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2095,11 +2095,12 @@ static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
 	}
 
 	phys_bs = bs;
 	atomic_bs = nvme_configure_atomic_write(ns, id, lim, bs);
 
-	if (id->nsfeat & NVME_NS_FEAT_IO_OPT) {
+	if (id->nsfeat >> NVME_NS_FEAT_OPTPERF_SHIFT &
+	    NVME_NS_FEAT_OPTPERF_MASK) {
 		/* NPWG = Namespace Preferred Write Granularity */
 		phys_bs = bs * (1 + le16_to_cpu(id->npwg));
 		/* NOWS = Namespace Optimal Write Size */
 		if (id->nows)
 			io_opt = bs * (1 + le16_to_cpu(id->nows));
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index bc991d4ae89d..f279e5d72e2d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -593,11 +593,12 @@ enum {
 };
 
 enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FEAT_ATOMICS	= 1 << 1,
-	NVME_NS_FEAT_IO_OPT	= 1 << 4,
+	NVME_NS_FEAT_OPTPERF_SHIFT = 4,
+	NVME_NS_FEAT_OPTPERF_MASK = 0x3,
 	NVME_NS_ATTR_RO		= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_LBA_UMASK	= 0x60,
 	NVME_NS_FLBAS_LBA_SHIFT	= 1,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
-- 
2.45.2


