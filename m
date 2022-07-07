Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ECD0C433EF
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Jul 2022 13:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Aycc0fHEDsk5iliYgbS1RkZHcrdY9EoPv5d9uS5Mmz0=; b=XOxmiEUgUEijoOXGgqyHlk2AUN
	9CkHDvO3bXZzEUClho/MokNe3JmLle0n/lwnavRKP/dE37XAFi+FZ25aNc3MlIq2IgzRil3C7mpDT
	hp881Qtmb62xPBywi8wk9mxiH+LVLIsp83Z8LLEF4NDRcbgCU3bv988tT0S3D62sc0u5B2xatGaL0
	h7+q1g+ujUJQisArSILb/YLs8OoJQoKTC/3FH2d4bmsBBKMTqK4Eik7yYIlhFBt28cmN2lWRl+eur
	I3tAZLznmioy7g+9X7nWMxOJl0JiE1QuIW0kyqZRGT3HuDCQwVZ39JqgX/U3ERfoaxUW4m2wjevRn
	+5iJQFHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9RVt-00GFDn-FF; Thu, 07 Jul 2022 13:25:49 +0000
Received: from [2001:4bb8:189:3c4a:2f57:8289:689d:9cf6] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o9RVn-00GFAZ-MF; Thu, 07 Jul 2022 13:25:44 +0000
Date: Thu, 7 Jul 2022 15:25:40 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvmes fixes for Linux 5.19
Message-ID: <Ysbe1DGn9vLRpEOh@infradead.org>
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

The following changes since commit f3163d8567adbfebe574fb22c647ce5b829c5971:

  Merge tag 'nvme-5.19-2022-06-30' of git://git.infradead.org/nvme into block-5.19 (2022-06-30 14:00:11 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.19-2022-07-07

for you to fetch changes up to 5c629dc9609dc43492a7bc8060cc6120875bf096:

  nvme: use struct group for generic command dwords (2022-07-06 19:12:56 +0200)

----------------------------------------------------------------
nvme fixes for Linux 5.19

 - another bogus identifier quirk (Keith Busch)
 - use struct group in the tracer to avoid a gcc warning (Keith Busch)

----------------------------------------------------------------
Keith Busch (2):
      nvme-pci: phison e16 has bogus namespace ids
      nvme: use struct group for generic command dwords

 drivers/nvme/host/pci.c   | 3 ++-
 drivers/nvme/host/trace.h | 2 +-
 include/linux/nvme.h      | 2 ++
 3 files changed, 5 insertions(+), 2 deletions(-)

