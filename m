Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 955A3C4332F
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Feb 2022 19:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=mILWJkOV19IH17s+8Hyvqz22HPNn5S9y0LlgqE97rAw=; b=uruq3JMoc4x4FWssrJXBKhPx66
	GpXI5adK4kyP5eBFOw/MYE0DT9X/aAp9YktvQnkszSkHA+88ztb2Pzd1JGt6/5nHeorBJOiQgxSbu
	rMFC/mzsQGXldT80q/zK3BV6wdm0bawFpSyLJCYwE0ob1kcadULr98NfkPUluzl1lxfo5CowZGxnJ
	h/1BiGNtjK82x2v5A+8tyRfGtujawM+Kws4rtsLiv967GLSaDAUJZagd/L31uMbfRVOJTNGqvaDzH
	eRvOFaCvvBslN5g9SnmwCgeicNLYRRnCutgS1uH1kHdGQQyHPVXa0ZSjXebMjyVDk0E8NsBpky+nE
	DcCxZhHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nEyPJ-00DSg7-0y; Tue, 01 Feb 2022 19:01:37 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nEyPG-00DSeD-3P
 for linux-nvme@lists.infradead.org; Tue, 01 Feb 2022 19:01:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 9E9EEB82F6D;
 Tue,  1 Feb 2022 19:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B116C340EB;
 Tue,  1 Feb 2022 19:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643742091;
 bh=cVwY7uf25xXL0j0QUPYf5N1qHOInyxhDvkPW079SA40=;
 h=From:To:Cc:Subject:Date:From;
 b=JS1BjjmAzjQWsYp3zYQfRj0QMVYvf2qnStPbZScXwuySfQGo0GmCEy9tiAzD1Asqo
 +NlEZy403D9Dsokf8RX4cHgxPQ4vVcvgbZwKMFYM/OYnavjrCbKfzL/sHlTsYLOatj
 dCkW39bZQhlZdcGZAJ250z4V6FBhh7t3QY7n8n0AurhSg3bMeFN7BgPcDh+b6nlIQT
 izicVwv9pXvIti942M1oViQSVLsKac9mmcJEtfXvLUW0L4bkhJ6N+FdX7zyB+yoiZS
 SFO/uRYh9CbtUGvTvQpdgWa13cmHxJY/j1Sy12O19K9WyaXa90Ghq/75fTYzjQQgD3
 1287oUglFucOw==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 0/7] 64-bit data integrity field support
Date: Tue,  1 Feb 2022 11:01:21 -0800
Message-Id: <20220201190128.3075065-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220201_110134_308165_5F85EEC5 
X-CRM114-Status: GOOD (  11.90  )
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

The NVM Express protocol added enhancements to the data integrity field
formats beyond the T10 defined protection information. A detailed
description of the new formats can be found in the NVMe's NVM Command
Set Specification, section 5.2, available at:

  https://nvmexpress.org/wp-content/uploads/NVM-Command-Set-Specification-1.0b-2021.12.18-Ratified.pdf

This series implements one possible new format: the CRC64 guard with
48-bit reference tags. This does not add support for the variable
"storage tag" field, or any potential hardware acceleration.

Changes since RFC v1:

  - Generated the reflected CRC table and cacluated CRC accordingly
    instead of reflecting the input/output (Eric Biggers, patch 3)

  - Fixed Kconfig.debug dependency for CRC tests (patch 4)

  - Fixed endian conversion sparse error (patch 7).

  - Added support for PRACT (Klaus Jensen, patch 7)

Keith Busch (7):
  block: support pi with extended metadata
  nvme: allow integrity on extended metadata formats
  lib: add rocksoft model crc64
  lib: add crc64 tests
  asm-generic: introduce be48 unaligned accessors
  block: add pi for nvme enhanced integrity
  nvme: add support for enhanced metadata

 block/Kconfig                   |   1 +
 block/bio-integrity.c           |   1 +
 block/t10-pi.c                  | 198 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/core.c        | 167 ++++++++++++++++++++++-----
 drivers/nvme/host/nvme.h        |   4 +-
 include/asm-generic/unaligned.h |  26 +++++
 include/linux/blk-integrity.h   |   1 +
 include/linux/crc64.h           |   2 +
 include/linux/nvme.h            |  53 ++++++++-
 include/linux/t10-pi.h          |  20 ++++
 lib/Kconfig.debug               |   4 +
 lib/Makefile                    |   1 +
 lib/crc64.c                     |  26 +++++
 lib/gen_crc64table.c            |  51 ++++++--
 lib/test_crc64.c                |  68 +++++++++++
 15 files changed, 576 insertions(+), 47 deletions(-)
 create mode 100644 lib/test_crc64.c

-- 
2.25.4


