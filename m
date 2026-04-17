Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7842CF8E499
	for <linux-nvme@archiver.kernel.org>; Fri, 17 Apr 2026 01:57:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FUQOgbnR7fb9TvRKeaJrBXV8GjBjh4S9IAVC916d1UI=; b=01CsqYVd0gO1JrwPjG0JTVJ/J7
	A9YxmUAj/sWFYfpIEoAZ6sBK0sNP4BkJV7T6YUDNljSqa1Il9EKD8SoGKLh5i8ckzj9H78Cd/11W6
	I90F/lav+sw9idQL9tp6q6zYQM2bNN1mm0CBobE/zYT1kpelzLMgA0QFnpSN24NTQr0lKfk/hPJx3
	HW5xgz3IA68tdGtueVEQxtE/fIsf1hYsymgmDtU4jp3J7cBXjPvv5fzxCt9sBToIyIgugbTJNpF/H
	CcW7fyyrVc1IlAhkK0krPHBqMMFk4ENNy9wWvZl8Lwebe65A6b0wi5UZipR+W+SuDUxUjAkrNvBUo
	chJPjYAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSm-00000003IF2-0FLg;
	Fri, 17 Apr 2026 01:57:44 +0000
Received: from mail-pf1-x462.google.com ([2607:f8b0:4864:20::462])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDYSj-00000003IDD-2POY
	for linux-nvme@lists.infradead.org;
	Fri, 17 Apr 2026 01:57:42 +0000
Received: by mail-pf1-x462.google.com with SMTP id d2e1a72fcca58-8296e257735so36218b3a.1
        for <linux-nvme@lists.infradead.org>; Thu, 16 Apr 2026 18:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776391060; x=1776995860; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FUQOgbnR7fb9TvRKeaJrBXV8GjBjh4S9IAVC916d1UI=;
        b=WEdEnV/PGKOfJh7DfreKqLN/5EpUnEC/zl9qlE/C2MW/NMIdJqvOT3Tps2qKCkKGhm
         onjbdjnKO0LDtSDlRdFX1Pqf5CiGCGce+hE6sJI+qVgm9oodYOZ+qSAJdmIUhvHC4GMB
         IK9mSNzcX/2Vv8Z/1cNcu78/xtk5sNIY2P2+PP0rrVw5JhSuh9KGYRJ9+YbysbDej0P0
         i4I139nF7VHshDdfYMGUHm7Dhfl/SKAwnb/n+A1NZyaMEwe1VnCAFSwEPi7rpWHGzjx9
         S7Jsa0iQMOwgFpkEbLx0PLiIy6iaECFvJR9Yws3NW0xAojEyzb/zmsaHx/yDFD0qfCgo
         lLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776391060; x=1776995860;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FUQOgbnR7fb9TvRKeaJrBXV8GjBjh4S9IAVC916d1UI=;
        b=kmQ1WAGpzFSOWORAie8xs4xrrte+R6/+BdTXuCOWb4OGSaHnF3MOha2BTw+lYD8GL4
         E9237x4fvsEmD3Z32NaryBqUascEXhspEMDhyqYZxj9gcRHnCsyoIJf7rKsH6kluB0XZ
         RIMDxeXExW162dwDlqdPZWlgQWRuCHBJG4YSKdMpt1poSg89fWbjMCQEEfwN727yYBgd
         Hq3Om/hvgZJAsXzZfIYRqzJCHmxfarXAvJfSFiJwY3NqAP2jLCIoDcNvp12/vdd/+Jty
         9N2ZRwb1XV6fTx4DIv6oBsZyiDyX0vqqLLy8n9MDH+WUrHp83E8cXoAzFnWnchG7gN8j
         if6Q==
X-Forwarded-Encrypted: i=1; AFNElJ8moiTvF/LtrUHcorhjDTqLaczqi8SDyLfU8A3fSxhc+kTcRrGuhJWjBvJ5tQ8d07TujNFoVngyO8FO@lists.infradead.org
X-Gm-Message-State: AOJu0Yy11smn46EWd2SsB0RoGK9xE4BwRBz0vAEOdXx1xhjigL2+1uyP
	h6ZiEyH7ppQT5XLO0HjyNARp2do99kFrF1nL/8ZdEvapt5vxKcLQVigUC7Ock+nJdsaebGDTy3N
	Ckg9lNwYu+IDI7DlkoguNUeSHLLHpbM8PTXQuuM/g8M1c7OvtDfhT
X-Gm-Gg: AeBDievkMl8QBGAm3qCx09YDmrPzVrNXNpowQBHF7bOr2oqhZO2UaxZfVf+C+MGjfjg
	tV7akhBgmGiPtsxKhlGXRU/60vn/GztqBG4gMziDU5dgIrB5fIOwbABj2WyxHMExCldzezdnaUF
	moUfqQeuiV5EWKjDs3C1Li43TUdDFbey5XxGhGFddWPlQtDtCHgcmuZCf4XcJGJmxNjntshX6yw
	hXlsB3KU1XGId8s+i03zV3tK/GSQwT6WO65xp1z6YAtWnSGao03DC22v7ROAPZ0NotlrU1NZePO
	AmfdUuPs8QCKBuEhFu9HUsYY/RGKHrx1VCi694W2nw7o3n616Dun2lKX8nJKSkFXTnNLEDtmdwt
	S/oHC/9yv6tK9VYux7MwCmLHo8uFjaAzTSeg4kPo/qPsF3WhV8w==
X-Received: by 2002:a17:90b:1d52:b0:35f:b204:c62c with SMTP id 98e67ed59e1d1-3614022c036mr490528a91.0.1776391060538;
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-36141943c35sm24518a91.3.2026.04.16.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 18:57:40 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id C637C3406AA;
	Thu, 16 Apr 2026 19:57:39 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id B6B12E406BE; Thu, 16 Apr 2026 19:57:39 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v3 0/6] block: fix integrity offset/length conversions
Date: Thu, 16 Apr 2026 19:57:26 -0600
Message-ID: <20260417015732.2692434-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260416_185741_616789_C0763660 
X-CRM114-Status: GOOD (  12.14  )
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

The block layer's integrity code currently sets the seed (initial
reference tag) in units of 512-byte sectors but increments it in units
of integrity intervals. Not only do the T10 DIF formats require ref tags
to be the lower bits of the logical block address, but mixing the two
units means the ref tags used for a particular logical block vary based
on its offset within a read/write request. This looks to be a
longstanding bug affecting block devices that support integrity with
block sizes > 512 bytes; I'm surprised it wasn't noticed before.

Also fix the newly added fs_bio_integrity_verify() to pass
bio_integrity_verify() a struct bdev_iter representing the data instead
of the integrity. Most of the integrity data is currently being skipped.

v3:
- Drop bi and bip arguments to bip_set_seed() (Christoph)

v2:
- Reorder fixes before refactoring commits
- Use u64, SECTOR_SHIFT (Christoph)
- Don't take sector_t in bip_set_seed() (Christoph)

Caleb Sander Mateos (6):
  block: use integrity interval instead of sector as seed
  bio-integrity-fs: pass data iter to bio_integrity_verify()
  blk-integrity: take u64 in bio_integrity_intervals()
  bio-integrity-fs: use integrity interval instead of sector as seed
  t10-pi: use bio_integrity_intervals() helper
  blk-integrity: avoid sector_t in bip_{get,set}_seed()

 block/bio-integrity-fs.c            |  8 ++++++--
 block/bio-integrity.c               |  4 ++--
 block/t10-pi.c                      |  7 ++++---
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 27 ++++++++++++++++++++-------
 include/linux/bvec.h                |  1 +
 8 files changed, 35 insertions(+), 29 deletions(-)

-- 
2.45.2


