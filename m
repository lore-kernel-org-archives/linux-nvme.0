Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7E86C64ED6
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Mar 2023 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BO2ojvrftzKAb+rB9vgOUPkR8QgNJwvNUsPY8PtxTpc=; b=ROuFqgYj+K4uO6f5tOkWscMoUe
	jT5Z0zvhRCQBDAi3MCUtxdAkCzwO3wbtrch6nhPJTWhZlB72on8CKxdgJ/5JcQ0yPT0AfaLOp3wNp
	C+vqHL4pjQTzRP0fSAWq/Q2ddIiZa1DekQnyFM1QpDc8hMdneFMKcofFOeEOmCtNtDoogv6UB7QUk
	+sb5wFrDH6rVu9aXf6xl/LV3EdUEWZTg7ntxH4P7gQS82kDLT79I4YO8kluL+ddzY4GpmKAX4C2Xu
	awK6bfErBRVVUvkag0buHjJi6HBDbJ2PDd2GDf7OK42WePpiwTp39AeJIwKzibVTW+u++hX98Ve1v
	hsloNb8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXMoa-00GNb7-7w; Wed, 01 Mar 2023 13:48:16 +0000
Received: from [136.36.117.140] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXMoX-00GNaS-F7; Wed, 01 Mar 2023 13:48:13 +0000
Date: Wed, 1 Mar 2023 06:48:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fix for Linux 6.3
Message-ID: <Y/9Xn595ioya85dO@infradead.org>
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

The following changes since commit 310726c33ad76cebdee312dbfafc12c1b44bf977:

  block: be a bit more careful in checking for NULL bdev while polling (2023-02-24 13:19:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2022-03-01

for you to fetch changes up to 26a57cb35548ae67c14871cccbf50da3edb01ea4:

  nvme-fabrics: show well known discovery name (2023-02-28 06:14:44 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - don't access released socket during error recovery (Akinobu Mita)
 - bring back auto-removal of deleted namespaces during sequential scan
   (Christoph Hellwig)
 - fix an error code in nvme_auth_process_dhchap_challenge
   (Dan Carpenter)
 - show well known discovery name (Daniel Wagner)
 - add a missing endianess conversion in effects masking (Keith Busch)

----------------------------------------------------------------
Akinobu Mita (1):
      nvme-tcp: don't access released socket during error recovery

Christoph Hellwig (1):
      nvme: bring back auto-removal of deleted namespaces during sequential scan

Dan Carpenter (1):
      nvme-auth: fix an error code in nvme_auth_process_dhchap_challenge()

Daniel Wagner (1):
      nvme-fabrics: show well known discovery name

Keith Busch (1):
      nvme: fix sparse warning on effects masking

 drivers/nvme/host/auth.c    |  2 +-
 drivers/nvme/host/core.c    | 37 +++++++++++++++++++------------------
 drivers/nvme/host/fabrics.h |  3 ++-
 drivers/nvme/host/tcp.c     |  6 ++++++
 4 files changed, 28 insertions(+), 20 deletions(-)

