Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 407DFC3DA4A
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Aug 2024 20:36:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sh0TLefWclonqMnISj2v4MyXaHUkj/UROH8ipCOl1UM=; b=h7F9wG3LQKp7MHXEt5Ra0uJC2J
	HoY/yP+CxXP6c46RkFSEaHaGYZ1cpfnBZ6h0ZGW7GE1RTPDTk91l5tkqKmsR6UyoFs1D5zHbjeumS
	0AgWlb8ij5oIF0p6Zin0QXB5oeZ4XWvAV5IVE2FFGzttpwQrU8oMScefWRRWOZPwLa8cFpOateyfM
	0VI7uOn/Gm2Ny05siFskbT4v4afn9IV1phoQPh75Z0RPnw9qGpgFvB591wsWKmF7oXxZToFI+jdoT
	/Vo7NnROdirZvxemzm3CxXFKvtVYg6qIYrvM8TkaR5RpJZ2Oq0+Pcv2F4RTfiCUOS0xoU+h6cszrG
	Jyv03xyw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEXs-0000000EFK4-0xgE;
	Thu, 22 Aug 2024 20:36:36 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1shEXp-0000000EFJA-1YRL
	for linux-nvme@lists.infradead.org;
	Thu, 22 Aug 2024 20:36:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6EBD7A40FFF;
	Thu, 22 Aug 2024 20:36:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E158C32782;
	Thu, 22 Aug 2024 20:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724358991;
	bh=uU35JBCWd05HH3orw20Gk392f8nP+AuCiiAa2Ji57/Q=;
	h=Date:From:To:Cc:Subject:From;
	b=mIs2vziJ/cGpdfurdZHJUG4mo3xuwfubUj3vqiNIkMGKrw3IUqXd04HUecgSqg/sa
	 p+jO1hxWZQb+cef9rUhDHc+89sWP4ZXMFj8qCRTnp5iDYLQiSq3QPuakhSsojiAeOl
	 /5KtXrfuvGCdTzQgKDDAYkZT3Mlzqm2+qswJddax3TWjmLlNoP9C5rDJ3A5sNLD0YS
	 MEuMdJWeD4EbM0GE5U23aMrJQFG42KgE8bahh1n5eCX6t8FmQuNDsw7CxqU6/PSAJh
	 EVdAOWIHJopi0flf26hqmeqi635Nc7CM2sWAPfvlMhvwG8gJcwP3seBuPoBl5W0/Ry
	 vZzOXhnE6774g==
Date: Thu, 22 Aug 2024 14:36:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for Linux 6.11
Message-ID: <ZsehTd8kUzkrmQkp@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_133633_495109_205A370C 
X-CRM114-Status: UNSURE (   7.36  )
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

The following changes since commit 81475beb1b5996505a39cd1d9316ce1e668932a2:

  block: Drop NULL check in bdev_write_zeroes_sectors() (2024-08-19 09:48:59 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.11-2024-08-22

for you to fetch changes up to fe01751347359862c65c715d51c0b3f4fa8ee2f0:

  nvme: Remove unused field (2024-08-22 13:28:40 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.11

 - Remove unused struct field (Nilay)
 - Fix fabrics keep-alive teardown order (Ming)

----------------------------------------------------------------
Ming Lei (1):
      nvme: move stopping keep-alive into nvme_uninit_ctrl()

Nilay Shroff (1):
      nvme: Remove unused field

 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)


