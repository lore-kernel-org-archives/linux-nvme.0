Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBE64C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Jan 2022 16:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lOZFgU+mU6azPamEjabWdoNAoBXamcbihFoacma408Y=; b=fVz9CkjEs2A1moCF7VaCAMXTE4
	Jg8GclpZoWAAHX9G20ZXa93drbCD8pb2D0ujheELZCHAQGcXU1vuiCyrzCl+3im1fRWDYbUdnyqE8
	kZlCip9cUyu5reKPbq4Es7CdODxZQYiF6IMHbVY59vBixZoA2CSQrF9y/GM97KPaVMSuHyHNCAsVD
	bz/YAbTCSG1q2UC+XbRCgoewOK7z4FzTXnyYtI7FLC52YY1PMD6v7msgKcwSbenBmlBVNYonJ8RVU
	OEAekvAfvIVIBIOgZKgRQGbwyYe2BDHCz92Uo/W8+5EGPExq8V2wPYr6mI/lPc1eM/TzXHs1HAkYZ
	x4Q/NlvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nC1mZ-003t9E-9M; Mon, 24 Jan 2022 16:01:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nC1mK-003szd-7M
 for linux-nvme@lists.infradead.org; Mon, 24 Jan 2022 16:01:13 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 09AEB614C7;
 Mon, 24 Jan 2022 16:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EDAC340E5;
 Mon, 24 Jan 2022 16:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643040070;
 bh=D3cFc/NBIAKXRfJhPp6StLK8ULApGVcFR4ulS3YCWUQ=;
 h=From:To:Cc:Subject:Date:From;
 b=LpXp9TSxT9DE4dWhl8kwwb+u+FDuQ6R5RNmldAa79eAXhv+4zjfK/cR2DNrCGh66T
 4GpN1b6bmLoZ3osKkobMbihcZgC+XOBs451dIO7hfTvNeqXlw9qRDfXjEk4sviVPHc
 cvRMBnCN4y/EUq+pWRRADhslAEllBDQX2BqUCkalrTprazEQRlwmrmzrEr2l8vWcm4
 RrUwYu2gfY4aKJF5udNbRjCkctX8RqIAr4Oo2iSZYmf/1/EVFU/E/hfsIE/7OIiZch
 46pUfq3eQl+7JFul6fXguYURidLaO7ywGE/iaMyVn7V8Oc0v8/QrOD7DEZaJStBNC4
 S25nsPZR42T1w==
From: Keith Busch <kbusch@kernel.org>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-block@vger.kernel.org
Cc: axboe@kernel.dk, hch@lst.de, martin.petersen@oracle.com, colyli@suse.de,
 arnd@arndb.de, Keith Busch <kbusch@kernel.org>
Subject: [RFC 0/7] 64-bit data integrity field support
Date: Mon, 24 Jan 2022 08:01:00 -0800
Message-Id: <20220124160107.1683901-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220124_080112_358206_0E95CB92 
X-CRM114-Status: GOOD (  13.22  )
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
"storage tag" field.

The NVMe CRC64 parameters (from Rocksoft) were not implemented in the
kernel, so a software implementation is included in this series based on
the generated table. This series does not include any possible hardware
excelleration (ex: x86's pclmulqdq), so it's not very high performant
right now.

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
 drivers/nvme/host/nvme.h        |   1 +
 include/asm-generic/unaligned.h |  26 +++++
 include/linux/blk-integrity.h   |   1 +
 include/linux/crc64.h           |   2 +
 include/linux/nvme.h            |  53 ++++++++-
 include/linux/t10-pi.h          |  20 ++++
 lib/Kconfig.debug               |   3 +
 lib/Makefile                    |   1 +
 lib/crc64.c                     |  79 +++++++++++++
 lib/gen_crc64table.c            |  33 ++++--
 lib/test_crc64.c                |  68 +++++++++++
 15 files changed, 608 insertions(+), 46 deletions(-)
 create mode 100644 lib/test_crc64.c

-- 
2.25.4


