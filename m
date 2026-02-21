Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1D97C5DF70
	for <linux-nvme@archiver.kernel.org>; Sat, 21 Feb 2026 03:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NXu/gPjFkEzi2Q+OHDdxkBiS2LRCgR2xtZ9vFmofSGU=; b=ZBhT1Fgn/N5gcGD3TTL0g1bUIA
	ApVkxoJTgS1pITqC3F4w4yRqqvD3SY0mWdJAz8XysISpPL3W924aI9vjP7hBluSfQsngRyVV4Nvoj
	oeAEWhXaE38yftYv47LfsMVpSwx3qhp0xTK4FOGtu/+WgxBanIOq8FLW1OY/6SYcm0zOb8WK4/Eku
	flamX370OsAd/G2606IRZ2Jn5wQStpsAGpovyKVfBMouLFraDUcxyLiyNpLR8nmxwObCNr/WZGT1Z
	E5AD7yJVddhmqsIJSH37fqzUwz79ft2jaPaRoOQZzr/gY9kqCdoidNYgRa1LEvbIXFu4ShoIjgbHq
	p09jthOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjx-0000000FnYa-2Fbw;
	Sat, 21 Feb 2026 03:33:09 +0000
Received: from mail-pl1-x661.google.com ([2607:f8b0:4864:20::661])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtdjv-0000000FnWO-0kZR
	for linux-nvme@lists.infradead.org;
	Sat, 21 Feb 2026 03:33:08 +0000
Received: by mail-pl1-x661.google.com with SMTP id d9443c01a7336-2ab08e6c553so1408475ad.3
        for <linux-nvme@lists.infradead.org>; Fri, 20 Feb 2026 19:33:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771644786; x=1772249586; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NXu/gPjFkEzi2Q+OHDdxkBiS2LRCgR2xtZ9vFmofSGU=;
        b=J03ojCCo9/ASepNerko5RCbVssB9lgriFeWP+Y4ZZRbdCXgsvqV5bsjg2qe+C/KAJ2
         uq6wsO46ES1ANv8X/mp3YaVprZulNjY2fQ/plxTJ9Xr5bjN/swe1B6Tqk8Td8oG5/E6N
         Yzm1yTOZoKpC3uHR6GuVWYcCLz8oum3nrzjfMtAo0x8CpB9z8F6Mpaxnu11pTKXCaicf
         WlkWIR20raJ20+RzcWh5hCwQUZVbq6qAl5AIn1K0guPtEio0+iMH+SdxaT7qxstJV7zy
         SFjJVVycaTY8o3JgmPmv2g7jDaQoWwBJ/C4yEt4orjVCn3KOxdvk85V/eT/WaLB14WGn
         6K7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771644786; x=1772249586;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXu/gPjFkEzi2Q+OHDdxkBiS2LRCgR2xtZ9vFmofSGU=;
        b=FQCjUovIWqulyzTvJFlPgRJ4/DrKyDZdQ1QH3yuz0B2ZkCcbF18CdMXpl9IyVOrTOd
         cPN4qtxh9af3TD7qqffUqk/KAIScuheuBSFo65ThJjPKCSDRtUzsYlPZnz2zDHqGBNBs
         CLF4xNNoJ2sxSU07V/ukuA6L0ZQqpqiTskd0cuGrRwvwlHFXSVtvhI2pts6j06u6PfEx
         tDf9a694hbaZQiZUVj17iyFA9fXiYe13fG0ymO4ii0aZTdCeYye+5K/HitZJ2VRZzsA0
         TVXAbvSnFS3ZRJ56zBtOyEl+82bb5ueBuT0t5vrVUiEyB17iv+JyKBb4d5e8k3ywt4Xr
         J0Zw==
X-Gm-Message-State: AOJu0Yyd+oqCtUR55lW42fMSyTm8DXwzl9Xdj+yoP74ee8DTMSJLDNFM
	leo/8yMkQgFohu/BJNtVznVqfVsU3Nb9AEklKgiubPG+eXE/WBe1lj91VhVhARvESq1ZtWSuqxL
	0ZDWoEcUjHLVYEsExFPbfUop2C8311jhkuH1p
X-Gm-Gg: AZuq6aJxKrOQEmC0g8XM8Z6dM9VUJXcbtmfkkcHh+8+9blb2NRcA5cHK+mlPEqEaxT/
	LliiNCgAwiIFbtGonTZA9dXQbrRYGDgOiFOaW9U90Xg6eDJ3Ued+UvSrxoTSesHtSiMuKcHxco0
	7v5W40zu+fn/GEdcVwOdVNZTUmhkNMfvlsG5ZNPURXVdeszeEZNdcM+gDTs9/RL3C/xyzBoeww0
	FTJDMM68TgGuuLkrK34Q1K8Ro5uZIyaz04bVvPXsAjoFPkAiJ7fbrWAHU559mYvmrR9YC0LGjbl
	rPWazMxZ7gOxRPeuNit0MD+HqYUr8wknbPFj2sX6yFL9g0m+KCDL1jK5ZSI/IqCYHde6GIu38Rc
	IMiHJ0XktM3Wfryn+NVilk/Nu9z/mRraKDGDnmcLEw95Wu+NPS0B8mw==
X-Received: by 2002:a17:902:dac9:b0:2a0:ccee:b356 with SMTP id d9443c01a7336-2ad7445409amr13401605ad.1.1771644785898;
        Fri, 20 Feb 2026 19:33:05 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2ad74e1890csm1574005ad.14.2026.02.20.19.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 19:33:05 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 2603B340648;
	Fri, 20 Feb 2026 20:33:05 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 118A6E427C8; Fri, 20 Feb 2026 20:33:05 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v2 0/7] nvme: set discard_granularity from NPDG/NPDA
Date: Fri, 20 Feb 2026 20:32:55 -0700
Message-ID: <20260221033302.1451669-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260220_193307_217307_C20E290D 
X-CRM114-Status: GOOD (  10.22  )
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

NVMe block devices always report the logical block size for the
discard_granularity queue limit. However, more accurate values may be
available in the NPDG/NPDA fields of the Identify Namespace structure or
the NPDGL/NPDAL fields of the NVM Command Set Specific Identify
Namespace structure. So use these values to compute discard_granularity.

Also fix the use of the OPTPERF field to better comply with version 2.1
of the NVMe spec.

Update the target side to report NPDGL and NPDAL as well, in case the
discard granularity doesn't fit in the 16-bit NPDG and NPDA fields.

Caleb Sander Mateos (7):
  nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
  nvme: fold nvme_config_discard() into nvme_update_disk_info()
  nvme: update nvme_id_ns OPTPERF constants
  nvme: always issue I/O Command Set specific Identify Namespace
  nvme: set discard_granularity from NPDG/NPDA
  nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
  nvmet: report NPDGL and NPDAL

 drivers/nvme/host/core.c          | 74 +++++++++++++++++++------------
 drivers/nvme/target/admin-cmd.c   |  2 +
 drivers/nvme/target/io-cmd-bdev.c | 19 ++++++--
 drivers/nvme/target/nvmet.h       |  2 +
 include/linux/nvme.h              | 13 +++++-
 5 files changed, 76 insertions(+), 34 deletions(-)

-- 
2.45.2


