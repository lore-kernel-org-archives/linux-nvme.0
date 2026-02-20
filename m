Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818C3C531FF
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Feb 2026 03:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NOgVdASCtfEdZpu2pyEPIB/X7jO6X9UX5H0tHLp8bxA=; b=H+g7j7is5ApkJJJPyCnxoEyAdT
	sp6ar5PYkbVmg31tp23ywljtFyrI8659pakrEF8meDs+LCt0/Jpb2sNayBbJUuxsB9pQPDlfeN69b
	XReu57wkEqX2syg3yZ3tOb/PzpjmzZluUy3OmxAPMQKXazsfC5rGKcuNoX/ZLmnjMFarUOC2P8M2p
	5upwPzs+GRJdlQacnMZX9ZgXb9MJFg845o8QvjH6TbOK4W57zk1+7GQSJVWANsxX4I+6cSy4926vv
	/nLTDHs2o4dgkdknVSUTUDKeokU8Gup31ElGT/QGU0j92XJj6Id1Pamrg810P8qGK4IepJkS7JORb
	FloKV/sA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBm-0000000DA9l-421r;
	Fri, 20 Feb 2026 03:28:22 +0000
Received: from mail-ot1-x364.google.com ([2607:f8b0:4864:20::364])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtHBi-0000000DA6p-0vpI
	for linux-nvme@lists.infradead.org;
	Fri, 20 Feb 2026 03:28:20 +0000
Received: by mail-ot1-x364.google.com with SMTP id 46e09a7af769-7d4c5efea44so295005a34.1
        for <linux-nvme@lists.infradead.org>; Thu, 19 Feb 2026 19:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771558097; x=1772162897; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NOgVdASCtfEdZpu2pyEPIB/X7jO6X9UX5H0tHLp8bxA=;
        b=PHw3pVgA6O0UY4WCoXA0Kug8J+oHXWUEU3O0ndgTftSpUVXwzvGOzbdYzTcWWRvXbm
         4pwf5YlpbzMzkLl9X/JO/ZbNfg7RFBn1p9mK3OKhtY0xOnEkjlgXKRsNUZ7OhrY2csQ/
         HgORDsRgP5BOrwIF4XeGeBeRbOMeqkfVwIsmR4UevvZqQ2Qmk84S0Pd2OsjoWU6WOYO6
         VgFZF/bK7ekMSMmO2p7aBVcPPogNI65DM+5hntDRgTrVJcCfaXWaMo3aBPFa6Mr+FUEq
         XSNiB/B16TIMWb7I4STN+rVnKjSXkCbqMxDYKBi7uJu7RB4L+4v9ISe38qODSS9GAh7i
         iVxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771558097; x=1772162897;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOgVdASCtfEdZpu2pyEPIB/X7jO6X9UX5H0tHLp8bxA=;
        b=brYJz0Lb/9XKzUrLAjk9I0t3rtmNS7BA6J7frjq7SO9mamiJP0gg2jpsisOKBjro5V
         ycqJ4+6xYDB3S1l4OK6cESz56lwoYXCYURMZCSDEPYO6x97k1gdnAybYtrzE/RFWF+bJ
         0f2hOCibPhHpFxoJWp6HVZJkhYo2wHVdpzZTtQPkIwgcWkZxq9fwZz6PMXutGQ1hxdip
         eq6TfHMuJcFvWyRIHOXlvy2Xb3o1426MRpJ4JeWKVFRSBK/Fg5+FwYIrBL+Je82uzjSq
         wWswPIzf2lJq9KOYIQOVzqcdpDLm/shmm9jnDJ1hLSbzwPc0FyrXh7ib8rcSjmiPDYk+
         b1+A==
X-Gm-Message-State: AOJu0Ywq2YHdF1Lgz8SgdKDsP7mriiU4BR180VnSpo0m3pp5lR943ER+
	bnG4QijIm15gOzmA9cQKZ9aLlhOzmvVbr2/HpeQNSJAuLPGxK2nKo1niSqDjPiHjB+d3lk73hDd
	+KNHVqh14gey7g7XbCg+iymhl3NfS4Hjt4qkn5T4AKcjnsDrx0bRb
X-Gm-Gg: AZuq6aJrNInFTN4U+j205ZCzVIQdNddfXMZqoXY7KKgqpTnuFIymAwQjYMyNk8dCRlv
	xqwtoNjuKXVh3YVzW+8ry6lQ7k/n/bFDjqTr6cISzV7Ixy2VqQy4cB4HlYnQgzdJuUC4PMhRnyq
	JC9ehPs9tqSZ3kmu6b6yxjoTieyOCp4uyet18xoYHN09BOc0tpqAzWCkiawikZiDVqh6zTuuJGh
	2HzyV4RsBTXtcd2313Se6aMfBMp5W0kILQ5fbPBAu3pLhtChDeM8AMIb9lJzZ5xDcjhhht9wYO3
	MuPESB46cWO0HCd+/F+2jqZDSzrhSlrV/5Va0gWMNPP1NPhoOhLRLyc3oy8lirbBp0F4fRPJwr5
	+5Snq2jevasiuzeHhXNCNWqSZ9BFYi7kpysu9li8=
X-Received: by 2002:a05:6870:c1c6:b0:3e1:739d:4540 with SMTP id 586e51a60fabf-40eeeb309efmr9967541fac.6.1771558097039;
        Thu, 19 Feb 2026 19:28:17 -0800 (PST)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 586e51a60fabf-40eaee45d28sm4640795fac.1.2026.02.19.19.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 19:28:17 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id BA11D3400C7;
	Thu, 19 Feb 2026 20:28:15 -0700 (MST)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id ABA93E420F8; Thu, 19 Feb 2026 20:28:15 -0700 (MST)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/6] nvme: improve discard_granularity spec compliance
Date: Thu, 19 Feb 2026 20:28:03 -0700
Message-ID: <20260220032809.758089-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260219_192818_261252_D321BEE6 
X-CRM114-Status: GOOD (  10.69  )
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

Update the target side to report NPDGL and NPDAL as wel, in case the
discard granularity doesn't fit in the 16-bit NPDG and NPDA fields.

Caleb Sander Mateos (6):
  nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
  nvme: update nvme_id_ns OPTPERF constants
  nvme: always issue I/O Command Set specific Identify Namespace
  nvme: set discard_granularity from NPDG/NPDA
  nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
  nvmet: report NPDGL and NPDAL

 drivers/nvme/host/core.c          | 21 ++++++++++++++++-----
 drivers/nvme/target/admin-cmd.c   |  2 ++
 drivers/nvme/target/io-cmd-bdev.c | 19 +++++++++++++++----
 drivers/nvme/target/nvmet.h       |  2 ++
 include/linux/nvme.h              | 10 ++++++++--
 5 files changed, 43 insertions(+), 11 deletions(-)

-- 
2.45.2


