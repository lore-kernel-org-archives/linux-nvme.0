Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F72AC83F1B
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Jul 2025 13:02:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LiMX4zXZm5inHHY6IvtGUw3iKra4Hn1K3aeA1DUKkgU=; b=kIl9DezQ/VsIdItQObbgbaSLoo
	VtWFTb9CS3TLaCZYpoBPWfPZ5DjKrnpsY3du2mIpDrGinYUwykv7rK15YnZwNtzKhx+Cvw285TMgU
	hTpK9sr+bJvdfJwL0Jt2aYuNHI04DElhAfyj2NUkwtjejS5hZgtTmeQur0gp88gQx6Th614rhaklp
	Fd+VBXkd+X3llBSpSdVOU9iA8UhPcKFjV6CYXz98Gbb05TaIxsZi89nSxGSxg2moGx4Mm8mk+7Sxe
	9b72/Y9XZBRd2yLxeWln3+NkCsrnjObAidsUEI3y3Sv7/mSeM1hjZXkab+hSXq6UMb95VdzDgeTVX
	GP0e1q3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucOFb-0000000ACC5-3e7i;
	Thu, 17 Jul 2025 13:02:15 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ucMv5-00000009zfq-3x5k;
	Thu, 17 Jul 2025 11:37:00 +0000
Date: Thu, 17 Jul 2025 13:36:56 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.16
Message-ID: <aHjgWKyuasbJrqg6@infradead.org>
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

The following changes since commit 3051247e4faa32a3d90c762a243c2c62dde310db:

  block: fix kobject leak in blk_unregister_queue (2025-07-11 20:39:23 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.16-2025-07-17

for you to fetch changes up to 0523c6cc87e558c50ff4489c87c54c55068b1169:

  nvmet-tcp: fix callback lock for TLS handshake (2025-07-15 09:49:13 +0200)

----------------------------------------------------------------
nvme-fix for Linux 6.16

 - revert the cross-controller atomic write size validation that caused
   regressions (Christoph Hellwig)
 - fix endianness of command word prints in nvme_log_err_passthru()
   (John Garry)
 - fix callback lock for TLS handshake (Maurizio Lombardi)
 - fix misaccounting of nvme-mpath inflight I/O (Yu Kuai)
 - fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_list()
   (Zheng Qixing)

----------------------------------------------------------------
Christoph Hellwig (1):
      nvme: revert the cross-controller atomic write size validation

John Garry (1):
      nvme: fix endianness of command word prints in nvme_log_err_passthru()

Maurizio Lombardi (1):
      nvmet-tcp: fix callback lock for TLS handshake

Yu Kuai (1):
      nvme: fix misaccounting of nvme-mpath inflight I/O

Zheng Qixing (1):
      nvme: fix inconsistent RCU list manipulation in nvme_ns_add_to_ctrl_list()

 drivers/nvme/host/core.c  | 27 +++++++++++----------------
 drivers/nvme/target/tcp.c |  4 ++--
 2 files changed, 13 insertions(+), 18 deletions(-)

