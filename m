Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127CBECAAD3
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Sep 2022 07:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oZ37gH4GcI6zuhqYXKYXANHATWQQe0itpTonSt2Fnqc=; b=BjOgaxOjtovAIvNBpUwcFFdm46
	w3PgDR3cjP2uCNsJZ8sdX9JvxmGpRgfDB185c/t1FGeDV3tocBEGvfj4wi60amfOxARB0E7c2A/kq
	x+H5B/9Z1sfJ7Yl4OMHXjBt2ouySXlBAF+tVuIel5i2GYni/9bZiuHvKgmz4IbGjO5wHGqNh8NVKs
	rFfATV3mKF+zc7HAo3sl9nd1KFKB4YRy+HgtEP6kwEC7hA9arFy2BuVbpNQ5VnqwKVnSsndEZ3AQS
	tdqJm5jPEczEKIpThQr3pOdKdOfMMn23fISHy1KF4yH8/wSYcKeP88HQJ4O7wVP6v+8M2ZB4sPcC+
	kixv5sQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTeeE-00AK1j-BF; Thu, 01 Sep 2022 07:29:58 +0000
Received: from 213-225-1-14.nat.highway.a1.net ([213.225.1.14] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oTeeC-00AK0L-6f; Thu, 01 Sep 2022 07:29:56 +0000
Date: Thu, 1 Sep 2022 10:29:51 +0300
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.0
Message-ID: <YxBfb38kb18Im/QB@infradead.org>
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

The following changes since commit 645b5ed871f408c9826a61276b97ea14048d439c:

  Merge branch 'md-fixes' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into block-6.0 (2022-08-24 13:58:37 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.0-2022-09-01

for you to fetch changes up to 478814a5584197fa1fb18377653626e3416e7cd6:

  nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change() (2022-08-31 07:58:10 +0300)

----------------------------------------------------------------
nvme fixes for Linux 6.0

 - error handling fix for the new auth code (Hannes Reinecke)
 - fix unhandled tcp states in nvmet_tcp_state_change (Maurizio Lombardi)
 - add NVME_QUIRK_BOGUS_NID for Lexar NM610 (Shyamin Ayesh)

----------------------------------------------------------------
Hannes Reinecke (1):
      nvmet-auth: add missing goto in nvmet_setup_auth()

Maurizio Lombardi (1):
      nvmet-tcp: fix unhandled tcp states in nvmet_tcp_state_change()

Shyamin Ayesh (1):
      nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM610

 drivers/nvme/host/pci.c    | 2 ++
 drivers/nvme/target/auth.c | 1 +
 drivers/nvme/target/tcp.c  | 3 +++
 3 files changed, 6 insertions(+)

