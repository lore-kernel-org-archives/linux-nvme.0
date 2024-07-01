Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0752C2BD09
	for <linux-nvme@archiver.kernel.org>; Mon,  1 Jul 2024 05:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LlODSFaN1XpjkzmcZRQPSqxuyDuPQcljPg6BB3l6xz0=; b=pkKK2GkUTbrfP6P8P4jHurS0Mm
	4y8FZqP6kP/5cG1s/FrVFiOQhwxjThbBGCsJlTD9hjfSfqmFFvY8Dbu+uU+J3YzJc97BIPNokcFdo
	ZvY9YUzRH5xqD8umRk+e0p/rIpIfTF/bFs8PRCW6nIPub+RnX71WL4bZqR94FwGNtKWRQMoiYrntQ
	qyorqtJehYnZn68vdd319KYxa7o+fk1XDPeC4vK3M5sYCDSPUh0fvlCAvtcEAJpUULnrs0mzyDyn5
	IQ8vS073Gw1ZGy2DcpXabEREHu0M6vX3aRnJgF4DptMqL4ZoL94ZiTRP4X+vNnXFRBzTjIWQjXVTC
	5pg0bF6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QR-00000001ivZ-358s;
	Mon, 01 Jul 2024 05:18:03 +0000
Received: from 2a02-8389-2341-5b80-ec0f-1986-7d09-2a29.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:ec0f:1986:7d09:2a29] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sO9QQ-00000001ivK-1Og8;
	Mon, 01 Jul 2024 05:18:02 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: io_opt fixups
Date: Mon,  1 Jul 2024 07:17:49 +0200
Message-ID: <20240701051800.1245240-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Hi all,

I recently noticed that on my test VMs with the Qemu NVMe emulations I
see a zero max_setors_kb limit in sysfs.  It turns out Qemu advertises
a one-LBA optimal write size, which is a bit silly.

This series handles this odd case properly both in the block layer and
the nvme driver as a sort of defense in depth.

Diffstat:
 block/blk-settings.c     |    5 ++---
 drivers/nvme/host/core.c |    3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)

