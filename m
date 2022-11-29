Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58F22C4321E
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Nov 2022 13:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bxRikpF+oJEmmcPPvrj/GfyFwM1k+Z8kAMRCOFz+eqU=; b=Bq4c3I47CyFyo6beG0pmQQ/uNf
	8n5RrM305OyVkVJJQWEH44ov6inPlLeuEBtrrsPuESsZMV4XUJ2OGBaNrGtuQwVm2om8NIbS2qJ2y
	nzoPHDD0h1eFJPtIycgRlhE29EuGwi6js5F3iDHQzTFRVd4G/NE8wtWUZh0lRpEE+nU323YpuT4T/
	JyIKHXptWf4PUkbOdONzV0CjUhAsXUlqRkRNrb9WIvyfIoJkYZMY84/SeKGNdxdwAbmHzZofplScq
	HeJhAxN3Dz+BWKW2y+eAqIR8Ixbt0tuR0gbzAPfDb7i8FpFIhRC9gVlvwAVUiyg7fOfDWBe2dHIRZ
	tolvDblA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00Yx-008lWp-5x; Tue, 29 Nov 2022 13:22:15 +0000
Received: from [2001:4bb8:192:26e7:691d:40a8:d7b5:b2f5] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p00Yu-008lUP-37; Tue, 29 Nov 2022 13:22:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	asahi@lists.linux.dev,
	linux-nvme@lists.infradead.org
Subject: remove path cleanups
Date: Tue, 29 Nov 2022 14:21:59 +0100
Message-Id: <20221129132208.4337-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

this series cleans up the remove path in the PCIe driver and a bit in the
common code after fixing a harmless bug in the Apple driver.

Diffstat:
 host/apple.c  |    4 -
 host/core.c   |   65 +++++++++-----------------------
 host/fc.c     |    2 
 host/nvme.h   |    3 -
 host/pci.c    |  117 +++++++++++++++++++++++++---------------------------------
 host/rdma.c   |    5 --
 host/tcp.c    |    5 --
 target/loop.c |    2 
 8 files changed, 77 insertions(+), 126 deletions(-)

