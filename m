Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AB7C6FD1C
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Mar 2023 04:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bF/Wd72ByyxSY9ZX1MicBMeY/tPgYwqU9VpxIRfAbu8=; b=pKl08uccawLgVgmC3xNmkUBrIn
	u8hnyBay60WMg+jLseqK1V3/HNtUgcqRF7DabAGex95NqwNOm1ITmnGtLNFWPJSQGLOXkQv5Bfa4L
	VO2+Ro1C6stI0rxzuBmm/1QU+u8g+0id6tZi/9GmXyWAcBCdb7lFGIw0Ult5mIxD2uRkiEJcJBFA8
	NRNnnLQ8ZdcUiyvSNiNyMpOeEfyW8f6SDY2PXmJsZNRObL4iSOZE/cQ01wyo28Wm9Du6t9EF4HqMz
	nNwTX54lMKUthU6nUBqh7XeF+bHDK20jEe93m6fGYFw1GOcX1NaEWMRX0U4LAv2itCtlPzlfLL+UX
	R3+6GP7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfCEM-000iMm-0S;
	Thu, 23 Mar 2023 04:07:14 +0000
Received: from 213-147-166-156.nat.highway.webapn.at ([213.147.166.156] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pfCEJ-000iMH-2q;
	Thu, 23 Mar 2023 04:07:12 +0000
Date: Thu, 23 Mar 2023 05:07:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.3
Message-ID: <ZBvQbMungfXYQaL8@infradead.org>
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

The following changes since commit 9d2789ac9d60c049d26ef6d3005d9c94c5a559e9:

  block/io_uring: pass in issue_flags for uring_cmd task_work handling (2023-03-20 20:01:25 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.3-2023-03-23

for you to fetch changes up to aa01c67de5926fdb276793180564f172c55fb0d7:

  nvme-tcp: fix nvme_tcp_term_pdu to match spec (2023-03-22 09:19:56 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.3

 - send Identify with CNS 06h only to I/O controllers (Martin George)
 - fix nvme_tcp_term_pdu to match spec (Caleb Sander)

----------------------------------------------------------------
Caleb Sander (1):
      nvme-tcp: fix nvme_tcp_term_pdu to match spec

Martin George (1):
      nvme: send Identify with CNS 06h only to I/O controllers

 drivers/nvme/host/core.c | 3 ++-
 include/linux/nvme-tcp.h | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

