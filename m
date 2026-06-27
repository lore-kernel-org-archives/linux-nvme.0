Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E60C43327
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 05:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LBI2TZBBdvnIGwxDwxfcA0X2DAXeqtxaRyAM5YR83X8=; b=GVEkwk7dHJZeDH7beDgIruwX4Y
	XyFslX/VNFiVj5i6vASmFReuBRQmWmA7Z5yi0Xst8wYE6YjB50cOZjGWNhXkxH9Vsu+COX1JC2dUV
	cx6si6uHti4lEY8pgBTuObdas3bp2Li4vmLEbzZXZ+1mDhZXcr+bljJzNEkEJtVfdwt9n1YhlDb7D
	c7WVtCqBEB3yK70clN7N+ve4DG6z5qj3E6Jse/QdtdMS8Y4cPt3QNi0Wo/vmNZsMYapovnSsxhEyz
	lA55w4t0F7Fh2AHwnKTmk6BpDMwDsM81mMEKQhPYzd20IwvF1yx2KF2UlHUpVdQXCREDx5Pv1Sxs3
	BLZCxS/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLoZ-0000000CA5k-24Xv;
	Sat, 27 Jun 2026 05:42:51 +0000
Received: from mail-pj1-x1068.google.com ([2607:f8b0:4864:20::1068])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLoW-0000000CA4A-1FjH
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 05:42:50 +0000
Received: by mail-pj1-x1068.google.com with SMTP id 98e67ed59e1d1-37f9e2642deso58826a91.1
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 22:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538967; x=1783143767; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LBI2TZBBdvnIGwxDwxfcA0X2DAXeqtxaRyAM5YR83X8=;
        b=ADlJYCUF7/+RX5B4us+lzxtEQqpMqgs3z5GjC6oZepgDgw8ozc4nM8ldE8z2Y68aly
         9rPKt6YzVdbf+KUXzsisA6WYv0JwxGwyeuRDMF8P/D7h8erEBiPWAaJL69dVUkDDmEtP
         DEjdphg4cIKtPoyW6kYEuaUnf1Merwy0ZZthUDWKbgpPjJ2XeS0iBC67HD9vUQ0QgM+b
         9HdrMsbetbvl6EmnR9/n07I1uwVXvJn2hzWhhY7whrVYX2kD70FfBvS8XAZ2FFBgDrpF
         mGoN2dTUEf0nilMRVuQrPU2TE/MBCaE7yKGQgrGc3sUwgDDf5FLA+4O+o3aIJtmHFLf/
         oHWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538967; x=1783143767;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LBI2TZBBdvnIGwxDwxfcA0X2DAXeqtxaRyAM5YR83X8=;
        b=pgmDoHG5Ec7OOAaJeMCQDJBfRJP1WEU83+zs5/skqxIYtmRcNttt8h2y/Mu/ZJGI0C
         vnNb59SiqtHo6cPWoDbdvEAHkl7Ekd443Gt4mum532XkjWd2fk5+g9Ke59utvce8WtmN
         V3PurrZEflYdmC3wN62mizbV0hrKUBKgkr3hAyXTE6mn5JYjitL9dIfhvzmZN/qn9sXx
         y9WE9rI3NGEVMCa38ldydpn2w3LZG/oWQ2A26flhL2/O+X4bYs7uR90xk1XwORD5qiz/
         3FIGAZCJNB+Q/xej6fg5bYe8sCAXnP2aIxBDFdYRw8QNLBIX+o0ZbpgNHHUvgJuaGpvA
         EKLQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp+vrvq/v+NXoPevDgAHXI7zuN9EzHHngCHHHlcdJo/F+2xJgrHOsx9TlWoeHlTJ4zJGToweIXVhwAg@lists.infradead.org
X-Gm-Message-State: AOJu0Yw2llfjIb77auo+JVQddiSnVVv4xy8MomWuCoqokUCO3Z8NPfEs
	yxeM1yKpwA/ZyYAGC2qTcuShy5qkus1UNcAwrV57JUGybKXch5Tyv+rCsiOa1lUTbSJaXcTXhkS
	/xa+grllffocO/XfK6xsgYVu2oz6g3w2wjiWdbNGj9uP1hP8Zhtu7
X-Gm-Gg: AfdE7cntEobf3yNZNxGM2SGErx7IggaSkdaAd0hkMTiumuZyhvOU4sX8jV44LDGRdXx
	1fk/t+7UnXIv9L/Ni91NQHj3j4gzFPBrkTwo/fRfxeyEyBx5w+t5wL+fN8qV0awsRWS63UqmBtr
	LIk/8wVOKzJe//oOb3wgvDURpBJOlXpI/1MZ3KbqMm0rNrQ4/+fW+6a1xTL93zsIvL4JrvB3EQp
	ZL70fdazr3zJF6CP9QNnHvt7ii/KdvpliRQEfwMbi4N8YUD2EolIHTxn4l37pkyHaysDY/XGctQ
	jU0D73B3UqYwEA1GGlrN0z3sKgQWNmmlLf8lMjb/VhAuPL/vep+wQeZDMm2zAmfJRQKCoJW4tS2
	E0aB5njFpQ6Lct0TTKMkLuf+o4O4X
X-Received: by 2002:a17:90b:5207:b0:364:be8f:1d86 with SMTP id 98e67ed59e1d1-37dfa223d7dmr4789320a91.8.1782538966692;
        Fri, 26 Jun 2026 22:42:46 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-37fb11c60c1sm166693a91.3.2026.06.26.22.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:46 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 0809840146;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id F351FE40712; Fri, 26 Jun 2026 23:42:45 -0600 (MDT)
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
Subject: [PATCH v4 0/5] block: use integrity interval instead of sector as seed
Date: Fri, 26 Jun 2026 23:42:15 -0600
Message-ID: <20260627054220.2174166-1-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_224248_523780_25F4C8AD 
X-CRM114-Status: GOOD (  10.71  )
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

The block integrity layer currently sets the integrity seed (initial
reference tag) in units of 512-byte sectors. However, Type 1 and Type 2
ref tags are actually in units of integrity intervals. On devices with
integrity interval size > 512 bytes, ref tags are seeded incorrectly.

Ref tag "remapping" in blk_integrity_{prepare,complete}() covers up this
ref tag seed discrepancy by offsetting all ref tags in each bio to
convert to/from the absolute integrity interval numbers. But
REQ_OP_ZONE_APPEND operations don't have their ref tags remapped, so the
ref tags using units of sectors will be stored to the device. As future
optimizations, the ref tag remapping could be avoided entirely on NVMe
and some SCSI devices by passing the ref tag seed instead of the
absolute integrity interval as the expected initial ref tag.

So avoid relying on remapping to convert between the ref tag seed in
units of sectors and stored ref tags in units of integrity intervals.
Initialize the ref tag seed as the integrity interval, not sector.

The subsequent commits clean up the integrity ref tag seed code a bit.

v4:
- Drop patch already applied

v3: https://lore.kernel.org/linux-block/20260417015732.2692434-1-csander@purestorage.com/T/
- Drop bi and bip arguments to bip_set_seed() (Christoph)

v2:
- Reorder fixes before refactoring commits
- Use u64, SECTOR_SHIFT (Christoph)
- Don't take sector_t in bip_set_seed() (Christoph)

Caleb Sander Mateos (5):
  block: use integrity interval instead of sector as seed
  blk-integrity: take u64 in bio_integrity_intervals()
  bio-integrity-fs: use integrity interval instead of sector as seed
  t10-pi: use bio_integrity_intervals() helper
  blk-integrity: avoid sector_t in bip_{get,set}_seed()

 block/bio-integrity-fs.c            |  2 +-
 block/bio-integrity.c               |  4 ++--
 block/t10-pi.c                      |  7 ++++---
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/bio-integrity.h       | 11 -----------
 include/linux/blk-integrity.h       | 27 ++++++++++++++++++++-------
 include/linux/bvec.h                |  1 +
 8 files changed, 30 insertions(+), 28 deletions(-)

-- 
2.54.0


