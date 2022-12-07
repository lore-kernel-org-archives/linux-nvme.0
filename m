Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC8DC352A1
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 14:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Ega/ymHiohwYqmOVO0xNlbAF7Cc6uCydw63WlUlCezo=; b=DgTTKA6vwDG4iOgVb2jzxDBEfD
	i0bXLLdbYyp2AB9zqqv++SFnq3R9A3HH82Rw5QlO3hallb4cylw03HpPENANB/5SHUoztl9lvM1CQ
	qzT5cfiorOT+ebYbhjMmiqIPXekNVEQbEtPdZQNLbcdVsvbXFaU5dSDaFldXNmu/MYjl/TwtW9swl
	WwezyibUSM25vClMd6l7mRqUWqR1Im515/zHFgTwvU/mzgaaGzyyITnT+Rt09WCMwhaRFVopf5uhW
	zN/tf/Nvz18dLQw+B2B5fsBjuUawTGQpJd3ENtSjoeHzHOLmCtd6/exm3oW6F+QdpNcQBdYELzSVi
	24N6yjBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2v7F-004Xs2-Bt; Wed, 07 Dec 2022 14:09:41 +0000
Received: from [2001:4bb8:19a:6deb:1e50:ef0a:649d:fd9d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2v7D-004XpL-Sv; Wed, 07 Dec 2022 14:09:40 +0000
Date: Wed, 7 Dec 2022 15:09:37 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.1
Message-ID: <Y5CeoZZcOCYaS/P9@infradead.org>
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

The following changes since commit 899d2a05dc14733cfba6224083c6b0dd5a738590:

  nvme: fix SRCU protection of nvme_ns_head list (2022-11-30 14:37:46 +0100)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.1-2022-12-07

for you to fetch changes up to 6f2d71524bcfdeb1fcbd22a4a92a5b7b161ab224:

  nvme initialize core quirks before calling nvme_init_subsystem (2022-12-06 09:05:59 +0100)

----------------------------------------------------------------
nvme fixes for Linux 6.1

 - initialize core quirks before calling nvme_init_subsystem
   (Pankaj Raghav)

----------------------------------------------------------------
Pankaj Raghav (1):
      nvme initialize core quirks before calling nvme_init_subsystem

 drivers/nvme/host/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

