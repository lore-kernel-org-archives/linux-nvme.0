Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E87EE8538E
	for <linux-nvme@archiver.kernel.org>; Fri,  3 Apr 2026 19:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=M7691Rpd885rtdqhZsGvsmlwE0WhG23SmYwp1iH7phM=; b=0lZDuxxLOzhBE+eqde3qqRp60L
	SHQPEPIwR3J4KEUZlHB9zrL4UfG2JoAUllKaP4rNwvP7k59Lhim/B+AAe0CGyWMr5rOQTfvdiDcRT
	lDI7svECDfz695KxAyo4pWEP+u8erqor6Pt/7nwH63xNYbpHTwYErrSqpZWUs8qdmh3sAd8+EvCgt
	27FhvIVVPqIpu/D+NDszxlbnqnWIImOwF8R9R5BJWipsRp5KjwLXVmrxLJ7K7WiZd3ghMRkOSmtDi
	aDQf/EkNQtxtWbFjNBQyGqmc3BaSCHhg9o4SIYV0ep1HV3Qkf6Hk/daelCi6u+1grwgKIIRntWGF3
	LPHUNUUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOU-00000002Ulp-13Di;
	Fri, 03 Apr 2026 19:41:26 +0000
Received: from mail-pg1-x564.google.com ([2607:f8b0:4864:20::564])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w8kOQ-00000002Uit-2jSQ
	for linux-nvme@lists.infradead.org;
	Fri, 03 Apr 2026 19:41:24 +0000
Received: by mail-pg1-x564.google.com with SMTP id 41be03b00d2f7-c76c90716ccso70707a12.1
        for <linux-nvme@lists.infradead.org>; Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1775245281; x=1775850081; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M7691Rpd885rtdqhZsGvsmlwE0WhG23SmYwp1iH7phM=;
        b=OTQtMZ37wV8RLZIyM6buDSf9qHE9LQQ2Or0F/jHYqrzNDIjknMbU21UE3oC/ZS/3eh
         l45U4gasHdh1VMYTxIweu66LPEjYQjZj3it3n6Nx4hyHU0pU0WG2XjZQ3dKOy1wSBR45
         InhlB5XTslc+Xq30OU3Z6EAC5j2t7eJwHsTJgUvOyQFP3wRW8CcFV8psfjkVQKAXt43e
         S5A5cXW8Ehr5R3KI7q6suWM0AYorxz/XcMal00roYSsuWHcb0ZtEAjjyHvZoC4Rs4ZIh
         5j3EchoBpldIrk7zk6wZjURfV/uS2/awG9wyRFsYXTaaLFSSMTzpsTyVzOI+VAEcNqUk
         rqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245281; x=1775850081;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M7691Rpd885rtdqhZsGvsmlwE0WhG23SmYwp1iH7phM=;
        b=jG9+QvoiIDfbSKtMhq70/Lhj0MymcjWRDxfy49E43ZEkNvYXAFXC2Jc5HDAeLRJBTL
         2Zm+ulD6BIOCOsJhm1QvqlBtL9zYkxgpURpnHYiVGekuf+Ts8Qhm5t94Ok4yKDG6o7nb
         NyE7SEHaDgyhbB+oKN4yobvp1x6qYLnu3bag7kDD39fp3DUzhvU/Fwfgliolhz7BnvAM
         E7o5qkSb3oygPT0z1r2ovRyO+12nXmdiHVlOCSr1aqf3hYEweIkMQhApAry9yvdK3iYB
         /IyxFJNJC24U14chtYP+S9LC2GZHByqI1wDOFNEp3kVKyt2mF5I5DknEmnR0dXEIw4rp
         cbNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVt6dH0p+KMLx/uOqSrMMBaa89wVYLIs2z6kBOrpNQmCNp34pQtRaeuCwbf5f+hbjk/Ae9ZdcNquFzb@lists.infradead.org
X-Gm-Message-State: AOJu0YywhgQFQ5+AdNFd4SOn9zCGs4q8VScJDuejma+l2/n/hquzup6B
	anbn3Z1/2tNYIFksIRTW8zor6nO10RLCaSV0H7WzkPKX1IyzS+sZxMfG6iBGb+JKp/G0Gw2GKuU
	1ucr9SnUhK73GxPFQzt/fdhRCJvBxVZtvCjasthtFVAKExLHq9Wtm
X-Gm-Gg: AeBDievT4zfK+tXxOymFdMp6jCj5yFpa9UNWccg2llSpfy1dew95I/ZPK7ZFr0lng07
	FCoSiNiS7y5zO8aeXgRvpEja2KfjRz9+/ey9x3d4D39znI9ln1ffMdchAp1fvTyqvc6oFXOs0WY
	r2y5PLFiasN3G+2wFQoXsXOiygndnFiOmjy9zj9ztzLiT+FoLaWzbbyV/zcsNonw4rNsgcS/Z0h
	u+S+zgrO6x5w/1QJXNDd6F/ftYQi72uoELhLDaUuLxGJLJ7nSHwkM6jdZJMuiIZwvA+0ThL9OVt
	mlZwf+Lej5hOOjDYtZDU0oxOGPN6nWBH7zmuWZDtkhKhGh/olIn0hZc6To6HWh6EYt6O4woDwE0
	aqdz6WK7/4ghTrUo8Kunv2g31AY4ovbyjqQKXoYU=
X-Received: by 2002:a05:6a00:2d12:b0:82c:66ba:5f80 with SMTP id d2e1a72fcca58-82d0db7b707mr2480662b3a.4.1775245281177;
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-82cf9c40eadsm676630b3a.8.2026.04.03.12.41.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:41:21 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (dev-csander.dev.purestorage.com [10.112.29.101])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 8432334014E;
	Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 6A065E41AC2; Fri,  3 Apr 2026 13:41:20 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH 0/6] block: fix integrity offset/length conversions
Date: Fri,  3 Apr 2026 13:41:03 -0600
Message-ID: <20260403194109.2255933-1-csander@purestorage.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260403_124122_698629_2D0C5F1B 
X-CRM114-Status: GOOD (  11.36  )
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

Caleb Sander Mateos (6):
  blk-integrity: take sector_t in bio_integrity_intervals()
  block: use integrity interval instead of sector as seed
  bio-integrity-fs: pass data iter to bio_integrity_verify()
  bio-integrity-fs: use integrity interval instead of sector as seed
  t10-pi: use bio_integrity_intervals() helper
  target: use bio_integrity_intervals() helper

 block/bio-integrity-fs.c            |  5 +++--
 block/bio-integrity.c               |  2 +-
 block/t10-pi.c                      |  4 ++--
 drivers/nvme/target/io-cmd-bdev.c   |  3 +--
 drivers/target/target_core_iblock.c |  3 +--
 include/linux/blk-integrity.h       | 12 ++++++------
 6 files changed, 14 insertions(+), 15 deletions(-)

-- 
2.45.2


