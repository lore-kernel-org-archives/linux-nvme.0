Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87CE2C3DA4A
	for <linux-nvme@archiver.kernel.org>; Fri, 26 Jul 2024 14:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=9ZLFofokjfU7//UDtVNElzEKTKXHnBscRwjVt2hSO8w=; b=G+KWpPKW7oFbRhRkVYxEnij0pJ
	nNHn6dNRRDo8dg27JImWganIhNYXhVyhTn2My68HZNEusG1oX1GzuZXL4FweHeP8o/MtBwKtWuPhr
	1jZ87HtJml4zioUGNteS1oSoyQFIzdGsTBh7M4CVNc2B1WLkJvd5+k2KMKTbPnRYY8tkT+G3VJjYv
	cacRnxPYPXOgEoiqTJ4ymzfRvtH5DPiyLYy9TvO30IZJaiQkrZ6A5gqMOsyP5KywB1RVBvP538z/Y
	RgAI0xGtZxpcbwrjgxUb9nd04+wlLwjdfYmd9LPvMJZtunuE+AEF/d2wI9Bmn9eeQHV/iAeLoIVzS
	c7FAw9qA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXLYk-000000045If-1wb1;
	Fri, 26 Jul 2024 14:04:38 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sXLYh-000000045Hz-2UNt
	for linux-nvme@lists.infradead.org;
	Fri, 26 Jul 2024 14:04:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id CB89A617CE;
	Fri, 26 Jul 2024 14:04:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C12BC32782;
	Fri, 26 Jul 2024 14:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722002673;
	bh=9SzFlHUnBNx3icwe0s2VEzLe202VvxBz8/DPN6YeSqM=;
	h=Date:From:To:Cc:Subject:From;
	b=adiL/nJSPL5gNEIdahlTjGjc0CWCq8Ft9PzzwH0LtXjb3Zeqe4CmRWvQoQSt1kBOB
	 a+uobfty+82RjLR7R+TDD7DFUJuDP3WMElZ/E7zwOC+8AvZC4FU8bZbZRuRhKX6h71
	 rLy6qoRdy5AhXqYIDTnTXk0nZaE2ePYT2qT1s5A8ocqtYuJ6tSew+gCHWO7ssks/wa
	 vXLA85O+K6Ez2/OmtVdCTNOgR1qUuIlevDK6fW7OjL5mOT6eMBzFnIVj3+LBzyEfbm
	 agyFu7pMyFjiVKtIghQ210gBuukGYWmC0ewq6QhTT2voq67ygcW/UNTJYc4JI0ErKU
	 JVxemdZH16dSQ==
Date: Fri, 26 Jul 2024 08:04:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.11
Message-ID: <ZqOs77uDJQGEFHf2@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240726_070435_707271_042A77B9 
X-CRM114-Status: UNSURE (   7.88  )
X-CRM114-Notice: Please train this message.
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

The following changes since commit 8e64d2356cbc800b4cd0e3e614797f76bcf0cdb8:

  s390/dasd: fix error checks in dasd_copy_pair_store() (2024-07-15 10:57:39 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.11-2024-07-26

for you to fetch changes up to c31fad1470389666ac7169fe43aa65bf5b7e2cfd:

  nvme-pci: add missing condition check for existence of mapped data (2024-07-25 07:20:54 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.11

 - Fix request without payloads cleanup  (Leon)
 - Use new protection information format (Francis)
 - Improved debug message for lost pci link (Bart)
 - Another apst quirk (Wang)
 - Use appropriate sysfs api for printing chars (Markus)

----------------------------------------------------------------
Bart Van Assche (1):
      nvme-pci: Fix the instructions for disabling power management

Francis Pravin (1):
      nvme-core: choose PIF from QPIF if QPIFS supports and PIF is QTYPE

Israel Rukshin (1):
      nvme: remove redundant bdev local variable

Leon Romanovsky (1):
      nvme-pci: add missing condition check for existence of mapped data

Markus Elfring (1):
      nvme-fabrics: Use seq_putc() in __nvmf_concat_opt_tokens()

WangYuli (1):
      nvme/pci: Add APST quirk for Lenovo N60z laptop

 drivers/nvme/host/core.c    |  8 +++++++-
 drivers/nvme/host/fabrics.c |  4 ++--
 drivers/nvme/host/pci.c     | 12 ++++++++++--
 drivers/nvme/host/sysfs.c   |  5 ++---
 include/linux/nvme.h        |  9 +++++++++
 5 files changed, 30 insertions(+), 8 deletions(-)


