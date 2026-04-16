Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D58FBF433CD
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Apr 2026 00:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=32BeK9NcDM0TTacs4Hgu5YnQIjPRb6EDjdK365GBPos=; b=ZxvV/r8uhYG5+jsCtQXnc9ZkpG
	9IVOY3/Ay1Xf/hNqEIb4BebweNSfuzqZ6HY0fXl6t/JHHAzUZaCClwGJtk3h4RH4puTVHVJYkgDtK
	upPPZzdV0lxyYIt8KJCH+Yrtl1EjADTbdfsRKdsuOlLNZMPvO+c0ARG5lrU5wO/hD2p92t0X+ycX2
	6+c3M0z09+kew/JFiniZodkU6q5vq43mvSovsMMUr8Xa9eF06+0WKakGmPLVpxh2fgGxbkeEIzGip
	hnWXkGdzOI+H54iK1ppLXNTu7fkQ5Gb2yq2jH8qggKjE+JvdzbFBmyL5HGMR673cA3SS2W5ENw1rQ
	FVvPaxjw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVP-00000001ngk-2HvM;
	Thu, 16 Apr 2026 00:22:51 +0000
Received: from mail-pf1-x462.google.com ([2607:f8b0:4864:20::462])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wDAVM-00000001neU-18QQ
	for linux-nvme@lists.infradead.org;
	Thu, 16 Apr 2026 00:22:49 +0000
Received: by mail-pf1-x462.google.com with SMTP id d2e1a72fcca58-8244105fa96so135866b3a.3
        for <linux-nvme@lists.infradead.org>; Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1776298967; x=1776903767; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=32BeK9NcDM0TTacs4Hgu5YnQIjPRb6EDjdK365GBPos=;
        b=dQpNeIhuAgeC/qi1n5apchM6Hh6YuqA94UUviyE+QO+XmmIJEuVEgm7KxbPIhFUtmb
         gRsxN16EIOkCAxVNVqjlHI1w/DN2Uc5Wt3v0D3ZEDNsR7iJ9+PR+w0C/HBxgfTNyPN6n
         OT2hFy/GujUSAnz5xiQPxLzkNhLCjk3H1Q7g9I81eUXI3wQZVGiH1OBWveSZCOTIifpY
         ACV64S9ggyJzoOXUhSyrcGJkgWU0fdmRRbjaV4OR4vIgNQBAxth8CgMfnbVIDnUfg6Qo
         Qj0a8YtI80KHzhNNZdWtaDBhAd34SPnTSU/af1y8y0TYjG5ENQFjB85d6EFm4yfYnBdZ
         oFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776298967; x=1776903767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=32BeK9NcDM0TTacs4Hgu5YnQIjPRb6EDjdK365GBPos=;
        b=PYIb8VsPkbYZk1H5vqTrOQwaNNQuyImHlaha1s6LxoaTnKZlcBJsiodPA2kxBMgOxe
         YC3mkn9bvMPNOBuRf9p8ahtGtdIqN4R0oadM+EEG4T94VU6Ir7u+eU2bZ2c9hPMPX7uQ
         i+haO2rsvt1IWHuSfU4SyTF/A0T4oiEazk5lcN7H1Vezb5OAJWLNVQ3814R+zkoUH4sg
         IHSI/eBPD5NESuJH2gQFCTBPMtuEMWEQNAvXfuZrQ68c0aBf7+udkEOKkeA/X68aF3Fz
         qv8vx5v17NQBhX6Q1LiIaTXkQ6/jh3T6LG0uFCkL75CI9WoA5H+f1cltkAZAWEvkGVe8
         1TYg==
X-Forwarded-Encrypted: i=1; AFNElJ8Yb5ccMefk3GEbgJ1LfN/RCjOQbdWTcpuEE9O1MA2O6uh+AxUZ4t88ei4sC8zD5LJ4TDew+iykVhvp@lists.infradead.org
X-Gm-Message-State: AOJu0Yxy9Jv7fFfeksBqR2xIXV+808UbBTh4VFXkyyom+vZMci6XVdPK
	z1NmdivKMfgjoSQAQASHaoLNJmXopeh2Ke4AcQ01wnOq6WIhRPmbSi4S68G8KH0QWHhydMdHHUq
	/OShyJG+uEF5RqtSrTri80fQQYDOKF+tzZdHj
X-Gm-Gg: AeBDies2IjTr07IbtHuIVtm5GrCUNNqiuY/xt2gPYEFpWISh0kcHjjxoKNPcKScTam2
	HRfA/mA4/EhcSEwKRaQHZCE/cG8NEyWYMJ+EWmnfSHMouG6/8Cy3LAuXI3HmVFJnMLJkGctU1Pr
	Sge36LjPIXwwlh7OL9Odllgn4ZiZnMtiDog7BO2TY1xUs/eZUXuXH7MtIpWG4zWVeRN/chtjxnU
	b/9YUjJh1jprsZPHXP8kgs8NS/+jNv6yVQv6JNdcYRccwY7AGov7Htv9sxORhuO5uJtfJzywDot
	XjFzD4fQUZw7hXqrAuNFow8mVvbJst6B85NTK2CZE0ZvgzRhYlfCukxMNUgr98MWKtba49oa2ON
	fPRdpRhTY+rI0RqpL4StIDicvfm1/ywwJhSFGx5TqOI4o2k2iot3QZmZ/q1frbcRI
X-Received: by 2002:a05:6a00:809:b0:81f:453d:1ab9 with SMTP id d2e1a72fcca58-82f678215a0mr2547248b3a.3.1776298967035;
        Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82f6741a4a2sm280415b3a.7.2026.04.15.17.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 17:22:47 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id A7CFE3405AE;
	Wed, 15 Apr 2026 18:22:45 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 914E7E41B93; Wed, 15 Apr 2026 18:22:45 -0600 (MDT)
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
Subject: [PATCH v2 0/6] block: fix integrity offset/length conversions
Date: Wed, 15 Apr 2026 18:22:08 -0600
Message-ID: <20260416002214.2048150-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260415_172248_335717_791C1474 
X-CRM114-Status: GOOD (  11.72  )
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

 block/bio-integrity-fs.c            |  5 +++--
 block/bio-integrity.c               |  4 ++--
 block/t10-pi.c                      |  7 ++++---
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 28 +++++++++++++++++++++-------
 include/linux/bvec.h                |  1 +
 8 files changed, 33 insertions(+), 29 deletions(-)

-- 
2.45.2


