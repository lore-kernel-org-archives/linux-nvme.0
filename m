Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBA10C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 13:24:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=MYz9g7LLBWo3lswpU1/1a/rHCbBCo/ztXRmq3SmkIhA=; b=VNLs8P3QVAHPJka0byE5FPmuVn
	o1igKYQ6T10MM7iRU+6odtgp6NwM+Zz6XignOoZrdvTr0gFBDQ0q9WZYsrCG9M4wwfvOVN/xy8ExE
	SWZG/HmdXTKWBmwKjeTwtR/0+r/s8ri4+6sNt6xBmXbM4Vc9fK+UXDke/v72oQlwa7PN9LinWsjhV
	gtvWCoPl1LH+AkXnfAVDwiUg7HRQZnIPFlYNfmsKPZPzkTPskA8ZCMOl9k52NjCGFZnq8xY0GLcEO
	SnsxMYbOd9GSXz8Tf19a1r3YgnwVr/qbfddCHlUwG8GXr8HZrQHzKKjGegiktmcxrD/LrSLOHiyar
	ThdnAH2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4MoX-00FKvz-JL; Thu, 23 Jun 2022 13:24:05 +0000
Received: from [2001:4bb8:189:7251:9e7:d0ec:8481:b319] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4MoT-00FKom-8P; Thu, 23 Jun 2022 13:24:01 +0000
Date: Thu, 23 Jun 2022 15:23:59 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <YrRpb4LlxotvjCML@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

The following changes since commit 2645672ffe21f0a1c139bfbc05ad30fd4e4f2583:

  block: pop cached rq before potentially blocking rq_qos_throttle() (2022-06-21 10:59:58 -0600)

are available in the Git repository at:

  ssh://git.infradead.org/var/lib/git/nvme.git nvme-5.19

for you to fetch changes up to e6487833182a8a0187f0292aca542fc163ccd03e:

  nvme: move the Samsung X5 quirk entry to the core quirks (2022-06-23 15:22:22 +0200)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: move the Samsung X5 quirk entry to the core quirks

Joel Granados (1):
      nvme: fix the CRIMS and CRWMS definitions to match the spec

Leo Savernik (1):
      nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH

 drivers/nvme/host/core.c | 14 ++++++++++++++
 drivers/nvme/host/pci.c  |  6 ++----
 include/linux/nvme.h     |  4 ++--
 3 files changed, 18 insertions(+), 6 deletions(-)

