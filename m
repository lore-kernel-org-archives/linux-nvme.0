Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FCA0C19F2A
	for <linux-nvme@archiver.kernel.org>; Thu, 11 Aug 2022 14:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eNVCBqUqn8SFOfBc/qsyONTEJOmB7aKbelzMUwsw9NI=; b=Z2cNpzLCTLpA1xpF3MfVq3kP6Z
	0PnZXv1imCpy4a7DgpkSHw35h4YB8FuvatT5yunF56xvxtcxyB9O3xiGRxLMEcPDZGFYEIjacAvaa
	xr0GljsAadovR8iFly5cSDRet/I9l/2JLjQF9fJUrPJBQFkeUSdAc9Bge6sthpc/UbRyWybiJN05j
	oLI42Y8lWhj0mVmOs4kOJZ/oKHUGQWC4gQ+8vkpgXvrH0jR09XWh9+QSmYT/RNAMyzGI31gIWGnqh
	4RanufWzemhOwDqkEgd80EdgsTOZsy9/BYkCfw45yYo7YO1yFdUvyyNYa7f+eFo9/b1/gHN/Bw5Q1
	qenfN9AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM8oQ-00D2TY-RV; Thu, 11 Aug 2022 14:05:26 +0000
Received: from [2001:4bb8:182:2eeb:8088:4912:c90b:f14d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oM8oP-00D2Qy-EV; Thu, 11 Aug 2022 14:05:25 +0000
Date: Thu, 11 Aug 2022 16:05:25 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.0
Message-ID: <YvUMpS5PxgJSykCB@infradead.org>
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

The following changes since commit fa9db655d0e112c108fe838809608caf759bdf5e:

  Merge tag 'for-5.20/block-2022-08-04' of git://git.kernel.dk/linux-block (2022-08-04 20:00:14 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.0-2022-08-11

for you to fetch changes up to f37527a09dac324c74bb341c841096395a2f2566:

  nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S70 (2022-08-11 14:10:16 +0200)

----------------------------------------------------------------
nvme fixes for Linux 6.0

 - print nvme connect Linux error codes properly (Amit Engel)
 - fix the fc_appid_store return value (Christoph Hellwig)
 - fix a typo in an error message (Christophe JAILLET)
 - add another non-unique identifier quirk (Dennis P. Kliem)
 - check if the queue is allocated before stopping it in nvme-tcp
   (Maurizio Lombardi)
 - restart admin queue if the caller needs to restart queue in nvme-fc
   (Ming Lei)
 - use kmemdup instead of kmalloc + memcpy in nvme-auth (Zhang Xiaoxu)

----------------------------------------------------------------
Amit Engel (1):
      nvme-fabrics: parse nvme connect Linux error codes

Christoph Hellwig (1):
      nvme-fc: fix the fc_appid_store return value

Christophe JAILLET (1):
      nvme-fabrics: Fix a typo in an error message

Dennis P. Kliem (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S70

Maurizio Lombardi (1):
      nvme-tcp: check if the queue is allocated before stopping it

Ming Lei (1):
      nvme-fc: restart admin queue if the caller needs to restart queue

Zhang Xiaoxu (1):
      nvmet-auth: use kmemdup instead of kmalloc + memcpy

 drivers/nvme/host/fabrics.c            | 8 +++++++-
 drivers/nvme/host/fc.c                 | 5 ++++-
 drivers/nvme/host/pci.c                | 2 ++
 drivers/nvme/host/tcp.c                | 3 +++
 drivers/nvme/target/fabrics-cmd-auth.c | 4 ++--
 5 files changed, 18 insertions(+), 4 deletions(-)

