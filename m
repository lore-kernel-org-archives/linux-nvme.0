Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8863DC4321E
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Nov 2022 17:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wKQ+eyxu4Hf6WNBFlwekjNZWaXw/s3S01mnTtxrWClE=; b=txECVCHO95LxUrb3oF4EGDoO2z
	YR2wsqqPQizY2CvdOP6saD6p9Wh6MoaZtpIN55rVq/bzZhYP8kHAzY8TXmsTY60lUmUCtXn+LwbWZ
	a3FwB6obOwtX7+bHnk0bxvVpg9X5rS3WkpSST7KBU3VktmnltZydCQZg9ING35Awf0Nd8RntOpVRI
	jO+mKY62K1JRsCkArtO2bS64mkLo92j0vJOswDrlELxYEuEDdTzocrCib9aY7VZSKLyn/eFh9/OlU
	S6EtgMrN+yw0u+u4Xfv+kn2JHq9wpo4rSROBje6kCEyNJFmjuW2Gwt9zlEBs/3wFeZ2A4/jBtFKuR
	JlnvP2dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0RLh-001HmN-Iq; Wed, 30 Nov 2022 17:58:21 +0000
Received: from [2001:4bb8:192:26e7:c70:4a89:bc61:2] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0R6Z-0017T8-3C; Wed, 30 Nov 2022 17:42:43 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: James Smart <james.smart@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	linux-nvme@lists.infradead.org
Subject: use the core tagset alloc/free helpers in nvme-pci
Date: Wed, 30 Nov 2022 18:42:34 +0100
Message-Id: <20221130174240.227616-1-hch@lst.de>
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

this series switches over nvme-pci to use the common tagset alloc/free
helpers.

Diffstat:
 host/core.c   |   25 +++++++++++-----
 host/fc.c     |    4 +-
 host/nvme.h   |    7 ++--
 host/pci.c    |   89 +++++++++++-----------------------------------------------
 host/rdma.c   |    5 +--
 host/tcp.c    |    4 +-
 target/loop.c |    4 +-
 7 files changed, 48 insertions(+), 90 deletions(-)

