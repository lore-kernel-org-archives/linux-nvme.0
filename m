Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D99C001DC
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Jul 2023 20:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Eg768jXQNsUXmosWqx7uZD7w3xqqrl7XQ0EXAdMsG/8=; b=hoqY6WMUhmqQ/C1OW4lkYc5dM+
	7gbTzaQ0wcmztnnCqGPuy2xoEtYmWx5ifDtcbbk9H/w0omOWb2LXNrQJrxJWVQILYwF7FXpTmpgC4
	VRnIXMYEt5wa+tMt2IJT5Td1qbi10oyed5cGoA7T+4uBi5CPcBrRcUkmklDiD8iFSjUgbF7BP2WNZ
	B+JG0xN1oxpQDDT/etDsgW6EvVIxM6gCS8XO/vNtTxjapcXzM/FTGe9dEQUZ6/mzN/IShmcfB39dP
	9e5TDu1gVv1EUpzTbIVJCFHDbFzDTIkxdw4racK+cyHCO0B78dv2OJLiVxtBsqefZ691l4vV+3Xj5
	hbTv1fXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qK2rz-004J40-0f;
	Thu, 13 Jul 2023 20:24:59 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qK2rw-004J3S-2z
	for linux-nvme@lists.infradead.org;
	Thu, 13 Jul 2023 20:24:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C4AFA61B36;
	Thu, 13 Jul 2023 20:24:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA778C433C8;
	Thu, 13 Jul 2023 20:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689279895;
	bh=HM/kNLi+ytdrxXxnUlTh3sy3JB7X95S4gsgZ/sObx9A=;
	h=Date:From:To:Cc:Subject:From;
	b=J/s/MlK8f5vrA19J4U7dnGdW3jpy60xqAeDWVYDY62cMosUPCyHczadmgSFhQSfke
	 kq498vgaMLbVMMw1QJnkmZ7s0+VHKcfQzu6fTZF1nul/zgBfUOQA0IPN6nZNDCYyNG
	 cXdJglVqKRmvtSwW8k21ZhSdkqQ5TLT4uLlHZ3YWMTzyc91rMw3vkgQZLfgstRP/z6
	 T7iyllV7KJoZZm+JTPpY+wRtFk0ohYAQY6kZXtmB5IkhCmy2uM7iiXDqc/A5y0lmXa
	 qKesNs7bPm9uoosxLWSfvpkw7D8C+PUfUYZ0WlLxJGR2WMIAzQSDex9dR3oH1SoTEE
	 1F1r2JdvVtaQA==
Date: Thu, 13 Jul 2023 14:24:52 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.5
Message-ID: <ZLBdlPjrbvdex1Hq@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230713_132457_022277_B28ED8A1 
X-CRM114-Status: GOOD (  10.08  )
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

The following changes since commit 2fb48d88e77f29bf9d278f25bcfe82cf59a0e09b:

  blk-crypto: use dynamic lock class for blk_crypto_profile::lock (2023-07-05 16:36:12 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.5-2023-07-13

for you to fetch changes up to b8f6446b6853768cb99e7c201bddce69ca60c15e:

  nvme-pci: fix DMA direction of unmapping integrity data (2023-07-13 08:16:07 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.5

 - Don't require quirk to use duplicate namespace identifiers
   (Christoph, Sagi)
 - One more BOGUS_NID quirk (Pankaj)
 - IO timeout and error hanlding fixes for PCI (Keith)
 - Enhanced metadata format mask fix (Ankit)
 - Association race condition fix for fibre channel (Michael)
 - Correct debugfs error checks (Minjie)
 - Use PAGE_SECTORS_SHIFT where needed (Damien)
 - Reduce kernel logs for legacy nguid attribute (Keith)
 - Use correct dma direction when unmapping metadata (Ming)

----------------------------------------------------------------
Ankit Kumar (1):
      nvme: fix the NVME_ID_NS_NVM_STS_MASK definition

Christoph Hellwig (1):
      nvme: don't reject probe due to duplicate IDs for single-ported PCIe devices

Damien Le Moal (1):
      nvmet: use PAGE_SECTORS_SHIFT

Keith Busch (2):
      nvme: warn only once for legacy uuid attribute
      nvme: ensure disabling pairs with unquiesce

Michael Liang (2):
      nvme-fc: return non-zero status code when fails to create association
      nvme-fc: fix race between error recovery and creating association

Ming Lei (1):
      nvme-pci: fix DMA direction of unmapping integrity data

Minjie Du (1):
      nvme: fix parameter check in nvme_fault_inject_init()

Pankaj Raghav (1):
      nvme: add BOGUS_NID quirk for Samsung SM953

 drivers/nvme/host/core.c         | 36 +++++++++++++++++++++++++++++++++---
 drivers/nvme/host/fault_inject.c |  2 +-
 drivers/nvme/host/fc.c           | 37 ++++++++++++++++++++++++++++++-------
 drivers/nvme/host/pci.c          | 29 ++++++++++++++++++++---------
 drivers/nvme/host/sysfs.c        |  2 +-
 drivers/nvme/target/loop.c       |  2 +-
 drivers/nvme/target/passthru.c   |  4 ++--
 include/linux/nvme.h             |  2 +-
 8 files changed, 89 insertions(+), 25 deletions(-)

