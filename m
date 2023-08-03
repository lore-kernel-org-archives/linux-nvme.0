Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 140C9C001DF
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Aug 2023 14:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=e2gS+iKC7Zm2EHSrJ3eLnJLe8m1Y8sKKIxPaJEZvRN8=; b=3Fp8Q8U6jNp2L+graxS2tIdTI1
	bpiXtSbeeE4yD31guahSFFlwwhTg+84OmXfyGnGBZwT6SEgY+cebpyi/yhe4m/xXromZG1ji8mmZ4
	XhwqKHM3185X1RvxS9BdRYShUTjm91eQ4pjqhyxzCWCvgF9ssA+dXV7rD/Ej9VeV2WAEhc4/BhdjE
	K+YWql28XlX8BfZGmPE6pAuaW7X9kl2WoNYFicXAdmnXwtQjSlT3/QkMpRYGn/S4XOVFoaE0HT57I
	Unz8cgQWiX/z+ItP6hMNgeeTaKWB+0Eli1oCU9+qynOeKJzmzYOYghJKUOv0h3czvNtHsga4tdHMD
	P9KovKPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qRZgm-009sU8-2u;
	Thu, 03 Aug 2023 14:52:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qRZgj-009sRB-2C
	for linux-nvme@lists.infradead.org;
	Thu, 03 Aug 2023 14:52:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 66B8C61DC4;
	Thu,  3 Aug 2023 14:52:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C092C433C7;
	Thu,  3 Aug 2023 14:52:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691074347;
	bh=0DeQSC6SpWiKwQAuuAjchXQTVlBeN+zans8q+KZ8KmU=;
	h=Date:From:To:Cc:Subject:From;
	b=Dv8Yvhwf6YjAbzx4sOwDhO50VpY3SK/cmOw1xY2yWLG2TST0pt4oJUGvMQpEWEKAU
	 v44CRqsmz24EEiuDdKYwbDIUZon0xjlK6Xl3IuSqWFNyfojkPwIrnJY6ylJVQ5iccK
	 iNbv2plgbjaXBHpFty49bFmCJPf6kPSak+2w5pvi/NJLqJo6ln5pGQObcBvL6Ua4rw
	 lLn+WP0WJIjq6mpcOuZBnlgdbh8/hPQrLGVByzNyyU894Azjfb7Ycz+fXKrHef1MYK
	 Qxr8Cijfub2MT7HFReleNPN8E7VGhuhIEeXijupSPZeq/yED1La0Nmnt+j/m189MOb
	 9oCbmhmp644pA==
Date: Thu, 3 Aug 2023 08:52:25 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.5
Message-ID: <ZMu/Kcw8rknRQYJa@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230803_075229_784283_1DCC5B93 
X-CRM114-Status: UNSURE (   8.72  )
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

The following changes since commit b8f6446b6853768cb99e7c201bddce69ca60c15e:

  nvme-pci: fix DMA direction of unmapping integrity data (2023-07-13 08:16:07 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.5-2023-08-02

for you to fetch changes up to 688b419c57c13637d95d7879e165fff3dec581eb:

  nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G (2023-08-01 13:28:29 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.5

 - Fixes for request_queue state (Ming)
 - Another uuid quirk (August)

----------------------------------------------------------------
August Wikerfors (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Samsung PM9B1 256G and 512G

Ming Lei (3):
      nvme: fix possible hang when removing a controller during error recovery
      nvme-tcp: fix potential unbalanced freeze & unfreeze
      nvme-rdma: fix potential unbalanced freeze & unfreeze

 drivers/nvme/host/core.c | 10 +++++++---
 drivers/nvme/host/pci.c  |  3 ++-
 drivers/nvme/host/rdma.c |  3 ++-
 drivers/nvme/host/tcp.c  |  3 ++-
 4 files changed, 13 insertions(+), 6 deletions(-)

