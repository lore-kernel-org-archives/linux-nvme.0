Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79431C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Feb 2022 07:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LbFS9C+3gXb5be9xi8m5bFC27t57KtOCBKFV3poBquM=; b=2Fyh3efGQf02a1fo/SNVItCRcT
	UZqevOcDFQR8pKSHKmRVsZBVyKy4SlGH7cglAM4rVUzbC2WCpmrdc6F/kKP45Z901JJiu1bKehtny
	nBhwc6714w4jGrkAqekpMmiFulxAED+2sJ8dt2bSOdalnhMQjO9hxe1e2CmEtWOYZfrvvfNtqkhHF
	424uik9aWqGmWDt00gCCfNxvZBfW9zlBZAUo/TwBCGYCn9FLx4iA0bAWCq81Q3HSTW2haOjpNmMXJ
	wtQ8Rryl0pLQ44o0mlVlXUXXtvaFhQ6DdKwgkT6N7YhMTLbHpA8TfcIesodVCHB1n2NdCi79ESR9e
	Nl9sAgvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nN8dG-00H8Wn-VW; Thu, 24 Feb 2022 07:33:46 +0000
Received: from [2001:4bb8:198:f8fc:e55d:3b08:349b:3812] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nN8dC-00H8VM-Rn; Thu, 24 Feb 2022 07:33:43 +0000
Date: Thu, 24 Feb 2022 08:33:40 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <Yhc01AadzWuqPuAe@infradead.org>
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

The following changes since commit bb49c6fa8b845591b317b0d7afea4ae60ec7f3aa:

  block: clear iocb->private in blkdev_bio_end_io_async() (2022-02-22 06:59:49 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.17-2022-02-24

for you to fetch changes up to c2700d2886a87f83f31e0a301de1d2350b52c79b:

  nvme-tcp: send H2CData PDUs based on MAXH2CDATA (2022-02-23 14:43:11 +0100)

----------------------------------------------------------------
nvme fixes for Linux 5.17

 - send H2CData PDUs based on MAXH2CDATA (Varun Prakash)
 - fix passthrough to namespaces with unsupported features (me)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvme: don't return an error from nvme_configure_metadata
      nvme: also mark passthrough-only namespaces ready in nvme_update_ns_info

Varun Prakash (1):
      nvme-tcp: send H2CData PDUs based on MAXH2CDATA

 drivers/nvme/host/core.c | 19 ++++++---------
 drivers/nvme/host/tcp.c  | 63 +++++++++++++++++++++++++++++++++++++-----------
 include/linux/nvme-tcp.h |  1 +
 3 files changed, 58 insertions(+), 25 deletions(-)

